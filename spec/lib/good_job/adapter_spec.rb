# frozen_string_literal: true
require 'rails_helper'

RSpec.describe GoodJob::Adapter do
  let(:adapter) { described_class.new(execution_mode: :external) }
  let(:active_job) { instance_double(ActiveJob::Base) }
  let(:good_job) { instance_double(GoodJob::Execution, queue_name: 'default', scheduled_at: nil) }

  describe '#initialize' do
    it 'guards against improper execution modes' do
      expect do
        described_class.new(execution_mode: :blarg)
      end.to raise_error ArgumentError
    end
  end

  describe '#enqueue' do
    it 'calls GoodJob::Execution.enqueue with parameters' do
      allow(GoodJob::Execution).to receive(:enqueue).and_return(good_job)

      adapter.enqueue(active_job)

      expect(GoodJob::Execution).to have_received(:enqueue).with(
        active_job,
        create_with_advisory_lock: nil,
        scheduled_at: nil
      )
    end

    context 'when inline' do
      let(:adapter) { described_class.new(execution_mode: :inline) }

      before do
        stub_const 'PERFORMED', []
        stub_const 'JobError', Class.new(StandardError)
        stub_const 'TestJob', (Class.new(ActiveJob::Base) do
          def perform(succeed: true)
            PERFORMED << Time.current

            raise JobError unless succeed
          end
        end)
      end

      it 'executes the job immediately' do
        adapter.enqueue(TestJob.new(succeed: true))
        expect(PERFORMED.size).to eq 1
      end

      it "raises unhandled exceptions" do
        expect do
          adapter.enqueue(TestJob.new(succeed: false))
        end.to raise_error(JobError)

        expect(PERFORMED.size).to eq 1
      end

      context 'when inline_execution_respects_schedule is TRUE' do
        before do
          config = Rails.application.config.good_job.dup.merge({ inline_execution_respects_schedule: true })
          allow(Rails.application.config).to receive(:good_job).and_return(config)
        end

        it 'does not execute future scheduled jobs' do
          adapter.enqueue_at(TestJob.new, 1.minute.from_now.to_f)
          expect(PERFORMED.size).to eq 0
          expect(GoodJob::ActiveJobJob.count).to eq 1
        end
      end

      context 'when inline_execution_respects_schedule is FALSE' do
        before do
          config = Rails.application.config.good_job.dup.merge({ inline_execution_respects_schedule: false })
          allow(Rails.application.config).to receive(:good_job).and_return(config)
        end

        it 'executes future scheduled jobs' do
          expect do
            adapter.enqueue_at(TestJob.new, 1.minute.from_now.to_f)
            expect(PERFORMED.size).to eq 1
            expect(GoodJob::ActiveJobJob.count).to eq 0
          end.to output(/DEPRECATION WARNING/).to_stderr_from_any_process
        end
      end
    end

    context 'when async' do
      it 'triggers an execution thread and the notifier' do
        allow(GoodJob::Execution).to receive(:enqueue).and_return(good_job)
        allow(GoodJob::Notifier).to receive(:notify)

        scheduler = instance_double(GoodJob::Scheduler, shutdown: nil, create_thread: nil)
        allow(GoodJob::Scheduler).to receive(:new).and_return(scheduler)

        adapter = described_class.new(execution_mode: :async_all, poll_interval: -1)
        adapter.enqueue(active_job)

        expect(scheduler).to have_received(:create_thread)
        expect(GoodJob::Notifier).to have_received(:notify)
      end
    end
  end

  describe '#enqueue_at' do
    it 'calls GoodJob::Execution.enqueue with parameters' do
      allow(GoodJob::Execution).to receive(:enqueue).and_return(good_job)

      scheduled_at = 1.minute.from_now

      adapter.enqueue_at(active_job, scheduled_at.to_i)

      expect(GoodJob::Execution).to have_received(:enqueue).with(
        active_job,
        create_with_advisory_lock: nil,
        scheduled_at: scheduled_at.change(usec: 0)
      )
    end
  end

  describe '#shutdown' do
    it 'is callable' do
      adapter.shutdown
    end
  end

  describe '#execute_async?' do
    context 'when execution mode async_all' do
      let(:adapter) { described_class.new(execution_mode: :async_all) }

      it 'returns true' do
        expect(adapter.execute_async?).to be true
      end
    end

    context 'when execution mode async' do
      let(:adapter) { described_class.new(execution_mode: :async) }

      context 'when Rails::Server is defined' do
        before do
          stub_const("Rails::Server", Class.new)
        end

        it 'returns true' do
          expect(adapter.execute_async?).to be true
          expect(adapter.execute_externally?).to be false
        end
      end

      context 'when Rails::Server is not defined' do
        before do
          hide_const("Rails::Server")
        end

        it 'returns false' do
          expect(adapter.execute_async?).to be false
          expect(adapter.execute_externally?).to be true
        end
      end
    end

    context 'when execution mode async_server' do
      let(:adapter) { described_class.new(execution_mode: :async_server) }

      context 'when Rails::Server is defined' do
        before do
          stub_const("Rails::Server", Class.new)
        end

        it 'returns true' do
          expect(adapter.execute_async?).to be true
          expect(adapter.execute_externally?).to be false
        end
      end

      context 'when Rails::Server is not defined' do
        before do
          hide_const("Rails::Server")
        end

        it 'returns false' do
          expect(adapter.execute_async?).to be false
          expect(adapter.execute_externally?).to be true
        end
      end
    end
  end
end
