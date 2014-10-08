Message-ID: <54350951.8000801@...1114...>
Date: Wed, 08 Oct 2014 11:52:17 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <1412688204-29265-1-git-send-email-openvpn.list@...1114...>	<1412688204-29265-2-git-send-email-openvpn.list@...1114...>	<CAE4D3A4_33FxfHx_qUF8QHaWd6TzaQqtkq8C317CnCrNXco4=w@...278...>	<20141007201512.GX396@...1296...>	<543477D2.1070203@...1114...>
	<20141008071852.GZ396@...1296...>
In-Reply-To: <20141008071852.GZ396@...1296...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="PHLF1LcU91TCoObiWtDV0EQFth3i9iFwQ"
Subject: Re: [Openvpn-devel] [PATCH 2/2] systemd: Do not mask usernames when
 querying for it via systemd-ask-password
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--PHLF1LcU91TCoObiWtDV0EQFth3i9iFwQ
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

On 08/10/14 09:18, Gert Doering wrote:
> Hi David,
>=20
> please take a second to consider what your position on this is - "I like
> systemd a lot, I want to push support for it everywhere" or "I'm maintain=
er
> of OpenVPN and carefully consider what goes in there".

I consider myself an OpenVPN maintainer who carefully does consider what
we do apply.  But I also happen to primarily use Linux, where I see the
future will be dominated by systemd.  Thus I am concerned about our
systemd support.

> After that, please take a step back and actually *read* what I proposed:
>=20
> On Wed, Oct 08, 2014 at 01:31:30AM +0200, David Sommerseth wrote:
> [..]
>>> OTOH, having a *generic* mechanism to run an external "askpass" mechani=
sm
>>> - which could then be something x11-ssh-askpass, for example, on systems
>>> that are not Linux or have no systemd, is something I'd find generically
>>> useful.  On systemd systems, this would then point to systemd, of cours=
e.
>>
>> That is *exactly* what systemd-ask-password is.  And for Linux, this is
>> the mechanism which is designed for this purpose and it will be the
>> solution the majority of Linux distros will use.
>=20
> So we seem to be in actual agreement that this is a useful thing - but
> the current code actually is *not* that.  It's "this useful feature, done=
=20
> in a very particular way, which only works if systemd is running".

We've had several patches on pastebins which we've discussed in the
past.  A few times you have actually told me that my *generic*
implementations where over-engineered.  Once you even told me to make it
specific and we could broaden the scope once we see the need.  This is
what I am doing right now.

Currently I am not aware of anyone else needing an ask-password feature.
 But I'm willing to see how we can adopt the systemd implementation we
already have when that request comes.

> And this is my whole point here - it has nothing to do with "do I have
> experience with systemd or not" or "do I like systemd or not".  When you
> asked me to take over maintainership for 2.4, you put responsibility on
> my shoulders, more than just "be the commit-and-push dummy".
>=20
> When I look at features and patches, I always try to have a broader view
>=20
>   - will this come back and bite us?

In the current state, we will get complaints about usernames being
masked.  Enforcing --echo regardless of systemd version will come back
an bite us on those distros using a too old systemd base.  Hence, I try
to avoid these two scenarios.

I don't know about systemd versions in other distros than Fedora and
RHEL 7.  But Fedora 20 which will live alongside Fedora 21 ships with
v208.  Fedora 19 ships with version 204 but will go EOL some weeks after
Fedora 21 is released.  RHEL 7 has v208 as the base version.  So if we
don't consider systemd versions, we will get complaints about OpenVPN
not working with systemd on these releases.

In fact the --echo feature will come in a release after v216.  So you
see there is a gap until this feature will be available in systemd distros.

>   - is this code that is very narrow to a particular environment, but mig=
ht
>     be more useful if done in a more generic way?

Okay, should we do the same for setting up IP addresses and routes in
tun.c too then?  Should we stop fixing issues, isolated to particular
platforms in that code because we need a more generic approach which
doesn't bloat the code with #ifdefs?   Because that is all I'm doing
here.  I'm not extending OpenVPN with new features, just fixing annoyances.

> So - running a configurable external program which *could* be systemd's
> ask-password, but could be something completely different on, say, FreeBS=
D,
> would give you what you ask for (systemd integration), but be of larger
> benefit to the OpenVPN project.
>
> Yes, it would be a bit more work to get that API right, well-defined and
> well-documented.  Should that stop us?

