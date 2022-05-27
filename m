From: Heiko Hund <heiko@...2662...>
Date: Fri, 27 May 2022 03:24:54 +0200
Message-Id: <20220527012457.1819262-2-heiko@...2662...>
In-Reply-To: <20220527012457.1819262-1-heiko@...2662...>
References: <20220527012457.1819262-1-heiko@...2662...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 1/4] remove foreign_option() call for IPv6
 DNS servers
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

The call survived since the initial commit 94bfc256d, where it was added
as a fallback, since no IPv6 DNS server handling was implemented at the
time. Now there's dhcp_option_dns6_parse() which adds the servers to the
tuntap options, just like how it is done with the v4 servers.

Signed-off-by: Heiko Hund <heiko@...2662...>
---
 src/openvpn/options.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 20cc849d..65f4d889 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -7825,7 +7825,6 @@ add_option(struct options *options,
             if (strstr(p[2], ":"))
             {
                 ipv6dns = true;
-                foreign_option(options, p, 3, es);
                 dhcp_option_dns6_parse(p[2], o->dns6, &o->dns6_len, msglevel);
             }
             else
-- 
2.32.0


