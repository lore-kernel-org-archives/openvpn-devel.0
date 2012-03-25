From: Alon Bar-Lev <alon.barlev@...277...>
Date: Sun, 25 Mar 2012 13:27:02 +0200
Message-Id: <1332674822-10508-1-git-send-email-alon.barlev@...277...>
Subject: [Openvpn-devel] [PATCH] cleanup: flags should not be bool
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
To: Openvpn-devel@lists.sourceforge.net
Cc: Alon Bar-Lev <alon.barlev@...277...>

Discussed at [1][2][3].

[1] https://bugs.gentoo.org/show_bug.cgi?id=297854#c2
[2] https://297854.bugs.gentoo.org/attachment.cgi?id=214304
[3] http://sourceforge.net/mailarchive/forum.php?thread_name=20120325111517.GI1359%40greenie.muc.de&forum_name=openvpn-devel

Signed-off-by: Alon Bar-Lev <alon.barlev@...277...>
---
 src/openvpn/socket.c |    6 +++---
 src/openvpn/socket.h |    6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index 608213b..6b1f8d2 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -2606,7 +2606,7 @@ struct in6_addr add_in6_addr( struct in6_addr base, uint32_t add )
 
 /* set environmental variables for ip/port in *addr */
 void
-setenv_sockaddr (struct env_set *es, const char *name_prefix, const struct openvpn_sockaddr *addr, const bool flags)
+setenv_sockaddr (struct env_set *es, const char *name_prefix, const struct openvpn_sockaddr *addr, const unsigned int flags)
 {
   char name_buf[256];
 
@@ -2643,7 +2643,7 @@ setenv_sockaddr (struct env_set *es, const char *name_prefix, const struct openv
 }
 
 void
-setenv_in_addr_t (struct env_set *es, const char *name_prefix, in_addr_t addr, const bool flags)
+setenv_in_addr_t (struct env_set *es, const char *name_prefix, in_addr_t addr, const unsigned int flags)
 {
   if (addr || !(flags & SA_SET_IF_NONZERO))
     {
@@ -2659,7 +2659,7 @@ void
 setenv_link_socket_actual (struct env_set *es,
 			   const char *name_prefix,
 			   const struct link_socket_actual *act,
-			   const bool flags)
+			   const unsigned int flags)
 {
   setenv_sockaddr (es, name_prefix, &act->dest, flags);
 }
diff --git a/src/openvpn/socket.h b/src/openvpn/socket.h
index 4a4f75d..ef21cb6 100644
--- a/src/openvpn/socket.h
+++ b/src/openvpn/socket.h
@@ -372,17 +372,17 @@ struct in6_addr add_in6_addr( struct in6_addr base, uint32_t add );
 void setenv_sockaddr (struct env_set *es,
 		      const char *name_prefix,
 		      const struct openvpn_sockaddr *addr,
-		      const bool flags);
+		      const unsigned int flags);
 
 void setenv_in_addr_t (struct env_set *es,
 		       const char *name_prefix,
 		       in_addr_t addr,
-		       const bool flags);
+		       const unsigned int flags);
 
 void setenv_link_socket_actual (struct env_set *es,
 				const char *name_prefix,
 				const struct link_socket_actual *act,
-				const bool flags);
+				const unsigned int flags);
 
 void bad_address_length (int actual, int expected);
 
-- 
1.7.3.4


