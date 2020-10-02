From: Gert Doering <gert@...1296...>
Date: Fri,  2 Oct 2020 19:57:36 +0200
Message-Id: <20201002175736.82609-1-gert@...1296...>
In-Reply-To: <63aacbfb-20a0-de78-fccb-bbf8a2ad4189@...2318...>
References: <63aacbfb-20a0-de78-fccb-bbf8a2ad4189@...2318...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Fix redirecting of IPv4 default gateway if
 connecting over IPv6.
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

Commit aa34684972eb0 fixed a long-standing bug in setting the
"route-list" flag RTSA_REMOTE_HOST for IPv4 ("we have a well-defined
remote_host == VPN server IP address") even if connecting over IPv6.

Unfortunately the logic in redirect_default_route_to_vpn() was also
wrong, and refused cooperation if that flag is not set, triggering
the message
    "NOTE: unable to redirect IPv4 default gateway -- Cannot
     obtain current remote host address"

Correct operation: if RTSA_REMOTE_HOST is not set, or remote_host
is IPV4_INVALID_ADDR (= 255.255.255.255), do not try to install a
host route for continued connectivity to the VPN server - which is
not needed when connecting over IPv6.  But the actual *routes*
(/0 or 2 x /1) can be installed just fine.

There is a second bug here, which hits if there is no IPv4 gateway
at all.  In that case, the same function triggers the message
    "NOTE: unable to redirect IPv4 default gateway -- Cannot
     read current default gateway from system"

This is caused by using "IPV4_INVALID_ADDR" as a flag for "do we
know the remote_host?" - which worked before, but after the commit
said above, the "remote_host" field is not well-defined unless
RTSA_REMOTE_HOST is set.  So, change the condition to check that.

Reported-By: François Kooman <fkooman@...2318...>
Reported-By: Thomas Schäfer <tschaefer@...75...>
Trac: #1332

Signed-off-by: Gert Doering <gert@...1296...>
---
 src/openvpn/route.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index d75aa5f4..8037d8b3 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -1011,14 +1011,10 @@ redirect_default_route_to_vpn(struct route_list *rl, const struct tuntap *tt,
          * - we are connecting to a non-IPv4 remote host (i.e. we use IPv6)
          */
         else if (!(rl->rgi.flags & RGI_ADDR_DEFINED) && !local
-                 && (rl->spec.remote_host != IPV4_INVALID_ADDR))
+                 && (rl->spec.flags & RTSA_REMOTE_HOST))
         {
             msg(M_WARN, "%s Cannot read current default gateway from system", err);
         }
-        else if (!(rl->spec.flags & RTSA_REMOTE_HOST))
-        {
-            msg(M_WARN, "%s Cannot obtain current remote host address", err);
-        }
         else
         {
 #ifndef TARGET_ANDROID
@@ -1041,7 +1037,8 @@ redirect_default_route_to_vpn(struct route_list *rl, const struct tuntap *tt,
                 /* route remote host to original default gateway */
                 /* if remote_host is not ipv4 (ie: ipv6), just skip
                  * adding this special /32 route */
-                if (rl->spec.remote_host != IPV4_INVALID_ADDR)
+                if ((rl->spec.flags & RTSA_REMOTE_HOST)
+                    && rl->spec.remote_host != IPV4_INVALID_ADDR)
                 {
                     add_route3(rl->spec.remote_host,
                                IPV4_NETMASK_HOST,
-- 
2.28.0


