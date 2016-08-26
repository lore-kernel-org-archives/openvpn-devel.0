Date: Fri, 26 Aug 2016 20:58:52 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20160826185852.GA78279@...1296...>
References: <1472162097-17855-1-git-send-email-davids@...515...>
	<20160826131442.GY78279@...1296...>
	<492d59a2-1899-5be4-ba74-e5faa5cccd49@...515...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oMvEetrZIm2PFzDm"
Content-Disposition: inline
In-Reply-To: <492d59a2-1899-5be4-ba74-e5faa5cccd49@...515...>
Subject: Re: [Openvpn-devel] [PATCH] Fix client connection instant timeout
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: David Sommerseth <davids@...515...>
Cc: openvpn-devel@lists.sourceforge.net

--oMvEetrZIm2PFzDm
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Aug 26, 2016 at 06:11:36PM +0200, David Sommerseth wrote:
> On 26/08/16 15:14, Gert Doering wrote:
> > If we keep the other one (Arne had some reservations because the amount
> > of code in the "now-privileged" part is bigger than "just bind"), then
> > this is a working fix - so, conditional ACK.
>=20
> If you look at the diff with these two patches and without, you
> basically move the do_uid_gid_chroot() from above
> do_init_server_poll_timeout() to down below do_init_2().  So this last
> patch just ensures the order of do_init_server_poll_timeout() and
> do_init_2() is preserved.

I understand that :-) - the point isn't the timeout initialization, but
Arne had reservations about do_init_2() being "too big" - which is why
the original patch from James wasn't merged months ago.

(Unfortunately we only discussed this on IRC, not formally on the list,
so it never made a "true NAK")

But maybe the point is somewhat moot - now, only part of the code
runs privileged, while before that, people needing privileged ports
had to run *everything* privileged...

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--oMvEetrZIm2PFzDm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQCVAwUBV8CRa6kuBuNlUUl1AQIccwP7BCSq1zUs/lblz19W4eq6ZgG03vD6m8P0
+54RSmLnugRLt4UveC+HIZs+CE9ryIW4pzHJgGp2yYSO3oyv01c+MgzAA5HLHWdG
dEq+td7w8FknOSDDYjI8nyyg+9VEyu/+5/6jWbRawDloGLddsAPjPMskqYjIc2xB
bOa1y99XZT8=
=+SvE
-----END PGP SIGNATURE-----

--oMvEetrZIm2PFzDm--

