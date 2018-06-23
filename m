Date: Sat, 23 Jun 2018 09:33:23 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20180623073323.GP57262@...1296...>
References: <20180613141213.5962-1-a@...2181...>
 <20180620155301.GY57262@...1296...>
 <c416ea67-e4ce-148b-eb19-6d18b35da559@...2181...>
 <20180622094635.GI57262@...1296...>
 <d496bbf5-3c55-f2d9-2ab2-bc89ded80131@...2181...>
 <CAKuzo_jDrcGjQeMaVm3X6yzgKBZecbYHfAAxxCFAuycagTe22Q@...278...>
 <20180622182709.GO57262@...1296...>
 <8117ab50-c3d1-2210-6665-9ea86b7110ac@...2181...>
 <CAKuzo_je1ZsOoTeaUdFxnP1JDMM1Op5TP-p=xA85SLn0pPCSGQ@...278...>
 <5fe13344-8e3c-3283-3217-c64f4ef234c5@...2181...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="13LwGeCavelYIlim"
Content-Disposition: inline
In-Reply-To: <5fe13344-8e3c-3283-3217-c64f4ef234c5@...2181...>
Subject: Re: [Openvpn-devel] [PATCH v3 2/8] windows: properly configure TAP
 driver when no IPv4 is configured
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Antonio Quartulli <a@...2181...>
Cc: Selva Nair <selva.nair@...277...>, Gert Doering <gert@...1296...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--13LwGeCavelYIlim
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sat, Jun 23, 2018 at 11:13:07AM +0800, Antonio Quartulli wrote:
> > Very likely. It would be nice to find the on-link route that triggers t=
hat code
> > path to ensure it doesn't cause any other issues.
>=20
> My server was on the same LAN (connecting via v4) as the client - should
> that be considered on-link? maybe this is what triggers that code path.

Oh, definitely.  I had the feeling it was related to "server over v4",
but that would trigger "on-link" too.

Actually it might trigger the on-link ASSERT for the "ipv4 and ipv6"
case as well, as soon as "redirect-gateway ipv4" is involved.

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--13LwGeCavelYIlim
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJbLffCAAoJEB2Cnv7KVigSgfAL/iquxgOFpF22RVD7aP0gMt33
iS2EWIa3NtpmRGIJH1VxD20OWwjWWznRxovnKzvVpU2wCaT4mYGvhHv2yMUjcBJN
mIJducMemXIy9tt+W8czUOOcOBTUbmn/HDKGcHkYG5SXJMnrvEcZlagtvAuVuIKI
XaLKC59tpUMvLsQPzexJcNReolFqzEA6f4HxGn964JHfeAc6jhU9S0e6MT0lSRtm
iy6G5UcMbksDAGg8NlvtuVVtIEAMEkAHbVp4bto0SPlq+FUk/Ps9cUvb8BeHAiGA
rOTdX77poDPXFemqov5RXyx8LlPOUB7H/NxsRTAF8RrLoIQKWIc9AkdWXdpg4fa4
K4CJLXPgaqkoAf/vCUYabRsxGQiEzOFbeVXjSJ6qjExXlOwdDzkGRU7MtwEb+/AY
STkcL/nSBGDy9LZhL+cAfCHSauMgNANmdXTK7T9Z52uKibcUCZ36QGGYWDAb45HB
7VV4eXE9v+X8cgVzNg7bBTzlDUi1wM+tskJqL+clYg==
=YT5c
-----END PGP SIGNATURE-----

--13LwGeCavelYIlim--

