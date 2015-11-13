Date: Fri, 13 Nov 2015 20:36:20 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20151113193620.GW24952@...1296...>
References: <CAKuzo_i7tOuGT87h2wQmCG1ivx9NDB5K0J8Z0sXxzTKO-oMHxw@...278...>
	<1447271171-29141-1-git-send-email-selva.nair@...277...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="stFzI3XAseUQ09UW"
Content-Disposition: inline
In-Reply-To: <1447271171-29141-1-git-send-email-selva.nair@...277...>
Subject: Re: [Openvpn-devel] [PATCH] Handle ctrl-C and ctrl-break events on
 Windows
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva Nair <selva.nair@...277...>
Cc: openvpn-devel@lists.sourceforge.net

--stFzI3XAseUQ09UW
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, Nov 11, 2015 at 02:46:10PM -0500, Selva Nair wrote:
> > With nssm, the console is shared with nssm, so ctrl-C is delivered as
> > a signal. I'll send a patch handling both cases.
>=20
> The patch is in the next email.=20
>=20
> Handling the key-board input is easy, but making the callback interrupt t=
he event loop
> looks tricky. I am not well versed with the event handling in the code, s=
o=20
> opted to generate a key-pressed event. If there is a better way please su=
ggest.

Arne might have an idea here... I do not understand the event handling
that well either.

[..]
> Tested on windows 7 with cmd-line use and start/stop with nssm. For nssm,=
 the default=20
> delay after ctrl-C is 1500 msec which is not enough for the process to ex=
it if exit-notify
> is being used. About 1 second per extit notify trials + an extra 1 second=
 is suggested.=20

So this would be something for Samuli to adjust when setting up NSSM?  Like,
2500 ms?

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--stFzI3XAseUQ09UW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVkY7n6kuBuNlUUl1AQITuAP/Ss6nKqFbQXq1IxsJay2yN+PHEyFug+Zr
TgAawv7pFNnYF+2qZg6XZuoulXra4z6lXdFycNcvJQQtbrSKapGLaHnaHfQrqTJm
w8COJUoYyyiWS3STrRSTWQfXfwltCcUuWVEOg7PmdKKScEMQtm/Pnz98WsMEm43i
oI6Nf+A9Bs0=
=1fZC
-----END PGP SIGNATURE-----

--stFzI3XAseUQ09UW--

