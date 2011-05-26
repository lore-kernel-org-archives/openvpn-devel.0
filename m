From: =?utf-8?q?Samuli=20Sepp=C3=A4nen?= <samuli@...515...>
Date: Thu, 26 May 2011 16:23:04 +0300
Message-Id: <1306416185-4901-4-git-send-email-samuli@...515...>
In-Reply-To: <1306416185-4901-1-git-send-email-samuli@...515...>
References: <1306416185-4901-1-git-send-email-samuli@...515...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 3/4] Fix a Visual Studio 2008 build error in
	tun.c
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

From: Samuli Seppanen <samuli@...515...>

Partially fixes ticket #137

Signed-off-by: Gert Doering <gert@...1296...>
Tested-by: Samuli Sepp=C3=A4nen <samuli@...515...>
Signed-off-by: Samuli Sepp=C3=A4nen <samuli@...515...>
---
 tun.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/tun.c b/tun.c
index 895409a..8cdd248 100644
--- a/tun.c
+++ b/tun.c
@@ -572,7 +572,7 @@ init_tun_post (struct tuntap *tt,
 #endif
 }
=20
-#if defined(TARGET_WIN32) || \
+#if defined(WIN32) || \
     defined(TARGET_DARWIN) || defined(TARGET_NETBSD) || defined(TARGET_OPE=
NBSD)
=20
 /* some of the platforms will auto-add a "network route" pointing
--=20
1.6.3.3


