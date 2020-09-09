From: selva.nair@...277...
Date: Wed,  9 Sep 2020 18:15:29 -0400
Message-Id: <1599689729-25906-1-git-send-email-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH] Add a remark on dropping privileges when
 --mlock is used
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

From: Selva Nair <selva.nair@...277...>

trac #1059

Signed-off-by: Selva Nair <selva.nair@...277...>
---
 doc/man-sections/generic-options.rst | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/doc/man-sections/generic-options.rst b/doc/man-sections/generic-options.rst
index a07fe7e..d5f0883 100644
--- a/doc/man-sections/generic-options.rst
+++ b/doc/man-sections/generic-options.rst
@@ -230,6 +230,13 @@ which mode OpenVPN is configured as.
   The downside of using ``--mlock`` is that it will reduce the amount of
   physical memory available to other applications.
 
+  The limit on how much memory can be locked and how that limit
+  is enforced are OS-dependent. On Linux the default limit that an
+  unprivileged process may lock (RLIMIT_MEMLOCK) is low, and if
+  privileges are dropped later, future memory allocations will very
+  likely fail. The limit can be increased using ulimit or systemd
+  directives depending on how OpenVPN is started.
+
 --nice n
   Change process priority after initialization (``n`` greater than 0 is
   lower priority, ``n`` less than zero is higher priority).
-- 
2.1.4


