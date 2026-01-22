From: Frank Lichtenheld <frank@...2641...>
Date: Thu, 22 Jan 2026 16:47:51 +0100
Message-ID: <20260122154751.155227-1-frank@...2641...>
In-Reply-To: <gerrit.1769015758000.Iff1343a2f8cc7e32b8f36b359a00248e4dc3e8c9@...2715...>
References: <gerrit.1769015758000.Iff1343a2f8cc7e32b8f36b359a00248e4dc3e8c9@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2] status: Avoid conversion warnings in
 status_read/status_printf
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

Just use explicit casts. len is limited by BCAP and
c is limited by being from buf_read_u8. So they are
safe.

In case of status_printf this is only for Windows.
len is limited by sizeof(buf), so also a safe cast.

Change-Id: Iff1343a2f8cc7e32b8f36b359a00248e4dc3e8c9
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1485
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1485
This mail reflects revision 2 of this Change.

Acked-by according to Gerrit (reflected above):

        
diff --git a/src/openvpn/status.c b/src/openvpn/status.c
index 3f57244..d09f367 100644
--- a/src/openvpn/status.c
+++ b/src/openvpn/status.c
@@ -206,11 +206,6 @@
     return ret;
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wconversion"
-#endif
-
 #define STATUS_PRINTF_MAXLEN 512
 
 void
@@ -243,7 +238,7 @@
             size_t len = strlen(buf);
             if (len > 0)
             {
-                if (write(so->fd, buf, len) != len)
+                if (write(so->fd, buf, (unsigned int)len) != len)
                 {
                     so->errors = true;
                 }
@@ -274,16 +269,14 @@
             /* read more of file into buffer */
             if (c == -1)
             {
-                int len;
-
                 ASSERT(buf_init(&so->read_buf, 0));
-                len = read(so->fd, BPTR(&so->read_buf), BCAP(&so->read_buf));
+                ssize_t len = read(so->fd, BPTR(&so->read_buf), BCAP(&so->read_buf));
                 if (len <= 0)
                 {
                     break;
                 }
 
-                ASSERT(buf_inc_len(&so->read_buf, len));
+                ASSERT(buf_inc_len(&so->read_buf, (int)len));
                 continue;
             }
 
@@ -299,7 +292,7 @@
                 break;
             }
 
-            buf_write_u8(buf, c);
+            buf_write_u8(buf, (uint8_t)c);
         }
 
         buf_null_terminate(buf);
@@ -307,7 +300,3 @@
 
     return ret;
 }
-
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif

