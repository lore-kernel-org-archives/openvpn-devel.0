From: Richard Bonhomme <tincanteksup@...277...>
Date: Tue,  7 Jul 2020 00:29:55 +0100
Message-Id: <20200706232955.3343-1-tincanteksup@...277...>
Subject: [Openvpn-devel] [Patch] New man page corrections -
 script-options.rst
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

Signed-off-by: Richard Bonhomme <tincanteksup@...277...>
---
 doc/man-sections/script-options.rst | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/doc/man-sections/script-options.rst b/doc/man-sections/script-options.rst
index 280127b1..8ea5b4a7 100644
--- a/doc/man-sections/script-options.rst
+++ b/doc/man-sections/script-options.rst
@@ -67,7 +67,7 @@ SCRIPT HOOKS
   OpenVPN will run command ``cmd`` to validate the username/password
   provided by the client.
 
-  ``cmd`` consists of a path to script (or executable program), optionally
+  ``cmd`` consists of a path to a script (or executable program), optionally
   followed by arguments. The path and arguments may be single- or
   double-quoted and/or escaped using a backslash, and should be separated
   by one or more spaces.
@@ -114,7 +114,7 @@ SCRIPT HOOKS
 --client-connect cmd
   Run command ``cmd`` on client connection.
 
-  ``cmd`` consists of a path to script (or executable program), optionally
+  ``cmd`` consists of a path to a script (or executable program), optionally
   followed by arguments. The path and arguments may be single- or
   double-quoted and/or escaped using a backslash, and should be separated
   by one or more spaces.
@@ -174,7 +174,7 @@ SCRIPT HOOKS
   Run command ``cmd`` when our remote ip-address is initially
   authenticated or changes.
 
-  ``cmd`` consists of a path to script (or executable program), optionally
+  ``cmd`` consists of a path to a script (or executable program), optionally
   followed by arguments. The path and arguments may be single- or
   double-quoted and/or escaped using a backslash, and should be separated
   by one or more spaces.
@@ -200,13 +200,13 @@ SCRIPT HOOKS
   Similarly if *our* IP address changes due to DHCP, we should configure
   our IP address change script (see man page for ``dhcpcd``\(8)) to
   deliver a ``SIGHUP`` or ``SIGUSR1`` signal to OpenVPN. OpenVPN will
-  then reestablish a connection with its most recently authenticated
+  then re-establish a connection with its most recently authenticated
   peer on its new IP address.
 
 --learn-address cmd
   Run command ``cmd`` to validate client virtual addresses or routes.
 
-  ``cmd`` consists of a path to script (or executable program), optionally
+  ``cmd`` consists of a path to a script (or executable program), optionally
   followed by arguments. The path and arguments may be single- or
   double-quoted and/or escaped using a backslash, and should be separated
   by one or more spaces.
@@ -244,7 +244,7 @@ SCRIPT HOOKS
 --route-up cmd
   Run command ``cmd`` after routes are added, subject to ``--route-delay``.
 
-  ``cmd`` consists of a path to script (or executable program), optionally
+  ``cmd`` consists of a path to a script (or executable program), optionally
   followed by arguments. The path and arguments may be single- or
   double-quoted and/or escaped using a backslash, and should be separated
   by one or more spaces.
@@ -255,7 +255,7 @@ SCRIPT HOOKS
 --route-pre-down cmd
   Run command ``cmd`` before routes are removed upon disconnection.
 
-  ``cmd`` consists of a path to script (or executable program), optionally
+  ``cmd`` consists of a path to a script (or executable program), optionally
   followed by arguments. The path and arguments may be single- or
   double-quoted and/or escaped using a backslash, and should be separated
   by one or more spaces.
@@ -316,7 +316,7 @@ SCRIPT HOOKS
   ``cmd`` should return :code:`0` to allow the TLS handshake to proceed,
   or :code:`1` to fail.
 
-  ``cmd`` consists of a path to script (or executable program), optionally
+  ``cmd`` consists of a path to a script (or executable program), optionally
   followed by arguments. The path and arguments may be single- or
   double-quoted and/or escaped using a backslash, and should be separated
   by one or more spaces.
@@ -346,7 +346,7 @@ SCRIPT HOOKS
   Run command ``cmd`` after successful TUN/TAP device open (pre ``--user``
   UID change).
 
-  ``cmd`` consists of a path to script (or executable program), optionally
+  ``cmd`` consists of a path to a script (or executable program), optionally
   followed by arguments. The path and arguments may be single- or
   double-quoted and/or escaped using a backslash, and should be separated
   by one or more spaces.
-- 
2.17.1


