Date: Fri, 19 Feb 2010 16:53:31 -0600
From: "Karl O. Pinc" <kop@...1206...>
References: <4B7E71A5.3020806@...1114...>
	<20100219134650.GR9556@...1296...>
	<4B7EA05C.5000802@...1114...>
	<20100219145623.GU9556@...1296...>
	<jwvk4u9ce0t.fsf-monnier+inbox@...1269...>
	<20100219193304.GZ9556@...1296...>
	<20100219224249.GE9556@...1296...>
In-Reply-To: <20100219224249.GE9556@...1296...> (from
	gert@...1296... on Fri Feb 19 16:42:49 2010)
Message-Id: <1266620011.31441.15@...1207...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [IPv6] Merge conflicts in mroute.c
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
To: Gert Doering <gert@...1296...>
Cc: Openvpn-devel@lists.sourceforge.net, Stefan Monnier <monnier@...1282...>

On 02/19/2010 04:42:49 PM, Gert Doering wrote:

>  - the external globals in6addr_any and in6addr_loopback will not
>    be compiled in (in6_addr.c).
>=20
>    ** I expect this to cause linking problems for my code **


> As said: I would welcome contact to someone who is using
> uClibc+OpenVPN
> and could help me test this and adapt the code if needed.

To run the risk of harping on a theme....

If the problem is that someone is './configure --no-ipv6'-ing
ipv6 away then maybe openvpn needs to have a similar ./configure
option?  Or could ./configure just test against UCLIBC_HAS_IPV6?


Karl <kop@...1206...>
Free Software:  "You don't pay back, you pay forward."
                 -- Robert A. Heinlein


