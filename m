Message-ID: <4F6C9753.1080002@...1702...>
Date: Fri, 23 Mar 2012 16:31:31 +0100
From: Samuel CUELLA <samuel.cuella@...1702...>
MIME-Version: 1.0
References: <4F6C68AE.60003@...1702...> <4F6C89F4.9000806@...1114...>
In-Reply-To: <4F6C89F4.9000806@...1114...>
Subject: Re: [Openvpn-devel] [openvpn-devel] OpenVPN 2.1.4/Linux:
 route-gatewy not working
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
To: David Sommerseth <openvpn.list@...1114...>
Cc: openvpn-devel@lists.sourceforge.net

On 03/23/2012 03:34 PM, David Sommerseth wrote:
> 
> Hi Samuel,
> 
> Interesting finding you've found here.  However, we're not developing the
> 2.1 branch any more.  So if you could try the latest git master branch
> [1], that'd be great ... And if that still fails, try to apply your patch
> to see if that improves it.
> 
> There has been some fixes to the whole routing part in 2.2 and 2.3, so we
> need to be sure we're not fixing something which is fixed in a different way.
> 
I've just tested with the git master: same problem with the exact same
cause.

My patch just create an empty route list and set appropriate flags, just
like "redirect-gateway". I've also noted that
redirect_default_route_to_vpn() will only apply the pushed default route
if a default route already exist on the client.

If there is no default route, the pushed default route won't be applied.
Is that an expected/desired behavior ?

Here is the patch against the latest git master:
----
Author: Samuel CUELLA <samuel.cuella@...1702...>

Fix the route-gateway option behavior.

Signed-off-by: Samuel CUELLA <samuel.cuella@...1702...>
----
diff -Nur openvpn-git-orig/options.c openvpn-git/options.c
--- openvpn-git-orig/options.c  2012-03-23 15:59:29.000000000 +0100
+++ openvpn-git/options.c   2012-03-23 17:29:33.000000000 +0100
@@ -5218,6 +5218,7 @@
   else if (streq (p[0], "route-gateway") && p[1])
     {
       VERIFY_PERMISSION (OPT_P_ROUTE_EXTRAS);
+      rol_check_alloc (options);
       if (streq (p[1], "dhcp"))
    {
      options->route_gateway_via_dhcp = true;
@@ -5227,6 +5228,7 @@
      if (ip_or_dns_addr_safe (p[1], options->allow_pull_fqdn) ||
is_special_addr (p[1])) /* FQDN -- may be DNS name */
        {
          options->route_default_gateway = p[1];
+         options->routes->flags |= (RG_ENABLE|RG_REROUTE_GW);
        }
      else
        {


