Date: Wed, 27 Apr 2022 09:59:47 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <Ymj380c+Pl7JLFik@...1296...>
References: <20220427074828.6283-1-kprovost@...2661...>
 <20220427074828.6283-2-kprovost@...2661...>
 <761e5640-6d43-d25b-4845-25698d2e0688@...2181...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="3afCROF5LKu3dps/"
Content-Disposition: inline
In-Reply-To: <761e5640-6d43-d25b-4845-25698d2e0688@...2181...>
Subject: Re: [Openvpn-devel] [PATCH] Handle (DCO) timeouts in client mode
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Antonio Quartulli <a@...2181...>
Cc: Kristof Provost <kprovost@...2661...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>, Lev Stipakov <lev@...515...>

--3afCROF5LKu3dps/
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, Apr 27, 2022 at 09:55:24AM +0200, Antonio Quartulli wrote:
> > --- a/src/openvpn/forward.c
> > +++ b/src/openvpn/forward.c
> > @@ -1111,6 +1111,12 @@ process_incoming_dco(struct context *c)
> >=20=20=20
> >       dco_do_read(dco);
> >=20=20=20
> > +    if (dco->dco_message_type =3D=3D OVPN_NOTIF_DEL_PEER)
>=20
> Not sure where this constant is coming from, but on ovpn_dco_linux.h we=20
> have OVPN_CMD_DEL_PEER (similar format as the following OVPN_CMD_PACKET).

For "notifications coming from kernel", _NOTIF_ feels more logical
than _CMD_ ("commands going into kernel").  No?

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--3afCROF5LKu3dps/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJiaPfzAAoJEB2Cnv7KVigStNkL/RdLuS9AXAE9MiPn+qmf72Q6
hGCb2Oaxtw3xw87TrkYLW2Fz7MwYFXAfycti2k+iIIGMVjKpQyxKRI1ahAtCI6fc
M8dLDkGTwuBg03iK9d412FsnoGKsO301guvBtOLrKUB7s2+DOxj4KhzPsakOqWq9
L5o+rKCHKKjmtrjeBhockMWL8mT0QIfNWgdRrpiMJQq3VEKoC+xvUIZ+R6xu6y53
S3wArVjEjFshBTRjOYB9unqTEMB0emuTqK7j6zliHEij35B83bc00iJkfxduCWPg
GQn45k8287i5Io9jLN6vXaOM3CWn4C2HeG1gijjGyaqItxF9j+EACj2obIVsNM0Z
e5719IDOzZHkYpPoZFK1D2jwcoU6HpQUfKIGCe5Yw92TGQTqruusguaNam5h/iL1
8+/vpsYoHOl3HjyZfJ5GLNUwGcM0Wn7kMLR7wus2+8fF2iPfWLEx3RSUvrPp37U1
woFo44EIAkFAif0K9CzkKFFtSvX3EjR9GUdpF3QdVQ==
=KOIa
-----END PGP SIGNATURE-----

--3afCROF5LKu3dps/--

