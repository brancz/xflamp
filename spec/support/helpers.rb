require 'spec_helper'
require 'stringio'
require 'ostruct'

module Helpers
  attr_reader :last_run

  def capture
    _stdout, $stdout = $stdout, StringIO.new
    yield
    capture_result(true)
  rescue SystemExit => e
    capture_result(e.success?)
  ensure
    $stdout = _stdout if _stdout
  end

  def run_cli(*args)
    capture do
      XFLamp::CLI.run(*args)
    end
  end

  private

  def capture_result(success)
    @last_run = OpenStruct.new(:stdout => $stdout.string, :success? => success)
  end
end
