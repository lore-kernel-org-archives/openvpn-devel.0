From: Frank Lichtenheld <frank@...2641...>
Date: Sun,  7 Nov 2021 19:12:52 +0100
Message-Id: <20211107181252.17045-1-frank@...2641...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Updated URLs in README
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
Cc: Peppernrino <pepperandrino@...277...>, Frank Lichtenheld <frank@...2641...>

From: Peppernrino <pepperandrino@...277...>

Updated to current links, and added SSL to all.
Changed tap-windows to reflect NDIS 6 repository shift.

Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
 README | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

As part of an initative to clean up the Github PR submissions, submitting
this patch to the mailing list for inclusion. I know David didn't like
the manual URL but it is still better than the current one that goes to
a completely wrong document.
PR: https://github.com/OpenVPN/openvpn/pull/114

diff --git a/README b/README
index b75a568e..2a953be7 100644
--- a/README
+++ b/README
@@ -9,7 +9,7 @@ as published by the Free Software Foundation.
 
 To get the latest release of OpenVPN, go to:
 
-	https://openvpn.net/index.php/download/community-downloads.html
+	https://openvpn.net/community-downloads/
 
 To Build and Install,
 
@@ -24,10 +24,10 @@ or see the file INSTALL for more info.
 *************************************************************************
 
 For detailed information on OpenVPN, including examples, see the man page
-  http://openvpn.net/man.html
+  https://openvpn.net/community-resources/reference-manual-for-openvpn-2-4/
 
 For a sample VPN configuration, see
-  http://openvpn.net/howto.html
+  https://openvpn.net/community-resources/how-to/
 
 To report an issue, see
   https://community.openvpn.net/openvpn/report
@@ -56,15 +56,15 @@ Other Files & Directories:
 * sample/sample-config-files/
 
   A collection of OpenVPN config files and scripts from
-  the HOWTO at http://openvpn.net/howto.html
+  the HOWTO at https://openvpn.net/community-resources/how-to/
 
 *************************************************************************
 
-Note that easy-rsa and tap-windows are now maintained in their own subprojects.
+Note that easy-rsa and tap-windows6 are now maintained in their own subprojects.
 Their source code is available here:
 
   https://github.com/OpenVPN/easy-rsa
-  https://github.com/OpenVPN/tap-windows
+  https://github.com/OpenVPN/tap-windows6
 
 The old cross-compilation environment (domake-win) and the Python-based
 buildsystem have been replaced with openvpn-build:
-- 
2.30.2


