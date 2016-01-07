From: Steffan Karger <steffan@...1856...>
Date: Thu,  7 Jan 2016 20:52:44 +0100
Message-Id: <1452196364-18786-1-git-send-email-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH] Update manpage: OpenSSL might also need
	/dev/urandom inside chroot
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

As reported in trac ticket #646, OpenSSL might also need /dev/urandom to
be available in the chroot.  This depends on OS, OS version and ssl library
configuration.  Update the manpage to better explain this.

Signed-off-by: Steffan Karger <steffan@...1856...>
---
 doc/openvpn.8 | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/doc/openvpn.8 b/doc/openvpn.8
index 368bd4c..9760e8b 100644
--- a/doc/openvpn.8
+++ b/doc/openvpn.8
@@ -2139,15 +2139,12 @@ parameter can point to an empty directory, however
 complications can result when scripts or restarts
 are executed after the chroot operation.
 
-Note: if OpenVPN is built using the PolarSSL SSL
-library,
-.B \-\-chroot
-will only work if a /dev/urandom device node is available
-inside the chroot directory
+Note: The SSL library will probably need /dev/urandom to be available inside
+the chroot directory
 .B dir.
-This is due to the way PolarSSL works (it wants to open
-/dev/urandom every time randomness is needed, not just once
-at startup) and nothing OpenVPN can influence.
+This is because SSL libraries occasionally need to collect fresh random.  Newer
+linux kernels and some BSDs implement a getrandom() or getentropy() syscall
+that removes the need for /dev/urandom to be available.
 .\"*********************************************************
 .TP
 .B \-\-setcon context
-- 
2.5.0


