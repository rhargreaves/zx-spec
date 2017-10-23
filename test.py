#!/usr/bin/env python
import os
import subprocess
import time
import glob
import unittest

ZX_SPEC_OUTPUT_FILE = "printout.txt"
ZX_SPEC_TEST_END_MARKER = '-- ZX SPEC TEST END --'

class TestPasses(unittest.TestCase):

    @classmethod
    def setUpClass(self):
        clean()
        self.output = run_zx_spec("bin/test-passes.tap")
        self.num_tests = 62

    def test_zx_spec_header_displayed(self):
        self.assertRegexpMatches(self.output, 'ZX Spec: The TDD Framework')

    def test_indicators_show_tests_passed(self):
        self.assertRegexpMatches(
            self.output.replace('\n', ''),
            '\.' * self.num_tests)

    def test_all_tests_pass(self):
        self.assertRegexpMatches(
            self.output,
            'Pass: {0}, Fail: 0, Total: {0}'.format(
                self.num_tests))

    def test_framework_exited_correctly(self):
        self.assertRegexpMatches(self.output, ZX_SPEC_TEST_END_MARKER) 

    @classmethod
    def tearDownClass(self):
        clean()

class TestFailures(unittest.TestCase):

    @classmethod
    def setUpClass(self):
        clean()
        self.num_tests = 46
        self.output = run_zx_spec("bin/test-failures.tap")

    def test_zx_spec_header_displayed(self):
        self.assertRegexpMatches(self.output, 'ZX Spec: The TDD Framework')

    def test_shows_failed_tests(self):
        self.assertRegexpMatches(self.output, 'assert_fail')
        self.assertRegexpMatches(self.output, 'assert_a_equal\n fails for different value\n\nExpected: 250, Actual: 5')
        self.assertRegexpMatches(self.output, 'assert_b_equal\n fails for different value\n\nExpected: 250, Actual: 5')
        self.assertRegexpMatches(self.output, 'assert_c_equal\n fails for different value\n\nExpected: 250, Actual: 5')
        self.assertRegexpMatches(self.output, 'assert_d_equal\n fails for different value\n\nExpected: 250, Actual: 5')
        self.assertRegexpMatches(self.output, 'assert_e_equal\n fails for different value\n\nExpected: 250, Actual: 5')
        self.assertRegexpMatches(self.output, 'assert_h_equal\n fails for different value\n\nExpected: 250, Actual: 5')
        self.assertRegexpMatches(self.output, 'assert_l_equal\n fails for different value\n\nExpected: 250, Actual: 5')
        self.assertRegexpMatches(self.output, 'assert_hl_equal\n fails for different value\n\nExpected: 502, Actual: 500')
        self.assertRegexpMatches(self.output, 'assert_bc_equal\n fails for different value\n\nExpected: 502, Actual: 500') 
        self.assertRegexpMatches(self.output, 'assert_de_equal\n fails for different value\n\nExpected: 502, Actual: 500')
        self.assertRegexpMatches(self.output, 'assert_ix_equal\n fails for different value')            
        self.assertRegexpMatches(self.output, 'assert_mem_equal\n fails for different value\n\nExpected: 255, Actual: 204')
        self.assertRegexpMatches(self.output, 'assert_word_equal\n fails for different value\n\nExpected: 258, Actual: 65501')
        self.assertRegexpMatches(self.output, 'assert_str_equal\n fails for different value\n\nExpected: "diff test string", Ac\ntual: "test string\?\?\?\?\?"')
        self.assertRegexpMatches(self.output, 'assert_z_set\n fails when zero flag reset')
        self.assertRegexpMatches(self.output, 'assert_z_reset\n fails when zero flag set')
        self.assertRegexpMatches(self.output, 'assert_carry_set\n fails when carry flag reset')
        self.assertRegexpMatches(self.output, 'assert_carry_reset\n fails when carry flag set')
        self.assertRegexpMatches(self.output, 'assert_s_set\n fails when signed flag reset')
        self.assertRegexpMatches(self.output, 'assert_s_reset\n fails when signed flag set')
        self.assertRegexpMatches(self.output, 'assert_p_v_set\n fails when overflow flag reset')
        self.assertRegexpMatches(self.output, 'assert_p_v_reset\n fails when overflow flag set')
        self.assertRegexpMatches(self.output, 'x\n fails for different value\n\nExpected: 503, Actual: 500')
        self.assertRegexpMatches(self.output, 'x\n fails for different value\n\nExpected: 2, Actual: 1')  
        self.assertRegexpMatches(self.output, 'x\n fails for different value\n\nExpected: 3, Actual: 1')
        self.assertRegexpMatches(self.output, 'assert_a_not_equal')
        self.assertRegexpMatches(self.output, 'assert_b_not_equal')
        self.assertRegexpMatches(self.output, 'assert_c_not_equal')
        self.assertRegexpMatches(self.output, 'assert_d_not_equal')
        self.assertRegexpMatches(self.output, 'assert_e_not_equal')
        self.assertRegexpMatches(self.output, 'assert_h_not_equal')
        self.assertRegexpMatches(self.output, 'assert_l_not_equal')
        self.assertRegexpMatches(self.output, 'assert_hl_not_equal')
        self.assertRegexpMatches(self.output, 'assert_bc_not_equal')
        self.assertRegexpMatches(self.output, 'assert_de_not_equal')
        self.assertRegexpMatches(self.output, 'assert_ix_not_equal')
        self.assertRegexpMatches(self.output, 'assert_a_is_zero')
        self.assertRegexpMatches(self.output, 'assert_a_is_not_zero')
        self.assertRegexpMatches(self.output, 'assert_mem_not_equal')
        self.assertRegexpMatches(self.output, 'assert_word_not_equal')
        self.assertRegexpMatches(self.output, 'assert_str_not_equal')

    def test_16_bit_numbers_displayed_correctly(self):
        self.assertRegexpMatches(self.output, 'assert_word_equal\n fails for different value\n\nExpected: 258, Actual: 65501')

    def test_all_tests_failed(self):
        self.assertRegexpMatches(self.output, 'Pass: 0, Fail: {0}, Total: {0}'.format(
            self.num_tests
        ))

    def test_framework_exited_correctly(self):
        self.assertRegexpMatches(self.output, ZX_SPEC_TEST_END_MARKER)  

    @classmethod
    def tearDownClass(self):
        clean()

