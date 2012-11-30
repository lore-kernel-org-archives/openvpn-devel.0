From: Arne Schwabe <arne@...1227...>
Date: Fri, 30 Nov 2012 20:17:47 +0100
Message-Id: <1354303076-13606-1-git-send-email-arne@...1227...>
Subject: [Openvpn-devel] [PATCH 01/10] Remove dnsflags_to_socktype,
	it is not used anywhere
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

---
 src/openvpn/socket.c |    2 +-
 src/openvpn/socket.h |    5 -----
 2 files changed, 1 insertion(+), 6 deletions(-)

diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index 505cf3b..21a4b2b 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -158,7 +158,7 @@ openvpn_getaddrinfo (unsigned int flags,
   CLEAR(hints);
   hints.ai_family = ai_family;
   hints.ai_flags = AI_NUMERICHOST;
-  hints.ai_socktype = dnsflags_to_socktype(flags);
+  hints.ai_socktype = SOCK_STREAM;
 
   status = getaddrinfo(hostname, NULL, &hints, res);
 
diff --git a/src/openvpn/socket.h b/src/openvpn/socket.h
index 44f1098..9cb01fa 100644
--- a/src/openvpn/socket.h
+++ b/src/openvpn/socket.h
@@ -478,11 +478,6 @@ bool unix_socket_get_peer_uid_gid (const socket_descriptor_t sd, int *uid, int *
 #define GETADDR_UPDATE_MANAGEMENT_STATE (1<<8)
 #define GETADDR_RANDOMIZE             (1<<9)
 
-/* [ab]use flags bits to get socktype info downstream */
-/* TODO(jjo): resolve tradeoff between hackiness|args-overhead */
-#define GETADDR_DGRAM                 (1<<10)
-#define dnsflags_to_socktype(flags) ((flags & GETADDR_DGRAM) ? SOCK_DGRAM : SOCK_STREAM)
-
 in_addr_t getaddr (unsigned int flags,
 		   const char *hostname,
 		   int resolve_retry_seconds,
-- 
1.7.9.5


