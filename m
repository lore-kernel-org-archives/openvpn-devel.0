From: Frank Lichtenheld <frank@...2641...>
Date: Fri,  3 Feb 2023 20:14:40 +0100
Message-Id: <20230203191440.136050-6-frank@...2641...>
In-Reply-To: <20230203191440.136050-1-frank@...2641...>
References: <20230203191440.136050-1-frank@...2641...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 5/5] Windows: fix signedness errors with
 recv/send
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

On Linux those functions actually take void pointer,
so no behavior change there. On Windows, we avoid
warnings about unsigned char vs char.

Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
 src/openvpn/manage.c | 4 ++--
 src/openvpn/proxy.c  | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c
index 8397d3cf..3ea1992b 100644
--- a/src/openvpn/manage.c
+++ b/src/openvpn/manage.c
@@ -2251,7 +2251,7 @@ man_read(struct management *man)
         man->connection.lastfdreceived = fd;
     }
 #else  /* ifdef TARGET_ANDROID */
-    len = recv(man->connection.sd_cli, buf, sizeof(buf), MSG_NOSIGNAL);
+    len = recv(man->connection.sd_cli, (void *)buf, sizeof(buf), MSG_NOSIGNAL);
 #endif
 
     if (len == 0)
@@ -2348,7 +2348,7 @@ man_write(struct management *man)
         }
         else
 #endif
-        sent = send(man->connection.sd_cli, BPTR(buf), len, MSG_NOSIGNAL);
+        sent = send(man->connection.sd_cli, (const void *)BPTR(buf), len, MSG_NOSIGNAL);
         if (sent >= 0)
         {
             buffer_list_advance(man->connection.out, sent);
diff --git a/src/openvpn/proxy.c b/src/openvpn/proxy.c
index aa10363c..ed47eaa2 100644
--- a/src/openvpn/proxy.c
+++ b/src/openvpn/proxy.c
@@ -126,7 +126,7 @@ recv_line(socket_descriptor_t sd,
         }
 
         /* read single char */
-        size = recv(sd, &c, 1, MSG_NOSIGNAL);
+        size = recv(sd, (void *)&c, 1, MSG_NOSIGNAL);
 
         /* error? */
         if (size != 1)
-- 
2.34.1


