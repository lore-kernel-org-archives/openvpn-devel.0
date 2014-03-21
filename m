From: Arne Schwabe <arne@...1227...>
Date: Fri, 21 Mar 2014 14:18:44 +0100
Message-Id: <1395407925-25518-12-git-send-email-arne@...1227...>
In-Reply-To: <1395407925-25518-1-git-send-email-arne@...1227...>
References: <1395407925-25518-1-git-send-email-arne@...1227...>
Subject: [Openvpn-devel] [PATCH 11/12] Fix assert when using port-share
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
 src/openvpn/ps.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/openvpn/ps.c b/src/openvpn/ps.c
index 901a094..6807aac 100644
--- a/src/openvpn/ps.c
+++ b/src/openvpn/ps.c
@@ -803,7 +803,7 @@ port_share_open (const char *host,
    * Get host's IP address
    */
 
-  status = openvpn_getaddrinfo (GETADDR_RESOLVE|GETADDR_HOST_ORDER|GETADDR_FATAL,
+  status = openvpn_getaddrinfo (GETADDR_RESOLVE|GETADDR_FATAL,
                                  host, port,  0, NULL, AF_INET, &ai);
   ASSERT (status==0);
   hostaddr = *((struct sockaddr_in*) ai->ai_addr);
-- 
1.8.5.2 (Apple Git-48)


