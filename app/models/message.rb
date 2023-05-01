class Message < ApplicationRecord
    after_commit :destroy_delayed, on: :create

    private
  
    def destroy_delayed
      delay(run_at: 30.seconds.from_now).destroy
    end
end
