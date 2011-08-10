From: Heiko Hund <heiko.hund@...1489...>
Date: Wed, 10 Aug 2011 12:55:08 +0000
Message-Id: <1312980908-25157-3-git-send-email-heiko.hund@...1489...>
In-Reply-To: <1312980908-25157-1-git-send-email-heiko.hund@...1489...>
References: <1312980908-25157-1-git-send-email-heiko.hund@...1489...>
Subject: [Openvpn-devel] [PATCH 2/2] don't use struct in6_addr s6_addr32
	member anymore
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

The s6_addr32 member of struct in6_addr is not available when building
for WIN32. To work around this, a local union is defined that allows
accessing 32 bit chunks of the IPv6 address passed to add_in6_addr().

Signed-off-by: Heiko Hund <heiko.hund@...1489...>
---
 socket.c |   16 +++++++---------
 1 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/socket.c b/socket.c
index 6b855c0..887569c 100644
--- a/socket.c
+++ b/socket.c
@@ -2622,13 +2622,6 @@ print_in6_addr (struct in6_addr a6, unsigned int flags, struct gc_arena *gc)
 /* add some offset to an ipv6 address
  * (add in steps of 32 bits, taking overflow into next round)
  */
-#ifndef s6_addr32
-# ifdef TARGET_SOLARIS
-#  define s6_addr32 _S6_un._S6_u32
-# else
-#  define s6_addr32 __u6_addr.__u6_addr32
-# endif
-#endif
 #ifndef UINT32_MAX
 # define UINT32_MAX (4294967295U)
 #endif
@@ -2637,10 +2630,15 @@ struct in6_addr add_in6_addr( struct in6_addr base, uint32_t add )
     int i;
     uint32_t h;
 
+    union {
+      uint8_t  *addr;
+      uint32_t *addr32;
+    } in6 = { .addr = base.s6_addr };
+
     for( i=3; i>=0 && add > 0 ; i-- )
     {
-	h = ntohl( base.s6_addr32[i] );
-	base.s6_addr32[i] = htonl( (h+add) & UINT32_MAX );
+	h = ntohl( in6.addr32[i] );
+	in6.addr32[i] = htonl( (h+add) & UINT32_MAX );
 	/* 32-bit overrun? 
 	 * caveat: can't do "h+add > UINT32_MAX" with 32bit math!
          */
-- 
1.7.5.4


