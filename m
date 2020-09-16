From: David Sommerseth <davids@...515...>
Date: Wed, 16 Sep 2020 21:56:16 +0200
Message-Id: <20200916195616.30633-1-davids@...515...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] build: Fix make distclean/distcheck
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

In commit 0b5141d8f94 the sample-plugins got partially migrated to
automake.  But since it was not fully integrated within the full
standard build, the sample/sample-plugins/Makefile was not removed
by 'make distclean', which annoys 'make distcheck'.

The simplest way is just to explicitly enlist this Makefile in the list
of files 'make distclean' should remove.

Signed-off-by: David Sommerseth <davids@...515...>
---
 sample/Makefile.am | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sample/Makefile.am b/sample/Makefile.am
index 3be698e7..46d113ab 100644
--- a/sample/Makefile.am
+++ b/sample/Makefile.am
@@ -12,6 +12,9 @@
 MAINTAINERCLEANFILES = \
 	$(srcdir)/Makefile.in
 
+DISTCLEANFILES = \
+       $(builddir)/sample-plugins/Makefile
+
 EXTRA_DIST = \
 	sample-plugins \
 	sample-config-files \
-- 
2.26.0


