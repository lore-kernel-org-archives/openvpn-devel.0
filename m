Date: Fri, 21 Oct 2016 18:59:26 +0200
From: Maximilian Wilhelm <max@...1047...>
Message-ID: <20161021165926.GV25148@...2038...>
References: <20161021154630.GT25148@...2038...>
MIME-Version: 1.0
In-Reply-To: <20161021154630.GT25148@...2038...>
Subject: Re: [Openvpn-devel] Allow OpenVPN to communicate to peers via a
 Linux VRF
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

Anno domini 2016 Maximilian Wilhelm scripsit:

Hi again,

> I'm rolling out Linux VRFs[0] in my network and pushed all my external
> connections in a VRF, so nothing bad[tm] can happen.
> 
> Doing so broke my OpenVPN connections between network nodes, as I kind
> of expected.
> 
> I tried using the --bind option to let OpenVPN bind to the external IP
> for make a connection, but that doesn't work as the IP isn't
> resolvable via the main kernel routing table, as it's only visible
> within the VRFs routing table.
> 
> So I tried pushing the OpenVPN socket into the VRF and that worked
> fine.
> 
> I massaged that into a --outer-vrf option where a user could specify
> the VRF device. This can be found in
> 
>   https://github.com/OpenVPN/openvpn/pull/64

I just learned that it would be easy to make this more generic and
that the socket option isn't only used/useful for VRFs and created a
new PR for this.

  See https://github.com/OpenVPN/openvpn/pull/65

This basicly does the same thing - specify the bind-device and allows
implementing this for more platforms. I added code for FreeBSD but I
couldn't test this as I don't have a BSD machine available.

> The rational why the option is called outer-vrf is that, one might
> want to add one for the inner-vrf, when the tun/tap interface should
> be part of a VRF. As this could be easily done in an ifup-script I
> didn't bother adding this for now.
> 
> I'd be glad if this would be accepted.

Best
Max
-- 
The real problem with C++ for kernel modules is:
the language just sucks.
-- Linus Torvalds

