Date: Tue, 7 Oct 2014 22:15:13 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20141007201512.GX396@...1296...>
References: <1412688204-29265-1-git-send-email-openvpn.list@...1114...>
	<1412688204-29265-2-git-send-email-openvpn.list@...1114...>
	<CAE4D3A4_33FxfHx_qUF8QHaWd6TzaQqtkq8C317CnCrNXco4=w@...278...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="07KgZKBWke2i7lgQ"
Content-Disposition: inline
In-Reply-To: <CAE4D3A4_33FxfHx_qUF8QHaWd6TzaQqtkq8C317CnCrNXco4=w@...278...>
Subject: Re: [Openvpn-devel] [PATCH 2/2] systemd: Do not mask usernames when
	querying for it via systemd-ask-password
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Jon Ciesla <limburgher@...277...>
Cc: openvpn-devel@lists.sourceforge.net

--07KgZKBWke2i7lgQ
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Oct 07, 2014 at 12:56:55PM -0500, Jon Ciesla wrote:
> On Tue, Oct 7, 2014 at 8:23 AM, David Sommerseth <
> openvpn.list@...1114...> wrote:
>=20
> > From: David Sommerseth <davids@...1347...>
> >
> > In systemd after version 216, systemd-ask-password will support --echo
> > which will avoid masking the user input.  As OpenVPN uses this mechanism
> > collecting usernames when systemd is available, this will avoid the=20
[..]
>=20
> ACK.  Enables systemd features on systemd systems, and looks like a no-op
> on non-systemd systems.

Now this is getting interesting.  I had a LONG discussion with David on
IRC today, as I do not like where this is going - it's very very specific
code (not only "linux specific" but "linux with systemd"), and the more I
think about the less I'm convinced that we really want to have this inside
OpenVPN, depend on particular versions of systemd in our source (yet
another #ifdef that will turn into dead code in a few years), or link
against a systemd library.

OTOH, having a *generic* mechanism to run an external "askpass" mechanism
- which could then be something x11-ssh-askpass, for example, on systems
that are not Linux or have no systemd, is something I'd find generically
useful.  On systemd systems, this would then point to systemd, of course.

So this might be "./configure --enable-ask-pass=3D$my_program", which=20
could then be /usr/sbin/systemd-askpass, or something private to OpenVPN
which would check if systemd is running, and if yes, call systemd-askpass
and if not, call "whatever makes sense on that particular environment"
(if $DISPLAY, call ssh-askpass, otherwise, not).


Now, the really interesting thing about this is that we have an ACK for
a patch which is not without religion around it - from someone who has
never sent an ACK or a patch before.  So, do I take any ACK, no matter
who sent it?  Do we require ACKs to come from people that have actual
experience with the code, and are willing to work on the code when these
bits need maintenance in the future?  "This is the material where project=20
forks are made from"...

So fully independent from the patch at hand we have some discussion to
do - and we might want to postpone this particular topic and patchset
to the face to face meeting, as things tend to get out of hand when
discussed purely by mail / IRC.

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--07KgZKBWke2i7lgQ
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVDRJ0KkuBuNlUUl1AQLzwwP/WtFYp0DjbugpjzXLRAuYL1lhv4sYTyZr
YlO9UlVJvfCV5yZM5mvqTpdHvcfv/0e/H+hQ2yiA4CnOSrZp8400whzIzqP4r8rf
s/c63SUAPz/iB+WHQINH1M28JnwMGFwd3firK3MBhmsY946ovU3CyKfiXMAu0Kh7
ltoMIIw58mU=
=cOgB
-----END PGP SIGNATURE-----

--07KgZKBWke2i7lgQ--

