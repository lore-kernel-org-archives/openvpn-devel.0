Date: Tue, 7 Jun 2016 09:06:49 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20160607070649.GJ53051@...1296...>
References: <1465274660-11009-1-git-send-email-selva.nair@...277...>
	<1465274660-11009-2-git-send-email-selva.nair@...277...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="s3Dau3hWaCRC+rUf"
Content-Disposition: inline
In-Reply-To: <1465274660-11009-2-git-send-email-selva.nair@...277...>
Subject: Re: [Openvpn-devel] [PATCH 1/1] Ignore SIGUSR1/SIGHUP during exit
 notification
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

--s3Dau3hWaCRC+rUf
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Jun 07, 2016 at 12:44:20AM -0400, Selva Nair wrote:
> This allows exit notification to complete and finally trigger SIGTERM.
> The current practice of allowing a restart in this state clears
> the exit notification timer data and thus loses the SIGTERM.

This is along the lines I was thinking as well, so I like it better than
the first try (which was sort of fiddling with the symptoms, but not with
the underlying signal handling problem).

What if SIGTERM+SIGUSR1 are received in very quick succession, so that
we haven't even entered "explicit_exit_notification_interval" yet?

I'm not sure if I understand the full chain of events that happen on
a (soft or hard) SIGTERM, what state ->signal_received has when the
exit notification timer is active, and under which circumstances
get_signal() is called to collect signal info into the context... this
is magic stuff...

My original idea was "the place that sets signal_received will not do
that for SIGUSR1 if a SIGTERM has already been received" (so, de-coupled
from the exit notification timer), but it seems that this is not easy=20
to do.  So maybe your patch is the pragmatic way to solve this.

Arne?

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--s3Dau3hWaCRC+rUf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBV1ZyiakuBuNlUUl1AQLCcgP/R/flyn/fh2dNs/oLjwuTzb4aLXPdLUds
1v7Bm2yAe8PIIm/9+q939u7fdXdL93fl9D4rEDN75QLTmkXDq4jmI/nFVWp9/yuC
O5FPA3KBlwO7+dLhmtzZT6Hdbj1RU7928Cas5ogUt1IU7kc3s4tvtZLx9p9DYpSm
ZESg77Au9Rg=
=fuJr
-----END PGP SIGNATURE-----

--s3Dau3hWaCRC+rUf--

