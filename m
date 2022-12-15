Date: Thu, 15 Dec 2022 09:16:06 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <Y5rXxvlFb4zjesqM@...1296...>
References: <20221211191403.805-1-marc.becker@...2704...>
 <202212150804.2BF84I9b045409@...2054...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="d1imJqwH8JM3OkHl"
Content-Disposition: inline
In-Reply-To: <202212150804.2BF84I9b045409@...2054...>
Subject: Re: [Openvpn-devel] [PATCH applied] Re: use new pkcs11-helper
 interface to add providers
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Marc Becker via Openvpn-devel <openvpn-devel@lists.sourceforge.net>

--d1imJqwH8JM3OkHl
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Dec 15, 2022 at 09:04:18AM +0100, Gert Doering wrote:
> Your patch has been applied to the master and release/2.6 branch.
>=20
> commit 5954f03bb321a969ea6edbdd353e1dd4f61ac8f0 (master)
> commit d0141344b0c21747ba18be64470236066da62f33 (release/2.6)=20

Same thing here: fixing DMARC induced nonsense, the new commit IDs
are:

commit 45d9b0210a22353e587c29c5d3c3990346a4a189 (master)
commit 0236518cee65cc3d1da8d57b1d7785ecb2663a23 (release/2.6)
Author: Marc Becker <marc.becker@...2704...>
Date:   Sun Dec 11 20:14:03 2022 +0100

    use new pkcs11-helper interface to add providers

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--d1imJqwH8JM3OkHl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJjmtfGAAoJEB2Cnv7KVigS6/gL/iKRwev1dhDilEt4YvTzOSZc
hGtM3i9Q4KX8hH2mEItDOz12WuRkqvNQlpxJx6dbcjAN8BjvYr53VREuwlln3VKT
BzfBTHgSVNkD1Rk9kRwtUt8f44Kn5jsWzqGQWwfYUJsU/c+zwU0sEdHKTsCZ7EZ3
vtOtX63hgQj4vEbml87PoGUcancsP/K/iP+VCR9kmoGD08NiWN6rqdQvULTkF9H+
G1xxj70IkipRjCqsobEIz4+MCMAA4tSWdryGMBVyzdV74POW+zJGWsME7N2PPsE4
oL3JW9dtl0+v0NGpT4b83+8NYLXc79A0JWOq4Ua+xBnZuZDvvJRJPg1/iQQxF/IH
T3cW3kX3BlamZeuESrTyiUM9DxmfJ9Jn5aZsv875iBEtiCjwTx4/Ow6qHI6TaL+i
F4YrbfIb53uM17GmXym3+zGutrz1sl+B8sNCaLo+9R3JF+Q7z6W8Wng+n6X9ByxU
UCAP2w/DqId/BIRcvgQvXdGznVtPK1HlqNsBIKtEtw==
=Vr31
-----END PGP SIGNATURE-----

--d1imJqwH8JM3OkHl--

