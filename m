Date: Wed, 1 May 2024 22:12:51 +0200 (CEST)
Message-Id: <202405012012.441KCpav054607@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20240501124254.29114-1-gert@...1296...>
References: <20240501124254.29114-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: Use topology default of subnet
 only for server mode
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
To: Frank Lichtenheld <frank@...2641...>
Cc: openvpn-devel@lists.sourceforge.net

This looks good, and fixes my "reference" test case (p2p, no --server
but --tls-server / --secret, --ifconfig 10.2.3.4 10.2.3.5)

The twisty maze of passages surrounding o->mode is... interesting, but
helper_setdefault_topology() solves this in a reasonable way, I think
(the call inside helper_client_server() could have just set it, if undef,
as "we're server, and dev tun" is already known - but this way it's
"one common code").

I *do* wonder why options.c -> "server" doesn't just set o->mode = MODE_SERVER,
but that's propably lost in the mists of time...

Your patch has been applied to the master branch.

commit 066fcdba9741319fa38cbe40c1761c49727d3f9a (master)
Author: Frank Lichtenheld
Date:   Wed May 1 14:42:54 2024 +0200

     Use topology default of subnet only for server mode

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Arne Schwabe <arne-openvpn@...1227...>
     Message-Id: <20240501124254.29114-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg28592.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


