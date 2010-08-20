Message-ID: <4C6E73E4.6060300@...515...>
Date: Fri, 20 Aug 2010 15:24:04 +0300
From: =?ISO-8859-15?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------060508000503060702060101"
Subject: [Openvpn-devel] Summary of the IRC meeting (19th Aug 2010)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This is a multi-part message in MIME format.
--------------060508000503060702060101
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable

Hi,

Here's the summary of the previous community meeting.

---

COMMUNITY MEETING

Place: #openvpn-devel on irc.freenode.net
Date: Thursday, 19th Aug 2010
Time: 18:00 UTC

Planned meeting topics for this meeting were on this page:

<https://community.openvpn.net/openvpn/wiki/Topics-2010-08-19>

Next meeting next week, same place, same time. Your local meeting time
is easy to check from services such as

<http://www.timeanddate.com/worldclock>

or with

$ date -u


SUMMARY

Discussed Windows driver signing issues in OpenVPN 2.1.2. James is on
this and will make a new release (2.1.3) once finished. Windows 2000
drivers are part of this issue, as the latest Windows Driver Development
Kit (DDK/WDK) does not support Win2k anymore. Agreed that 2.1.3 should
support Win2k, but support can be dropped in later releases as Win2k is
already EOL (since 13th July 2010). Mattock sent mail to -users ml
asking if somebody is still on Win2k. No responses in first ~16 hours.

The upcoming 2.2-beta3 release will need changes because of the new DDK.
 Jamesyonan will make the required changes to 2.1.3 and dazo will merge
those into 2.2-beta3.

--

Discussed building the Windows releases. Currently jamesyonan is the
only one who knows how to build OpenVPN on Windows. He's in the process
of converting the OpenVPN build system (on Windows) to depend only on
python, Visual Studio Professional and DDK. The original build system
required bash and various other UNIX tools.

Decided to setup a WinXP 32bit VM and give selected community members
access to it. This way "testing" code can be built and tested on
Windows. Thanks to raidz, this VM is online and mostly configured already.

--

Jamesyonan asked if somebody could help him with finishing the build system:

"The current NSIS installer script needs to be updated to read the dist
directory that is built by the new python build system."

The new build system stuff is already in SVN in the "win" subdirectory.
Instructions for using James' SVN repository can be found from here:

<http://www.openvpn.net/index.php/open-source/documentation/miscellaneous/s=
ubversion-repository.html>

--

Discussed the first 2.2-beta release. Decided to proceed like this:

- jamesyonan fixes the driver issue in 2.1.2 and releases 2.1.3
- jamesyonan builds and signs the drivers for 2.2-beta3
- jamesyonan builds the first version of 2.2-beta3 for Windows
- simultaneously a WinXP VM is setup and configured for building next
releases
- the WinXP VM could be used for the Windows-side of the whole process
for later 2.2-beta/rc/stable releases

--

Discussed updating the community software "Downloads" page on
openvpn.net. Jamesyonan has a series of scripts to automate the process
of publishing a new releases, so mattock can't edit the downloads page
directly. Jamesyonan promised to give mattock access to the scripts and
page templates. This allows adding link to OpenVPN snapshot builds
available from http://build.openvpn.net/downloads

--

Discussed relation of old ("previous") and new ("current") releases.
Agreed that we should support the "previous" release for some time after
the "current" release is made. For example, 2.1.x series should be
supported with bugfixes until 2.2 goes stable + some extra time. This
gives system administrators some time to upgrade their infrastructure
while at the same time remaining on a stable and supported platform.

--

Discussed the issues in communication between community and company
developers. Jamesyonan agreed to become a regular in the IRC to
facilitate communication, even though he's constantly swamped (thanks
James!). Community members agreed to help him out in his tasks whenever
possible, starting with learning how to build the Windows releases.

---

Full chatlog as an attachment

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock

--------------060508000503060702060101
Content-Type: text/plain; charset="utf-8";
 name=openvpn_irc_meeting_chatlog_2010-08-19.txt
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
	filename="openvpn_irc_meeting_chatlog_2010-08-19.txt"

(21:01:18) jamesyonan: I almost have the driver signing issue fixed
(21:01:48) jamesyonan: but now there is another issue as well -- the latest=
 MS DDK doesn't support Win2K any longer
