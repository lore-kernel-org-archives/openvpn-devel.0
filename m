From: Gert Doering <gert@...1296...>
Date: Wed,  9 Sep 2020 14:22:23 +0200
Message-Id: <20200909122223.9222-1-gert@...1296...>
In-Reply-To: <20200909120707.8663-1-gert@...1296...>
References: <20200909120707.8663-1-gert@...1296...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v3] socks.c: fix alen for DOMAIN type
 addresses, bump up buffer sizes
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

When a SOCKS5 server sends back a reply, it encodes an "address",
which can be IPv4 (4 bytes), IPv6 (16 bytes) or "a domain name",
which has a lenght (1 byte) and "a string of length <length>" - so
when copying bytes, we need to hande "length +1" bytes.

Our code totally doesn't use this variant of addresses on reception,
but since this has been pointed out by "tpw_rules" in Trac, fix it,
so if/when someone works on this again, the foundation is correct.

While at it, increase buffer size used for sending to handle domain
names longer than 122 characters (length was already checked, so a
longer name would not overflow but just "not work").

v2: increase buf[] len in recv_socks_reply() from 22 to 270 so it
    is large enough to actually copy a domain name

v3: increase buf[] len in establish_socks_proxy_passthru() from 128 to
    270, to handle long domain names in queries

Reported-By: tpw_rules in Trac
Trac: #848

Signed-off-by: Gert Doering <gert@...1296...>
---
 src/openvpn/socks.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/src/openvpn/socks.c b/src/openvpn/socks.c
index 57f0cee2..d43d84a8 100644
--- a/src/openvpn/socks.c
+++ b/src/openvpn/socks.c
@@ -312,7 +312,7 @@ recv_socks_reply(socket_descriptor_t sd,
     char atyp = '\0';
     int alen = 0;
     int len = 0;
-    char buf[22];
+    char buf[270];		/* 4 + alen(max 256) + 2 */
     const int timeout_sec = 5;
 
     if (addr != NULL)
@@ -381,7 +381,10 @@ recv_socks_reply(socket_descriptor_t sd,
                     break;
 
                 case '\x03':    /* DOMAINNAME */
-                    alen = (unsigned char) c;
+                    /* RFC 1928, section 5: 1 byte length, <n> bytes name,
+                     * so the total "address length" is (length+1)
+                     */
+                    alen = (unsigned char) c +1;
                     break;
 
                 case '\x04':    /* IP V6 */
@@ -451,7 +454,7 @@ establish_socks_proxy_passthru(struct socks_proxy_info *p,
                                const char *servname,    /* openvpn server port */
                                volatile int *signal_received)
 {
-    char buf[128];
+    char buf[270];
     size_t len;
 
     if (!socks_handshake(p, sd, signal_received))
-- 
2.26.2


