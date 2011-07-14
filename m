From: samuli@...515...
Date: Wed, 13 Jul 2011 17:12:29 -0700
Message-Id: <1310602349-22195-3-git-send-email-samuli@...515...>
In-Reply-To: <1310602349-22195-1-git-send-email-samuli@...515...>
References: <1310602349-22195-1-git-send-email-samuli@...515...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 2/2] Fixed a typo in win32.h that prevented
	building with Visual Studio
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

Signed-off-by: Samuli Sepp=C3=A4nen <samuli@...515...>
Tested-by: Samuli Sepp=C3=A4nen <samuli@...515...>
---
 win32.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/win32.h b/win32.h
index ca6dd32..528af6c 100644
--- a/win32.h
+++ b/win32.h
@@ -272,7 +272,7 @@ char *get_win_sys_path (void);
=20
 /* call self in a subprocess */
 void fork_to_self (const char *cmdline);
-#ifndef _MSV_VER
+#ifndef _MSC_VER
 const char *inet_ntop(int af, const void *src, char *dst, socklen_t size);
 int inet_pton(int af, const char *src, void *st);
 #endif
--=20
1.7.4.1


