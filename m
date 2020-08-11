Date: Tue, 11 Aug 2020 11:51:25 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20200811095125.GF75094@...1296...>
References: <20181024113341.1242-1-arne@...1227...>
 <2c30a581-b699-150f-2dc8-309e15860f27@...2080...>
 <6512229c-0300-cd4b-5b79-ec6d2f1e2ac6@...1227...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="gvPGo+RAdjC9O5ul"
Content-Disposition: inline
In-Reply-To: <6512229c-0300-cd4b-5b79-ec6d2f1e2ac6@...1227...>
Subject: Re: [Openvpn-devel] [PATCH] Document comp-lzo no and compress being
 incompatible
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

--gvPGo+RAdjC9O5ul
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Oct 26, 2018 at 04:48:26PM +0200, Arne Schwabe wrote:
> Am 26.10.18 um 13:31 schrieb David Sommerseth:
> > On 24/10/18 13:33, Arne Schwabe wrote:
> >> Most of the new compress but not v2 version do use swap operation. For
> >> 'compress lzo' the swap option is not used for backwards compatibility.
> >> For lz4 the swap option is also not a problem since there is no version
> >> without swap. Unfortunately, compress introduced a second stub format
> >> with swap, contrary to the one in 'comp-lzo no' that does not use swap.
> >>
> >> Document this weirdness to let not others fall into this trap.

If we still want that: can you re-send based on the .rst we have no?

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--gvPGo+RAdjC9O5ul
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJfMmocAAoJEB2Cnv7KVigSje4L/Rnp/aW2PogrHUzPsh1oVsDK
pnCBiSh4G0no3VkL6ytdOgHiBjOv8LXESygsh19HzejEc8NhxCSXrh9QJRTK/e7K
qhJXOaF6OPV4llboR9TC67tfzxH0O8jNrgE3XqVKhWpOl5sm0aRHOmexD0DlhgIk
QjRTpwJ+tioYznneICFzteZNo7ffesTIDyq797Q9TGPg7blgdLC8c5tVwr5KXypM
tsxkV7Kz/sSdlaZSUwlPItrtXEOf0oRXmrakvInqq4KIE2tbEJKRy03OMxJQJBAo
yp+Si4jExzmvhsV429GU0078TEuofB6qlgya7z2dqwNMSvAf9XxazlF+/vOAWuRS
KLnGR7JUg293SXxBI+NjTaWw30aA6fGOH7QJLLozgUZ99Ui1vmv4IZII1zW7IjA5
Q3/suVp94owMjun5LbX7KIKbHGYSO5oAZfyVVmi3vc3P6ZcyeEc88LwvxzcvpHpZ
tFudbYomrFFPPvlwhxuwkvMXO3PGIQovgzpl5Q2cJw==
=c5aG
-----END PGP SIGNATURE-----

--gvPGo+RAdjC9O5ul--

