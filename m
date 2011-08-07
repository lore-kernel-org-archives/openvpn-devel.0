From: Bertrand Jacquin <beber@...1472...>
Date: Sun,  7 Aug 2011 12:59:17 +0200
Message-Id: <1312714757-10317-5-git-send-email-beber@...1472...>
In-Reply-To: <1312714757-10317-1-git-send-email-beber@...1472...>
References: <1312714757-10317-1-git-send-email-beber@...1472...>
Subject: [Openvpn-devel] [PATCH 4/4] Win32: Fill "Details" properties for
	openvpnserv.exe
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

Signed-off-by: Bertrand Jacquin <beber@...1472...>
---
 service-win32/Makefile.am |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/service-win32/Makefile.am b/service-win32/Makefile.am
index 4e4f55e..bb7b993 100644
--- a/service-win32/Makefile.am
+++ b/service-win32/Makefile.am
@@ -32,6 +32,14 @@ openvpnserv_SOURCES = \
 	openvpnserv.c \
 	service.h service.c
 
+openvpnserv_LDADD = \
+	../openvpn-res.o
+
+comma = ,
+
+%.o: %.rc
+	$(WINDRES) -D _VERSION_=$(subst .,$(comma),$(VERSION)),0 -i $< -o $@
+
 else
 
 dist_noinst_DATA = \
-- 
1.7.6


