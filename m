Subject: Re: [Openvpn-devel] More BSD TUN info.
From: Janne Johansson <jan.johansson@...1...>
In-Reply-To: <008901c1da97$e4ce0b70$1000000a@...4...>
References: <1017760165.9891.85.camel@...2...> 
	<008901c1da97$e4ce0b70$1000000a@...4...>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-1KMcmmFQDbAuTlZOhuTv"
Message-Id: <1017818817.1524.56.camel@...2...>
Mime-Version: 1.0
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=openvpn-devel>
Date: Wed Apr  3 08:05:49 2002
To: openvpn-devel@lists.sourceforge.net

--=-1KMcmmFQDbAuTlZOhuTv
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2002-04-03 at 00:44, James Yonan wrote:
> >Sorry for "spamming" so much with my porting issues.
>=20
> Hey, I think it's great you're trying to port it!  Post as much as you wa=
nt.
>=20
> >Now it seems that BSD (at least Free/OpenBSD) TUN devices send AF_INET
> as a u_int32_t in network byte order first, which Linux tun-devs
> dont.
>=20
> Interesting.  We should post something about that on the TUN/TAP list.  I
> would think that network byte order should be the correct behaviour.

I'll get back to this further down, but to clarify, _each_ packet read
from tun will have this u_int_32 prepended.

> >That's why my last mail contains sending of "00000002" as the first
> 32 bits, it's telling the other end which AF to use.
>=20
> >When initiated from the Linux end, the BSD will say
> "unknown address family" or something very similar, which is true
> since it gets "45000054" as the first data.
>=20
> >Is there two types of tun or is the BSD tuns just slightly different and
> incompatible by design?
>=20
> Also sounds like a TUN/TAP list question.  I know the TUN/TAP driver beca=
me
> an official part of the linux kernel as of the early 2.4 releases.
>=20
> A fix on the linux side to conform to network byte ordering would be dicey
> since it would break compatibility.

Well, sooner or later Linux should do that too, to support big endian
machines. But the issue was more to the fact that the BSD sends this:
"00000002 45000054 ..blabla" whereas Linux sends this:
"45000054 ..blabla".

The manpage for tun on BSD says:
"The first u_int32_t of data will always be the address family
 (eg, AF_INET) of the packet in network byte order.
 By default, the packet data follows immediately, but if the PREPADDR
 bit is set, the address to which the packet is to be sent is placed=20=20
 after the address family u_int32_t and before the packet data."

Now, I don't want to rant about OSes, but being able to just type
"man tun" when you're dealing with tun interfaces and get serious info
is quite nice. I googled a bit yesterday and could not find neither tun
info for Linux nor the kernel source as cvsweb, so I could read the
source at least. 8-/

> My approach would be to do the fix on the linux side but add an extra che=
ck
> for compatibility and allow packets if the order is wrong.  Since there
> aren't too many address families to worry about, the bad ordering test
> should't be terribly ambiguous.
>=20
> And since linux kernel changes take a long time to happen, it might be
> necessary to add a workaround in OpenVPN to deal with this.
>=20
> What do you think?

I don't know the openvpn data format, but if 45000054 is some sort of
openvtun identifier, you/we/I could add some code that checked for
00000002 followed by 45000054 and then strip the first u_int_32 from
the packet and go on. Perhaps a --remote-is-bsd or something similar?

The last bit of the manpage says:
"NOTES
 Very old versions of the tunnel device did not include the address
 family at the start of the packet.  More recent versions passed the
 address family as a single byte, but this caused problems with bpf,
 hence the current version passes a u_int32_t of address family.
 This was initially pass in host byte order, but the current version
 now uses network byte order."

I checked the CVS for openbsd, and the native -> network byte order
change was done 3 years ago, which is a really long time.
I wonder if Vtun ever did work between linux-vs-bsd ?
Or does it have code to handle this?

--=20
Janne Johansson
jan.johansson@...1...
BioMat Systems AB
Klarabergsg 37 3tr
111 21 Stockholm


--=-1KMcmmFQDbAuTlZOhuTv
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQA8qq7BNJYxu+mj1OkRAsmIAJ9UHkh2jBM171+7GxQvdFJIK1cSpgCfSq18
2/o3uJS0FslhLHiS4Gf/6QQ=
=dibU
-----END PGP SIGNATURE-----

--=-1KMcmmFQDbAuTlZOhuTv--


