Message-ID: <4BACBE17.3070202@...515...>
Date: Fri, 26 Mar 2010 16:00:55 +0200
From: =?ISO-8859-15?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------070709030205040807020306"
Subject: [Openvpn-devel] Summary of the IRC meeting (25th Mar 2010)
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
--------------070709030205040807020306
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable

Hi,

Here's the summary of the previous community meeting.

---

COMMUNITY MEETING

Place: #openvpn-discussion on irc.freenode.net
Date: Thursday, 25th March 2010
Time: 18:00 UTC

Planned meeting topics for this meeting were on this page:

<http://www.secure-computing.net/wiki/index.php/OpenVPN/IRC_meetings/Topics=
-2010-03-25>

Next meeting next week, same place, same time. Your local meeting time
is easy to check from services such as

<http://www.timeanddate.com/worldclock>


SUMMARY

Mattock updated the status of the community site server(s). In a
nutshell, all of the required infrastructure (LDAP, VPN, SSL certs etc.)
is in place. Backups are still work in progress. The Trac instance is
ready to go live as "beta" for use of a small number of developers and
users. Once the LDAP user self-service registration service (pwm) and
it's servlet container (tomcat) are ready, Trac can be published for
everyone and work on forums server can really begin.

Discussed the "Wrong CN in client-disconnect with
username-as-common-name" issue:

<http://sourceforge.net/mailarchive/forum.php?thread_name=3Dd8e57f271003021=
006v36871150obc7080725bc6efb3%40mail.gmail.com&forum_name=3Dopenvpn-users>

Nobody has been able to reproduce the issue, so no progress since last week.

Discussed the "OpenVPN will not connect through certain HTTP proxies" issue:

<http://sourceforge.net/tracker/?func=3Ddetail&atid=3D454722&aid=3D1840041&=
group_id=3D48978>

The above issue had been closed earlier as shown in this thread:

<http://thread.gmane.org/gmane.network.openvpn.devel/3399>

Discussed updating the autotools version used by OpenVPN:

<http://thread.gmane.org/gmane.network.openvpn.user/29251>

Agreed that if changing autools to a newer version helps our development
efforts, it should be done. Change for the sake of change does not make
sense, as a bunch of automated build scripts would then need to be modified.

Discussed problems with route.exe and Windows system paths on dual
(Windows) OS installations:

<http://sourceforge.net/tracker/index.php?func=3Ddetail&aid=3D1933593&group=
_id=3D48978&atid=3D454719>

Currently OpenVPN uses C:\Windows by default, but by using "--win-sys
env" OpenVPN autodetects the correct directory. Agreed that using
"--win-sys env" by default would better approach, as long as it works on
all Windows versions since Win2k.

Discussed the possibility of having multiple --up and --down scripts in
OpenVPN config files:

<http://sourceforge.net/tracker/?func=3Ddetail&aid=3D2078470&group_id=3D489=
78&atid=3D454719>

Currently OpenVPN command-line option parser expands the options in a
config file into command-line options when it launches. Agreed that
OpenVPN should give warnings about duplicate options if they are defined
at the same option parser recursion level, e.g. in the same config file.

Discussed problem with Debian's ipv6 patches:

<http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D574164>

Tried to locate the corresponding line in Debian-patched sources and
failed. Agreed that we need to consult agi to figure out what to do with
this.

In addition, d12fk announced that he has started working on OpenVPN GUI:

<http://openvpn-gui.sourceforge.net>

Mattock agreed to translate the GUI to Finnish within next few weeks.

---

Full chatlog as an attachment


--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock



--------------070709030205040807020306
Content-Type: text/plain; charset="utf-8";
 name=openvpn_irc_meeting_chatlog_2010-03-25.txt
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
	filename="openvpn_irc_meeting_chatlog_2010-03-25.txt"

