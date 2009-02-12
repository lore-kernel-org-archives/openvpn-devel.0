Message-ID: <4993A32A.9000304@...41...>
Date: Wed, 11 Feb 2009 21:18:50 -0700
From: James Yonan <jim@...41...>
MIME-Version: 1.0
References: <200811130123.46417.mailinglists@...1145...>
	<200902030008.20652.mailinglists@...1145...>
In-Reply-To: <200902030008.20652.mailinglists@...1145...>
Subject: Re: [Openvpn-devel] IPv6 Support
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: quoted-printable
To: =?ISO-8859-1?Q?Marcel_Pennewi=DF?= <mailinglists@...1145...>
Cc: openvpn-devel@lists.sourceforge.net

Marcel Pennewi=DF wrote:
> On Thursday 13 November 2008 01:23:46 Marcel Pennewi=DF wrote:
>> Hi,
>=20
> Hi again,
>=20
>> a long time ago Juanjo Ciarlante wrote a patch for openvpn to create a
>> tunnel via ipv6 [1]. Later i fixed the patch to work with openvpn-2.0 and
>> 2.1 which i use on OpenWRT and Gentoo. Roy (from Gentoo) wrote about this
>> also to the devel-list [1]. But since that no one answered :(
>>
>> What about IPv6-support to create a tunnel over IPv6? Since my first pat=
ch
>> i try to adapt the patch to newer versions. This patches are not properly
>> tested but works fine for me (on gentoo).[2][3]
>=20
> What about full IPv6-support - is this scheduled in the future or on any=
=20
> roadmap? No answer is not a good practice :(

Full IPv6 support is planned for OpenVPN 3.

Some more details on OpenVPN 3:

OpenVPN 3.0 is a revamping of the OpenVPN core into a modular, more
maintainable architecture.  Planned features include:

* IPv6 support
* IP multicast support
* Pluggable crypto library support (so that crypto libraries other than
OpenSSL may be used)
* Pluggable packet filter and network access control API
* Pluggable dynamic routing API (BGP, OSPF, etc.)
* Support for full-mesh topologies (in addition to the star and
point-to-point topologies supported in OpenVPN 2.x)
* Library API support allowing OpenVPN tunnels to be programmatically
created and destroyed
* Embedding support to allow OpenVPN to be embedded in other applications
* Asynchronous, event driven I/O subsystem (in the vein of Twisted,
boost::asio, or libevent)

James