(21:02:32) jamesyonan: so in order to support Win2K we need to ship multipl=
e versions of the drivers, each built by different versions of the DDK
(21:03:02) mattock: do we want to support Win2k? Isn't it EOL for microsoft?
(21:03:07) jamesyonan: and the installer needs to detect the windows versio=
n and install the correct driver
(21:03:11) ***cron2 just points out that he's here but not really "carry ar=
ound child"
(21:04:20) dazo: officially Win2K is EOL ... but I believe you can buy an e=
xtended support pack for 2-3 more years
(21:04:37) cron2: does the security problem affect w2k?
(21:04:47) jamesyonan: yes
(21:04:54) mattock: I'll check the EOL status of Win2k
(21:06:01) cron2: well, if we have w2k support in 2.1 and a security proble=
m affecting them, I think 2.1.2 as
(21:06:13) cron2: also needs to support w2k
(21:06:25) cron2: 2.2 might not
(21:06:43) jamesyonan: I don't think we just drop support for Win2K in the =
middle of a release cycle
(21:06:47) ecrist: I would think win2k users need somem notice, if anything.
(21:06:54) ecrist: some*
(21:07:10) cron2: jamesyonan: well, yes, what I said :)
(21:07:11) ecrist: win2k support will cease effective 2.2 or 2.3, perhaps
(21:07:12) mattock: jamesyonan: good point... but perhaps drop support in 2=
.2-beta2?
(21:07:59) dazo: http://support.microsoft.com/lifecycle/search/default.aspx=
?sort=3DPN&alpha=3DWindows+2000&Filter=3DFilterNO
(21:08:00) vpnHelper: Title: Microsoft Product Lifecycle Search (at support=
.microsoft.com)
(21:08:12) jamesyonan: maybe we can ping the lists and see how many people =
still use Win2K
(21:08:15) dazo: hmm .... Extended li
(21:08:24) dazo: Lifetime support expired in July
(21:08:52) ecrist: looks to me like terminating win2k effective 2.2 is reas=
onable.
(21:09:01) mattock: http://blogs.technet.com/b/windowsserver/archive/2010/0=
1/14/windows-2000-server-approaching-end-of-life.aspx
(21:09:03) vpnHelper: Title: Windows 2000 Server Approaching End of Life - =
Windows Server Division WebLog - Site Home - TechNet Blogs (at blogs.techne=
t.com)
(21:09:16) mattock: July 13th, 2010
(21:09:17) dazo: I do not see any issues if we make a separate download for=
 Win2000 ...  for 2.1.2, and announce that 2.1.2 is the last update with Wi=
n2000 support
(21:09:38) ecrist: maybe point the release notes to that webpage
(21:09:39) cron2: that sounds much  easier yes
(21:10:21) mattock: ok, July 13th 2010 is the EOL for extended support for =
Windows 2000 server
(21:10:27) mattock: or rather, was
(21:10:34) mattock: so it's not supported anymore
(21:11:02) mattock: I think supporting win2k in 2.1.2 is reasonable
(21:11:09) mattock: as is dropping support in 2.2-beta2
(21:11:15) mattock: and later 2.1.x releases (if any)
(21:11:20) ecrist: 2.1.*, really
(21:11:49) dazo: The advantage of having a separate download for 2.1.2 on W=
in2K, is that we easy can measure how many Win2K users we have
(21:12:00) mattock: dazo: yep, good point
(21:12:22) mattock: jamesyonan: what do you think? should 2.1.2 be the last=
 release to support win2k?
