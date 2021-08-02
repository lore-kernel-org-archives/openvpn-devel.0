From: Arne Schwabe <arne@...1227...>
Date: Mon,  2 Aug 2021 11:52:11 +0200
Message-Id: <20210802095211.693800-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v3] Add example script demonstrating TOTP
 via auth-pending
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

Signed-off-by: Arne Schwabe <arne@...1227...>

Patch v3: Some minor cleanups in the script (rename CNs, add more comments)

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 doc/man-sections/script-options.rst |   3 +
 sample/sample-scripts/totpauth.py   | 111 ++++++++++++++++++++++++++++
 2 files changed, 114 insertions(+)
 create mode 100755 sample/sample-scripts/totpauth.py

diff --git a/doc/man-sections/script-options.rst b/doc/man-sections/script-options.rst
index f48e5818d..6517f8474 100644
--- a/doc/man-sections/script-options.rst
+++ b/doc/man-sections/script-options.rst
@@ -147,6 +147,9 @@ SCRIPT HOOKS
   :code:`auth_control_file or further defer it. See ``--auth-user-pass-verify``
   for details.
 
+  For a sample script that implement TOTP (RFC 6238) based two-factor
+  authentication, see :code:`sample-scripts/totp.py`.
+
 --client-connect cmd
   Run command ``cmd`` on client connection.
 
diff --git a/sample/sample-scripts/totpauth.py b/sample/sample-scripts/totpauth.py
new file mode 100755
index 000000000..2991d6590
--- /dev/null
+++ b/sample/sample-scripts/totpauth.py
@@ -0,0 +1,111 @@
+#! /usr/bin/python3
+# Copyright (c) 2021 OpenVPN Inc <sales@...515...>
+# Copyright (c) 2021 Arne Schwabe <arne@...1227...>
+#
+# Permission is hereby granted, free of charge, to any person obtaining a copy
+# of this software and associated documentation files (the "Software"), to deal
+# in the Software without restriction, including without limitation the rights
+# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
+# copies of the Software, and to permit persons to whom the Software is
+# furnished to do so, subject to the following conditions:
+#
+# The above copyright notice and this permission notice shall be included in all
+# copies or substantial portions of the Software.
+#
+# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
+# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
+# SOFTWARE.
+
+import sys
+import os
+from base64 import standard_b64decode
+
+import pyotp
+
+# Example script demonstrating how to use the auth-pending API in
+# OpenVPN. This script is provided under MIT license to allow easy
+# modification for other purposes.
+#
+# This needs support of crtext support on the client (e.g. OpenVPN for Android)
+# See also the management-notes.txt file for more information about the auth pending
+# protocol
+#
+# To use this script add the following lines in the openvpn config
+
+# client-crresponse /path/to/totpauth.py 
+# auth-user-pass-verify /path/to/totpauth.py via-file
+# auth-user-pass-optional
+# auth-gen-token
+
+# Note that this script does NOT verify username/password
+# It is only meant for querying additional 2FA when certificates are
+# used to authenticate
+
+
+# For this demo script we hardcode the TOTP secrets in a simple dictionary.
+secrets = {"Test-Client": "OS6JDNRK2BNUPQVX",
+           "Client-2": "IXWEMP7SK2QWSHTG"}
+
+
+def main():
+    # Get common name and script type from environment
+    script_type = os.environ['script_type']
+    cn = os.environ['common_name']
+
+    if script_type == 'user-pass-verify':
+        # signal text based challenge response
+        if cn in secrets:
+            extra = "CR_TEXT:E,R:Please enter your TOTP code!"
+            write_auth_pending(300, 'crtext', extra)
+
+            # Signal authentication being deferred
+            sys.exit(2)
+        else:
+            # For unknown CN we report failure. Change to 0
+            # to allow CNs without secret to auth without 2FA
+            sys.exit(1)
+
+    elif script_type == 'client-crresponse':
+        response = None
+
+        # Read the crresponse from the argument file
+        # and convert it into text. A failure because of bad user
+        # input (e.g. invalid base64) will make the script throw
+        # an error and make OpenVPN return AUTH_FAILED
+        with open(sys.argv[1], 'r') as crinput:
+            response = crinput.read()
+            response = standard_b64decode(response)
+            response = response.decode().strip()
+
+        if cn not in secrets:
+            write_auth_control(1)
+            return
+
+        totp = pyotp.TOTP(secrets[cn])
+
+        # Check if the code is valid (and also allow code +/-1)
+        if totp.verify(response, valid_window=1):
+            write_auth_control(1)
+        else:
+            write_auth_control(0)
+    else:
+        print(f"Unknown script type {script_type}")
+        sys.exit(1)
+
+
+def write_auth_control(status):
+    with open(os.environ['auth_control_file'], 'w') as auth_control:
+        auth_control.write("%d" % status)
+
+
+def write_auth_pending(timeout, method, extra):
+    with open(os.environ['auth_pending_file'], 'w') as auth_pending:
+        auth_pending.write("%d\n%s\n%s" % (timeout, method, extra))
+
+
+if __name__ == '__main__':
+    main()
-- 
2.32.0


