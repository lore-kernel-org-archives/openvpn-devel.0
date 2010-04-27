Date: Mon, 26 Apr 2010 22:54:42 -0500
From: "Karl O. Pinc" <kop@...1206...>
In-Reply-To: <4E8CFE17-2394-4FAD-A1A5-AF193D97E7A3@...1348...>
	(from toby@...1348... on Mon Apr 26 21:46:06 2010)
Message-Id: <1272340482.17652.2@...1207...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] Unpackaged Windows binaries (Was: Re:
 [Openvpn-users] [ANN] OS X packages - OpenVPN 2.1.1)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
To: Toby Thain <toby@...1348...>
Cc: openvpn-devel@lists.sourceforge.net, openvpn-users@lists.sourceforge.net

On 04/26/2010 09:46:06 PM, Toby Thain wrote:
>=20
> On 27-Apr-10, at 12:19 PM, Karl O. Pinc wrote:
>=20
> > On 04/26/2010 06:19:31 PM, Toby Thain wrote:
> >>>
> >>>
> >>
> >> I don't think unpackaged OS X binaries are very useful, which is
> why
> >> I
> >>
> >> created the pkg+dmg.
> >
> > I agree, because the Apple development kit is shipped,
> > if not installed, on every Mac.
>=20
> It ships on the DVD but most people never install it, of course.
>=20
> >  (Last I looked.)  And
> > because ./configure ; make is painless.
>=20
> To use your argument from above -- imho much too complex for most end=20
>=20
> users. As well as requiring Apple Developer Tools (they have to go=20=20
> find the original DVD, which may or may not even be possible), this=20=20
> involves locating and downloading two source archives from two=20=20
> different sites, and configuring and building them both; beyond the=20=20
> pale for non-technical users, even though it's trivial for "us".

I'm not following you here.  I thought we were talking about whether
unpackaged OS/X binaries were useful to anybody.  The answer being
no because developers and packagers are the only people who need=20
them and developers and packagers can easily create OS/X binaries.

>=20
> The pkg/dmg is, on the other hand, a genuine one click install. (Even=20
>=20
> if you have to do a 2nd key install, which pkg has to be built=20=20
> individually and distributed securely anyway.)

Depending on the degree of security required it could be enough
to key the server but not the client.  It does not matter to
my argument though, if you're going to make individualized packages
for each user you may as well put everything required into
the package you supply.  Having to compile binaries for MS Windows
becomes a big sticking point when making an all-inclusive MS
Windows installer; because you're already making an installer
you know how to do that and you've got a working example
of the OpenVPN installer as a starting point.

> It seems logical to me that an OS X binary dmg could be on the=20
> OpenVPN
>=20=20
> downloads page, giving a similar level of convenience to "yum install=20
>=20
> openvpn" or "apt-get install openvpn" or "emerge openvpn".

Sure.  Packages can be useful to end-users.

>=20
> One thing that should *not*, in my opinion, be encouraged at all by=20=20
> OpenVPN, are third party package managers (MacPorts, Fink, Homebrew=20=20
> etc) as the binary route on OS X. That seems to do more harm than
> good.

I have no opinion.  I suppose it depends on the degree of systems
integration provided by the 3rd party.  I assume this is usually
none, in which case there's no point and the end-user may as well
get their packages straight from the source.

>=20
>=20
> If I were deploying it, rather than hacking on it, I would expect a=20=20
> binary installer to be available for my platform, at
> http://openvpn.net

I'd expect my distro provider to supply it, be sure it integrates
with everything else, and support security fixes.  YMMV.
Of course this assume a distro.  Users of commercial OSs
are generally expected to arrange for their own systems
integration and application support.  In that case the
typical user should follow your advice and get their
packages direct from OpenVPN.

Which raises another issue.  IMO OpenVPN is encouraging
bad practices by supplying packages for distros that
include OpenVPN.  The typical user is more likely to have
a bad OpenVPN experience, over time, when using packages
obtained directly from OpenVPN than when using packages
created by their distro, for the reasons outlined above
and earlier in this thread.  Some people may benefit
from having the most recent OpenVPN and obtaining it
straight from the project, but these people are also
the most likely to be able to package it themselves.
If this is all true then the OpenVPN project is doing
it's userbase a dis-service by making, say, packages
for Red Hat available for download because this is
tacit encouragement of bad practice.  At minimum
there should be a warning to educate the naive user.

The situation is different for MS Windows and OS/X.
Packages are needed for those platforms and whatever
other commercial OSs the project wants to support.

There.  Now I've wandered far from the original
topic and likely offended someone too.
Mission accomplished.  :-P

Regards,


Karl <kop@...1206...>
Free Software:  "You don't pay back, you pay forward."
                 -- Robert A. Heinlein