(21:13:09) jamesyonan: mattock: yes, I think I agree with that
(21:13:51) mattock: ok, good
(21:14:08) mattock: does this decision have effect on driver signing in 2.2=
-beta2?
(21:14:27) mattock: I mean, it's not an issue in 2.2-beta2, then
(21:14:27) mattock: ?
(21:15:33) mattock: btw. the topics page is here: https://community.openvpn=
.net/openvpn/wiki/Topics-2010-08-19
(21:15:35) vpnHelper: Title: Topics-2010-08-19 =EF=BF=BD=EF=BF=BD=EF=BF=BD =
OpenVPN Community (at community.openvpn.net)
(21:15:35) dazo: what you're asking is if 2.2-beta needs code changes to wo=
rk with the new DDK?
(21:16:05) mattock: dazo: perhaps, have to google for DDK first :)
(21:16:26) jamesyonan: dazo: yes
(21:16:27) mattock: ok, driver development kit
(21:17:02) dazo: jamesyonan:  yes - as in right question, or code needs to =
be changed?
(21:17:34) jamesyonan: dazo: yes, some changes in build scripts are required
(21:17:40) mattock: I'll send mail to -users list looking for win2k users
(21:17:44) dazo: okay
(21:21:11) dazo: jamesyonan:  if you mail me the changes you need to do in =
the beta2.2 branch, I'll make sure to get them in ... edit files, git add <=
filename>, git commit -s, and git format-patch HEAD~1 ... and then you can =
mail me the 0001-*.patch=20
(21:24:27) mattock: ok, sent
(21:24:30) mattock: sorry for the delay
(21:26:56) mattock: shall we move to the 2.2-beta2 showstopper issues?
(21:27:04) dazo: shoot!
(21:27:28) mattock: so build scripts in 2.2-beta2 need modification, as jam=
es noted
(21:28:01) mattock: jamesyonan: could some of us help you make the build sc=
ript modifications?
(21:29:12) dazo: I don't know how the build process works ... I got a feeli=
ng jamesyonan got some clever scripts automating a lot of this ... and it's=
 not easy for us to test if the modifications are correct
(21:29:30) jamesyonan: dazo: I will release 2.1.3 with driver signing fix, =
then you should be able to get build system patch from svn
(21:29:35) cron2: we'd need to actually build the stuff :)
(21:29:48) dazo: jamesyonan:  cool!  I'll do that
(21:29:54) mattock: jamesyonan: excellent!
(21:30:48) jamesyonan: it would be cool if others could learn the Windows b=
uild system -- I'm a bit of a bottleneck here
(21:30:56) mattock: jamesyonan: is it trivial to build the 2.2-beta2 Window=
s installer after fixing the build scripts (in 2.1.3)
(21:31:26) cron2: windows building is not *that* hard if you actually have =
a windows machine
(21:31:27) jamesyonan: the easy part of the build system is that there's on=
e script that does everything : ./domake-win
(21:31:45) jamesyonan: the hard part is getting all the dependencies
(21:31:57) ***cron2 has no windows machines except an old laptop that does =
not have enough disk space in c: (and the build system fails in intersting =
ways if not all is on c:)
(21:32:14) dazo: what's the requirements for windows building? ... what kin=
d of OS and software is needed? Can that be on a VM which some of us have a=
ccess to?
(21:32:14) cron2: I used a customer machine for my build tests...
(21:32:17) mattock: andrew just asked if we needed a Windows VM to use as b=
uild machine
(21:32:28) mattock: what do you think?
(21:32:36) cron2: dazo: windows XP, mingw, windows device driver kit
(21:32:48) cron2: and there's one catch: git doesn't like mingw
(21:32:56) ecrist: heh
(21:33:06) mattock: jamesyonan: would a VMWare VM do the trick? If andrews =
sets one up
(21:33:15) dazo: cron2:  oh?  there are two git version for windows, though
(21:33:18) raidz: I would be more than happy to give you guys a win xp vm i=
f needed
(21:33:18) jamesyonan: another alternative is that I could publish a set of=
 signed driver builds, and then others could take over the Windows build pr=
ocess using those driver builds as a source
(21:33:20) mattock: I can learn Windows building, even though it gives me t=
he creeps :)
(21:33:23) raidz: and it would be on kvm, not vmware
(21:33:40) cron2: dazo: for *mingw*?  this is a specific environment (where=
 you can run bash scripts and such)
