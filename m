Reply-To: openvpn-devel@lists.sourceforge.net
References: <CAFHpkQGG9x_kYP6bthSxgB+1Y38r45ffD1WCnaA+Jp4Ed8PbQw@...278...>
 <cf0cbe5b-238c-8790-5be1-3cb693ac4148@...1147...>
 <CAFHpkQGu93WJEhFMyA1y4RFdL9bJJijdMrQWOMdHt+DU1iVO-g@...278...>
 <CAFHpkQEZDWqMbwU07LGtLVXyN2_VGz3v8jHZdwRAfGg07Jw3wA@...278...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <c0d738c1-2f62-3746-21cd-e451a3d90824@...2080...>
Date: Mon, 11 Sep 2017 14:30:45 +0200
MIME-Version: 1.0
In-Reply-To: <CAFHpkQEZDWqMbwU07LGtLVXyN2_VGz3v8jHZdwRAfGg07Jw3wA@...278...>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="NsXOhDoXkPHMW9XAaFkvOSbdjNFsxc3No"
Subject: Re: [Openvpn-devel] proper configuring of "tls-verify"
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Cc: Jan Just Keijser <janjust@...1147...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--NsXOhDoXkPHMW9XAaFkvOSbdjNFsxc3No
Content-Type: multipart/mixed; boundary="xokH5r3xtnvwJXsc0laqUawFnH0X5UJVG";
 protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
To: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Cc: Jan Just Keijser <janjust@...1147...>,
 "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>
Message-ID: <c0d738c1-2f62-3746-21cd-e451a3d90824@...2080...>
Subject: Re: [Openvpn-devel] proper configuring of "tls-verify"
References: <CAFHpkQGG9x_kYP6bthSxgB+1Y38r45ffD1WCnaA+Jp4Ed8PbQw@...278...>
 <cf0cbe5b-238c-8790-5be1-3cb693ac4148@...1147...>
 <CAFHpkQGu93WJEhFMyA1y4RFdL9bJJijdMrQWOMdHt+DU1iVO-g@...278...>
 <CAFHpkQEZDWqMbwU07LGtLVXyN2_VGz3v8jHZdwRAfGg07Jw3wA@...278...>
In-Reply-To: <CAFHpkQEZDWqMbwU07LGtLVXyN2_VGz3v8jHZdwRAfGg07Jw3wA@...278...>

--xokH5r3xtnvwJXsc0laqUawFnH0X5UJVG
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On 11/09/17 14:02, =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=D0=B8=D1=86=
=D0=B8=D0=BD wrote:
>=20
>=20
> 2017-09-11 16:54 GMT+05:00 =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=D0=
=B8=D1=86=D0=B8=D0=BD <chipitsine@...277...
> <mailto:chipitsine@...277...>>:
>=20
>=20
>=20
>     2017-09-11 16:45 GMT+05:00 Jan Just Keijser <janjust@...1147...
>     <mailto:janjust@...1147...>>:
>=20
>         Hi,
>=20
>         On 11/09/17 13:22, =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=D0=
=B8=D1=86=D0=B8=D0=BD wrote:
>=20
>             Hello,
>=20
>             is someone actually using "tls-verify" in production ?
>             we tried to implement additional certificate check using
>             tls-verify
>=20
>=20
>             while it works in general, in case when it hits "exit 1", it
>             look like a timeout from client point of view. it is not any
>             good
>=20
>=20
>         do you mean that when a client is denied access (i.e. the
>         tls-verify script exits 1 on the server) that the client sees
>         this as a timeout?=C2=A0 that is "normal" behaviour, as the server
>         does not tell the client *WHY* access is refused - it simply
>         stop responding to a client that does not pass
>         authentication/authorization. The client will not hear from the
>         server, and will time out after a specified interval.=C2=A0 This =
is
>         actually the most secure way to do things, as a rogue client
>         cannot DoS a server this way.
>=20
>=20
>     I'd say it depends.
>=20
>     we run a lot of openvpn-gui with real people sitting in front of
>     them, from their point of view it "oh, it does not work! fix it!"
>     in out case better UX is to deliver proper reason to the client
>=20
>     for someone maybe the better UX is to keep silence
>=20
>=20
>=20
> what is wrong with timeout is endless retry.
> there's no way to pass authentication once it failed, so why does client
> have to retry ?

User-friendliness and security seldom walks hand-in-hand.  As this
friendliness provides enough information fragments for an attacker to
figure out "I need to try something else".  A non-responding server
gives no clues.  It can be a crappy server or it can be access denied;
the attacker doesn't know - thus making it harder to figure out what to
do next.

The client will by default try to reconnect, because that is what it in
most cases is told to do when the server is unresponsive.  And since
this happens with many seconds in between, a single client will not
attempt to DoS a server by mistake by retrying in a too tight loop.

A failed authentication is a failed authentication.  Thus UX client
front-ends could treat this silence like that - but also account for
other types of connectivity issues.  If it should try to reconnect or
not, well, that's entirely up to the configuration file.   There is
--single-session which can be used to control this.

But for servers running OpenVPN clients, retrying indefinitely at
regular intervals may just as well be valuable; if it is an issue which
is temporary.  Then these clients would reconnect once everything is
back online again on the server side.


--=20
kind regards,

David Sommerseth
OpenVPN Technologies, Inc



--xokH5r3xtnvwJXsc0laqUawFnH0X5UJVG--

--NsXOhDoXkPHMW9XAaFkvOSbdjNFsxc3No
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCgAGBQJZtoH7AAoJEIbPlEyWcf3y6yQP/2O2/q6G+wL0dFKwjcsTCFcp
S1ttdHvgPs29o7e2YSXivMVLdfNUYo66a0+P9bhrQv3MLJPBmeI3geaEqtmRnQPs
yNEjkrW9PLbzdW9gdPd4KaydDTwTRmeskv3BOFx7W8ccZnYDV1Nb5+rb/5RtytWM
VOUIQu4ed9+f6VrKdviW3OJolzSfpUZzF1ehptk1wU5/b9MNtmm6iXsOLJ6J36jy
ppfle+kg6HYPsU2bzWZdHaP8JX4Hp7eEX4H5ABpumFjpoomIgaCN09xKax9wHjKv
Yy5P/NyAan1tVvEDwCIYhUzgChEEffMWlVWPYwms4YXRgkTUkpJTmdn++Nxj7COa
ZA2X3rF9pO+OSD2zx47Nb2zoNoCAKqQ3gT3BU8FLec8nkxFI1c4cpJiVCToYDXn9
X145amp8LC6RAyFLn9XlRbpQYk9n3tpNPAyCkZQRNEa0d/u6yAtX86d27zxLPwr5
iPxTcWnAs7klOlbitaJkIoNbqO7jbsn7n68/oRRLQog2WDEodI353WNQbOgmR+xk
3FV20sITbY6wEMPj1Sw6TTm+r5b2qQPJ43GPIXpD35H2FivlNwYcN+Q6bvNkjIiT
/OS9LhCPUbIM0nE3pMpeqpKeO0pdTqR8gHWM6GfEU5nU5AEU+HG+EQNzEJXxqvaP
SNfrBBkIHRO8GCNpSUoz
=Yj1C
-----END PGP SIGNATURE-----

--NsXOhDoXkPHMW9XAaFkvOSbdjNFsxc3No--

