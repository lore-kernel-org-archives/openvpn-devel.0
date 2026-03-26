Date: Thu, 26 Mar 2026 08:55:13 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <acTmYYJRIdtwscY0@...1296...>
References: <20260322014606.1415363-1-luca.boccassi@...277...>
 <CAKuzo_iwvHHST4br9F+V0vGHQUOBSw0ju_yGTtCXGj7ws59pXA@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="kDgnDnzLo1DCvDyB"
Content-Disposition: inline
In-Reply-To: <CAKuzo_iwvHHST4br9F+V0vGHQUOBSw0ju_yGTtCXGj7ws59pXA@...278...>
Subject: Re: [Openvpn-devel] [PATCH] management: add multi-line base64 input
 for passwords
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva Nair <selva.nair@...277...>
Cc: luca.boccassi@...277..., openvpn-devel@lists.sourceforge.net

--kDgnDnzLo1DCvDyB
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, Mar 25, 2026 at 05:54:01PM -0400, Selva Nair wrote:
> I have only skimmed through the patch, but reusing "password" with no
> argument could break existing UI clients, hypothetically.  If any UI clie=
nt
> is currently using an empty password to quit the dialog, it will get into=
 a
> stalemate. I guess a new keyword or an extra token after 'Auth'  to
> indicate multi-line input would be required.

Bump the mgmt version, query it?

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--kDgnDnzLo1DCvDyB
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQGzBAEBCAAdFiEEti5qK05WVwt73GvgHYKe/spWKBIFAmnE5lcACgkQHYKe/spW
KBIxKQv/SEk0rPKE0/G+4nFvskOL+vZEr9BGt5H60sZ3Q+q7PK/nBYdm9evspGPo
pioNPoWHBJzn0xZQLm2CzgXLBuwbfXLNF4/OwnrNwYo6fYV2Ld1cl7Mm60k9421M
w+0ID1AJqQKK/+HBjMGfFxm4ZBwzfNqllCySjMqU33AuS0b6ejjNSoDHx0acfjCM
nUWj1oAPizbOQLwKhxhpZJQ51NSNJlTiDUykqCZjo+ll8GPFJhPEPdvxEwfigwCq
W6a9BirsTaNynMytpG6mLxccJI8P0bbhGi3mI2sQUFqxxS2XTD9j2pSW5RieHBbU
+p2bq2XmVH6BsclNL8huX/FeItTvl+lRAN5NURk2a0Ci8krd4L2vkc31U47pty7y
+TaiWR/zlsx8hQrlnqcPoZEMEDFfqHs1hjOw6keIRTcrE3zODnSjYSKCnlJ903OB
LUnLwXfyq+6thU+49/rGPtRYafW0prWARgnWBOInjXKb7c0Sj5rSm3ZMgBcXQHkG
zHsu5m11
=zAH1
-----END PGP SIGNATURE-----

--kDgnDnzLo1DCvDyB--

