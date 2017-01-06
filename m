References: <CAFHpkQEqEqu4Pcy4-KfhGqLYW26HR-ydCZO0xeU9YP5ZZUiL-Q@...278...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <dec62c2a-7c92-bfcb-1949-48ae1eeadc44@...2080...>
Date: Fri, 6 Jan 2017 13:52:05 +0100
MIME-Version: 1.0
In-Reply-To: <CAFHpkQEqEqu4Pcy4-KfhGqLYW26HR-ydCZO0xeU9YP5ZZUiL-Q@...278...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="b2G94HN3IetslMjhfdFXiTfJM5bbXpvv8"
Subject: Re: [Openvpn-devel] helping developers to collaborate properly
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--b2G94HN3IetslMjhfdFXiTfJM5bbXpvv8
Content-Type: multipart/mixed; boundary="lWaqwlOkEw4xn2NUKQHH2ueta2ISkntNB";
	protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
To: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>,
	"openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>
Message-ID: <dec62c2a-7c92-bfcb-1949-48ae1eeadc44@...2080...>
Subject: Re: [Openvpn-devel] helping developers to collaborate properly
References: <CAFHpkQEqEqu4Pcy4-KfhGqLYW26HR-ydCZO0xeU9YP5ZZUiL-Q@...278...>
In-Reply-To: <CAFHpkQEqEqu4Pcy4-KfhGqLYW26HR-ydCZO0xeU9YP5ZZUiL-Q@...278...>

--lWaqwlOkEw4xn2NUKQHH2ueta2ISkntNB
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On 06/01/17 09:18, =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=D0=B8=D1=86=
=D0=B8=D0=BD wrote:
> Hello,
>=20
> https://github.com/OpenVPN/openvpn/pull/77
>=20
> I'm not sure about exact text (I need help from you),
> the idea behind those changes is to point developers who use regular
> github workflow to a proper procedures (maybe there're pages on wiki ?
> @mattock  ?)
>=20
> it will help to not lose PRs and will probably save time of current
> developers

Two questions:

1) Can you explain what those .github/ files does?

2) Can you please elaborate *how* this will save us developers time?

As we do have public reviews on a distributed channel (which is the
mailing list [0]), I would dare to say we have a very efficient way of
handling that process.

- Patch(es) arrives the mailing list
- Patch(es) gets reviewed, with feedback, and finally an ACK
- Gert or I download the mail(s) in our mail program (including
  headers, fairly simple with mutt or alpline, not even much
  complicated in Thunderbird)
- We run our 'git ack-am' [1] script which takes the mail file and the
  a nick of the person(s) giving an ACK ... which generates the "PATCH
  applied" mails automatically.
- We push the git out the git trees.

The GitHub PRs are actually not giving us developers much benefits.  For
the review process of larger patches, it can have some benefits for a
more smooth discussion on individual patch lines.  But once the patches
are ready for final ACK, the mailing list approach is much more
efficient for us, as we want to keep references to final discussions
decentralized.


[0] We don't trust that GitHub will be present forever and our
    mailing lists are archived several places, where the Message-ID is
    unique for each mail - regardless of mail archive hosting.
[1] <https://gitlab.com/dazo/misc-git-tools/tree/master>


--=20
kind regards,

David Sommerseth
OpenVPN Technologies, Inc



--lWaqwlOkEw4xn2NUKQHH2ueta2ISkntNB--

--b2G94HN3IetslMjhfdFXiTfJM5bbXpvv8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJYb5L5AAoJEIbPlEyWcf3yMVIQAJyE4rHp219mC2pasfYuEUkw
w6KUO73qTTTGxSnvA1U0mYskr8jhvTv0G48dyfXuhAh+KfpNNzsayVzgxavs3dMh
BALptSGih5qD7vuvxYkBVm9OijdZ7dHTuxUJ0kOVuR5sjQGNM8Z0/koxgVBELAve
z9RAcFttJgH0nMvc2NDMk+0Tw/TS1DGk8sRA/w/UveFgKo74ZaNPMNtNV9CnW5eU
mTTXzhlo3GtFzA65jpzmvXxHBTzdtNgRNPELcuHWfPb5Q2WI3Vgvf3sSJKnkejI9
AXe3OHJL5AugYoKdtxf9GkTjj7xEkJ0c83wImISgWpEzfGWKGtraJ1Z03C2f8q6K
Dn2B/9yXX6O05uoEpZsOcYLomQQPEHFJ3qXawLMytsp5Y+JSFy2CxBk6V3NbK8UQ
JzUxK7Q/yU+a5Qhedomhk6Mff5jtWe2Rg/nPvHjPIwKSgDOeg+ylVgmBoZM8/F3/
EkWGqg5BPQYeW9g6HS9c3vzX2Gb+KkJkEsXkZBonqfTv9KYN9Pq1fGpHtI9kT9kY
sLuNNtuQ+iLg/VfMv3o9V5pnxjaGuTOzQxTUrh59UYz85+mdkwakWWqtsEwGROUD
MUK/zB9h3e1SdDZqrbQNR6UdHfEW0klRUg+BPpECDFryxtznlMAn0HjFHRviiw2u
ECE78Z3u507cpkjyPl7+
=ektI
-----END PGP SIGNATURE-----

--b2G94HN3IetslMjhfdFXiTfJM5bbXpvv8--

