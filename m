From: Frank Lichtenheld <frank@...2641...>
Date: Fri, 22 Sep 2023 12:39:00 +0200
Message-Id: <20230922103900.37205-1-frank@...2641...>
In-Reply-To: <gerrit.1695305263000.I30f4ea502a36eca155cbc79b89c0d18ee3419877@...2715...>
References: <gerrit.1695305263000.I30f4ea502a36eca155cbc79b89c0d18ee3419877@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] CMake: fix HAVE_DAEMON detection on Linux
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
Cc: Lev Stipakov <lev@...515...>, Gert Doering <gert@...1296...>

From: Lev Stipakov <lev@...515...>

On Linux, daemon() is defined in unistd.h, not in
stdlib.h like in MacOS or FreeBSD.

Change-Id: I30f4ea502a36eca155cbc79b89c0d18ee3419877
Signed-off-by: Lev Stipakov <lev@...515...>
Acked-by: Gert Doering <gert@...1296...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/362
This mail reflects revision 1 of this Change.
Acked-by according to Gerrit (reflected above):
cron2 <cron2>

        
diff --git a/CMakeLists.txt b/CMakeLists.txt
index 9de6aba..76351c1 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -158,7 +158,7 @@
 check_symbol_exists(gettimeofday sys/time.h HAVE_GETTIMEOFDAY)
 check_symbol_exists(basename libgen.h HAVE_BASENAME)
 check_symbol_exists(chsize io.h HAVE_CHSIZE)
-check_symbol_exists(daemon stdlib.h HAVE_DAEMON)
+check_symbol_exists(daemon "unistd.h;stdlib.h" HAVE_DAEMON)
 check_symbol_exists(dirname libgen.h HAVE_DIRNAME)
 check_symbol_exists(getrlimit sys/resource.h HAVE_GETRLIMIT)
 check_symbol_exists(mlockall sys/mman.h HAVE_MLOCKALL)

