From: Maximilian Wilhelm <max@...1047...>
Date: Mon,  3 Sep 2007 01:14:00 +0200
Message-Id: <11887748431923-git-send-email-max@...1047...>
In-Reply-To: <11887748431930-git-send-email-max@...1047...>
References: <11887748431930-git-send-email-max@...1047...>
Subject: [Openvpn-devel] [PATCH] Let Makefile.am build wtmp, too.
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

Signed-off-by: Maximilian Wilhelm <max@...1047...>
---
 Makefile.am |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/Makefile.am b/Makefile.am
index 36e2cf9..6384857 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -94,7 +94,8 @@ openvpn_SOURCES = \
 	status.c status.h \
 	syshead.h \
 	thread.c thread.h \
-	tun.c tun.h
+	tun.c tun.h \
+	wtmp.c wtmp .h
 
 LDADD = @LIBOBJS@
 
-- 
1.5.2.4


