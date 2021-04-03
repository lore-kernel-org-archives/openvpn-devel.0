Date: Sat, 3 Apr 2021 22:11:33 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20210403201133.GH976@...1296...>
References: <20210403184626.23067-1-arne@...1227...>
 <MFiU_JhTmRrOQ3TVBmz_4V8sNTkAzlgaoYK7ojMOHK_hyClEDbHQMgODWjt6eoNuxcHNPRmrznhABgTYLEXtl4FO-BAcLjSCz97WPx0mvNg=@protonmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="biKn9r/lcytv7tmK"
Content-Disposition: inline
In-Reply-To: <MFiU_JhTmRrOQ3TVBmz_4V8sNTkAzlgaoYK7ojMOHK_hyClEDbHQMgODWjt6eoNuxcHNPRmrznhABgTYLEXtl4FO-BAcLjSCz97WPx0mvNg=@protonmail.com>
Subject: Re: [Openvpn-devel] [PATCH v2] Remove P2MP mode and check for
 gettimeofday
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: tincantech <tincantech@...2282...>
Cc: Arne Schwabe <arne@...1227...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--biKn9r/lcytv7tmK
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sat, Apr 03, 2021 at 07:28:39PM +0000, tincantech via Openvpn-devel wrot=
e:
> > This also removes the ENABLE_SHAPER and TIME_BACKTRACK_PROTECTION
> > defines, which also depend only on the HAVE_GETTIMEOFDAY or WIN32.
>=20
> Is this the end of --shaper option ?

No.

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--biKn9r/lcytv7tmK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJgaMv1AAoJEB2Cnv7KVigSikYL/jZO7a4jLLfbFMqN+vI8PbGL
sq2rZI4QznPZsvKiy1T9tWE2vag1g3ew+Tuo2T962TBORlMtKCM7yEgHZ+3HGN3H
cyK0H780Ejt6KTwwNG+PxO86t9b7ymg47jANlk3P8dHZfm0sNkP3SNkAmagBKqW+
UNPI4Fnn7SleJvPWxoEKfNS3I/bj3utAXU62IDfK5V5uB5lbt81I66ar7QFVwi19
YyI52nlAhOyrm0NwAQcEJiX6OUvcJxcRv54QqFvSdWPm8RD40lG4MCCXub0IXd8F
otkdpIY6lk3BNDvdGuJ9wJFrP1JxOkVIfEhn8DYP9L6/0+4JXTbRDL5V+Cd54+Zl
L04qGQsFeHNs6JTS9rlO7TGNjhUUpwJtfH6LsQ6nC6dPpTpqk1hVlVKo8gcFHLX6
M6IISUIOGzvXq4dQV2rBPH56JOEr9NA/Uz1CTOp3xL21Bsso8zdeXSIt0yi2p2Kd
4KFvwRRqYmeQA8YCO1/S39t35uW/ZLMUpOvv7EF7fg==
=J3O2
-----END PGP SIGNATURE-----

--biKn9r/lcytv7tmK--

