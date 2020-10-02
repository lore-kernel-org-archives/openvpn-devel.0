From: Vladislav Grishenko <themiron@...2010...>
Date: Sat,  3 Oct 2020 02:51:46 +0500
Message-Id: <20201002215146.31324-1-themiron@...2010...>
Subject: [Openvpn-devel] [PATCH] Add CRL extractor script for --crl-verify
 dir mode
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

When --crl-verify is enabled, specified CRL file gets reloaded on
every client connection. With huge CRL files it may take a significant
amount of time - seconds and tens of seconds, during which OpenVPN is
blocked and can't serve existing and/or incoming connections due its
singlethread nature.
In alternative mode --crl-verify option takes directory containing
files named as decimal serial numbers of the revoked certificates and
'dir' flag, revoked certificate check is being done by checking the
presence of client's certificate number in that directory.

This script allow to perform incremental extraction of revoked serial
numbers from CRL by adding absent ones and removing excess ones.

Usage example:
    extractcrl.py -f pem /path/to/crl.pem /path/to/outdir
    extractcrl.py -f der /path/to/crl.crl /path/to/outdir
    cat /path/to/crl.pem | extractcrl.py -f pem - /path/to/outdir
    cat /path/to/crl.crl | extractcrl.py -f der - /path/to/outdir

Output example:
    Loaded:  309797 revoked certs in 4.136s
    Scanned: 312006 files in 0.61s
    Created: 475 files in 0.05s
    Removed: 2684 files in 0.116s

Signed-off-by: Vladislav Grishenko <themiron@...2010...>
---
 contrib/extract-crl/extractcrl.py | 138 ++++++++++++++++++++++++++++++
 1 file changed, 138 insertions(+)
 create mode 100755 contrib/extract-crl/extractcrl.py

diff --git a/contrib/extract-crl/extractcrl.py b/contrib/extract-crl/extractcrl.py
new file mode 100755
index 00000000..441464e9
--- /dev/null
+++ b/contrib/extract-crl/extractcrl.py
@@ -0,0 +1,138 @@
+#!/usr/bin/env python3
+# -*- coding: utf-8 -*-
+
+'''
+Helper script for CRL (certificate revocation list) file extraction
+to a directory containing files named as decimal serial numbers of
+the revoked certificates, to be used with OpenVPN CRL directory
+verify mode. To enable this mode, directory and 'dir' flag needs to
+be specified as parameters of '--crl-verify' option.
+For more information refer OpenVPN tls-options.rst.
+
+Usage example:
+    extractcrl.py -f pem /path/to/crl.pem /path/to/outdir
+    extractcrl.py -f der /path/to/crl.crl /path/to/outdir
+    cat /path/to/crl.pem | extractcrl.py -f pem - /path/to/outdir
+    cat /path/to/crl.crl | extractcrl.py -f der - /path/to/outdir
+
+Output example:
+    Loaded:  309797 revoked certs in 4.136s
+    Scanned: 312006 files in 0.61s
+    Created: 475 files in 0.05s
+    Removed: 2684 files in 0.116s
+'''
+
+import argparse
+import os
+import sys
+import time
+from subprocess import check_output
+
+FILETYPE_PEM = 'PEM'
+FILETYPE_DER = 'DER'
+
+def measure_time(method):
+    def elapsed(*args, **kwargs):
+        start = time.time()
+        result = method(*args, **kwargs)
+        return result, round(time.time() - start, 3)
+    return elapsed
+
+@measure_time
+def load_crl(filename, format):
+
+    def try_openssl_module(filename, format):
+        from OpenSSL import crypto
+        types = {
+            FILETYPE_PEM: crypto.FILETYPE_PEM,
+            FILETYPE_DER: crypto.FILETYPE_ASN1
+        }
+        if filename == '-':
+            crl = crypto.load_crl(types[format], sys.stdin.buffer.read())
+        else:
+            with open(filename, 'rb') as f:
+                crl = crypto.load_crl(types[format], f.read())
+        return set(int(r.get_serial(), 16) for r in crl.get_revoked())
+
+    def try_openssl_exec(filename, format):
+        args = ['openssl', 'crl', '-inform', format, '-text']
+        if filename != '-':
+            args += ['-in', filename]
+        serials = set()
+        for line in check_output(args, universal_newlines=True).splitlines():
+            _, _, serial = line.partition('Serial Number:')
+            if serial:
+                serials.add(int(serial.strip(), 16))
+        return serials
+
+    try:
+        return try_openssl_module(filename, format)
+    except ImportError:
+        return try_openssl_exec(filename, format)
+
+@measure_time
+def scan_dir(dirname):
+    _, _, files = next(os.walk(dirname))
+    return set(int(f) for f in files if f.isdigit())
+
+@measure_time
+def create_new_files(dirname, newset, oldset):
+    addset = newset.difference(oldset)
+    for serial in addset:
+        try:
+            with open(os.path.join(dirname, str(serial)), 'xb'): pass
+        except FileExistsError:
+            pass
+    return addset
+
+@measure_time
+def remove_old_files(dirname, newset, oldset):
+    delset = oldset.difference(newset)
+    for serial in delset:
+        try:
+            os.remove(os.path.join(dirname, str(serial)))
+        except FileNotFoundError:
+            pass
+    return delset
+
+def check_crlfile(arg):
+    if arg == '-' or os.path.isfile(arg):
+        return arg
+    raise argparse.ArgumentTypeError('No such file "{}"'.format(arg))
+
+def check_outdir(arg):
+    if os.path.isdir(arg):
+        return arg
+    raise argparse.ArgumentTypeError('No such directory: "{}"'.format(arg))
+
+def main():
+    parser = argparse.ArgumentParser(description='OpenVPN CRL extractor')
+    parser.add_argument('-f', '--format',
+        type=str.upper,
+        default=FILETYPE_PEM, choices=[FILETYPE_PEM, FILETYPE_DER],
+        help='input CRL format - default {}'.format(FILETYPE_PEM)
+    )
+    parser.add_argument('crlfile', metavar='CRLFILE|-',
+        type=lambda x: check_crlfile(x),
+        help='input CRL file or "-" for stdin'
+    )
+    parser.add_argument('outdir', metavar='OUTDIR',
+        type=lambda x: check_outdir(x),
+        help='output directory for serials numbers'
+    )
+    args = parser.parse_args()
+
+    certs, t = load_crl(args.crlfile, args.format)
+    print('Loaded:  {} revoked certs in {}s'.format(len(certs), t))
+
+    files, t = scan_dir(args.outdir)
+    print('Scanned: {} files in {}s'.format(len(files), t))
+
+    created, t = create_new_files(args.outdir, certs, files)
+    print('Created: {} files in {}s'.format(len(created), t))
+
+    removed, t = remove_old_files(args.outdir, certs, files)
+    print('Removed: {} files in {}s'.format(len(removed), t))
+
+if __name__ == "__main__":
+    main()
-- 
2.17.1


