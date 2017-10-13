#!/usr/bin/env python
import os
import subprocess
import time
import glob
import unittest

class TestPasses(unittest.TestCase):

    @classmethod
    def setUpClass(self):
        clean()
        self.output = run_zx_spec("bin/test-passes.tap")

    def test_zx_spec_header_displayed(self):
        self.assertRegexpMatches(self.output, 'ZX Spec - The TDD Framework')

    def test_indicators_show_tests_passed(self):
        self.assertRegexpMatches(self.output, '\.' * 4)

    def test_all_tests_pass(self):
        self.assertRegexpMatches(self.output, 'Pass: 5, Fail: 0, Total: 5')

    @classmethod
    def tearDownClass(self):
        clean()

class TestFailures(unittest.TestCase):

    @classmethod
    def setUpClass(self):
        clean()
        self.output = run_zx_spec("bin/test-failures.tap")

    def test_zx_spec_header_displayed(self):
        self.assertRegexpMatches(self.output, 'ZX Spec - The TDD Framework')

    def test_shows_failed_tests(self):
        self.assertRegexpMatches(self.output, 'assert_fail fails')
        self.assertRegexpMatches(self.output, 'assert_a_equals fails')
        self.assertRegexpMatches(self.output, 'assert_a_not_equals fails')
        self.assertRegexpMatches(self.output, 'assert_a_is_zero fails')
        self.assertRegexpMatches(self.output, 'assert_a_is_not_zero fails')

    def test_all_tests_failed(self):
        self.assertRegexpMatches(self.output, 'Pass: 0, Fail: 5, Total: 5')

    @classmethod
    def tearDownClass(self):
        clean()

def clean():
    for f in glob.glob("printout.*"):
        os.remove(f)

def run_zx_spec(tape):
    ZX_SPEC_OUTPUT_FILE = "printout.txt"
    proc = subprocess.Popen([
        "fuse",
        "--tape", tape,
        "--auto-load",
        "--no-autosave-settings"])

    wait_count = 0
    while not os.path.exists(ZX_SPEC_OUTPUT_FILE):
        time.sleep(0.1)
        wait_count += 1
        if wait_count == 20:
            raise 'Output file not produced in time'

    time.sleep(7)
    proc.kill()

    with open(ZX_SPEC_OUTPUT_FILE, 'r') as f:
        return f.read()

if __name__ == '__main__':
    unittest.main(verbosity=2)