(20:01:39) jamesyonan: hi everyone
(20:02:13) mattock: hello!
(20:02:20) mattock: dazo, are you present?
(20:02:25) jamesyonan: hi
(20:02:48) mattock: also, who else is available?
(20:05:19) mattock: I think dazo should be coming
(20:05:34) ecrist [ecrist@...1335.../supporter/professional/ecrist] =EF=BF=
=BD=EF=BF=BD entrato nel canale.
(20:05:58) mattock: james, here are some topics for this week, mostly lefto=
vers from last week: http://www.secure-computing.net/wiki/index.php/OpenVPN=
/IRC_meetings/Topics-2010-03-25
(20:05:59) vpnHelper: Title: OpenVPN/IRC meetings/Topics-2010-03-25 - Secur=
e Computing Wiki (at www.secure-computing.net)
(20:06:28) mattock: perhaps I'll give a brief update about community site s=
tatus - it's been a while since last time
(20:07:29) mattock: so there's only one thing missing, which is proper back=
ups to our own backup server
(20:07:51) rob0 [~rob0@...1323...] =EF=BF=BD=EF=BF=BD entrato nel canale.
(20:08:11) mattock: ecrist already provides us with backup service (thanks =
Eric), which is already in use
(20:08:27) ecrist: :)
(20:08:47) mattock: the rest of the infrastructure (e.g. LDAP, OpenVPN VPN)=
 is already in place and working properly
(20:09:45) mattock: forums server is work in progress, as it requires that =
people can create user accounts themselves
(20:10:30) mattock: this self-service registration will be accomplished wit=
h "pwm" (a Java webapp), which writes account information to LDAP, which al=
l services (trac, forum software etc.) will be using
(20:11:10) mattock: I'm currently configuring pwm and it's servlet containe=
r (tomcat)
(20:11:41) mattock: so, in a nutshell, the Trac instance can be launched pr=
etty soon, whereas forums will take a little longer
(20:11:57) mattock: initially Trac accounts will have to be manually create=
d (by me)
(20:12:09) mattock: so it's mainly for core developer use at first
(20:12:17) mattock: that's about it, I guess
(20:13:22) waldner [~waldner@...1336.../waldner] =EF=BF=BD=EF=BF=BD entrato=
 nel canale.
(20:14:24) jamesyonan: sounds good
(20:15:12) mattock: I just send dazo email, just in case
(20:15:41) mattock: I'll check if we could start discussing some of the iss=
ues without David=20
(20:16:28) mattock: did we get any resolution to this cn issue: https://sou=
rceforge.net/mailarchive/forum.php?thread_name=3Dd8e57f271003021006v3687115=
0obc7080725bc6efb3%40mail.gmail.com&forum_name=3Dopenvpn-users
(20:16:29) vpnHelper: Title: SourceForge.net: OpenVPN: openvpn-users (at so=
urceforge.net)
(20:16:54) jamesyonan: re: warnings -- these are mostly to help people out.=
  For example in pre-2.1 releases, we didn't have script-security.  Since t=
he addition of script-security was not backwards compatible, the warning te=
lls people immediately why their old config doesn't work.
(20:18:07) jamesyonan: someone was supposed to check if this issue is trigg=
ered by mid-session reauth
(20:18:23) mattock: I think Jan volunteered for the job :)
(20:18:44) mattock: I don't think he managed to reproduce the problem
(20:18:49) mattock: I'll check
(20:19:41) mattock: one thing not on the agenda is the HTTP proxy server is=
sue
(20:20:02) mattock: the bug reporter responded to me and the proxy server h=
e encountered the problem with was T-mobile something
(20:20:20) mattock: not a widely used one
(20:21:04) mattock: given there are no other bug reports, I think dazo thou=
ght it best to close the report as wontfix
(20:22:06) mattock: I think the autotools issue has not yet been covered fu=
lly... in a nutshell, nobody complained @openvpn-users when I asked about d=
eprecating old autotools support
(20:22:44) mattock: also, there are plenty of workarounds for old OS'es (us=
e autoreconf on another host, install newer autotools version etc.)
(20:23:12) mattock: so if new autotools makes sense for any reason, I think=
 we should start using it
(20:23:28) mattock: james, what do you think?
(20:26:07) jamesyonan: I'm not really gung-ho about the autotools change si=
nce I have some automated build scripts that need to extract from svn and b=
uild on many different linux platforms, including RHEL 4.  But I don't want=
 to hold this back if I'm the only one complaining.
