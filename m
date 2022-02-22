From: Kristof Provost <kprovost@...2661...>
Date: Tue, 22 Feb 2022 14:28:24 +0100
Message-Id: <20220222132824.18935-4-kprovost@...2661...>
In-Reply-To: <20220222132824.18935-1-kprovost@...2661...>
References: <20220222132824.18935-1-kprovost@...2661...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 3/3] dco: Check for ipi_addr before using it
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
To: openvpn-devel <openvpn-devel@lists.sourceforge.net>

From: Kristof Provost <kp@...1376...>

If IP_RECVDSTADDR exists we'll define ENABLE_IP_PKTINFO, but that
doesn't actually mean we have struct in_pktinfo. We need to check
HAVE_IN_PKTINFO for that.

This fixes DCO builds on FreeBSD.

Signed-off-by: Kristof Provost <kp@...1376...>
---
 src/openvpn/dco.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/openvpn/dco.c b/src/openvpn/dco.c
index 0ce03664..4234bb22 100644
--- a/src/openvpn/dco.c
+++ b/src/openvpn/dco.c
@@ -44,7 +44,7 @@ static bool
 dco_multi_get_localaddr(struct multi_context *m, struct multi_instance *mi,
                         struct sockaddr_storage *local)
 {
-#if ENABLE_IP_PKTINFO
+#if ENABLE_IP_PKTINFO && defined(HAVE_IN_PKTINFO)
     struct context *c = &mi->context;
 
     if (!(c->options.sockflags & SF_USE_IP_PKTINFO))
-- 
2.35.1