class TestHexDisplay(unittest.TestCase):

    @classmethod
    def setUpClass(self):
        clean()
        self.output = run_zx_spec("bin/test-hex.tap")

    def test_hex_values_are_displayed_correctly(self):
        self.assertRegexpMatches(self.output, 'assert_word_equal\n fails for different value\n\nExpected: 0000, Actual: FFFF')
        self.assertRegexpMatches(self.output, 'fails for different value\n\nExpected: ACDC, Actual: FFFF')

    def test_framework_exited_correctly(self):
        self.assertRegexpMatches(self.output, ZX_SPEC_TEST_END_MARKER)

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
        time.sleep(1)
        wait_count += 1
        if wait_count == 120:
            raise IOError('Output file not produced in time')

def wait_for_framework_completion(filename):
    wait_count = 0
    while ZX_SPEC_TEST_END_MARKER not in printout_txt(filename):
        time.sleep(1)
        wait_count += 1
        if wait_count == 120:
            raise Exception('Framework did not indicate clean exit in time')

def run_zx_spec(tape):  
    cmd_line = "{0} --no-sound --zxprinter --printer --tape {1} --auto-load --no-autosave-settings".format(
        os.getenv("FUSE", "fuse"),
        tape)
    proc = subprocess.Popen(
        cmd_line, shell=True)
    wait_for_printout(ZX_SPEC_OUTPUT_FILE)
    wait_for_framework_completion(ZX_SPEC_OUTPUT_FILE)
    proc.kill()
    return printout_txt(ZX_SPEC_OUTPUT_FILE)

if __name__ == '__main__':
    unittest.main(verbosity=2)