(21:33:57) cron2: jamesyonan: that would be appreciated
(21:34:06) dazo: cron2:  ahh ... is cygwin supported?
(21:34:08) mattock: jamesyonan: signed drivers would help=20
(21:34:10) cron2: dazo: no
(21:34:15) dazo: gah ... oki
(21:34:33) jamesyonan: I use a package called "msys" that is a mingw-built =
version of standard unix tools like bash
(21:34:34) cron2: dazo: well, one might make it work, but it's a different =
useful-cli-on-windows environment than mingw
(21:34:44) dazo: I see
(21:34:50) cron2: mingw+msys, that's it (sorry for omitting the msys bit)
(21:35:00) mattock: raidz: not sure if kvm can be used for Windows driver b=
uilding
(21:35:01) dazo: and one of the git versions are msys based
(21:35:15) mattock: although building the drivers is different from using t=
hem...
(21:35:26) raidz: :-)
(21:35:41) mattock: just ignore what I said, I make no sense :)
(21:35:49) cron2: git compiled under mingw+msys works for basic stuff, but =
fails for "has file x been changed?" tests because of file modes - windows =
can not provide proper unix "chmod" semantics, so what git checks out and t=
hen later on finds on the file system doesn't agree
(21:36:00) dazo: sure, that shouldn't be any problem ... KVM or vmware ... =
it's both a machine for Windows ... so it shouldn't really matter ... perfo=
rmance wise is rather another topic though
(21:36:06) raidz: I could probably get you a vmware vm if its necessary, I =
am not a fan of vmware
(21:36:16) dazo: cron2:  okay
(21:36:26) cron2: dazo: but I built git myself, so maybe the provided versi=
on for git-on-msys is fixed in that regard
(21:36:35) raidz: kvm owns vmware in windows performance!
(21:36:35) mattock: I think James' suggestion about providing signed driver=
s is the easiest one=20
(21:36:51) mattock: then we could use *NIX to build the Windows installers
(21:36:54) dazo: cron2:  http://code.google.com/p/msysgit/
(21:36:55) vpnHelper: Title: msysgit - Project Hosting on Google Code (at c=
ode.google.com)
(21:37:07) cron2: raidz/mattock: a VM should be sufficient.  from within wi=
ndows, you can't really see the difference anyway
(21:37:17) mattock: raidz: we'd need a Windows VM to test installer and Ope=
nVPN anyways
(21:37:21) cron2: dazo: noted, will test "as soon as I'm at that customer a=
gain"
(21:37:26) dazo: :)
(21:37:41) raidz: which flavor xp, 7? 2003?
(21:37:55) mattock: perhaps 7?
(21:38:02) mattock: I guess XP is also coming to EOL soon
(21:38:05) raidz: your choice
(21:38:06) jamesyonan: I'm also in the process of developing a new build sy=
stem using python instead of bash as the scripting language.  This code is =
in the win subdirectory.  The advantage of this system is that it doesn't r=
equire mingw or msys -- it uses python, visual studio, and DDK
(21:38:10) cron2: I think building on XP is more likely to give us upwards =
compatible binaries
(21:38:23) cron2: jamesyonan: is visual studio freely available?
(21:38:42) ecrist: cron2: I think so.
(21:38:54) raidz: How about XP 64bit?
(21:39:05) ecrist: http://msdn.microsoft.com/en-us/vstudio/default.aspx
(21:39:06) vpnHelper: Title: Visual Studio on MSDN (at msdn.microsoft.com)
(21:39:15) dazo: mattock:  XP EOL is in 2014
(21:39:17) mattock: raidz: isn't that the most incompatible Windows ever?
(21:39:31) raidz: ouch
(21:39:39) mattock: dazo: ok, I guess it was only the OEM version
(21:40:00) mattock: then I'd go with XP as cron2 suggested
(21:40:03) jamesyonan: cron2: no, visual studio costs money, however OpenVP=
N Tech has an MSDN subscription, and we could probably provision a Windows =
VM with visual studio installed for community builds
(21:40:04) dazo: If stuff built on XP works in Win7 ... then I'd go for XP
(21:40:32) mattock: jamesyonan: sounds good
(21:40:43) cron2: jamesyonan: mmmh, ok.  what's the advantage of visual stu=
dio vs. msys/mingw?
(21:40:46) raidz: mattock: Ok, winxp 32bit it is. How much ram would you li=
ke allocated to it?
(21:41:10) cron2: (call me a windows noob, so I'm genuinely interested - ha=
ven't done any development on ms platforms since DOS 6.0 days)
(21:41:24) ***cron2 likes msys "feels like home"
(21:41:26) mattock: mmm... is 1GB enough for XP? I mean realistically?
(21:41:27) jamesyonan: I'm a bit concerned with the maintenance of msys/min=
gw
(21:41:41) ecrist: mattock: that's plenty
(21:41:42) cron2: jamesyonan: ok, that's a strong argument
(21:41:47) cron2: mattock: plenty
(21:41:56) mattock: raidz: ok, 1GB if you got that much
(21:41:57) dazo: jamesyonan:  can you elaborate?
(21:42:01) raidz: winxp 32bit, 1gb ram it is
(21:42:21) mattock: raidz: sounds good... just make sure it's behind a VPN,=
 firewall and all that
(21:42:26) mattock: :D
(21:42:42) raidz: hehe, will do
(21:42:48) cron2: raidz: once that VM is set up, how complicated would it b=
e to clone it?  (Like "I'd like to test some new tap driver features and ma=
ke sure I'll not break something for james")
(21:43:15) mattock: cron2: there are some issues with truly cloning the VM.=
..=20
(21:43:36) mattock: I played with Windows deployments a while back... MS ha=
d some crappy software to do automated deployments
(21:43:49) jamesyonan: dazo: sometimes newer windows API methods are not ex=
posed in mingw .h files
(21:43:49) mattock: I'd say not worth the effort... however, there are OSS =
tools for the same job
(21:44:00) raidz: Yeah, that would be kind of tough
(21:44:01) dazo: well, it could be done easier ... make a image copy of the=
 disk ... if changes screws it up, restore to the backup image
(21:44:06) raidz: dazo: thats what I am thinking
(21:44:14) raidz: We could go down that route
(21:44:17) mattock: dazo, raidz: yep, that's easy
(21:44:33) cron2: that's along the lines I was thinking
(21:44:36) dazo: that route do not cause any nasty licensing issues
(21:44:56) mattock: or any issues with serial numbers, anti-piracy stuff etc
(21:45:08) raidz: :-D
(21:45:14) dazo: jamesyonan:  ahh ... that's concerning ... then I understa=
nd the python route even better
(21:45:33) mattock: ok, so this is looking good
(21:45:41) cron2: but changing to ms vis studio also means "no more cross c=
ompiling", right?
(21:45:45) mattock: raidz will create a WinXP 32bit 1GB VM
(21:46:01) jamesyonan: python is very actively supported for windows right =
now
(21:46:04) raidz: mattock: doing it now!
(21:46:16) mattock: raidz: great!
(21:46:39) dazo: cron2:  it can mean that, to some degree .... but if mingw=
 don't follow windows API closely enough, the cross build is worthless anyw=
ay
(21:47:02) jamesyonan: the python build system can exist in parallel with t=
he standard autoconf/automake system
(21:47:04) cron2: well, there is that
(21:47:19) jamesyonan: of course visual studio and DDK must run on real win=
dows
(21:47:29) dazo: yeah
(21:48:27) mattock: raidz: is it possible to put the VM behind a VPN and gi=
ve access to a few people?
(21:48:33) raidz: yep
(21:48:43) mattock: I'm worried about Windows getting hacked
(21:48:50) mattock: and also securing the connecting
(21:48:59) mattock: ok, nice!
(21:49:05) cron2: vpn-only is fine for me :)
(21:49:16) raidz: we can discuss that on IM shouldn't be an issue
(21:49:20) ***dazo agrees
(21:49:21) mattock: ok, good
(21:50:15) mattock: jamesyonan: when you get drivers for 2.1.3 fixed... wil=
l it be trivial to rebuild and sign the drivers for 2.2-beta2?
(21:50:38) mattock: 2.2-beta2 has parts of IPv6 support in place
(21:50:51) jamesyonan: mattock: probably
(21:50:57) mattock: ok
(21:51:03) mattock: what if we do this:
(21:51:09) dazo: (IPv6 support only in wintap driver)
(21:52:28) mattock: - james fixes the driver issue with 2.1.2
(21:52:28) mattock: - ...and builds and signs the drivers for 2.2-beta2
(21:52:29) mattock: - ... and builds the first version of 2.2-beta2 for Win=
dows
(21:52:29) mattock: - simultaneously the WinXP VM is setup and configured f=
or building next releases
(21:52:52) mattock: and in 2.2-beta3 the WinXP VM could be used for the Win=
dows-side of the whole process
(21:52:59) mattock: is this realistic?
(21:53:02) cron2: mattock: +1
(21:53:34) dazo: it might be that we need to jump to 2.2-beta3 .... to grab=
 the changes from jamesyonan for doing proper windows builds
(21:53:52) cron2: this sounds like a good plan to get moving quickly
(21:54:15) mattock: jamesyonan: is that ok for you?
(21:54:46) mattock: dazo: probably... people will wonder what we've been sm=
oking to release 2.2-beta3 as the first beta release :)
(21:55:32) dazo: mattock:  I know ... the other option is to scratch earlie=
r commits ... release new tarballs with already used names .... I find that=
 more messy :)
