From: samuli@...515...
Date: Tue,  2 Jun 2015 10:59:42 +0300
Message-Id: <1433231982-24945-1-git-send-email-samuli@...515...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Improve documentation in --script-security
	section of the man-page
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: openvpn-devel@lists.sourceforge.net

From: Samuli Sepp=C3=A4nen <samuli@...515...>

Trac: #395

Signed-off-by: Samuli Sepp=C3=A4nen <samuli@...515...>
---
 doc/openvpn.8 | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/doc/openvpn.8 b/doc/openvpn.8
index df16a7f..3eb2493 100644
--- a/doc/openvpn.8
+++ b/doc/openvpn.8
@@ -2007,6 +2007,11 @@ or
 As of OpenVPN v2.3, this flag is no longer accepted.  In most *nix environ=
ments the execve()
 approach has been used without any issues.
=20
+Some directives such as \-\-up allow options to be passed to the external
+script. In these cases make sure the script name does not contain any spac=
es or
+the configuration parser will choke because it can't determine where the s=
cript
+name ends and script options start.
+
 To run scripts in Windows in earlier OpenVPN
 versions you needed to either add a full path to the script interpreter wh=
ich can parse the
 script or use the
--=20
2.1.4


