Date: Mon, 26 Apr 2010 14:11:26 -0500
From: "Karl O. Pinc" <kop@...1206...>
In-Reply-To: <20100426165319.11222.qmail@...1287...> (from peter@...1287... on
	Mon Apr 26 11:53:19 2010)
Message-Id: <1272309086.19417.1@...1207...>
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
To: Peter Stuge <peter@...1287...>
Cc: openvpn-devel@lists.sourceforge.net

On 04/26/2010 11:53:19 AM, Peter Stuge wrote:
> Karl O. Pinc wrote:
> > the project is already releasing unpackaged Linux
> > binaries
>=20
> Really?

They seem to have stopped sometime after July 30 2008.

http://web.archive.org/web/20080730205524/openvpn.net/index.php/
downloads.html

It's hard to tell when because archive.org does not appear
to be allowed to archive the site any longer.  Or at least=20
there's nothing more recent.  (This seems silly.  I wonder why.)

(I clearly haven't been downloading binaries in a while.
Probably because I rely on my distro for binaries so
they can do the systems integration and security patches,=20
or I am getting development from CVS/git.

IMO people who don't rely on their distro for systems integration
and security patches are asking for trouble.  There are of course
always reasons to make specific exceptions, RH comes to mind. :)

Is OpenVPN in RHEL6?)

>=20
> > and it now talking about doing the same for OS/X binaries.
>=20
> Recently discussed work for contrib/ produces a .dmg, very much a
> package in my view.

Ok.  I don't know much about .dmg.  I thought they were basically
tarballs by another name in that they just stick stuff somewhere.
My Mac usage is sporadic, sorry.

>=20
>=20
> > There's clear utility.
>=20
> I guess it depends. I'm not sure that I agree that compilation is a
> much bigger bother than (cross-)compiling the NSIS installer..

On Debian all I had to do was "aptitude install nsis" and then
run it to make MS Windows installers.  Plug and play, no=20
compiling necessary.

Regards,

Karl <kop@...1206...>
Free Software:  "You don't pay back, you pay forward."
                 -- Robert A. Heinlein