(21:55:45) jamesyonan: mattock: that's reasonable -- one caveat is that the=
 NSIS installer script hasn't been updated yet to work with the python buil=
d system
(21:56:12) jamesyonan: mattock: another caveat is that someone needs to ins=
tall all the dependencies on the VM
(21:56:17) dazo: jamesyonan:  can that become a community task?  to offload=
 you? ... we need the VM first then
(21:56:32) dazo: (with dependencies)
(21:57:13) jamesyonan: dazo: yes, that would be good
(21:58:23) cron2: so, child asleep, hands free again :)
(21:58:43) cron2: mattock, dazo: well, releasing as beta3 show that we did =
some testing on beta1 and beta2 :-) (which we did!)
(21:59:13) dazo: true, I'm running beta2 on two servers .... one client rol=
e and one server role
(22:00:03) mattock: btw... regarding VPN access to the build (XP) computer.=
.. if we use OpenVPN, does that make testing the builds harder?
(22:00:34) cron2: yes.  it would be good to have the access-the-XP VPN term=
inate somewhere else that the tap driver on windows is not in use
(22:01:14) dazo: mattock:  what do you mean now?  running the OpenVPN serve=
r on XP as a OpenVPN server?
(22:01:49) cron2: that's how I understood the question - run the OpenVPN on=
 the XP VM itself
