From: Frank Lichtenheld <frank@...2641...>
Date: Wed, 21 Feb 2024 12:18:14 +0100
Message-Id: <20240221111814.942965-1-frank@...2641...>
In-Reply-To: <gerrit.1707986932000.I8a67b82eb4afdc8d82c5a879c18457b41e77cbe7@...2715...>
References: <gerrit.1707986932000.I8a67b82eb4afdc8d82c5a879c18457b41e77cbe7@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2] Route: remove incorrect routes on exit
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

From: Gianmarco De Gregori <gianmarco@...2726...>

Implemented a safeguard to verify the returned value
from add_route3() when the default gateway is not a local
remote host.

Prior to this implementation, RT_DID_LOCAL flag was
erroneously set even in case of add_route3() failure.
This problem typically occurs when there's no default
route and the --redirect-gateway def1 option is specified,
and in case of reconnection makes it impossible for the client
to reobtain the route to the server.
This fix ensures OpenVPN accurately deletes the appropriate
route on exit by properly handling add_route3() return value.

Fixes: Trac #1457
Change-Id: I8a67b82eb4afdc8d82c5a879c18457b41e77cbe7
Signed-off-by: Gianmarco De Gregori <gianmarco@...2726...>
Acked-by: Frank Lichtenheld <frank@...2641...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/522
This mail reflects revision 2 of this Change.
Acked-by according to Gerrit (reflected above):
Frank Lichtenheld <frank@...2641...>

        
diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index 6c027d9..6ab4392 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -1055,7 +1055,10 @@
                     ret = add_route3(rl->spec.remote_host, IPV4_NETMASK_HOST,
                                      rl->rgi.gateway.addr, tt, flags | ROUTE_REF_GW,
                                      &rl->rgi, es, ctx);
-                    rl->iflags |= RL_DID_LOCAL;
+                    if (ret)
+                    {
+                        rl->iflags |= RL_DID_LOCAL;
+                    }
                 }
                 else
                 {

