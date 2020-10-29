From: David Sommerseth <davids@...515...>
Date: Thu, 29 Oct 2020 22:32:59 +0100
Message-Id: <20201029213259.1636-1-davids@...515...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] build: Fix missing install of man page in
 certain environments
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
Cc: Philip Brown <philip@...2584...>

It turns out the logic for dist_man_MANS was incorrectly put inside the
HAVE_PYDOCUTILS block.  This results in the man page being installed
only if python-docutils is installed and available.

The solution is simple, move the dist_man_MANS part outside the
python-docutils block.  The openvpn.8 file is prebuilt in source
tarballs and will thus be available.

Reported-By: Philip Brown <philip@...2584...>
Tested-By: Philip Brown <philip@...2584...>
Signed-off-by: David Sommerseth <davids@...515...>
---

Note: This may have a negative impact on hosts running 'make install'
(which also happens via 'make distcheck') when using the git tree or
otherwise not having a pre-built doc/openvpn.8 file available.
---
 doc/Makefile.am | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/doc/Makefile.am b/doc/Makefile.am
index 340dd553..df2f54a3 100644
--- a/doc/Makefile.am
+++ b/doc/Makefile.am
@@ -67,10 +67,11 @@ dist_html_DATA = openvpn.8.html
 CLEANFILES = \
 	 openvpn.8 openvpn.8.html
 
+endif
+
 if WIN32
 else
 dist_man_MANS = openvpn.8
 endif
-endif
 
 dist-hook : openvpn.8 openvpn.8.html
-- 
2.26.0