(22:01:56) mattock: I mean that if OpenVPN is installed on the XP machine a=
lready... and then we build OpenVPN on the XP machine, and install it on th=
e same XP machine
(22:02:15) cron2: for testing, yes, for production access (to actually do t=
he building), no
(22:02:25) mattock: doesn't that create problems, especially if the new ins=
tall does not work
(22:02:29) dazo: yes, cron2 caught my point
(22:02:38) cron2: mattock: yes, it would -> don't do it
(22:02:48) mattock: ok, so where do we test the builds?
(22:02:48) cron2: put the OpenVPN server on a linux vm next door :)
(22:02:56) dazo: we can use winxp as a server as well ... *but* we need a b=
ackdoor via another VPN as well
(22:03:24) dazo: (we would then probably access the winxp openvpn server vi=
a the vpn though)
(22:03:57) dazo: (change delta between v2.2-beta2 and the last commit in be=
ta2.2 ... http://www.fpaste.org/Ro1r/)
(22:05:10) mattock: I don't think we need  to solve this VPN issue right no=
w...=20
(22:05:17) dazo: nope, good point
(22:06:08) mattock: jamesyonan: how can we help with the NSIS installer scr=
ipt / python build system issue?
(22:07:17) mattock: what issues does it have currently?
(22:07:37) cron2: my guess is "not finished"
(22:07:41) jamesyonan: the NSIS installer script needs to be updated to rea=
d the "dist" directory that is built by the new python build system
(22:08:04) mattock: is the new build system stuff in SVN already?
(22:08:09) jamesyonan: yes
(22:08:14) mattock: nice!
(22:08:23) mattock: ok, so let's wait until raidz setups the VM
(22:08:46) mattock: somebody at the company can then install Visual Studio
(22:09:00) mattock: then somebody (perhaps I) can install DDK and requireme=
nts for OpenVPN builds
(22:09:19) mattock: then we can get to debugging and fixing the build scrip=
ts
(22:09:41) dazo: +1
(22:09:51) mattock: next topic?
(22:11:19) mattock: no objections :)
(22:12:02) mattock: jamesyonan: what should we do with the community softwa=
re "Downloads" page? I understood you have a script to help making releases=
...
(22:12:09) mattock: so I can't edit the page directly
(22:12:51) mattock: do you want to make the 2.2-beta3 release yourself? or =
offload it to someone else, e.g. me?
(22:13:15) jamesyonan: yes, I do have a series of scripts to automate the p=
rocess of publishing a new release
(22:13:35) dazo: could that be dumped into the VM as well?
(22:14:52) jamesyonan: the scripts to publish the release run on *nix
(22:14:59) dazo: ahh :)
(22:15:31) mattock: do you want to make the releases yourself?
(22:15:49) cron2: signing the tar.gz is problematic if "we" do it
(22:15:59) mattock: cron2: yes, true
(22:16:20) raidz: which version of visual studio guys?
(22:16:37) cron2: but mattock might be able to do the "update the web site"=
 bit (and enhance that part to add links, more releases, etc.)
