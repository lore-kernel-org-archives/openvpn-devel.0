From: Alon Bar-Lev <alon.barlev@...277...>
Date: Sat, 24 Mar 2012 09:58:38 +0200
Message-Id: <1332575918-3384-7-git-send-email-alon.barlev@...277...>
In-Reply-To: <4F6D06C5.3030408@...1114...>
References: <4F6D06C5.3030408@...1114...>
Subject: [Openvpn-devel] [PATCH 6/6] build: windows: set vendor to openvpn
	project + cleanups
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Openvpn-devel@lists.sourceforge.net
Cc: Alon Bar-Lev <alon.barlev@...277...>

*NOTICE* This is Latin code page file, beware of conversion.

Signed-off-by: Alon Bar-Lev <alon.barlev@...277...>
---
 src/openvpn/openvpn_win32_resources.rc   |    6 +++---
 src/openvpnserv/openvpnserv_resources.rc |    4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/src/openvpn/openvpn_win32_resources.rc b/src/openvpn/openvpn_w=
in32_resources.rc
index 6d77163..e1cd959 100644
--- a/src/openvpn/openvpn_win32_resources.rc
+++ b/src/openvpn/openvpn_win32_resources.rc
@@ -24,11 +24,11 @@ BEGIN
     BEGIN
         BLOCK "040904b0"
         BEGIN
-            VALUE "CompanyName", "OpenVPN.net"
-            VALUE "FileDescription", "OpenVPN"
+            VALUE "CompanyName", "The OpenVPN Project"
+            VALUE "FileDescription", "OpenVPN Daemon"
             VALUE "FileVersion", PACKAGE_VERSION ".0"
             VALUE "InternalName", "OpenVPN"
-            VALUE "LegalCopyright", "Copyright ? OpenVPN Project"=20
+            VALUE "LegalCopyright", "Copyright =A9 The OpenVPN Project"=20
             VALUE "OriginalFilename", "openvpn.exe"
             VALUE "ProductName", "OpenVPN"
             VALUE "ProductVersion", PACKAGE_VERSION ".0"
diff --git a/src/openvpnserv/openvpnserv_resources.rc b/src/openvpnserv/ope=
nvpnserv_resources.rc
index 7eac95b..9b79cb7 100644
--- a/src/openvpnserv/openvpnserv_resources.rc
+++ b/src/openvpnserv/openvpnserv_resources.rc
@@ -24,11 +24,11 @@ BEGIN
     BEGIN
         BLOCK "040904b0"
         BEGIN
-            VALUE "CompanyName", "OpenVPN.net"
+            VALUE "CompanyName", "The OpenVPN Project"
             VALUE "FileDescription", "OpenVPN Service"
             VALUE "FileVersion", PACKAGE_VERSION ".0"
             VALUE "InternalName", "OpenVPN"
-            VALUE "LegalCopyright", "Copyright ? OpenVPN Project"=20
+            VALUE "LegalCopyright", "Copyright =A9 The OpenVPN Project"=20
             VALUE "OriginalFilename", "openvpnserv.exe"
             VALUE "ProductName", "OpenVPN"
             VALUE "ProductVersion", PACKAGE_VERSION ".0"
--=20
1.7.3.4


