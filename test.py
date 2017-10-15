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
        self.num_tests = 5

    def test_zx_spec_header_displayed(self):
        self.assertRegexpMatches(self.output, 'ZX Spec: The TDD Framework')

    def test_indicators_show_tests_passed(self):
        self.assertRegexpMatches(self.output, '\.' * self.num_tests)

    def test_all_tests_pass(self):
        self.assertRegexpMatches(
            self.output,
            'Pass: {0}, Fail: 0, Total: {0}'.format(
                self.num_tests))

    def test_framework_exited_correctly(self):
        self.assertRegexpMatches(self.output, '-- ZX SPEC TEST END --') 

    @classmethod
    def tearDownClass(self):
        clean()

class TestFailures(unittest.TestCase):

    @classmethod
    def setUpClass(self):
        clean()
        self.num_tests = 5
        self.output = run_zx_spec("bin/test-failures.tap")

    def test_zx_spec_header_displayed(self):
        self.assertRegexpMatches(self.output, 'ZX Spec: The TDD Framework')

    def test_shows_failed_tests(self):
        self.assertRegexpMatches(self.output, 'assert_fail')
        self.assertRegexpMatches(self.output, 'assert_a_equals')
        self.assertRegexpMatches(self.output, 'assert_a_not_equals')
        self.assertRegexpMatches(self.output, 'assert_a_is_zero')
        self.assertRegexpMatches(self.output, 'assert_a_is_not_zero')

    def test_all_tests_failed(self):
        self.assertRegexpMatches(self.output, 'Pass: 0, Fail: {0}, Total: {0}'.format(
            self.num_tests
        ))

    def test_framework_exited_correctly(self):
        self.assertRegexpMatches(self.output, '-- ZX SPEC TEST END --')   

    @classmethod
    def tearDownClass(self):
        clean()

def clean():
    for f in glob.glob("printout.*"):
        os.remove(f)

def printout_txt(filename):
    with open(filename, 'r') as f:
        return f.read()  

def wait_for_printout(filename):
    wait_count = 0
    while not os.path.exists(filename):
        time.sleep(0.1)
        wait_count += 1
        if wait_count == 20:
            raise IOError('Output file not produced in time')

def wait_for_framework_completion(filename):
    wait_count = 0
    while "-- ZX SPEC TEST END --" not in printout_txt(filename):
        time.sleep(1)
        wait_count += 1
        if wait_count == 20:
            raise Exception('Framework did not indicate clean exit in time')

def run_zx_spec(tape):
    ZX_SPEC_OUTPUT_FILE = "printout.txt"
    proc = subprocess.Popen([
        "fuse",
        "--tape", tape,
        "--auto-load",
        "--no-autosave-settings"])

    wait_for_printout(ZX_SPEC_OUTPUT_FILE)
    wait_for_framework_completion(ZX_SPEC_OUTPUT_FILE)
    proc.kill()
    return printout_txt(ZX_SPEC_OUTPUT_FILE)

if __name__ == '__main__':
    unittest.main(verbosity=2)
