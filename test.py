#!/usr/bin/env python
import os
import subprocess
import time
import glob
import unittest

class ZxSpecTestCase(unittest.TestCase):
    def setUp(self):
        clean()

    def tearDown(self):
        clean()

    def test_zx_spec_header_displayed(self):
        ZX_SPEC_OUTPUT_FILE = "printout.txt"

        proc = subprocess.Popen([
            "fuse",
            "--tape", "bin/zx-spec-test.tap",
            "--auto-load",
            "--no-autosave-settings"])

        while not os.path.exists(ZX_SPEC_OUTPUT_FILE):
            time.sleep(0.1)

        time.sleep(1)
        proc.kill()

        with open(ZX_SPEC_OUTPUT_FILE, 'r') as f:
            zx_spec_output = f.read()

            self.assertRegexpMatches(zx_spec_output, 'ZX Spec - The TDD Framework')

def clean():
    for f in glob.glob("printout.*"):
        os.remove(f)

if __name__ == '__main__':
    unittest.main()
