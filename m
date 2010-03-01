From: "Karl O. Pinc" <kop@...1206...>
Date: Sun, 28 Feb 2010 23:31:06 -0600
Message-Id: <1267421466-9788-1-git-send-email-kop@...1206...>
Subject: [Openvpn-devel] [PATCH] Frob the openvpn(8) man page tls-verify
	section to clarify
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net
Cc: Peter Stuge <peter@...1287...>

From: Karl O. Pinc <kop@...1304...>

---
 openvpn.8 |   22 +++++++++++++---------
 1 files changed, 13 insertions(+), 9 deletions(-)

diff --git a/openvpn.8 b/openvpn.8
index f1612a7..0150ba7 100644
--- a/openvpn.8
+++ b/openvpn.8
@@ -4232,11 +4232,23 @@ test).
 
 .B cmd
 should return 0 to allow the TLS handshake to proceed, or 1 to fail.
+
+Note that
+.B cmd
+may contain whitespace (if enclosed in quotes), in which case the first
+word of
+.B cmd
+is the shell command to execute and the remaining words are its
+arguments.
+When
 .B cmd
-is executed as
+is executed it is passed two (additional) arguments, as follows:
 
 .B cmd certificate_depth X509_NAME_oneline
 
+These arguments are, respectively, the current certificate depth and
+the X509 common name (cn) of the peer.
+
 This feature is useful if the peer you want to trust has a certificate
 which was signed by a certificate authority who also signed many
 other certificates, where you don't necessarily want to trust all of them,
@@ -4250,14 +4262,6 @@ in the OpenVPN distribution.
 
 See the "Environmental Variables" section below for
 additional parameters passed as environmental variables.
-
-Note that
-.B cmd
-can be a shell command with multiple arguments, in which
-case all OpenVPN-generated arguments will be appended
-to
-.B cmd
-to build a command line which will be passed to the script.
 .\"*********************************************************
 .TP
 .B --tls-remote name
-- 
1.5.6.5


