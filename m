From: Bertrand Jacquin <beber@...1472...>
Date: Sun,  7 Aug 2011 12:59:16 +0200
Message-Id: <1312714757-10317-4-git-send-email-beber@...1472...>
In-Reply-To: <1312714757-10317-1-git-send-email-beber@...1472...>
References: <1312714757-10317-1-git-send-email-beber@...1472...>
Subject: [Openvpn-devel] [PATCH 3/4] Win32: Fill "Details" properties for
	openvpn.exe
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
 Makefile.am |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/Makefile.am b/Makefile.am
index 32b40bb..d5d620d 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -146,6 +146,13 @@ openvpn_SOURCES = \
 	win32.h win32.c \
 	cryptoapi.h cryptoapi.c
 
+if WIN32
+openvpn_SOURCES += openvpn-res.rc
+
+openvpn_LDADD = openvpn-res.o
+endif
+
+
 nodist_openvpn_SOURCES = configure.h
 options.$(OBJEXT): configure.h
 
@@ -161,6 +168,11 @@ dist_noinst_DATA += openvpn.8
 nodist_html_DATA = openvpn.8.html
 openvpn.8.html: $(srcdir)/openvpn.8
 	$(MAN2HTML) < $(srcdir)/openvpn.8 > openvpn.8.html
+
+comma = ,
+
+%.o: %.rc
+	$(WINDRES) -D _VERSION_=$(subst .,$(comma),$(VERSION)),0 -i $< -o $@
 else
 dist_man_MANS = openvpn.8
 endif
-- 
1.7.6


