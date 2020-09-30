From: Arne Schwabe <arne@...1227...>
Date: Wed, 30 Sep 2020 15:13:17 +0200
Message-Id: <20200930131317.1299-13-arne@...1227...>
In-Reply-To: <20200930131317.1299-1-arne@...1227...>
References: <20200930131317.1299-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH 11/11] Add example script demonstrating TOTP
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
---
 Changes.rst                         |   2 +
 doc/man-sections/script-options.rst |   3 +
 sample/sample-scripts/totpauth.py   | 107 ++++++++++++++++++++++++++++
 3 files changed, 112 insertions(+)
 create mode 100755 sample/sample-scripts/totpauth.py

diff --git a/Changes.rst b/Changes.rst
index 0717c349..7b7d1491 100644
--- a/Changes.rst
+++ b/Changes.rst
@@ -13,6 +13,8 @@ Pending auth support for plugins and scripts
     script option and ``OPENVPN_PLUGIN_CLIENT_CRRESPONSE`` plugin function can
     be used to parse a client response to a ``CR_TEXT`` two factor challenge.
 
+    See ``sample/sample-scripts/totpauth.py`` for an example.
+
 
 Overview of changes in 2.5
 ==========================
diff --git a/doc/man-sections/script-options.rst b/doc/man-sections/script-options.rst
index 66bf3662..fff3d166 100644
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
index 00000000..95ac3529
--- /dev/null
+++ b/sample/sample-scripts/totpauth.py
@@ -0,0 +1,107 @@
+#! /usr/bin/python3
+# Copyright (c) 2020 OpenVPN Inc <sales@...515...>
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
+import pprint
+
+# Example script demonstrating how to use the auth-pending API in
+# OpenVPN. This script is provided under MIT license to allow easy
+# modification for other purposes.
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
+secrets = {"styx": "OS6JDNRK2BNUPQVX",
+           "apate": "IXWEMP7SK2QWSHTG"}
+
+
+def main():
+    # Get common name and script type from environment
+    script_type = os.environ['script_type']
+    cn = os.environ['common_name']
+
+    if script_type == 'user-pass-verify':
+        # signal text based challenge response
+
+        if cn in secrets:
+            extra = "CR_TEXT:E,R:Please enter your TOTP code!"
+            write_auth_pending(300, 'crtext', extra)
+
+            # Signal authentication being deferred
+            sys.exit(2)
+        else:
+            # For unkown CN we report failure. Change to 0
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
2.26.2


