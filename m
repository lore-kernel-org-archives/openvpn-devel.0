From: =?utf-8?q?Samuli=20Sepp=C3=A4nen?= <samuli@...515...>
Date: Tue, 31 May 2011 16:17:40 +0300
Message-Id: <1306847860-11695-1-git-send-email-samuli@...515...>
In-Reply-To: <1306416185-4901-1-git-send-email-samuli@...515...>
References: <1306416185-4901-1-git-send-email-samuli@...515...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Fix a Visual Studio 2008 build issue in
	socket.c
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
To: openvpn-devel@lists.sourceforge.net

Signed-off-by: Gert Doering <gert@...1296...>
Signed-off-by: Samuli Sepp=C3=A4nen <samuli@...515...>
---
 socket.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/socket.c b/socket.c
index 69be132..6659bcc 100644
--- a/socket.c
+++ b/socket.c
@@ -647,8 +647,9 @@ update_remote (const char* host,
       if (host && addr)
         {
           struct sockaddr_in6 sin6;
+          int success;
           CLEAR(sin6);
-          int success =3D getaddr6 (
+          success =3D getaddr6 (
                                     sf2gaf(GETADDR_RESOLVE|GETADDR_UPDATE_=
MANAGEMENT_STATE, sockflags),
                                     host,
                                     1,
--=20
1.6.3.3


