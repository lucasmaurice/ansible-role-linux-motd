import os

import testinfra.utils.ansible_runner

testinfra_hosts = testinfra.utils.ansible_runner.AnsibleRunner(
    os.environ['MOLECULE_INVENTORY_FILE']).get_hosts('all')


def test_motd_file_exist(host):
    f = host.file('/etc/profile.d/motd.sh')

    assert f.exists
    assert f.user == 'root'
    assert f.group == 'root'


def test_motd_file_work(host):
    host.run_test('/etc/profile.d/motd.sh')