(20:26:48) mattock: I agree that the newer version should provide some usef=
ul enhancements before the change is made
(20:26:59) mattock: changing it for the sake of change does not make sense
(20:28:28) mattock: what about this one: http://sourceforge.net/tracker/ind=
ex.php?func=3Ddetail&aid=3D1933593&group_id=3D48978&atid=3D454719
(20:28:30) vpnHelper: Title: SourceForge.net: OpenVPN: Detail: 1933593 - 2.=
1rc7 - apphelp.dll missing on Vista dual OS installation (at sourceforge.ne=
t)
(20:28:36) mattock: any idea whether this is still valid?
(20:30:07) mattock: I suppose having a couple of Windows installations side=
-by-side is pretty common
(20:30:34) jamesyonan: I haven't heard about this issue recently.
(20:31:06) mattock: any idea if it has been fixed?
(20:31:14) mattock: actively I mean :)
(20:31:27) mattock: or is it just that people are not reporting their probl=
ems
(20:31:42) d12fk_ [~quassel@...1337...] =EF=BF=BD=EF=BF=BD entrato nel cana=
le.
(20:33:58) jamesyonan: usually if a problem is real, there will be many rep=
orts and it will be fixed quickly
(20:34:10) mattock: also, where is "route.exe" coming from? is it built-in =
to Windows?
(20:34:17) jamesyonan: yes
(20:34:43) mattock: does OpenVPN pass any parameters (e.g. dll locations to=
 it)
(20:34:53) mattock: ...locations) to it?
(20:35:08) mattock: looks as if route.exe itself is messing things up
(20:35:36) jamesyonan: there is code that sets the PATH before calling route
(20:36:09) mattock: ok, so that might be the problem
(20:37:02) mattock: is there some common approach / piece of code in OpenVP=
N for detecting Windows settings such as the location of system32 directory?
(20:37:32) d12fk_: hi there
(20:37:38) mattock: hi d12fk
(20:38:03) d12fk_: well, we had a report from a user abou this issue a whil=
e ago
(20:38:45) d12fk_: he had vista on C: and XP on D: and the route.exe from v=
ista didn't run with the crt.ddl from XP iirc
(20:38:57) d12fk_: sry .dll
(20:39:12) mattock: d12fk: did he use --win-sys env (as janjust suggests)
(20:39:31) d12fk_: no, we don't have that parameter in our default config
(20:40:20) d12fk_: win-sys would have probably fixed it, but why not make i=
t work by default and get the right value from the registry?
(20:40:42) mattock: james: so by default c:\windows is used, but "--win-sys=
 env" can autodetect the correct directory?
(20:40:44) ecrist: hrm
(20:40:57) mattock: d12fk: that would sound like a good approach
(20:41:49) mattock: it would be "the Windows way" at least
(20:41:58) mattock: and less prone to error I guess
(20:42:02) d12fk_: i plan to hack up a "registry" parameter for win-sys and=
 make that the default
