Date: Thu, 09 Apr 2009 07:58:46 -0500
From: "Karl O. Pinc" <kop@...1206...>
References: <1239166995l.18482l.9l@...1207...>
	<F9B005F620B74BD29BB0A36AF509BCED@...576...> <1239203062l.18482l.11l@...1207...>
	<9e0cf0bf0904081546y3daea253u62c234e63a6e5b08@...278...>
	<1239246215l.5600l.0l@...1207...>
	<9e0cf0bf0904082301ia16b642n3781adc357958de3@...278...>
In-Reply-To: <9e0cf0bf0904082301ia16b642n3781adc357958de3@...278...>
	(from alon.barlev@...277... on Thu Apr  9 01:01:50 2009)
Message-Id: <1239281926l.5600l.2l@...1207...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] Unpackged Windows binaries? -- Problems
 building 2.1 rc15 on Windows XP
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; DelSp=Yes; Format=Flowed; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
To: Alon Bar-Lev <alon.barlev@...277...>
Cc: openvpn-devel@lists.sourceforge.net, dave <dev@...575...>


On 04/09/2009 01:01:50 AM, Alon Bar-Lev wrote:
> On Thu, Apr 9, 2009 at 6:03 AM, Karl O. Pinc <kop@...1206...> wrote:
> > It occurs to me that if I want to do more than
> > beg I should submit a patch, so one is attached.
> >
> > On 04/08/2009 05:46:46 PM, Alon Bar-Lev wrote:
> >>
> >> Available as part of OpenSC build [1].
> >>
> >> [1] http://www.opensc-project.org/build
> >
> > I noticed that. =A0Does that build all of what
> > OpenVPN 2.1 packages for Windows, i.e. includes
> > OpenVPN GUI? =A0The project does not seem to release
> > binaries for OpenVPN GUI, which is a requirement
> > for me.
>=20
> OpenVPN GUI is an application that is not part of OpenVPN.
> The fact that it is provided within the same installer is a
> mistake in my view.
> It also does not working in many scenarios OpenVPN support
> as it does not use the management interface.
>=20
> The tap also is not provided as it also should have been provided
> by a different package, as it is too being used by other projects,
> such as coLinux.
>=20
> > I was also a little put off by:
> > "The OpenVPN overlay is provided in order to solve OpenSSL version
> > incompatibility between OpenSC and OpenVPN projects."
> > How can I make sure that I've got what OpenVPN is releasing
> > so that I can go to OpenVPN for support?
>=20
> As OpenSSL does not have stable ABI, compiling two projects with
> different versions of OpenSSL, and loading the two into the same
> process results in invalid behavior.
>=20
> > The OpenVPN devs have a "built" source tree in which they run
> > install-win32/buildinstaller. =A0My point being that
> > if they would package it up
> > and release it alongside the resultant installer
> > none of these sorts of issues would ever come up.
>=20
> Wrong.

Would you care to elaborate?  AFAIK my patch produces
a directory structure from which it is easy to
produce an nsis installer containing OpenVPN provided
binaries, on any platform.  The only prerequisite
is an NSIS install.  You can therefore have an
installer that does not package OpenVPN GUI or tap
if you so choose.

   # Untar
   cd  openvpn-2.1_rc15-winbinaries/
   # Hack nsi/openvpn.nsi
   makensis nsi/openvpn.nsi

(I actually gave a fully qualified path to makensis
when testing, but that was a bit long to include here.)

Naturally this does not address the issue of those
who want customized binaries, or the lack of a
stable ABI.  I did not mean for what I wrote above to
make such claims.  There is still a need for a
(cross) compiler to address broader issues.

My patch addresses the need of those who wish
to repackage the binaries made available by the
OpenVPN project for easy deployment
on Windows clients.  I would think this addresses
a broad need.  Anybody who's using certs to authorize
clients needs to distribute keys and config files that
use them.  And many do not want to go to the trouble
of building their own binaries.  Yet it makes sense
to put the keys and config files into an installer
along with the rest of the OpenVPN to make installation
as simple as possible for the end-user, avoid
unnecessary helpdesk calls, and mitigate all the other hassles
that come with supporting end users.  The installer
could, for example, include help files that tell
the user what to click on connect to which
office.  My patch addresses
the needs of what could be a rather large group,
those who don't want to compile but do want
to customize the end-user experience.

Regards,

Karl <kop@...1206...>
Free Software:  "You don't pay back, you pay forward."
                  -- Robert A. Heinlein

