Date: Fri, 28 Jun 2019 09:49:53 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20190628074952.GS1097@...1296...>
References: <CAFHpkQFOUB6hq4rQjCGLvbXprjvUL0aD3y107oYj15t6CSMxTg@...278...>
 <20190626063502.GS1097@...1296...>
 <9f92ae0a-cae6-39bd-932b-fa977686f27a@...1227...>
 <CAFHpkQFn0Yn8dWya9H=EgC4MLugvrpHLkA=-eqyscQWZy_eDCw@...278...>
 <2d1c2e8a-7f60-6a40-164e-f8657d6f2103@...1227...>
 <20190627073924.GB1097@...1296...>
 <CAFHpkQEuGSh+7Mn1F17Ri7sqnhprnygAMpK3sXL19M-fHMHBbA@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="L7j14VgZ+PGuoIvj"
Content-Disposition: inline
In-Reply-To: <CAFHpkQEuGSh+7Mn1F17Ri7sqnhprnygAMpK3sXL19M-fHMHBbA@...278...>
Subject: Re: [Openvpn-devel] how to migrate users to "no compression" config
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: ???????? ?????????????? <chipitsine@...277...>
Cc: Gert Doering <gert@...1296...>, Arne Schwabe <arne@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--L7j14VgZ+PGuoIvj
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Jun 28, 2019 at 12:14:40PM +0500, ???????? ?????????????? wrote:
> by "high level" compression doc I mean something like that
>=20
> a) road warrior scenario (remote access for enterprise users) - should we
> enable compression ? or traffic usually is compressed ? RDP is compressed=
 ?
> any way to estimate compression (like $gzip_ratio in nginx)
> b) lz4, lzo, ... which one to choose ?
> c) how to push compression settings, best practices on that
>=20
> @mattock, what do you think, should some such documentation present on
> https://openvpn.net ?

The high level document should propably specify "do not use compression
at all, unless you have a specific need".

I'm fairly sure we did publish something along that lines already, but
have no idea where to look for it.

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--L7j14VgZ+PGuoIvj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJdFcagAAoJEB2Cnv7KVigS66kMAIe16iJCRyFLErg9uaUc0YSr
TMdMyr040ptn5HkmvspFE3YgKgtR+FfwDoXDtOYEZKAt41LBEwO2Rou1ggiVyaba
I/DXCYU92kn2dH5WB97xyvgw2ZFHv8yNWZ4k78faanurJijMc5whVJ1mC/TZaxky
hFgkB/3d+WB5NfUL9TSSu01smmHNkJ+ftru5ZxH160Ej7iQs02dVah5oEpKZ0xU2
9UEWnMCFOYEqkiUpH9E+Jje/zipddUvgfQt+wTYA9zq6luH3kUjnIm+7moW4zDen
naUty3KLxbKrb30XgK5ZsmzdQCWEW/6g4U1VDZxPzd4fInUeFqP6NMMU9fPKAsx8
bU5qW6sfoGXussjy6DC3DJRk513+9A4KU7bjUOKV97Im0cuEn0d2uDl5nnIw2Ki0
SHLrUoIgbXQd0ZL9Jlb//juMrSnbecYTXI4ykLlRe89s47coFcpzpu7tAP4LI7LA
Qbz35J8ckYMUYIOS+ZAiD6HFhkt3pNFAWQPGLRIw6Q==
=1r8p
-----END PGP SIGNATURE-----

--L7j14VgZ+PGuoIvj--

