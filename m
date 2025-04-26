From: Klemens Nanni <kn@...2273...>
Date: Sat, 26 Apr 2025 15:19:03 +0300
Message-ID: <20250426121903.67930-1-kn@...2273...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [SPAM] [PATCH] Fix tmp-dir documentation
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

Mention its default (on non-Windows systems), rephrase for brevity, fix
grammar, correct the module environment variable name and remove a wrong
default mentioned in a related option.
---
 doc/man-sections/generic-options.rst | 11 +++++------
 doc/man-sections/script-options.rst  |  8 +++-----
 2 files changed, 8 insertions(+), 11 deletions(-)

diff --git a/doc/man-sections/generic-options.rst b/doc/man-sections/generic-options.rst
index ba9376be..882cf283 100644
--- a/doc/man-sections/generic-options.rst
+++ b/doc/man-sections/generic-options.rst
@@ -454,12 +454,11 @@ which mode OpenVPN is configured as.
   independently of network and tunnel issues.
 
 --tmp-dir dir
-  Specify a directory ``dir`` for temporary files. This directory will be
-  used by openvpn processes and script to communicate temporary data with
-  openvpn main process. Note that the directory must be writable by the
-  OpenVPN process after it has dropped it's root privileges.
+  Specify a directory ``dir`` for temporary files instead of the default
+  :code:`TMPDIR` (or "/tmp" if unset). Note that it must be writable by the main
+  process after it has dropped root privileges.
 
-  This directory will be used by in the following cases:
+  This directory will be used to communicate with scripts and plugins:
 
   * ``--client-connect`` scripts and :code:`OPENVPN_PLUGIN_CLIENT_CONNECT`
     plug-in hook to dynamically generate client-specific configuration
@@ -469,7 +468,7 @@ which mode OpenVPN is configured as.
 
   * :code:`OPENVPN_PLUGIN_AUTH_USER_PASS_VERIFY` plug-in hooks returns
     success/failure via :code:`auth_control_file` when using deferred auth
-    method and pending authentication via :code:`pending_auth_file`.
+    method and pending authentication via :code:`auth_pending_file`.
 
 --use-prediction-resistance
   Enable prediction resistance on mbed TLS's RNG.
diff --git a/doc/man-sections/script-options.rst b/doc/man-sections/script-options.rst
index 0d1f9aec..e48710ba 100644
--- a/doc/man-sections/script-options.rst
+++ b/doc/man-sections/script-options.rst
@@ -87,11 +87,9 @@ SCRIPT HOOKS
   and password to the first two lines of a temporary file. The filename
   will be passed as an argument to ``cmd``, and the file will be
   automatically deleted by OpenVPN after the script returns. The location
-  of the temporary file is controlled by the ``--tmp-dir`` option, and
-  will default to the current directory if unspecified. For security,
-  consider setting ``--tmp-dir`` to a volatile storage medium such as
-  :code:`/dev/shm` (if available) to prevent the username/password file
-  from touching the hard drive.
+  of the temporary file is controlled by the ``--tmp-dir`` option. For security,
+  consider setting it to a volatile storage medium such as :code:`/dev/shm` (if
+  available) to prevent the username/password file from touching the hard drive.
 
   The script should examine the username and password, returning a success
   exit code (:code:`0`) if the client's authentication request is to be
-- 
2.49.0


