From: Gert Doering <gert@...1296...>
Date: Mon,  6 Oct 2025 19:04:58 +0200
Message-ID: <20251006170504.7235-1-gert@...1296...>
In-Reply-To: <gerrit.1759763846000.I8919c9efdf85424a124a0d54593cd1dbf3bc2341@...2715...>
References: <gerrit.1759763846000.I8919c9efdf85424a124a0d54593cd1dbf3bc2341@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2] mtu: Trivial -Wconversion fix
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

From: Frank Lichtenheld <frank@...2641...>

Just use the correct type.

Change-Id: I8919c9efdf85424a124a0d54593cd1dbf3bc2341
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1250
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1250
This mail reflects revision 2 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/src/openvpn/mtu.c b/src/openvpn/mtu.c
index 66f81a6..9e152df 100644
--- a/src/openvpn/mtu.c
+++ b/src/openvpn/mtu.c
@@ -280,15 +280,9 @@
     struct timeval tv;
 };
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wconversion"
-#endif
-
 const char *
 format_extended_socket_error(int fd, int *mtu, struct gc_arena *gc)
 {
-    int res;
     struct probehdr rcvbuf;
     struct iovec iov;
     struct msghdr msg;
@@ -313,7 +307,7 @@
         msg.msg_control = cbuf;
         msg.msg_controllen = 256; /* size of cbuf */
 
-        res = recvmsg(fd, &msg, MSG_ERRQUEUE);
+        ssize_t res = recvmsg(fd, &msg, MSG_ERRQUEUE);
         if (res < 0)
         {
             goto exit;
@@ -394,10 +388,6 @@
     return BSTR(&out);
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
-
 void
 set_sock_extended_error_passing(int sd, sa_family_t proto_af)
 {

