Date: Wed, 19 May 2021 07:56:48 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20210519055648.GW976@...1296...>
References: <TGB05j2zTgH3-jDRcHubPFmTAQrG1hHgF4XtWb8Ytc14RY1RFusKL-QJFkyzi6H849DfuoutjhVZfRkiqAhGyHs9lLnI5tnWKDpaOrRfQv8=@protonmail.com>
 <20210518143218.14520-1-gert@...1296...>
 <CAKuzo_iXBS=w7A0wtb4XmWw0xmwQY4zEN+-On2ABkCNKQKBgMQ@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="7rhpxm8EXEjuy5pt"
Content-Disposition: inline
In-Reply-To: <CAKuzo_iXBS=w7A0wtb4XmWw0xmwQY4zEN+-On2ABkCNKQKBgMQ@...278...>
Subject: Re: [Openvpn-devel] [PATCH] Ignore leading whitespace and comment
 lines for peer-fingerprint.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva Nair <selva.nair@...277...>
Cc: Gert Doering <gert@...1296...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--7rhpxm8EXEjuy5pt
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, May 18, 2021 at 07:23:44PM -0400, Selva Nair wrote:
> >      while ((line =3D strsep(&lines, "\n")))
> >      {
> > -        /* skip empty lines */
> > -        if (strlen(line) =3D=3D 0)
> > +       /* ignore leading whitespace */
> > +       while(isspace(*line))
> > +       {
> > +           line++;
> > +       }
> > +        /* skip empty lines and comment lines */
> > +        if (strlen(line) =3D=3D 0 || *line =3D=3D '#')
>=20
> As we support two comment characters ('#' and ';'), would be better to
> do the same here too.=20

Good point.  v2 is on the way.

> One could relax the requirement of comment as
> the first character using parse_line(), but this looks generous
> enough.

The "ignore leading whitespace" part takes care of this :-) - I looked
at parse_line() but it seemed a bit heavy handed to me.

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--7rhpxm8EXEjuy5pt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJgpKifAAoJEB2Cnv7KVigS8AQL/0gHOAJL9NhwLgFNPh02ryZV
pJWGDmpzi28k1fYo9zspbgtaYWOhi4fBffL6Ttxve70Vtr1+0BL53zxm1l9BbSM8
eBTvfUjE7WTmPi71tBLHv/Ykrl/APtedDKh+jB5HhA0y/Uk/Vg/d68JYV0DxPas3
9ghRs86gEWbOWOULxXFsjpek+7EO2doHALXOMhy1fmApZtsFfV7hWErw0njTrFwP
VHe3sTcmgHujAXpcflLvBOHBCyfgb6G8QbS8B07S1XrELGaU1eEvpzi2esWGUpLq
ZYi6ev2Ahd03KZvV5/UUjm6YfIO85OwM/TCdGUF/VoUxIrH5w/HuThb0hjitnx1B
Oig+ScqA+MWz9BvT9jBd1lGLkDgPpra6lHEY+2a9kEUC2ovjTajMi4T4gb3i3Jhk
hePuRgt+tJEE2p6vnZ8q5exs2osgeoRQ6t2RLczQ8APPlADmw/N1jsAo7Altuenl
qY8b8qgThD5jmrM8Zr3aclO+JXUHip3ekFgVQc6kXQ==
=7B4g
-----END PGP SIGNATURE-----

--7rhpxm8EXEjuy5pt--

