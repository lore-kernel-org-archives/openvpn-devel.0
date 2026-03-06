From: Gert Doering <gert@...1296...>
Date: Fri,  6 Mar 2026 17:31:56 +0100
Message-ID: <20260306163202.2586-1-gert@...1296...>
In-Reply-To: <gerrit.1771008284000.Idf5ce8f82e7727505cce67560e0b7423b8e41a40@...2715...>
References: <gerrit.1771008284000.Idf5ce8f82e7727505cce67560e0b7423b8e41a40@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v3] socket: Avoid sign-compare issue by
 comparing before assignment
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

The assignment implicitly converts the values, but
we can just do the comparison before the assignment.

Change-Id: Idf5ce8f82e7727505cce67560e0b7423b8e41a40
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1523
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1523
This mail reflects revision 3 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index 8d2d110..5df0792 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -2550,11 +2550,6 @@
     return WSAGetLastError();
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wsign-compare"
-#endif
-
 int
 socket_recv_queue(struct link_socket *sock, int maxsize)
 {
@@ -2579,11 +2574,10 @@
 
         /* Win32 docs say it's okay to allocate the wsabuf on the stack */
         wsabuf[0].buf = BSTR(&sock->reads.buf);
+        /* make sure maxsize is sane */
+        ASSERT(maxsize <= BLEN(&sock->reads.buf));
         wsabuf[0].len = maxsize ? maxsize : BLEN(&sock->reads.buf);
 
-        /* check for buffer overflow */
-        ASSERT(wsabuf[0].len <= BLEN(&sock->reads.buf));
-
         /* the overlapped read will signal this event on I/O completion */
         ASSERT(ResetEvent(sock->reads.overlapped.hEvent));
         sock->reads.flags = 0;
@@ -2656,10 +2650,6 @@
     return sock->reads.iostate;
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
-
 int
 socket_send_queue(struct link_socket *sock, struct buffer *buf, const struct link_socket_actual *to)
 {

