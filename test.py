#!/usr/bin/env python
import os
import subprocess
import time
import glob
import unittest

class ZxSpecTestCase(unittest.TestCase):

    @classmethod
    def setUpClass(self):
        clean()
        self.output = run_zx_spec()

    def test_zx_spec_header_displayed(self):
        self.assertRegexpMatches(self.output, 'ZX Spec - The TDD Framework')

    def test_all_tests_pass(self):
        self.assertRegexpMatches(self.output, 'Pass: 0, Fail: 0')

    @classmethod
    def tearDownClass(self):
        clean()

def clean():
    for f in glob.glob("printout.*"):
        os.remove(f)

def run_zx_spec():
    ZX_SPEC_OUTPUT_FILE = "printout.txt"
    proc = subprocess.Popen([
        "fuse",
        "--tape", "bin/zx-spec-test.tap",
        "--auto-load",
        "--no-autosave-settings"])

    wait_count = 0
    while not os.path.exists(ZX_SPEC_OUTPUT_FILE):
        time.sleep(0.1)
        wait_count += 1
        if wait_count == 20:
            raise 'Output file not produced in time'

    time.sleep(1)
    proc.kill()

    with open(ZX_SPEC_OUTPUT_FILE, 'r') as f:
        return f.read()

if __name__ == '__main__':
    unittest.main()
