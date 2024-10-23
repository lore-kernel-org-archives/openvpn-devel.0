Date: Wed, 23 Oct 2024 16:23:57 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <ZxkG_T7Jw7fI-C1I@...1296...>
References: <20241023134903.66485-1-rzvncj@...277...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="MuOUxMlmjiKKNxMQ"
Content-Disposition: inline
In-Reply-To: <20241023134903.66485-1-rzvncj@...277...>
Subject: Re: [Openvpn-devel] [PATCH] Allow setting an empty auth-token in
 push replies
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Razvan Cojocaru <rzvncj@...277...>
Cc: openvpn-devel@lists.sourceforge.net

--MuOUxMlmjiKKNxMQ
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, Oct 23, 2024 at 04:49:03PM +0300, Razvan Cojocaru wrote:
> This in turn allows the server to signal to the client that it
> should no longer attempt to reconnect, if it wants to keep the
> client out after an AUTH_FAILED.

This should not be necessary.  After an AUTH_FAILED the token is
already invalidated on the client side.

Can you describe your use case a bit better?  This code is complex
enough as it is, so I'm not really willing to add more cases to it
(which I do have to test then and forever) if not needed.

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--MuOUxMlmjiKKNxMQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJnGQb9AAoJEB2Cnv7KVigSbLQMAK8tmuV395cEtGZRl1ORY3Cs
x7QCLCSFh4X/PzdZVv3hRCtnLkFxMppPdTbRGsnaBeU0vs1TDy5lwI6VTPniHYCY
LO5RQwHPt3RquKR9918sXcgPGgx5/kHqSyVzBYP+w3/Sp5PQx4qI+MzI1JC9uuOP
WzXhEK/sm7+Rkzr4L0jU2PwGiH80zANyeHPgSieNLWpR6093yDSeYEpEgbKuRLkZ
SMOS55P+Xd+yx/NULc8PJ9sU28g0im5CjpdlwRa2rVruC2IyTLFPkMIzkJhiaZVD
mNJdVjPAv2MFJ2fPxwqrnSMkHc7dXSCcJ5fMpY6shy0H5LE01pWXUr67mRmsUkhG
DUyAFD+fNyu1lr/dNGkV5+YVtCONeqYKlcVbE+uFobzfHr5vGaDkte/PjCaxpY5O
5ZPcMwjUJT8iqmugU6HHq9eR6W6S1fwgJ9jdi4cKtDFO9f2aq3lF0t85g0Zj0x4n
7TJCAfNGBBaFd4MkOTwH+xJ+kkV5ApAUM9yl3d8bLg==
=uiY6
-----END PGP SIGNATURE-----

--MuOUxMlmjiKKNxMQ--