(20:42:27) d12fk_: but currently lacking the time to do it
(20:42:42) jamesyonan: mattock: yes
(20:43:32) mattock: james: what do you think about checking the correct pat=
h from the registry by default as d12fk suggested?
(20:43:40) mattock: any problems with that approach?
(20:46:14) jamesyonan: I'm fine with that if it can be done in a portable w=
ay that works on Win2K -> Win 7.
(20:47:18) mattock: ok, I guess that would be an ideal candidate for an ope=
n task (http://www.secure-computing.net/wiki/index.php/OpenVPN/Open_tasks)
(20:47:20) vpnHelper: Title: OpenVPN/Open tasks - Secure Computing Wiki (at=
 www.secure-computing.net)
(20:47:23) mattock: I'll add it there
(20:47:46) d12fk_: jamesyonan: as far as I know MS they drive backwards com=
patibility to the max, so i guess it will be
(20:48:09) mattock: then there's this, janjust closed it already, but perha=
ps we could drive a couple of more nails to it's coffin: http://sourceforge=
.net/tracker/?func=3Ddetail&aid=3D2078470&group_id=3D48978&atid=3D454719
(20:48:10) vpnHelper: Title: SourceForge.net: OpenVPN: Detail: 2078470 - mu=
ltiple up scripts and no error (at sourceforge.net)
(20:48:55) mattock: jamesyonan: do you agree with janjust's comment?
(20:50:05) jamesyonan: re: multiple up scripts, OpenVPN doesn't support it =
currently
(20:50:37) jamesyonan: mattock: which comment?
(20:50:55) mattock: the one at the end of the bug report
(20:51:34) mattock: actually it seems that the report was closed by SF.net =
robot, not janjust
(20:51:40) mattock: so it's still open
(20:53:17) jamesyonan: yes, I generally agree with janjust's comment -- the=
 ability to override options with subsequent options is important.  Maybe w=
e just emit a warning in this case?
(20:54:06) mattock: do you think extending the warnings to all options woul=
d make sense?
(20:55:25) d12fk_: but the cmdline options are parsed before the ones from =
the config file, aren't they?
(20:56:53) jamesyonan: d12fk: not really:  you could say openvpn --config f=
oo.conf --up myscript
(20:57:20) jamesyonan: the --up myscript would override any "up" in foo.conf
(20:58:25) d12fk_: so the parser is descending? --up followed by --config w=
ould be the other way around?
(21:00:58) jamesyonan: yes, the parser is processing the command line from =
left to right
(21:01:36) jamesyonan: the --config option in the command line is like a ma=
cro that expands all the directives from the file at that point in the comm=
and line
(21:02:08) mattock: could we check for duplicate directives when the config=
 file is expanded?
(21:02:15) mattock: or how does it work?
(21:02:51) d12fk_: ok, but then the warning should only appear if the redef=
inition happens at the same config "level" or depth
(21:02:54) mattock: I think it'd be a good idea to warn about errors in the=
 config file (regardless of whether the options are overridden later)
(21:03:11) d12fk_: mattock: thats what a meat
(21:03:31) d12fk_: jesus... i mean: what i meant =3D)
(21:04:03) mattock: d12fk: do you mean depth like in <connection> blocks?
(21:05:01) jamesyonan: "the warning should only appear if the redefinition =
happens at the same config "level" or depth": that makes sense
(21:05:51) d12fk_: mattock: no, iirc the option parser works recursively, s=
o it's the recursion depth i mean
(21:06:06) mattock: ok
(21:07:05) mattock: so we all agree that this is worth fixing?
(21:07:15) mattock: =3Dshould not be closed as wontfix
(21:08:16) d12fk_: ack
(21:08:50) jamesyonan: +1
(21:08:56) mattock: ok, I'll reopen the bug report
(21:09:12) mattock: done
(21:09:31) mattock: have we discussed this already: http://bugs.debian.org/=
cgi-bin/bugreport.cgi?bug=3D574164
(21:09:34) mattock: that's the last one, btw
(21:09:34) vpnHelper: Title: #574164 - openvpn: Assertion fails in socket.c=
:429 in p2p mode due to Debian ipv6 patch - Debian Bug report logs (at bugs=
.debian.org)
(21:12:02) mattock: I'm not sure if that's valid - I think that report has =
to do with the old IPv6 patches which are now in "testing"
(21:12:24) mattock: maybe valid for Debian, but not necessarily for testing=
 tree in general
