Date: Wed, 3 Apr 2024 19:27:13 +0200 (CEST)
Message-Id: <202404031727.433HRDMr095039@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20231201112022.15337-1-frank@...2641...>
References: <20231201112022.15337-1-frank@...2641...>
Subject: [Openvpn-devel] [PATCH applied] Re: Change default of topology to
 subnet
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

Sorry for being so slow in merging this.  I had to adjust my testbeds
to "not explode" and shied away from doing so :-) (all the server test
instances without "topology" defaulted to net30, and just applying this
patch would recreate the ip-pool-persist files, breaking t_client
EXPECT_IFCONFIG4_... settings).

So.

Whoever reads this - *THIS CAN BE DISRUPTIVE*.  But it's the right
way forward, given that DCO (on the server) will only work with
"--topology subnet", and it also saves on IPv4 address usage for
the pools...  and clients have been compatible with "subnet" across
all platforms since at least OpenVPN 2.2, so no excuses.


NOTE: for --server setups, this will still work, just changing the way
the pool is split, thus assigning new IP addresses to clients, and
invalidating the --ip-pool-persist file.

NOTE2: For p2p setups (no --server, just --tls-server/--tls-client or
even --secret) it will break the setup hard, as those usually use 
"--ifconfig ip1 ip2" and "ip2" will now be parsed as a netmask, with
surprising consequences.  See GH #529.


Your patch has been applied to the master branch.

commit 32e6586687a548174b88b64fe54bfae6c74d4c19
Author: Frank Lichtenheld
Date:   Fri Dec 1 12:20:22 2023 +0100

     Change default of topology to subnet

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Arne Schwabe <arne-openvpn@...1227...>
     Message-Id: <20231201112022.15337-1-frank@...2641...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg27627.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