(22:17:04) cron2: (I assume that this all happens inside the openvpn tech n=
etwork)
(22:17:07) mattock: cron2: yep, I need to add links to OpenVPN snapshots an=
d all that
(22:17:26) mattock: I can edit most of the pages, but not these dynamically=
 created ones
(22:17:30) mattock: like "Downloads"
(22:17:48) cron2: from mgetty release stuff, I assume that the script wil p=
ick a web site template, put in the most recent tarball version found, and =
ship to server
(22:17:49) mattock: well, actually I can, but my changes would just get ove=
rwritten later
(22:18:05) cron2: if that is how it works here, mattock would need to work =
on the templates
(22:18:55) mattock: jamesyonan: which Visual Studio version should we insta=
ll?
(22:19:17) jamesyonan: probably 2008
(22:19:20) mattock: ok
(22:19:39) mattock: raidz will install that, then
(22:20:38) raidz: jamesyonan: Visual Studio 2008 Standard Edition. Is that =
okay?
(22:20:54) jamesyonan: no, use professional edition
(22:21:28) mattock: jamesyonan: is there any way I could edit the page sour=
ce / template for the "Downloads" page?
(22:22:11) raidz: jamesyonan: sounds good, thanks
(22:22:24) jamesyonan: mattock: yes, I can give you the svn address where t=
hese scripts are kept
(22:22:31) mattock: ok, excellent!
(22:22:53) mattock: let's discuss that later
(22:25:38) mattock: should we talk about 2.1.x vs. 2.2-beta?
(22:25:49) mattock: briefly, I hope
(22:25:50) mattock: :)
(22:27:04) cron2: as far as I understand, 2.1 should only receive crucial f=
ixes, while 2.2 gets new features and an extended test phase to make sure t=
hat the new features don't break anything
(22:27:16) dazo: +1
(22:27:21) mattock: +1
(22:28:08) mattock: so "previous release" should receive only bugfixes...
(22:28:24) mattock: should those end after the "next release" is stable?
(22:28:59) mattock: or do we want overlap by having two "stable" releases b=
eing supported simultaneously?
(22:29:04) dazo: ideally yes, but we can have a transition period where bot=
h is supported .... say 6 months after the next major version
(22:29:16) cron2: mattock: I'd say yes for security fixes
(22:29:17) mattock: jamesyonan: how has this been handled historically?
(22:30:14) jamesyonan: historically, we've had only one "stable" release at=
 a time
(22:33:13) mattock: if we have a shorter release cycle, then supporting the=
 "previous release" for a while would make sense
(22:33:52) mattock: also, people might not be able to upgrade at once _and_=
 might also be reluctant to use RC's
(22:33:59) mattock: so some overlap would make sense I guess
(22:34:40) mattock: how much would be enough?
(22:34:42) dazo: Some overlap is reasonable.  And as OpenVPN is not haunted=
 with security issues, it should be doable .... 6 months might be too much,=
 though
(22:34:51) mattock: agreed
(22:34:55) mattock: maybe 3 months?
(22:35:48) dazo: probably, 3 months or if 2 major releases comes within the=
 support period, only the two last released releases
(22:36:19) dazo: (the two last releases, where the oldest one maximum 3 mon=
ths after the release of the newest one .... to say it in one sentence)
(22:36:19) mattock: supporting two previous releases would be simple to rem=
ember=20
(22:37:21) mattock: or maybe support the "previous release" until next-next=
 goes beta?
(22:37:48) ***ecrist reboots forum VM
(22:37:54) mattock: ecrist: why is that?
(22:38:47) ecrist: needed to apply a patch to the kernel
(22:38:51) mattock: ok
(22:38:56) ecrist: thought I'd done it before, but I had not
(22:39:12) ecrist: related to FreeBSD-SA-10:07.mbuf
(22:39:56) dazo: we can probably discuss these support periods in another m=
eeting?
(22:40:02) mattock: dazo: my thoughts exactly
(22:40:11) mattock: ok, so there's one more thing
(22:40:40) ecrist: forum is back up
(22:40:45) mattock: jamesyonan: what do you think about my suggestion about=
 hanging in the IRC more regularly?
