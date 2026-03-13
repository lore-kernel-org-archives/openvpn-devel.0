From: Frank Lichtenheld <frank@...2641...>
Date: Fri, 13 Mar 2026 11:37:07 +0100
Message-ID: <20260313103707.14534-1-frank@...2641...>
In-Reply-To: <gerrit.1773352679000.I29a33ac23f3c1a7cf16196aecc46ec3597a22175@...2715...>
References: <gerrit.1773352679000.I29a33ac23f3c1a7cf16196aecc46ec3597a22175@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] doc: improve Windows-specific options
 section
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

From: Heiko Hund <heiko@...2662...>

Change-Id: I29a33ac23f3c1a7cf16196aecc46ec3597a22175
Signed-off-by: Heiko Hund <heiko@...2662...>
Acked-by: Frank Lichtenheld <frank@...2641...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1574
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1574
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Frank Lichtenheld <frank@...2641...>

        
diff --git a/doc/man-sections/windows-options.rst b/doc/man-sections/windows-options.rst
index af2fb45..8d7dcbb 100644
--- a/doc/man-sections/windows-options.rst
+++ b/doc/man-sections/windows-options.rst
@@ -1,6 +1,12 @@
 Windows-Specific Options
 -------------------------
 
+These options are considered unknown on non-Windows platforms, resulting
+in fatal error (except ``--route-method``). You may want to use
+``--setenv opt`` or ``--ignore-unknown-option`` to ignore said error.
+Note that pushing unknown options from server does not trigger fatal
+errors.
+
 --allow-nonadmin TAP-adapter
   (Standalone) Set ``TAP-adapter`` to allow access from non-administrative
   accounts. If ``TAP-adapter`` is omitted, all TAP adapters on the system
@@ -16,12 +22,6 @@
   one inside the tunnel. It uses Windows Filtering Platform (WFP) and
   works on Windows Vista or later.
 
-  This option is considered unknown on non-Windows platforms and
-  unsupported on Windows XP, resulting in fatal error. You may want to use
-  ``--setenv opt`` or ``--ignore-unknown-option`` (not suitable for
-  Windows XP) to ignore said error. Note that pushing unknown options from
-  server does not trigger fatal errors.
-
 --cryptoapicert select-string
   *(Windows/OpenSSL Only)* Load the certificate and private key from the
   Windows Certificate System Store.

