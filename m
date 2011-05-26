From: =?utf-8?q?Samuli=20Sepp=C3=A4nen?= <samuli@...515...>
Date: Thu, 26 May 2011 16:23:05 +0300
Message-Id: <1306416185-4901-5-git-send-email-samuli@...515...>
In-Reply-To: <1306416185-4901-1-git-send-email-samuli@...515...>
References: <1306416185-4901-1-git-send-email-samuli@...515...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 4/4] Fix a Visual Studio 2008 build error in
	options.c
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

Partially fixes Trac ticket #137

Signed-off-by: Gert Doering <gert@...1296...>
Tested-by: Samuli Sepp=C3=A4nen <samuli@...515...>
Signed-off-by: Samuli Sepp=C3=A4nen <samuli@...515...>
---
 syshead.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/syshead.h b/syshead.h
index 5b86cad..58bfb6c 100644
--- a/syshead.h
+++ b/syshead.h
@@ -342,6 +342,7 @@
=20
 #ifdef WIN32
 #include <iphlpapi.h>
+#include <NtDDNdis.h>
 #include <wininet.h>
 /* The following two headers are needed of USE_PF_INET6 */
 #include <winsock2.h>
--=20
1.6.3.3


