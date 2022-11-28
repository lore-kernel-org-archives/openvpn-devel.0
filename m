Date: Mon, 28 Nov 2022 14:35:24 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <Y4S5HE0L3ZvtqsTz@...1296...>
References: <20221012133457.1927871-1-arne@...1227...>
 <20221012133457.1927871-3-arne@...1227...>
 <Y4S3B/u3W8MO5Wbc@...1296...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="GeoJDfShC9rQ/Rek"
Content-Disposition: inline
In-Reply-To: <Y4S3B/u3W8MO5Wbc@...1296...>
Subject: Re: [Openvpn-devel] [PATCH 3/3] Call dco_p2p_add_new_peer again if
 the peer id changes
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

--GeoJDfShC9rQ/Rek
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Nov 28, 2022 at 02:26:31PM +0100, Gert Doering wrote:
> On Wed, Oct 12, 2022 at 03:34:56PM +0200, Arne Schwabe wrote:
> > This allows a reconnect in p2p mode and has the side effect of updating
> > the peer address with the peerid
>=20
> Maybe I am just holding it wrong, but the patch does not change the
> situation for my p2p reconnection problem.

I was holding this wrong... applied to my tree, ran server tests, but
forgot to "push to the repo that the server tests use".

So, without the patch, the problem is easily reproduceable as written
below :-)

Now testing the actual patch.

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--GeoJDfShC9rQ/Rek
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJjhLkcAAoJEB2Cnv7KVigSh60MAJw8xAEf1ELw4i3I4Iqj+glG
MyE3DJUoMPH92XWojtoJHncplgI8WlMiBa37/LAdCEP6ttzTfXF/y3LI6ceM5uKM
oZ1lVeowq52jWGidYU/rTNmX0jyoXYVXnVEmF/S0RtoX3lZToHsrYC77AHKRDrxk
eZDycDYgrIUCIeJCz1CBkiPMafaF15Qjexa+9A872o/6nFe7hgS2zxNYtHrno8um
odCXVuvKSLTI2+5gUjleV4QI6oFneFwUE2jaik0jmj605ZL5ssrEukJNErl+BEpd
UF50PGMgbnu8NEaSsoN7gHdjhTRD3rVxVCYh6yYO0kHk3xgHcY+w41lz5VZW5yFW
3EFfdDixB0y3Prl3wf7MyqmSsSJE1mwnrpiljr7oZUGiByt5Pa/3wuiYI5DcEPxS
hskA0VAbAcV/YtPuRr0N+04w/yGivWT14DAuOhSjHNoPR1jESZU8yAvMR4wpasa2
J7b4iFncND/3sigQu9IvsWBfg3Oa8ZohATGWDbYLhQ==
=SHwt
-----END PGP SIGNATURE-----

--GeoJDfShC9rQ/Rek--

