From: Arne Schwabe <arne@...1227...>
Date: Thu,  1 Apr 2021 15:13:30 +0200
Message-Id: <20210401131337.3684-8-arne@...1227...>
In-Reply-To: <20210401131337.3684-1-arne@...1227...>
References: <20210401131337.3684-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH 07/14] Remove unused field txqueuelen from
 struct tuntap
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

The code uses tuntap->options.txqueuelen instead.

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/tun.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/src/openvpn/tun.h b/src/openvpn/tun.h
index 7e8fb7647..60ebfdcba 100644
--- a/src/openvpn/tun.h
+++ b/src/openvpn/tun.h
@@ -165,9 +165,6 @@ struct tuntap
 
     char *actual_name; /* actual name of TUN/TAP dev, usually including unit number */
 
-    /* number of TX buffers */
-    int txqueuelen;
-
     /* ifconfig parameters */
     in_addr_t local;
     in_addr_t remote_netmask;
-- 
2.30.1


