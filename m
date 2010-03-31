Message-ID: <20100331233557.5889.qmail@...1287...>
Date: Thu, 1 Apr 2010 01:35:57 +0200
From: Peter Stuge <peter@...1287...>
References: <cover.1270060247.git.fabian.knittel@...1338...>
	<4BB3D6A3.7020207@...1114...>
MIME-Version: 1.0
In-Reply-To: <4BB3D6A3.7020207@...1114...>
Subject: Re: [Openvpn-devel] [RFC][PATCH 0/9] VLAN tagging on TAP devices	in
	OpenVPN server mode
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

David Sommerseth wrote:
> I'll admit I don't understand too much how the VLAN's really work in
> core network code.

There's a prefix, and a wrapper to create virtual interfaces. And
there's the vconfig tool to do configuration. NIC drivers need to
support oversize frames.

vconfig add eth0 4  # VLAN 4 will be tagged on eth0

So to test this, one could do:

vconfig add tap0 4  # Creates tap9.4 which is VLAN 4 on tap9

Then run openvpn --mode server --vlan-tag 4 on that tap0, and client
traffic should then come out of tap0.4 rather than tap0.


> I'll try to find some time to read through the patches once more.
> 
> [* Other reviewers are most welcome to have a look as well! *]

I think they looked okey, apart from the things I pointed out
already.


> You scare at least me when stating that this code "was originally
> only intended as a proof of concept", which is why I'm not signing
> off these patches immediately and giving you a feature branch.
> But I'm open for full inclusion!

I'm generally in favor too. Although originally PoC I think this
looks like good quality now, and VLANs are actually really simple.

I would like to request extra special thorough review of broadcast
domain separation though, so that it's certain that nothing will jump
VLANs.


//Peter

