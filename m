Message-ID: <4EE08E3A.7010209@...1114...>
Date: Thu, 08 Dec 2011 11:15:22 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <d3f7c10b2411aa41afce3788970ca839@...1528...>
In-Reply-To: <d3f7c10b2411aa41afce3788970ca839@...1528...>
Subject: Re: [Openvpn-devel] [PATCH] Add option to disable priority tagged
 packets (VID=0)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: michael-dev <michael-dev@...1528...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


Adding Fabian to Cc, he knows more about the VLAN code.

With this feedback, I'm willing merge in the feat_vlan_tagging branch
into master.  I'm not sure if this should happen now in the v2.3 time
frame (which is getting more and more ready for alpha/beta releases), or
if we will take it in the next round with v2.4.  But I will bring that up
for discussion soonish.


kind regards,

David Sommerseth


On 08/12/11 09:33, michael-dev wrote:
> This patch adds an option to disable the creation of tagged priority
> packets with VID=0. This is for the feature_vlan_tagging
> openvpn-testing head.
> 
> I tested the vlan feature and it works fine for me (no dhcp tested). 
> Therefore I bridged my eth0 (LAN) and tap0 (OpenVPN) but as my switch 
> flags arp replys with priority, the client ended up with 802.1q
> tagged (VID=0) priority packets. These were not expected on the client
> (Ubuntu 10.04 lts) and I found a linux kernel discussion from summer
> 2010 about supporting VID=0 priority packets, so I expect more linux
> clients (windows untested) to not support this kind of packets. This
> option prevents the creating of these packets by ignoring the
> priority information.
> 
> This patch has already been tested and works fine for me.
> 
> Signed-off-by: Michael Braun <michael-dev@...1528...>
> 
> 
> 
> 
> ------------------------------------------------------------------------------
>
> 
Cloud Services Checklist: Pricing and Packaging Optimization
> This white paper is intended to serve as a reference, checklist and
> point of discussion for anyone considering optimizing the pricing and
> packaging model of a cloud services business. Read Now! 
> http://www.accelacomm.com/jaw/sfnl/114/51491232/
> 
> 
> 
> _______________________________________________ Openvpn-devel mailing
> list Openvpn-devel@lists.sourceforge.net 
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk7gjjgACgkQDC186MBRfrqtsACgm8JiXbRQPTicmDjxL0WxDfGC
KQkAoJu4gKtBtu6esT582SCBTD0z5J15
=q6lu
-----END PGP SIGNATURE-----

