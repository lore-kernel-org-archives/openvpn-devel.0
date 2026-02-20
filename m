From: Gert Doering <gert@...1296...>
Date: Fri, 20 Feb 2026 11:20:58 +0100
Message-ID: <20260220102106.32024-1-gert@...1296...>
In-Reply-To: <gerrit.1771268251000.Ie3f209a641c2f56494dfc7720b13f2a2ba3001a8@...2715...>
References: <gerrit.1771268251000.Ie3f209a641c2f56494dfc7720b13f2a2ba3001a8@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2] configure.ac: adjust to native inotify
 support for FreeBSD 15+
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

FreeBSD 15 has native inotify support, and no "libinotify.pc" pkg config
file anymore, plus no extra includes are needed.  This works fine if we
conditionalize the FreeBSD check to "freebsd-1[0-4]".

Due to m4 involvement double braces are needed for quoting.

See https://bugs.freebsd.org/bugzilla/show_bug.cgi?id=293176

Reported-by: Ivo Karabojkov <karabojkov@...2996...>
Reported-by: Marek Zarychta <zarychtam@...2997...>

Change-Id: Ie3f209a641c2f56494dfc7720b13f2a2ba3001a8
Signed-off-by: Gert Doering <gert@...1296...>
Acked-by: Antonio Quartulli <antonio@...2726...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1535
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1535
This mail reflects revision 2 of this Change.

Acked-by according to Gerrit (reflected above):
Antonio Quartulli <antonio@...2726...>

        
diff --git a/configure.ac b/configure.ac
index 9fa6a41..e151816 100644
--- a/configure.ac
+++ b/configure.ac
@@ -1294,7 +1294,7 @@
 
 if test "${enable_async_push}" = "yes"; then
 	case "$host" in
-		*-*-freebsd*)
+		*-*-freebsd1[[0-4]]*)
 			PKG_CHECK_MODULES(
 				[OPTIONAL_INOTIFY],
 				[libinotify],

