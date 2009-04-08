Date: Wed, 08 Apr 2009 10:04:22 -0500
From: "Karl O. Pinc" <kop@...1206...>
References: <1239166995l.18482l.9l@...1207...>
	<F9B005F620B74BD29BB0A36AF509BCED@...576...>
In-Reply-To: <F9B005F620B74BD29BB0A36AF509BCED@...576...> (from
	dev@...575... on Wed Apr  8 07:58:12 2009)
Message-Id: <1239203062l.18482l.11l@...1207...>
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
Content-Type: text/plain; DelSp=Yes; Format=Flowed; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
To: dave <dev@...575...>
Cc: openvpn-devel@lists.sourceforge.net


On 04/08/2009 07:58:12 AM, dave wrote:
> > -----Original Message-----
> > From: Karl O. Pinc [mailto:kop@...1206...]
> ...
> > I suspect that what I want is exactly what OpenVPN already has at
> > http://openvpn.net/prebuilt/.  The problem is that it's not
> > labeled as such and does not seem to have the same "supported"
> ...
> > So I guess what I'm asking is for this build to be documented
> > and placed on the download page with the rest of the
> > official downloads.  (Assuming I can just run
> > install-win32/buildinstaller and have an installer
> > produced.)
> ...
>=20
> I'm pretty sure you can setup MinGW to build on Linux, though I
> haven't.

Yeah.  On Debian it just installs and seems to work.  But there must
be more involved, somewhere, to have it go from source to nsis
installer.  I say this because I thought the instructions would
enable me to cross compile, and so I installed the prerequisites
on Linux and gave it a go.  The ./configure failed it's tests
for libraries, because of course the Windows libraries would
not run on Linux.

>=20
> Agreed on the binary tarball, but brace yourself:  the source tarball
> is
> not always up-to-date to the current version either.

Well, if the developers grant my wish then it _would_ be current. :)


Karl <kop@...1206...>
Free Software:  "You don't pay back, you pay forward."
                  -- Robert A. Heinlein

