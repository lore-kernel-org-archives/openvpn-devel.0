Date: Fri, 21 Oct 2016 17:46:31 +0200
From: Maximilian Wilhelm <max@...1047...>
Message-ID: <20161021154630.GT25148@...2038...>
MIME-Version: 1.0
Subject: [Openvpn-devel] Allow OpenVPN to communicate to peers via a Linux
	VRF
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: openvpn-devel@lists.sourceforge.net

Hi,

I'm rolling out Linux VRFs[0] in my network and pushed all my external
connections in a VRF, so nothing bad[tm] can happen.

Doing so broke my OpenVPN connections between network nodes, as I kind
of expected.

I tried using the --bind option to let OpenVPN bind to the external IP
for make a connection, but that doesn't work as the IP isn't
resolvable via the main kernel routing table, as it's only visible
within the VRFs routing table.

So I tried pushing the OpenVPN socket into the VRF and that worked
fine.

I massaged that into a --outer-vrf option where a user could specify
the VRF device. This can be found in

  https://github.com/OpenVPN/openvpn/pull/64

The rational why the option is called outer-vrf is that, one might
want to add one for the inner-vrf, when the tun/tap interface should
be part of a VRF. As this could be easily done in an ifup-script I
didn't bother adding this for now.

I'd be glad if this would be accepted.

Best
Max

[0] https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/Documentation/networking/vrf.txt
-- 
They that give up essential liberty to obtain temporary safety,
deserve neither liberty nor safety.  (Ben Franklin)

