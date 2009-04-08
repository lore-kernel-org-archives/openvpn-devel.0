Date: Tue, 07 Apr 2009 19:58:30 -0500
From: "Karl O. Pinc" <kop@...1206...>
Message-Id: <1239152310l.18482l.7l@...1207...>
MIME-Version: 1.0
Subject: [Openvpn-devel] Unpackged Windows binaries? -- Problems building
 2.1 rc15 on Windows XP
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
To: openvpn-devel@lists.sourceforge.net

Hello,

What I really want is a Windows binary and whatever
else gets built, _not_ packaged in an installer, so I can build
my own installer.  It would be nice if OpenVPN would
release such a binary.  Absent that I'm forced to
drag out a Windows machine, torture myself
for hours with it, and pester you. :-)

(I want to make my own installer so I can, e.g., install
real keys and config files that use them.  It seems
straightforward enough to script the keymaking
process and have that script also create an
installer.  Obtaining the raw materials, a Windows
binary, turns out to involve helpings of the
pain that comes with MS Windows.)

I've followed the instructions in domake-win and am having serious=20=20
problems building OpenVPN on XP.

One issue is that cryptoapi.c works around a
problem where CryptAcquireCertificatePrivateKey
is missing from MinGW.  However, I've installed
the latest stable MinGW, 5.1.4, and the function
is now in MinGW.  So, I tried commenting out the
#ifdef __MINGW32_VERSION hacks in cryptoapi.c.
This seems to have worked.  (So far)

But then I got bit by some strange windows problem:
http://forums.logitech.com/logitech/board/message?board.id=3Dquickcam_softw=
are&message.id=3D897&nobounce
(MinGW is a cygwin fork.)
I get this even though I long ago uninstalled the
logitech quickcam software.

Now I get seemingly random segfaults and
very strange behavior, like running domake-win
and having it tell me there's no autoconf directory,
or that at least version 1.4 of m4 is required
even though it's installed, or getting random segfaults
while running the autoconf stuff at the top
of install-win32/makeopenvpn.

In other words XP seems totally borked.

I find that LVPrSrv program has risen from
the dead to haunt me.  I may have finally gotten
rid of it....  For the moment the compile is working....

Now I get:
!define "SF_SELECTED" already defined!
Error in script "gen/nsi/openvpn.nsi" on line 264 -- aborting creation=20=20
process

This I imagine I can figure out.

If there happen to be recommended versions of all the
tools that are known to work together and avoid
all these problems, or anything else that makes
it "just work", please let me know.

Thank you for your time.

Regards,

Karl <kop@...1206...>
Free Software:  "You don't pay back, you pay forward."
                  -- Robert A. Heinlein

P.S.  If I can't have unpackaged Windows binaries
I would oh-so-love to have a cross-compiler
so I could compile for Windows on Linux.  There
seems to be one for OpenSC that compiles OpenVPN.
http://www.opensc-project.org/build/browser/trunk/build
Perhaps OpenVPN could coordinate with them and
support cross-compiling?  (Please, please, please.)

P.P.S.  It is not clear from the domake-win instructions
that the process is supposed to be undertaken on a
MS Windows machine.  A note in the instructions would
be helpful.

