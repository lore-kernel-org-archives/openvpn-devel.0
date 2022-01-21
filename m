Date: Fri, 21 Jan 2022 14:32:16 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <Yeq14J2ztKPwYS08@...1296...>
References: <20211019183127.614175-1-arne@...1227...>
 <20211019183127.614175-22-arne@...1227...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="6C1cm71UC2eZ9J4e"
Content-Disposition: inline
In-Reply-To: <20211019183127.614175-22-arne@...1227...>
Subject: Re: [Openvpn-devel] [PATCH v3 21/21] Always use 8192 bytes for
 ERR_BUF_SIZE
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net

--6C1cm71UC2eZ9J4e
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Oct 19, 2021 at 08:31:27PM +0200, Arne Schwabe wrote:
> The signature messages required by external key managed also break
> the 1280 limit. To also avoid this surprise of different behaviour
> with PKCS11 enabled/disable, always use the larger size.

JFTR, this patch has been obsoleted by Selva's eeb019acee57e commit.

This is now "large" for PKCS11 *or* ENABLE_MANAGEMENT, so for the
original purpose, fixed.

All original comments still apply, like, "make this less silly"

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--6C1cm71UC2eZ9J4e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJh6rXgAAoJEB2Cnv7KVigS/w4L/iXhPuiQUmBMD171Yqg3rS+g
LKiq7vISFCa8k4mXXb+puNb1HyFMeU7We10IlBzCQWBeWFez0OX8FvAnmAtg8R0E
95VBnNtR6ne3m0PEk7bfMHPh1YBPaGU4CsrKQLQ+81uSqW8INez7UnMZqOZx/sL2
i9ihmoBx8gr4RSTzB2sycFgou20/x0C+9hPL2AN4mwN7vTdmikG4HFWeMh+eAcME
qqcQqiT6WYaZjkwGMZrjic85vryNKAfqwwSFRiIqS1KietMDUCwNRUjbsxfarIqT
ceggoORHE7iYXY5mfeIcGWWrzHOdyUNt/TGV1+xFyp8aRiImbUdXQyk9x8agfs7K
NK9jjvEDv/8T7wLyPGxilEFVefzNFRmQw5QS8jbqeV2afZ0V3DAXebvSDo9/+gv/
Q1feGeOricTc6P5AQ1lyDnYuB5qHYc9MdAXVlXANKopuqlsUAu51RTsPvKt+ElVZ
OOamhRYo7eiB9IzxVzqk27JjlIom328gPtqecfspuw==
=CXH3
-----END PGP SIGNATURE-----

--6C1cm71UC2eZ9J4e--