(22:40:53) mattock: that'd help us _a lot_
(22:41:11) mattock: even if you don't monitor the IRC
(22:41:26) mattock: every 1-5 minutes I mean
(22:42:13) dazo: jamesyonan:  and to remove worries of spending too much ti=
me here ... it's not that much traffic on this channel between the meetings=
, but sometimes I wish you were here, as there are short quick questions wh=
ich could save time=20
(22:42:47) dazo: and ... you could bug us with things you see needs to be d=
one, and we might catch them and fix stuff quicker as well, which again off=
loads you even more
(22:42:54) mattock: +1
(22:43:00) jamesyonan: I can leave this channel open
(22:43:17) mattock: jamesyonan: you should definitely bug us more often... =
we're here to help you
(22:43:26) dazo: +1000
(22:44:13) mattock: and we all share the same goals... I for one want to of=
fload as much stuff from you as possible
(22:45:17) jamesyonan: thanks... It will help me a lot to offload the windo=
ws building responsibilities.
(22:45:29) mattock: you're welcome!
(22:45:36) dazo: indeed :)
(22:46:08) mattock: and believe me, if I could, I would not touch Windows w=
ith a 10-foot pole... but what has to be done, has to be done :)
(22:47:00) mattock: jamesyonan: I'd be great if you could let us know how y=
our work (e.g. fixing the Windows driver signing issue) is proceeding
(22:47:09) mattock: every now and then...
(22:48:14) mattock: anyways, I guess we're done...?
(22:48:22) ***dazo feels so ...
(22:49:26) mattock: jamesyonan: please let us know if you need help with an=
ything
(22:49:42) mattock: and it's great if you can hang around here and answer t=
o queries every now and then
(22:49:44) jamesyonan: I will, thanks.
(22:49:52) dazo: thank you too! :)
(22:50:31) mattock: I think we got a lot done today... I'll write the summa=
ry tomorrow
(22:50:40) dazo: thx!
(22:51:09) cron2: gn8 :)
(22:51:20) mattock: I actually forgot to write the summary for last week...
(22:51:20) dazo: gn8, cron2 :)
(22:51:30) dazo: shame on you!
(22:51:32) dazo: :-P
(22:51:33) raidz: :-D
(22:51:33) mattock: yeah
(22:51:39) raidz: I look forward to those
(22:52:16) mattock: fortunately it was mostly "what is the status of <somet=
hing to be released tomorrow>" stuff
(22:52:30) dazo: true
(22:52:41) mattock: I mentioned about that in today's topic list mail
(22:52:46) mattock: so I guess I'm excused :D
(22:52:54) mattock: anyways, good night everyone!
(22:53:05) mattock: cron2: n8!
(22:53:09) raidz: take it easy
(22:53:17) raidz: vm will be ready when you wake up
(22:53:19) mape2k ha abbandonato il canale (quit: Read error: Operation tim=
ed out).
(22:53:28) mattock: raidz: thanks!
(22:53:30) dazo: raidz:  that's awesome!  Thanks a lot!
(22:53:37) raidz: np guys!
(22:55:56) mattock: jamesyonan: could you register your IRC nickname to pre=
vent somebody impersonating as you?=20
(22:56:18) raidz: I was just thikning about that myself
(22:56:21) jamesyonan: how do I do that?
(22:57:00) mattock: oops
(22:57:04) mattock: ok, so "/msg nickserv register <password> <email-addres=
s>"
(22:57:20) mattock: I tried to register myself as <password> <email-address>
(22:57:22) mattock: :D
(22:57:59) raidz: http://www.ehow.com/how_2257930_register-user-name-freeno=
de.html
(22:58:01) vpnHelper: Title: How to Register a User Name on Freenode | eHow=
.com (at www.ehow.com)
(22:58:06) raidz: hehe
(23:06:18) modalit=EF=BF=BD=EF=BF=BD (+o jamesyonan) da ChanServ
(23:06:29) cron2: \o/
(23:06:35) dazo: :)
(23:07:41) jamesyonan: ok, I'm registered

--------------060508000503060702060101--

