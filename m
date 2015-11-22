Date: Sun, 22 Nov 2015 17:30:48 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20151122163048.GI24952@...1296...>
References: <1447271171-29141-2-git-send-email-selva.nair@...277...>
	<1447728489-14991-1-git-send-email-selva.nair@...277...>
	<20151122151858.GH24952@...1296...>
	<CAKuzo_jFMSQb98pS8mEeujbRs6WXi9a+aaFGbc6GwKa0ANyD6A@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="n8ucneZ6gTaxrU7s"
Content-Disposition: inline
In-Reply-To: <CAKuzo_jFMSQb98pS8mEeujbRs6WXi9a+aaFGbc6GwKa0ANyD6A@...278...>
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
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--n8ucneZ6gTaxrU7s
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sun, Nov 22, 2015 at 10:49:13AM -0500, Selva Nair wrote:
> > (Is it actually quicker as well, so does the nssm timeout still need to
> > be adjusted?  Haven't seen feedback from Samuli here yet)
> >
>=20
> In my tests openvpn exit processing takes only a few hundred msec, but if
> exit-notify is enabled that adds about 1 to 2 seconds[*]. As that option
> could be pushed as well its safer to setup nssm with a delay of  2500 msec
> between ctrl-C and 'kill without prejudice' (aka Terminate).

Ah, yes.  Thanks :-)  (you and Samuli need to work on the NSSM setup stuff
then, I don't have an eye on the windows stuff, so won't be able to track
this so it's not getting lost)

> [*} actually with exit-notify n, it should only take n-1 seconds to send n
> notifies, but integer arithmetic makes it always a little more than n-1.
> And for some reason it appears to wait a second even if another notify
> doesn't have to be sent. I've not looked into that part of the code
> carefully...

Our timer granularity is "1 second" for most stuff, and we tend to add
another second "just to be sure"... ran into this when trying to speed
up client PUSH_REQUEST sending in commit afb93fac803f

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--n8ucneZ6gTaxrU7s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVlHtt6kuBuNlUUl1AQLt4wQAnVhkW0EQ+HqUvaZaiQsMFTZudshe4ECH
lFZ5iLmdrVpvIIAj1BiwSHceX+ruBPOmxcuexk98UVgWGb01y+UV4RVQ8vp2GVT2
zQX8o+AIWt/G7eoX0NN1dqYQKm+CnI68MXDIaHG6JkeNdpSFlRWdKNnj5VOUVxX+
ARcilprYwx4=
=9pTx
-----END PGP SIGNATURE-----

--n8ucneZ6gTaxrU7s--

