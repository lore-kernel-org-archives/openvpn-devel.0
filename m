Date: Wed, 23 Nov 2016 23:32:57 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20161123223257.GC28918@...1296...>
References: <1479936104-4045-1-git-send-email-steffan@...1856...>
	<201611232216.uANMGwWk061543@...2054...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="hWspM8V/q+4sNHne"
Content-Disposition: inline
In-Reply-To: <201611232216.uANMGwWk061543@...2054...>
Subject: Re: [Openvpn-devel] [PATCH applied] Re: Poor man's NCP for non-NCP
 peers
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan@...1856...>
Cc: openvpn-devel@lists.sourceforge.net

--hWspM8V/q+4sNHne
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, Nov 23, 2016 at 11:16:58PM +0100, Gert Doering wrote:
> ACK.  We made it :-)

I *did* find a way to break it, I think - haven't tested, need to sleep -
just copying what I wrote to IRC just now since everyone is asleep=20
already...

23:30 <@cron2> syzzer: I *do* have a potential way to use this to break thi=
ngs
23:30 <@cron2> server with NCP enabled, --cipher foo
23:30 <@cron2> client with NCP disabled, --cipher bar
23:30 <@cron2> server will now use "cipher bar", while client will do "ciph=
er=20
               foo"...
23:31 <@cron2> so I think we should do a "v6a amendment" which disables thi=
s on=20
               the client if --ncp-disable is set (so 2.4 to 2.4 will eithe=
r do=20
               *real* NCP, or *no* NCP, but no half-assed two-way poorman)
23:31 <@cron2> this makes testing more annoying because you can't talk to a=
 2.4=20
               server to test the client side :-) - but it's *meant* to be =
a=20
               2.3<->2.4 migration feature

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--hWspM8V/q+4sNHne
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQCVAwUBWDYZF6kuBuNlUUl1AQL4ZgP/fQwl8XcmxfRslQoXiqGcwAwg6Bi6GO6e
3EuYJEtQoQo6bmJRCJ+Db8ltj6IGfQ4intcsudYlqMHbLFFlo2AYvsh8B2JXio2E
PE6BtZtMT3YETuBklfSmIGLI0xPPTitT4nrQF2rrLjmlypxGIgBgAAL9yQfYdyQI
GFclMaKyYMw=
=JhO0
-----END PGP SIGNATURE-----

--hWspM8V/q+4sNHne--