Agreed.  But it's damn hard to get the API right without a reference
implementation.  Currently we do have that in OpenVPN, but it is not
optimal.  And once we have requests for similar mechanisms for
non-systemd distros, yes, I agree we can make things more generic.

But to be honest, I am not convinced making OpenVPN execve() a wrapper
execve() the ask-pass program is the proper implementation, and then
pipe the result back and forth.  I think we should have something more
baked into OpenVPN, similar to what we do with OpenSSL and PolarSSL.

>> So you want a far more complex implementation to solve a situation which
>> is currently relevant to systemd?=20=20
>=20
> That is actually the point: I try to see the broader picture, and this is
> more useful than "just systemd".  But the way it's currently coded, with
> your last patch (which I admit that I ACKed - my fault, I should have=20
> spend more thought on the design first, and discuss with you beforehand),
> it's "really just systemd".

One of the first things I did when I stepped up as the first community
maintainer of OpenVPN was to try to reduce the fragmentation of OpenVPN
on the Linux side.  Almost all distros had their own additional patches.
 The patches which are in the distroes now are, afaik, only adopting
things which is unique for that distro.  We added a lot of the distro
patches all could benefit from into the upstream OpenVPN.

I am seeing this from a broader perspective than you probably are aware
of.  And I want to avoid Linux distros patching OpenVPN on the systemd
implementation separately due to issues which has been reported or
issues which I see may show up in the future.

In fact, if systemd had had a library function called sd_version() which
would return the systemd version, you probably would have ACKed the
patch fairly quickly.

But because I touched m4/pkg.m4 you suddenly see a big problem.  You
even told me on one of the previous patches that as long as systemd
related stuff was isolated inside its own configure.ac block, you didn't
see any problems.  The pkg.m4 is the only change which is outside the
systemd scope.  Btw. I'm even considering to submit that patch to
upstream pkgconfig, to avoid fragmentation (and we can then remove
pkg.m4 from our repo in the future).

>> In addition, I've not seen any other distros requiring such a feature, b=
ut
>> I might just be misinformed.
>=20
> If you're seeing this not from a RedHat angle but from an OpenVPN maintai=
ner
> point of view, why do you care what "distros require"?  If a Linux distro
> *requires* something, they can very well patch it themselves.
>=20
> We, as OpenVPN community, should aim for what is good for OpenVPN - both
> for all or user base and for the maintainers ourselves.

That is *exactly* what I try to do.  To reduce the risk of Linux distros
having to add additional patches separately.  To reduce the risk of
fragmentation among Linux distros.  Which means distros can work more
closely with upstream OpenVPN, because the gap is minimal.

>>> So fully independent from the patch at hand we have some discussion to
>>> do - and we might want to postpone this particular topic and patchset
>>> to the face to face meeting, as things tend to get out of hand when
>>> discussed purely by mail / IRC.
>>
>> I disagree to postpone this.  This is non-sense on such *clearly*
>> *defined* patches which are minimalistic and well contained.
>=20
> If you think this is so important that the patches need to go in right=20
> now, many months before we even consider a release of 2.4 (=3D many months
> before this will be relevant to any distribution), and it really can't
> wait to discuss the larger picture face to face, well, go ahead and=20
> do so.  You have commit rights, and I won't stop you, as the project
> is too important to me to risk a schism right now.

I have too much respect for the community to go rouge.

But once patches are in our trees, if distros need to patch things
before a 2.4 release due to complaints from their users, they can pick
our upstream patches instead of having their own approach.  And this
goes well into the mantra of Fedora and RHEL, where we say: upstream
first.  Which is why I want to have this solved ASAP.

Fedora 21 currently in Alpha and the final release will be out in a few
months.  From a Fedora/Red Hat perspective, I want to avoid hacks into
that release.  For RHEL 7, OpenVPN is no longer part of the base
packages, but available via EPEL.  Which makes it possible to make
RHEL 7+ distributions have more recent versions of OpenVPN as well.

Having that said, I think we need to consider to apply some of the
systemd fixes which are already applied to the 2.3 branch.  Especially
the waitpid() patches.


--=20
kind regards,

David Sommerseth



--PHLF1LcU91TCoObiWtDV0EQFth3i9iFwQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlQ1CVQACgkQDC186MBRfrpZjACeM+w5d7yr6lCnc6IZs0DzSoyg
Rp4AoJHYFLoF3V9nF+lBi3sjMHj7JIuf
=sk8K
-----END PGP SIGNATURE-----

--PHLF1LcU91TCoObiWtDV0EQFth3i9iFwQ--

