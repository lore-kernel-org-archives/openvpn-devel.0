Date: Wed, 8 Oct 2014 09:18:53 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20141008071852.GZ396@...1296...>
References: <1412688204-29265-1-git-send-email-openvpn.list@...1114...>
	<1412688204-29265-2-git-send-email-openvpn.list@...1114...>
	<CAE4D3A4_33FxfHx_qUF8QHaWd6TzaQqtkq8C317CnCrNXco4=w@...278...>
	<20141007201512.GX396@...1296...>
	<543477D2.1070203@...1114...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pqZtgxSH0iQu6R78"
Content-Disposition: inline
In-Reply-To: <543477D2.1070203@...1114...>
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
To: openvpn-devel@lists.sourceforge.net

--pqZtgxSH0iQu6R78
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi David,

please take a second to consider what your position on this is - "I like
systemd a lot, I want to push support for it everywhere" or "I'm maintainer
of OpenVPN and carefully consider what goes in there".

After that, please take a step back and actually *read* what I proposed:

On Wed, Oct 08, 2014 at 01:31:30AM +0200, David Sommerseth wrote:
[..]
> > OTOH, having a *generic* mechanism to run an external "askpass" mechani=
sm
> > - which could then be something x11-ssh-askpass, for example, on systems
> > that are not Linux or have no systemd, is something I'd find generically
> > useful.  On systemd systems, this would then point to systemd, of cours=
e.
>=20
> That is *exactly* what systemd-ask-password is.  And for Linux, this is
> the mechanism which is designed for this purpose and it will be the
> solution the majority of Linux distros will use.

So we seem to be in actual agreement that this is a useful thing - but
the current code actually is *not* that.  It's "this useful feature, done=20
in a very particular way, which only works if systemd is running".

And this is my whole point here - it has nothing to do with "do I have
experience with systemd or not" or "do I like systemd or not".  When you
asked me to take over maintainership for 2.4, you put responsibility on
my shoulders, more than just "be the commit-and-push dummy".

When I look at features and patches, I always try to have a broader view

  - will this come back and bite us?
  - is this code that is very narrow to a particular environment, but might
    be more useful if done in a more generic way?

So - running a configurable external program which *could* be systemd's
ask-password, but could be something completely different on, say, FreeBSD,
would give you what you ask for (systemd integration), but be of larger
benefit to the OpenVPN project.

Yes, it would be a bit more work to get that API right, well-defined and
well-documented.  Should that stop us?

[..]
> So you want a far more complex implementation to solve a situation which
> is currently relevant to systemd?=20=20

That is actually the point: I try to see the broader picture, and this is
more useful than "just systemd".  But the way it's currently coded, with
your last patch (which I admit that I ACKed - my fault, I should have=20
spend more thought on the design first, and discuss with you beforehand),
it's "really just systemd".

> In addition, I've not seen any other distros requiring such a feature, but
> I might just be misinformed.

If you're seeing this not from a RedHat angle but from an OpenVPN maintainer
point of view, why do you care what "distros require"?  If a Linux distro
*requires* something, they can very well patch it themselves.

We, as OpenVPN community, should aim for what is good for OpenVPN - both
for all or user base and for the maintainers ourselves.


[..]
> > So fully independent from the patch at hand we have some discussion to
> > do - and we might want to postpone this particular topic and patchset
> > to the face to face meeting, as things tend to get out of hand when
> > discussed purely by mail / IRC.
>=20
> I disagree to postpone this.  This is non-sense on such *clearly*
> *defined* patches which are minimalistic and well contained.

If you think this is so important that the patches need to go in right=20
now, many months before we even consider a release of 2.4 (=3D many months
before this will be relevant to any distribution), and it really can't
wait to discuss the larger picture face to face, well, go ahead and=20
do so.  You have commit rights, and I won't stop you, as the project
is too important to me to risk a schism right now.

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--pqZtgxSH0iQu6R78
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVDTlXKkuBuNlUUl1AQL2cgP/QnE8uOMSufM8K/EnhW0ZjtQHn0DtCV6H
2KPxwKsZut377odnc67bwHzESjLiaFchBxWruGd5+i76Xht9NXa0xCIEQeqOwaho
DBimVWD6KAgZyuxtnj20vkBNTWoW0evx+0+w2Huo/sHZk5LcJEoF+Oex7HQE5P1F
tcipUekMcFE=
=EuMt
-----END PGP SIGNATURE-----

--pqZtgxSH0iQu6R78--

