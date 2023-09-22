From: Frank Lichtenheld <frank@...2641...>
Date: Fri, 22 Sep 2023 18:04:41 +0200
Message-Id: <20230922160441.167168-1-frank@...2641...>
In-Reply-To: <gerrit.1689947729000.If4a67adac4d2e870fd719b58075d39efcd67c671@...2715...>
References: <gerrit.1689947729000.If4a67adac4d2e870fd719b58075d39efcd67c671@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] buffer: use memcpy in buf_catrunc
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
Cc: Antonio Quartulli <a@...2181...>, Heiko Hund <heiko@...515...>, Gert Doering <gert@...1296...>

Since we use strlen() to determine the length
and then check it ourselves, there is really
no point in using strncpy.

But the compiler might complain that we use
the output of strlen() for the length of
strncpy which is usually a sign for bugs:

error: ‘strncpy’ specified bound depends
 on the length of the source argument
 [-Werror=stringop-overflow=]

Warning was at least triggered for
mingw-gcc version 10-win32 20220113.

Also change the type of len to size_t
which avoids potential problems with
signed overflow.

v2:
 - make len size_t and change code to avoid any theoretical overflows
 - remove useless casts
v3:
 - fix off-by-one introduced by v2 %)
v4:
 - ignore unsigned overflow to simplify code

Change-Id: If4a67adac4d2e870fd719b58075d39efcd67c671
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Antonio Quartulli <a@...2181...>
Acked-by: Heiko Hund <heiko@...515...>
Acked-by: Gert Doering <gert@...1296...>
(cherry picked from commit c89a97e449baaf60924a362555d35184f188a646)
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to release/2.6.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/314
This mail reflects revision 1 of this Change.
Acked-by according to Gerrit (reflected above):
Antonio Quartulli <a@...2181...>
Heiko Hund <heiko@...515...>

        
diff --git a/src/openvpn/buffer.c b/src/openvpn/buffer.c
index d099795..7725438 100644
--- a/src/openvpn/buffer.c
+++ b/src/openvpn/buffer.c
@@ -316,10 +316,10 @@
 {
     if (buf_forward_capacity(buf) <= 1)
     {
-        int len = (int) strlen(str) + 1;
+        size_t len = strlen(str) + 1;
         if (len < buf_forward_capacity_total(buf))
         {
-            strncpynt((char *)(buf->data + buf->capacity - len), str, len);
+            memcpy(buf->data + buf->capacity - len, str, len);
         }
     }
 }

