Message-ID: <53028516.3090505@...1227...>
Date: Mon, 17 Feb 2014 22:54:30 +0100
From: Arne Schwabe <arne@...1227...>
MIME-Version: 1.0
References: <52CFF667.7080600@...1790...>
	<52CFFAF4.8050306@...1227...>	<52CFFDA4.4060601@...1790...>
	<52D07F70.8030609@...1227...>	<52D08946.6010906@...1790...>
	<20140119140416.GP226@...1296...>	<530262FB.7080206@...1790...>
	<20140217213435.GS16637@...1296...>
In-Reply-To: <20140217213435.GS16637@...1296...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="4KRFQNpAbR0ssn2v0wvKBJnmSE9UVpXfn"
Subject: Re: [Openvpn-devel] git master proto udp6+multihome is broken
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>, Tore Anderson <tore@...1790...>
Cc: openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--4KRFQNpAbR0ssn2v0wvKBJnmSE9UVpXfn
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable


>> This happens both with today's git master and with 2.3.2. BTW Arne's
>> patch to socket.c that fixes the assert crash we originally discussed
>> still isn't included in git master, has it been forgotten about?
> ISTR that Arne wrote something about "this is a quick fix, will send a
> proper patch later".  Then we lost a bit of momentum :-(
>
I did more socket cleanup to remove the offending variable that triggers
that problem:

https://github.com/schwabe/openvpn/commit/94a142d4e8bd09f8a7af4287516c0c341=
64ce1f4

but the patchset is only really tested in client mode and not server
mode and therefore I have not sent it to openvpn-devel yet.

Arne



--4KRFQNpAbR0ssn2v0wvKBJnmSE9UVpXfn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (Darwin)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlMChRYACgkQe8+cMNS4zRfFYQCfTggmw+VtsGgP++v0c/RtZzIa
7xgAoIiw154d5xI9UeSV8eOZ7YZui4bc
=bYNy
-----END PGP SIGNATURE-----

--4KRFQNpAbR0ssn2v0wvKBJnmSE9UVpXfn--

