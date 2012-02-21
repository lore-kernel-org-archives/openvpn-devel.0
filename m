From: Alon Bar-Lev <alon.barlev@...277...>
Date: Tue, 21 Feb 2012 03:22:13 +0200
Message-Id: <1329787361-26096-8-git-send-email-alon.barlev@...277...>
In-Reply-To: <1329787361-26096-1-git-send-email-alon.barlev@...277...>
References: <1329787361-26096-1-git-send-email-alon.barlev@...277...>
Subject: [Openvpn-devel] [PATCH 07/35] build: tests do not work disable
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
Cc: Alon Bar-Lev <alon.barlev@...277...>


Signed-off-by: Alon Bar-Lev <alon.barlev@...277...>
---
 Makefile.am |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/Makefile.am b/Makefile.am
index 26b80f3..f96eb45 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -57,16 +57,17 @@ SUBDIRS = \
 	service-win32 \
 	install-win32
 
-TESTS = t_client.sh t_lpback.sh t_cltsrv.sh
+test_scripts = t_client.sh t_lpback.sh t_cltsrv.sh
+#TESTS = $(test_scripts)
 sbin_PROGRAMS = openvpn
 
 dist_doc_DATA = \
 	management/management-notes.txt
 
 dist_noinst_SCRIPTS = \
-	$(TESTS) \
 	doclean \
 	domake-win \
+	$(test_scripts) \
 	t_cltsrv-down.sh \
 	configure_h.awk configure_log.awk
 
-- 
1.7.3.4