(21:12:32) mattock: and definitely not for stable openvpn
(21:13:33) mattock: I think we can't really do anything about that report r=
ight now...
(21:13:57) mattock: agreed?
(21:14:09) jamesyonan: can someone indicate the source code line that corre=
sponds to socket.c:429 in Debian build?
(21:14:10) d12fk_: let me take a look at the assertion
(21:18:03) d12fk_: hm, no ASSERT at 429 in allmerged or feat_ipv6_transport
(21:18:43) mattock: I assume Debian is using an older version of the ipv6 t=
ransport patch?
(21:19:26) d12fk_: there are some close to 429
(21:21:06) mattock: I'll quickly check the source package for Debian testin=
g/unstable
(21:24:27) mattock: ...takes a while
(21:26:07) mattock: hmm... I downloaded the Debian testing sources and appl=
ied the patches manually
(21:26:28) mattock: no assert on line 429
(21:27:09) d12fk_: probably best to talk to agi directly then
(21:27:10) mattock: I think we should leave this alone until somebody can p=
rovide additional information
(21:27:11) mattock: yep
(21:28:07) mattock: Jamesyonan: there's still the little typo in http://ope=
nvpn.net/howto.html: mimimal instead of minimal
(21:28:15) vpnHelper: Title: Error 404: File not Found (at openvpn.net)
(21:28:42) mattock: I think we covered everything we can for today
(21:28:54) mattock: or is there something else we should cover?
(21:30:00) d12fk_: i might want to announce that i'm developing on openvpn-=
gui again
(21:30:37) mattock: so is that the original OpenVPN GUI? It's just taht the=
re are like ~100 GUI's out there ;)
(21:30:44) mattock: that
(21:30:54) d12fk_: the one that openvpn.net ships
(21:31:25) d12fk_: mathias lost interest and didn't answer my mails so i mo=
ved i to sf.net
(21:31:40) mattock: what's the URL?
(21:32:07) d12fk_: no web as of yet but you can start at openvpn-gui.sf.net
(21:32:59) d12fk_: will publically announce once i have the code cleaned up
(21:33:23) d12fk_: mattock: interested in translating to finnish?
(21:33:34) jamesyonan: are you going to use the management interface?
(21:33:39) d12fk_: yes
(21:33:56) jamesyonan: cool
(21:33:56) d12fk_: in the mid term
(21:34:20) mattock: d12fk: how many strings are there?
(21:34:27) mattock: translatable strings I mean
(21:34:50) d12fk_: many
(21:35:10) mattock: many like in 200 or many like in 5000 (the biggest app =
I've translated)?
(21:35:22) d12fk_: let me grep
(21:35:30) mattock: (or was it 3000, can't remember exactly)
(21:35:38) mattock: it _was_ many, though ;)
(21:37:17) mattock: I'd guess OpenVPN GUI would be around 100-300
(21:37:55) d12fk_: 141 strings
(21:38:10) mattock: ok, it's a couple of hour's work=20
(21:38:14) mattock: plus some testing
(21:38:21) mattock: I think that's doable :)
(21:38:39) mattock: I can do it
(21:38:50) d12fk_: plus some dislogs
(21:38:52) d12fk_: dialogs
(21:39:04) d12fk_: ~15 strins each
(21:39:12) mattock: ok, still not much
(21:40:27) mattock: d12fk: let me know when you want OpenVPN GUI translated
(21:40:31) d12fk_: look at the .rc files in git
(21:41:18) mattock: where shall I send the translated files?
(21:41:54) d12fk_: http://openvpn-gui.git.sourceforge.net/git/gitweb.cgi?p=
=3Dopenvpn-gui/openvpn-gui;a=3Dblob;f=3Dopenvpn-gui-res-en.rc;h=3Da59f233f9=
32a39f5270394f1714f769110931d13;hb=3D71a2b8fd2371d2d0a6f9141847433b7730a6e7=
de
(21:41:55) vpnHelper: Title: SourceForge - openvpn-gui/openvpn-gui/blob - o=
penvpn-gui-res-en.rc (at openvpn-gui.git.sourceforge.net)
(21:42:41) d12fk_: i've chosen openvpn-devel as the mailing list for the pr=
j so far... it's evil but convenient =3D)
(21:43:02) mattock: I think openvpn-devel is a good place
(21:43:33) mattock: it does not make sense for every small project to have =
it's own communication channel
(21:44:18) d12fk_: nope, and i figured openvpn-gui is close enough related =
to openvpn itself
(21:44:26) mattock: agreed
(21:44:43) mattock: ok, I'll do the translation in the next few weeks and l=
et you know
(21:44:49) mattock: are we done for today?
(21:44:55) d12fk_: great
(21:45:10) d12fk_: nothing left on my list
(21:46:25) mattock: ok, I'll write summary tomorrow and send it the list
(21:46:40) mattock: I think we managed to cover quite a lot even though daz=
o was not present
(21:46:56) mattock: in fact, our backlog has emptied... nothing left to do =
anymore ;)
(21:47:06) rob0: We should take the opportunity to gossip behind his back.
(21:47:10) d12fk_: good night then, or whatever.. =3D)
(21:47:16) mattock: d12fk: you too!
(21:47:26) mattock: rob0: yes, especially as this channel is logged anyways=
 :)
(21:47:34) rob0: uh, oops :)
(21:48:20) mattock: anyways, good afternoon, evening and night, everyone!=20
(21:48:30) rob0: good night
(21:48:37) mattock: bye!
(21:49:22) d12fk_: see you around

--------------070709030205040807020306--

