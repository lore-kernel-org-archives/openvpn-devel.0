Date: Sun, 22 Nov 2015 16:18:58 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20151122151858.GH24952@...1296...>
References: <1447271171-29141-2-git-send-email-selva.nair@...277...>
	<1447728489-14991-1-git-send-email-selva.nair@...277...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qCGCnlPZoKZX9mDP"
Content-Disposition: inline
In-Reply-To: <1447728489-14991-1-git-send-email-selva.nair@...277...>
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

--qCGCnlPZoKZX9mDP
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Nov 16, 2015 at 09:48:09PM -0500, Selva Nair wrote:
> v2 changes
>  - cleaner, hopefully easier to get a code review :)
>  - handles both console mode and service mode
> -- >8 --
>=20
> Handle ctrl-C or ctrl-Break sent to the console as a SIGTERM.
> Depending on the console mode, windows delivers ctrl-C as a
> keyboard input or as a signal. We handle both cases. This allows
> graceful termination of openvpn from programs such as nssm.
> Works in both console mode and service mode.

If I read this right, the new code uses WriteConsoleInput() only to
signal "hey, some work to do here, wake up!" without actually sending any
keypress-to-itself, and the signal itself is sent by throw_signal()?

This is certainly nicer :-)

(Is it actually quicker as well, so does the nssm timeout still need to
be adjusted?  Haven't seen feedback from Samuli here yet)

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--qCGCnlPZoKZX9mDP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVlHc4qkuBuNlUUl1AQJqIwQAsPK+tz6S5obnm9hvvDbrRk6Qx1BCvNpy
g9bpNZkMWku0Dd2DIgErbBMGW360FVtA6u0FSadZVTFXt3jLL0fpZRuJmVYSwLdu
mkk65NzxA+UayjhpNaaQ4pIMoPZi3foR5hzmt6Dxh9K8KbQCHQCVUpYLcH9YoKSB
jocmvyC1Z4g=
=U6QF
-----END PGP SIGNATURE-----

--qCGCnlPZoKZX9mDP--

