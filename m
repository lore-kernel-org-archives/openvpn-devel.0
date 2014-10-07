Message-ID: <543477D2.1070203@...1114...>
Date: Wed, 08 Oct 2014 01:31:30 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <1412688204-29265-1-git-send-email-openvpn.list@...1114...>
	<1412688204-29265-2-git-send-email-openvpn.list@...1114...>
	<CAE4D3A4_33FxfHx_qUF8QHaWd6TzaQqtkq8C317CnCrNXco4=w@...278...>
	<20141007201512.GX396@...1296...>
In-Reply-To: <20141007201512.GX396@...1296...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="EG0pSIUrUMS4kg8lieh0Dr8hQSxGLqTBS"
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
To: Gert Doering <gert@...1296...>, Jon Ciesla <limburgher@...277...>
Cc: openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--EG0pSIUrUMS4kg8lieh0Dr8hQSxGLqTBS
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

On 07/10/14 22:15, Gert Doering wrote:
> Hi,
>=20
> On Tue, Oct 07, 2014 at 12:56:55PM -0500, Jon Ciesla wrote:
>> On Tue, Oct 7, 2014 at 8:23 AM, David Sommerseth <
>> openvpn.list@...1114...> wrote:
>>
>>> From: David Sommerseth <davids@...1347...>
>>>
>>> In systemd after version 216, systemd-ask-password will support --echo
>>> which will avoid masking the user input.  As OpenVPN uses this mechanism
>>> collecting usernames when systemd is available, this will avoid the=20
> [..]
>>
>> ACK.  Enables systemd features on systemd systems, and looks like a no-op
>> on non-systemd systems.
>=20
> Now this is getting interesting.  I had a LONG discussion with David on
> IRC today, as I do not like where this is going - it's very very specific
> code (not only "linux specific" but "linux with systemd"), and the more I
> think about the less I'm convinced that we really want to have this inside
> OpenVPN, depend on particular versions of systemd in our source (yet
> another #ifdef that will turn into dead code in a few years), or link
> against a systemd library.

*sigh* You asked me in that discussion to find someone else to review
the patches.  Which I did.  Jon is the OpenVPN maintainer for the Fedora
packages, and I have had several off-list discussions with him on other
matters, and trust his judgement fully.  Which is also why I asked him
to do the review.

Now lets call this what it really is: A typical "I don't like systemd"
quarrel, which I honestly do not find much fruitful at all.  But now the
discussion has moved out of the systemd/sysv-init groups and into the
application areas.  And I find it interesting that this critic comes
from you Gert, who, as far as I know, have had _no_ hands-on experience
with systemd.

First of all, I will claim that systemd will be one of the more
important system management solutions for Linux distributions in many
years.  Like it or not.  And we cannot ignore that.  Also consider that
the major enterprise Linux distributions has implemented systemd, all
the popular user/hacker distros likewise.  Such as Debian, Ubuntu,
openSuSE, Fedora, Arch, Mageia (former Mandrake, iirc), etc, etc.  Even
Gentoo *enforces* systemd if you want GNOME 3, otherwise it's an
alternative.  (Wikipedia has a nice overview on the systemd page [1])

[1] <http://en.wikipedia.org/wiki/Systemd#Adoption>

In regards to linking in libsystemd.  We do that to have a unified way
to detect if OpenVPN was started on a system with systemd being
functional.  The previous implementation in OpenVPN had a copy-paste of
a similar approach used in systemd.  That implementation was included in
OpenVPN in 2011.  And things have evolved since those days.  To reduce
the risk of having to modify OpenVPN later on again, and rather things
correctly, I discussed this with upstream systemd, and they recommended
to use a feature available in a systemd library.  Using the system
library also helped us avoiding SELinux challenges which we otherwise
would have to face - or in reality, all the package maintainers who uses
SELinux would need to take care of this.

> OTOH, having a *generic* mechanism to run an external "askpass" mechanism
> - which could then be something x11-ssh-askpass, for example, on systems
> that are not Linux or have no systemd, is something I'd find generically
> useful.  On systemd systems, this would then point to systemd, of course.

That is *exactly* what systemd-ask-password is.  And for Linux, this is
the mechanism which is designed for this purpose and it will be the
solution the majority of Linux distros will use.

But to ensure OpenVPN doesn't malfunction if things are not correctly
configured or started up on a system, I've tried to improve these
scenarios as I've either stumbled upon them or saw that this can happen.
 That also includes ACKing a systemd pacth from the Gentoo community, to
further improving the implementation regarding the detection of where
the systemd-ask-password program resides.  The only reason it's been
some patches is that systemd is fairly new and moves forward as well.  A
lot have happened since 2011 and we haven't paid attention.

I don't see us complaining about this when it comes to PolarSSL changes
when their API changes.  We can however have a different attitude to
PolarSSL, as the adoption isn't that broad compared to OpenSSL.  But for
systemd, that train is leaving the station now as systemd really gets
tracktion these days.

And just to clarify what systemd-ask-password does.  It provides a
channel for an application to query the user for input.  Whether that is
via a console/terminal, through a graphical boot screen or it for some
other reasons have this information cached in the systemd infrastructure
already.  I've even heard systemd guys are working on extending this to
use kdbus as well.  With the current implementation, we most likely
don't need to do that much if we support systemd-ask-password.

The benefit from all this, is that eventually OpenVPN configurations can
be started by end-users without root access.  The systemd integration
provides functionality to ensure that the user is allowed to start
OpenVPN, and when OpenVPN needs more input (typically
username/passwords/passphrases), systemd ensures that the user who
started OpenVPN gets the chance to provide this information.  And this
isn't unique for OpenVPN, this is a generic interface which all
applications which implements it can use.  In fact, I'm trying to figure
out how to debug a Fedora bugzilla where there are issues related to
querying for PKCS#11 PIN codes via systemd-ask-password.

At some point we might even pass the IP address of the tun/tap device
together with routing information via systemd, making it possible to run
openvpn completely without root privileges.  And this can work
out-of-the-box for both text-only installations and graphical workstations.

> So this might be "./configure --enable-ask-pass=3D$my_program", which=20
> could then be /usr/sbin/systemd-askpass, or something private to OpenVPN
> which would check if systemd is running, and if yes, call systemd-askpass
> and if not, call "whatever makes sense on that particular environment"
> (if $DISPLAY, call ssh-askpass, otherwise, not).

So you want a far more complex implementation to solve a situation which
is currently relevant to systemd?  Just so you don't need to see #ifdef
ENABLE_SYSTEMD in the code?  All these changes (except the pkg.m4 patch,
which can be used by all modules supported by pkg-config) and a few
lines in configure.ac, are well defined *inside* a "only if systemd is
enabled" block. It does not pollute any code paths which does not have
ENABLE_SYSTEMD defined.

Your suggestion will still need the --echo support, as without that even
usernames will not be displayed on the screen or will be masked somehow
- depending on the "ask-password" program.  Which means the reality want
to add *another* layer wrapper to hide systemd out of your sight.  In
addition, I've not seen any other distros requiring such a feature, but
I might just be misinformed.

> Now, the really interesting thing about this is that we have an ACK for
> a patch which is not without religion around it - from someone who has
> never sent an ACK or a patch before.  So, do I take any ACK, no matter
> who sent it?  Do we require ACKs to come from people that have actual
> experience with the code, and are willing to work on the code when these
> bits need maintenance in the future?  "This is the material where project=
=20
> forks are made from"...

Interesting time to question our development process.  As I've said
earlier, I trust Jon's judgement.  And *I* have provided these patches,
and I doubt I'm a stranger to the community these days.  But you
obviously fear that I will disappear completely ...

And this is why I think this is more about "we don't want systemd" than
the code itself.  We have areas in OpenVPN containing much more crappy
code than what I try to improve here.  But now I have a systemd focus,
because it's low hanging fruits and it can save us from having to fix
this in not too far future.  And improving the OpenVPN functionality in
Fedora is an interest of my employer.

> So fully independent from the patch at hand we have some discussion to
> do - and we might want to postpone this particular topic and patchset
> to the face to face meeting, as things tend to get out of hand when
> discussed purely by mail / IRC.

I disagree to postpone this.  This is non-sense on such *clearly*
*defined* patches which are minimalistic and well contained.

We already have much of the systemd implementations in place, and these
two patches will just ensure that OpenVPN will take advantage of useful
features on all systemd distros *and* avoiding issues for package
maintainers.  Plus we can avoid getting trac tickets complaining about
OpenVPN not working with systemd due to misalignment of features between
our implementation and the systemd reality among Linux users.

And this is one fact which seems to not be understood.  Systemd has a
potential to unify much of diversity among the Linux distributions than
earlier attempts.  And we've barely seen the beginning of where systemd
will bring the Linux platform next.


--=20
kind regards,

David Sommerseth


--EG0pSIUrUMS4kg8lieh0Dr8hQSxGLqTBS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlQ0d9QACgkQDC186MBRfrphbwCfa2w0alrOyacBdx/nrGaaAMfu
yRYAn0SdJf4uGqVNClRGyj0utRHjiv1e
=McSB
-----END PGP SIGNATURE-----

--EG0pSIUrUMS4kg8lieh0Dr8hQSxGLqTBS--

