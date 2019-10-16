require 'spec_helper_acceptance'

describe 'chrony class:' do
  it 'with defaults' do
    pp = <<-MANIFEST
      class { 'chrony': }
    MANIFEST

    # idempotent_apply(pp)
    apply_manifest(pp, catch_failures: true) do |r|
      expect(r.stderr).not_to eq(%r{error}i)
    end
  end

  describe package('chrony') do
    it { is_expected.to be_installed }
  end

  if os[:family] == 'RedHat'
    describe service(chronyd) do
      it { is_expected.to be_enabled }
      it { is_expected.to be_running }
    end
  end
  if os[:family] == 'Debian'
    describe service(chrony) do
      it { is_expected.to be_enabled }
      it { is_expected.to be_running }
    end
  end
end
