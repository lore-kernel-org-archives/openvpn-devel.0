Date: Sat, 18 Feb 2012 17:06:24 -0600
From: "Karl O. Pinc" <kop@...1206...>
References: <CAOazyz3S2GAFu+TN0s7482ovQBdWJYUxALVfOEiF6UGHR0oW0Q@...278...>
	<CAJKrh+Ujepn465ebS2yHThjZMqDRKA7+qWvHF1XNAjpVches1A@...278...>
In-Reply-To: <CAJKrh+Ujepn465ebS2yHThjZMqDRKA7+qWvHF1XNAjpVches1A@...278...>
	(from s@...1497... on Sat Feb 18 16:53:50 2012)
Message-Id: <1329606384.26198.0@...1207...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [DEVELOPER REQUESTED] Repackage TAP-Win32
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
To: Scott Zeid <s@...1497...>
Cc: openvpn-devel@lists.sourceforge.net

On 02/18/2012 04:53:50 PM, Scott Zeid wrote:
> On Feb 18, 2012 9:05 AM, "Alon Bar-Lev" <alon.barlev@...277...>=20
> wrote:
> > 9. Output of build system would be [at least] (msi, tarball) for
> > (win32, win64). Why tarball? To enable people to fetch files=20
> without
> > hacking the msi (example: cross compile).
>=20
> It should probably be a zip file since Windows doesn't support
> tarballs out
> of the box.

I'm not a MS guy, but that argument does not carry a whole lot
of weight since MS Windows does not support NSIS, or any other
sort of installer-crafter, out of the box either; and people should
be using an installer to install, not archived binaries
in whatever format.  It almost makes sense to make it harder
for the casual MS user to try to install using the raw
binaries.

Bikeshed argument flag!  In the end, it does not matter.




Karl <kop@...1206...>
Free Software:  "You don't pay back, you pay forward."
                 -- Robert A. Heinlein


