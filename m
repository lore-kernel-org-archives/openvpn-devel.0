Date: Tue, 23 Jun 2020 21:37:02 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20200623193702.GL1431@...1296...>
References: <202006230628.05N6Sa3g001325@...2054...>
 <20200623072123.GA2034@...1296...>
 <1592917531.4768.4.camel@...2316...>
 <CAFHpkQF5tz91P_UJxMuNCRDUYodw8QPV8=h8mmkSTHOUH5AdfA@...278...>
 <CAFHpkQH-yGFBJ=-Eaz5XCSaUcD-=S00y=MvPs6Vmr5nE_PcTRg@...278...>
 <1592936237.4768.43.camel@...2316...>
 <CAFHpkQGQgQm2cEA1kw1JpRkf4Ldu4kT=y-YXF-6cLTXbEx_zDQ@...278...>
 <20200623184733.GK1431@...1296...>
 <20200623192627.GA11911@...1296...>
 <1592940762.4768.52.camel@...2316...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="Og54tBb3+PNfNUUV"
Content-Disposition: inline
In-Reply-To: <1592940762.4768.52.camel@...2316...>
Subject: Re: [Openvpn-devel] [PATCH applied] Re: Add unit tests for engine
 keys
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: James Bottomley <James.Bottomley@...2317...>
Cc: Gert Doering <gert@...1296...>, ???????? ?????????????? <chipitsine@...277...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--Og54tBb3+PNfNUUV
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Jun 23, 2020 at 12:32:42PM -0700, James Bottomley wrote:
> > James, are you triggering on specific openvpn messages?  "--enable-
> > small"
> > changes these (trimming some warnings and help texts).  Can you test
> > with
> > "configure --enable-small", please?
> >=20
> > https://travis-ci.org/github/OpenVPN/openvpn/builds/701385033?utm_med
> > ium=3Dnotification&utm_source=3Demail
>=20
> Yes, that's it.  The problem is the message output by openssl is
>=20
> 2020-06-23 19:28:46 OpenSSL: error:0B080074:lib(11):func(128):reason(116)
>=20
> Instead of:
>=20
> 2020-06-23 12:30:43 OpenSSL: error:0B080074:x509 certificate routines:X50=
9_check_private_key:key values mismatch

Indeed :-)

> I think I can make the grep work with the former.

Please do not forget to output log.txt when it fails - it eases diagnosing
remote failures where we do not have easy access to "file system things"=20
(like travis or buildbot).

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--Og54tBb3+PNfNUUV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJe8lndAAoJEB2Cnv7KVigSyjAL/05w0peJcd0Eh8dbsk4yWpBI
O9nEVe5/AFDgdlTInL9Ib6Y9VbS+BPQTwCkxHovjd2FgTyomfGSwA4/+yWqvOLoa
0fHVCg9GDeJs4GBtbRl9TWQ7GlqofaeWmX1t6ucdA0NgIyIp8exjvynyUs00ABJn
NdDJKAwL6oYCcLSopCKQMGLsp1BbnxHOlwDI3OxImnSHbqsFWmeG8A9K04S3c4wB
hlX/xLPLwSn1DsnPXUXIEvecE7UljH8ifiE2dRs4RXXFYm0OttVk5OC2To3U/g/G
oryTrN6hI2FQuh4rx28CI4a97mJzQ6Q7ybl8lmJsDRrDEkw/GuruMH2wcKI/VCaK
G7l8vjw9MDzQIE8/ygck0pPvXBSfNM1HrST3tPUpi/CXJ8UVayMIxpNm3BqbcLf6
iHkBIWV8pav3JVhrtHfAEBG8Zr4pS1EUQuni6ym+hIcfiZxGHQLB5iHnipJ2/aZr
DbcmtYzYZwJ5mPDPhiPP+MOKLALNhOtKNeAIiW8kFw==
=UDYv
-----END PGP SIGNATURE-----

--Og54tBb3+PNfNUUV--

