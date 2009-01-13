Date: Tue, 13 Jan 2009 10:43:52 -0700
From: Ryan <openvpn-devel@...1183...>
Message-ID: <20090113174352.GA12597@...1184...>
MIME-Version: 1.0
Subject: [Openvpn-devel] topology subnet and route/iroute
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: openvpn-devel@lists.sourceforge.net

Hello,

I looked in the changelogs, bugs, and lists and I did not find anything
about this particular issue. I am using openvpn 2.1 rc11 and topology
subnet. I have a route line for 10.0.0.0/8 and a iroute line for the
same subnet. This works perfectly with net30 and p2p topologies but with
the subnet topology I get this error on the server:

OpenVPN ROUTE: failed to parse/resolve route for host/network: 10.0.0.0
work/xxx.228.234.5:42077 MULTI: internal route 10.0.0.0/8 ->
work/xxx.228.234.5:42077

And the route does not show up on the server. This may be a known issue
and I have not tried it on the latest release candidate.

By the way, I did not see any formal bug reporting policy so hopefully
this was the correct list.

Thanks!
Ryan

