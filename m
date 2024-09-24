Date: Tue, 24 Sep 2024 14:18:03 +0200 (CEST)
Message-Id: <202409241218.48OCI3lB077179@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20240924110130.3910-1-gert@...1296...>
References: <20240924110130.3910-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: Introduce DRIVER_AFUNIX backend
 for use with lwipovpn
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
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net

This patch "in itself" is not that complex, but the implications on
testing ("run server and client on the same machine, do a full 'ping'
or even 'http' through the tunnel without namespace/VRF/... support")
are very nice :-) 

Stared-at-code, fed to GHA and local test builds, and ran one of
my t_client.rc stanzas with

  ... --dev-node $path/lwipovpn --ifconfig-noexec --route-noexec

and lo and behold :-)

lwipovpn init complete: type=tun mtu=1500 local_ip=10.194.2.54 netmask=(not set) gw=(not set) local_ipv6=FD00:ABCD:194:2::100C

  ... ping through the tunnel works.

This patch itself is still rough (needs explicit --ifconfig-noexec, 
triggers some warnings about "ifconfig_netmask=(not set)", etc.) but
that is fixed by the following patches in the series.

As discussed on IRC and noted in Gerrit, I have unwrapped the
missing-space-word-wrapped "offload" - our 80 char line length is
a somewhat soft limit, in case wrapping gets even more ugly.

Your patch has been applied to the master branch.

commit d0a93625a335fdc42fff808c9e9d2b62b232eef2
Author: Arne Schwabe
Date:   Tue Sep 24 13:01:29 2024 +0200

     Introduce DRIVER_AFUNIX backend for use with lwipovpn

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20240924110130.3910-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg29379.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


