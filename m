Message-ID: <4C36F2BB.2000901@...515...>
Date: Fri, 09 Jul 2010 12:58:19 +0300
From: =?ISO-8859-15?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------060402050902070801040701"
Subject: [Openvpn-devel] Summary of the IRC meeting (8th Jul 2010)
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
--------------060402050902070801040701
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable

Hi,

Here's the summary of the previous community meeting.

---

COMMUNITY MEETING

Place: #openvpn-devel on irc.freenode.net
Date: Thursday, 8th Jul 2010
Time: 18:00 UTC

Planned meeting topics for this meeting were on this page:

<https://community.openvpn.net/openvpn/wiki/Topics-2010-07-08>

Next meeting next week, same place, same time. Your local meeting time
is easy to check from services such as

<http://www.timeanddate.com/worldclock>

or with

$ date -u


SUMMARY

Discussed the "auto-proxy on *NIX" feature request from Jason Haar.
Agreed that this feature would make sense. Decided to create a new
feature request, which is now here:

<https://community.openvpn.net/openvpn/ticket/18>

This ticket contains all the essential details.

--

Discussed the "Build failure on OpenBSD 4.7" issue:

<https://community.openvpn.net/openvpn/ticket/17>

A patch that fixes this issue has been written, tested and sent to
-devel mailinglist.

--

Discussed problems with SVN <-> Git interaction. Our original plan was
to use SVN for the beta2.2 branch. Due to the issues that were
encountered it was decided to move completely to Git - with James'
blessing. For more information take a look at the full chatlog and this
email thread:

<http://thread.gmane.org/gmane.network.openvpn.devel/3806>

--

Samuli gave a status update on our build server: no progress last week
due to forums server work. However, buildbot should still be in pretty
good shape by end of this month as planned earlier.

--

Discussed the "Broken topology subnet on OpenBSD" issue discussed on
#openvpn-devel. Agreed that more research is needed to verify that this
issue is really a bug. For detailed symptoms see full chatlog.

---

Full chatlog as an attachment

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock



--------------060402050902070801040701
Content-Type: text/plain; charset="utf-8";
 name=openvpn_irc_meeting_chatlog_2010-07-08.txt
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
	filename="openvpn_irc_meeting_chatlog_2010-07-08.txt"

(21:08:22) mattock: how about this: Suggestion from Jason Haar: under Unix,=
 the  "http_proxy" environment variable is typically used to refer to the U=
RL (eg http://proxy.server:portnum/) of the appropriate proxy server. Curre=
ntly openvpn's "auto-proxy" only supports Windows - surely it wouldn't take=
 >20 lines of code to check that env var for Unix systems? I know it's not =
a thorough solution - but there isn't one for Unix systems - that's as good=
 as it gets...=20
(21:08:34) ecrist: by 21:15, the meeting will be long over. :)
(21:09:09) mattock: ecrist: I'd love to attend that kind of meeting :)
(21:09:50) mattock: any thoughts on getting proxy settings from PROXY envir=
onment variable on UNIX?=20
(21:09:50) ***ecrist notes time here is UTC, which would make a meeting run=
ning past 21:15 over 3 hours long...
(21:09:54) dazo: mattock:  ACK ... that should be easy to fix
(21:10:03) ecrist: mattock, that seems a simple solution
(21:10:19) mattock: is the environment variable name always/usually the sam=
e?
(21:10:23) mattock: like $PROXY
(21:11:42) dazo: mattock:  I believe it actually is $http_proxy
(21:11:49) mattock: a clarification... I have to leave in 40 mins :D
(21:11:59) mattock: forgot about different timezones :)
(21:12:08) dazo: :)
(21:12:21) mattock: ok, should we file a feature request? I don't think Jas=
on has any code at hand
(21:12:25) mattock: =3Dready
(21:12:34) dazo: yeah, lets do that!
(21:12:50) mattock: great! I'll add it to my todo list... unless I manage t=
o file the request now
(21:13:16) dazo: http://www.cyberciti.biz/faq/linux-unix-set-proxy-environm=
ent-variable/
(21:13:17) vpnHelper: Title: How To Use Proxy Server To Access Internet at =
Shell Prompt With http_proxy Variable (at www.cyberciti.biz)
(21:13:59) mattock: good link
(21:14:16) mattock: ok, so this OpenBSD build failure would require James?
(21:14:21) mattock: https://community.openvpn.net/openvpn/ticket/17
(21:14:23) vpnHelper: Title: #17 (build failure on OpenBSD 4.7 IFF_MULTICAS=
T) =EF=BF=BD=EF=BF=BD=EF=BF=BD OpenVPN (at community.openvpn.net)
(21:15:00) dazo: I believe we just needed a verification from krzee that th=
e patch does work ... and today I believe he gave a positive answer here
(21:15:11) dazo: so I'm about to ACK that patch, it looks good
(21:15:46) dazo: as a side note: I'm just wondering if we should anyway hav=
e these patches sent to the mailing list as well
(21:15:48) mattock: ok, great!
(21:16:20) dazo: what we do need to make James aware of is that we have fou=
nd troubles with 'topology net30' on OpenBSD
(21:16:24) mattock: I think we should... the more eyes look at the patches =
the better
(21:16:35) mattock: ...I'll mail James
(21:16:37) dazo: yeah .... I can ping cron2 about that=20
(21:16:47) dazo: cron2 wrote that patch
(21:18:24) dazo: ecrist:  /me is thinking about $http_proxy env variable ..=
. is that also valid on *BSD?
(21:20:01) mattock: ok, mail sent
(21:21:37) jamesyonan [~jamesyona@...1320...] =EF=BF=BD=EF=BF=BD entrato ne=
l canale.
(21:21:45) jamesyonan: hi
(21:21:51) dazo: Hi, James!
(21:21:57) dazo: Good you're here!
(21:22:36) mattock: dazo: *BSD _might_ support HTTP_PROXY: http://www.ivord=
e.ro/Setting_up_HTTP_PROXY_via_command_line_in_Linux_FreeBSD-107.html
(21:22:39) vpnHelper: Title: Set up HTTP PROXY via command line in Linux/Fr=
eeBSD - Networking Devices (at www.ivorde.ro)
(21:22:40) dazo: it's a rather silent meeting today ... but that gives us b=
etter possibilities to look at the SVN push I did some weeks ago, which I'm=
 reluctant to call a success
(21:22:45) mattock: I guess it's a "de facto" standard
(21:22:56) dazo: mattock:  that's what I wanted to be sure about :)
(21:22:56) ecrist: dazo: no idea, I don't use proxy servers on freebsd
(21:23:20) ecrist: it appears to be standard, though.
(21:23:37) ecrist: HTTP_PROXY, that is, on freebsd
(21:23:46) mattock: standard similarly to "#/your/shell/here" at the beginn=
ing of a script :D
(21:24:01) dazo: yeah ... Linux seems to be http_proxy and not HTTP_PROXY .=
.. but we can look for both
(21:24:10) ecrist: you mean #!/path/to/interpreter
(21:24:35) mattock: ecrist: good correction
(21:24:37) dazo: nah, it's gonna be C code ... getenv("http_proxy") and get=
env("HTTP_PROXY")
(21:24:49) dazo: ahh
(21:24:51) ***dazo misreadh
(21:24:51) krzee: [11:17]  <dazo> I believe we just needed a verification f=
rom krzee that the patch does work ... and today I believe he gave a positi=
ve answer here
(21:25:08) krzee: i never tried the patch, i tried the result of it (defini=
ng it in config.h)
(21:25:21) krzee: i did that before the patch existed
(21:25:36) dazo: krzee:  aha .. would you be so kind to try out that patch?
(21:25:38) mattock: jamesyonan: did you read dazo's email about the SVN bet=
a 2.2 issues?
(21:25:44) mattock: ...already
(21:25:46) krzee: work is insane today because we go live on the new system=
 AND new phone system and database and all, so i have to wait til after work
(21:25:52) krzee: yes, i certainly will, tonight
(21:26:09) krzee: we go live on monday, hectic til then preparing
(21:26:17) dazo: krzee:  cool thx!  Anyway, cron2 should mail the patch to =
the ML as well, to get more eyes on it too
(21:27:09) mattock: hmm... I wonder if we could make Trac mail any attached=
 patches to the mailing list automatically...
(21:27:16) dazo: krzee:  good luck with the upgrades :)
(21:27:17) jamesyonan: mattock: yes, I did -- unfortunately, I'm not very f=
amiliar with git <-> svn conversions
(21:27:40) dazo: jamesyonan:  that's fair enough
(21:27:48) dazo: I can explain why some of this happens
(21:28:05) krzee: thanx =3D]
(21:28:53) dazo: as SVN is centralised, it has a list over valid people who=
 can do commits ... while git is de-centralised, thus there is no central d=
atabase over valid committers ... so basically git eats whatever the commit=
ter is (it needs to be an e-mail address though, but it can by all means be=
 a fake one)
(21:30:08) dazo: the other thing is that git tries to keep the history as a=
ccurate as possible ... it takes no shortcuts .... so when I have an empty =
branch, and does a push to this SVN branch .... it will go all the way back=
, and commit each commit from git separately - and in this process rewrite =
committer to me
(21:30:19) dazo: that is kind of the results we're having now
(21:31:03) dazo: This might be very fine ... *but* it means that in the SVN=
 revision history .... there will now exist two almost identical patches fo=
r all commits done in the BETA21 branch and the branch I was given
(21:31:10) dazo: the only difference is the committer
(21:31:24) dazo: and this, I believe might not be so good.
(21:31:59) dazo: So I see two possible solutions ... both includes scrappin=
g the current SVN branch I was given and "start from scratch"
(21:32:40) dazo: solution A)  I will compress all the OpenVPN history until=
 the community patches comes in ... and then push that as one single commit=
 to SVN
(21:33:19) dazo: solution B)  That my SVN branch gets prepared by James to =
be branched out of his latest BETA21 change .... so that I "continue" on to=
p of that
(21:34:22) dazo: The vast majority community patches do have pretty good Si=
gned-off and Acked-by statements in the commit log, so that way we can stil=
l keep track of the commits I push to SVN
(21:34:34) dazo: even though my pushes will be changed to me as the committ=
er
(21:35:24) jamesyonan: I have a python script that I use for svn merging of=
 large numbers of commits from one branch to another, while retaining the f=
ull history
(21:35:47) dazo: jamesyonan:  that sounds like the thing we need then!
(21:37:00) jamesyonan: http://secure.openvpn.net/tmp/massmerge.py
(21:37:46) jamesyonan: this is for svn -> svn merges, but it contains the b=
asic infrastructure for programmatic commits to svn
(21:38:18) dazo: jamesyonan:  what will we do with the current tree / branc=
h?  can we scrap it and roll back the history?
(21:39:02) dazo: I have not done anything which is worth saving ... and I b=
elieve you have done the last change in BETA21
(21:41:19) jamesyonan: which tree?  you mean /contrib/dazo ?
(21:41:25) dazo: jamesyonan:  yes
(21:41:52) jamesyonan: why not just svn rm?
(21:42:51) dazo: I was just open for us to remove the traces from the histo=
ry ... as I expect svn rm will just leave yet another trace ... but if you'=
re fine with that approach, sure, lets do that :)
(21:46:37) mattock: what about the "topology subnet" + OpenBSD issue?
(21:47:36) ***dazo interprets the silence as 'do svn rm'
(21:48:26) dazo: re: openbsd + topology ... this is what krzee discovered: =
topology subnet is broken, no errors but good config doesnt work.   on fbsd=
/openbsd i tested that using ipconfig-push <ip> <subnet> does not give an e=
rror when using net30 (but i believe it should / the code exists)... so it =
gives a topology subnet type ifconfig, which obviously doesnt work
(21:49:14) jamesyonan: Let's think about this.  It seems like git -> svn ca=
uses some information loss, and maintaing the git/svn repo relationship mig=
ht be a time sink.  Suppose we just migrate to git 100%.  I need to underst=
and how much effort this will require, how the history translates over, wha=
t changes would be required to build tools, etc.
(21:49:54) dazo: jamesyonan:  if you are willing to do such a move ... I'll=
 help you out as much as I can=20
(21:50:15) mattock: I think that's would solve most of the issues...
(21:50:21) dazo: jamesyonan:  A good starting point is this one: http://git=
.or.cz/course/svn.html
(21:50:26) vpnHelper: Title: Git - SVN Crash Course (at git.or.cz)
(21:51:07) mattock: what if we just continue pulling James' stuff from SVN =
to Git... and use Git for managing releases.
(21:51:20) dazo: that is also doable
(21:51:26) dazo: very much doable, actually
(21:51:51) mattock: I mean, that would not require James to learn tons of g=
it stuff - at least initially
(21:51:58) dazo: but it might be more a challenge for James, as he will not=
 be able to easily fix stuff in the git repo that way
(21:52:21) jamesyonan: so I presume then that svn -> git conversion doesn't=
 suffer the same loss of info as the reverse?
(21:52:59) mattock: jamesyonan: that's how I've understood it
(21:53:02) mattock: dazo?
(21:53:06) dazo: jamesyonan:  no, not at all ... if you clone the git repos=
itory ... you can even see which SVN revisions each git commit from you com=
es from
(21:54:01) dazo: git is very conservative about the history ... it tracks b=
oth author and committer of each commit separately .... and it is almost im=
possible to rewrite the history like it seems it's possible to do with the =
python script James showed me
(21:55:05) dazo: (it is possible to amend the last commit in git ... but by=
 doing that, the commit ID changes ... so it is not trivial to do so if you=
 have pushed your tree remote and someone have pulled the tree ... such mod=
ifications are identified immediately then)
(21:56:24) mattock: sorry, I got to leave in ~5 mins... does something requ=
ire my presence?
(21:56:31) mattock: the buildbot stuff perhaps?
(21:56:48) dazo: mattock:  a quick update would be great :)
(21:57:05) jamesyonan: I'm not really a fan of svn per-se.  I'm totally ope=
n to migrating to git if it can be done in small steps.
(21:58:12) mattock: ok... I've been working on various forums stuff lately,=
 so nothing has really happened on BuildBot front. However, forum migration=
 has been moving forward smoothly, so by the end of July buildbot + package=
s should be in good shape=20
(21:58:18) dazo: jamesyonan:  What if you clone the git tree ... you can pl=
ay as much as you want with it, as all changes are done locally only - it's=
 not before you begin to do 'git push' you give your changes away ... and t=
hen in the mean time while you're getting familiar, you can do your commits=
 to SVN
(21:58:30) dazo: and I will make sure to pull them down and put them into t=
he git tree
(21:58:55) jamesyonan: right -- the first step would be to clone the git tr=
ee and get the build system working on that
(21:58:55) mattock: I'll hit the shower and check back in ~10 mins... then =
I'll have to go
(21:59:28) jamesyonan: does anyone know if trac can be tied to both an svn =
and git repo at the same time (during the migration)?
(21:59:46) dazo: jamesyonan:  yeah .... something like that ... git clone g=
it://openvpn.git.sourceforge.net/gitroot/openvpn/openvpn-testing.git  ... t=
hat should get you started
(22:00:12) dazo: jamesyonan:  if you have some time today, I can walk you t=
hrough the basic things if you want, after this meeting
(22:01:21) jamesyonan: dazo: sounds good -- I'll probably just immerse myse=
lf in the docs initially
(22:01:23) dazo: mattock:  you might have a better overview over trac, git =
and svn ...?
(22:02:02) dazo: jamesyonan:  sounds good :)  And whenever you wonder about=
 something ... let me know .... there's also #git here on FreeNode as well
(22:03:59) mattock: jamesyonan: I think Trac (0.11 at least) only supports =
one VCS backend at one time
(22:04:13) mattock: and git support is pretty slow - at least the browsing =
stuff
(22:04:26) dazo: jamesyonan:  I dont know how much time you have for readin=
g .... but to really understand git and how it works ... the book ProGit is=
 really worth reading ... http://progit.org/book/  (it's also published on =
paper)
(22:04:28) vpnHelper: Title: Pro Git - Table of Contents (at progit.org)
(22:06:03) mattock: the Git user manual is also pretty good, I read it a wh=
ile back: http://www.kernel.org/pub/software/scm/git/docs/user-manual.html
(22:06:05) vpnHelper: Title: Git User's Manual (for version 1.5.3 or newer)=
 (at www.kernel.org)
(22:06:26) mattock: git takes a little getting used to, but seems less shak=
y than SVN
(22:06:34) mattock: and more powerful
(22:06:53) mattock: confusing SVN does not take much
(22:07:01) mattock: at least in my experience
(22:07:04) dazo: yeah, but I found it easier to read ProGit actually ... ex=
plaining all those strange git words before going deep :)
(22:07:21) mattock: dazo: I guess I'll have to read it too, then :)
(22:07:25) ***ecrist tires of git vs svn conversations
(22:07:33) dazo: but it's a while since I've looked at the official git doc=
s :)
(22:07:56) mattock: ok, did we make a decision to move to git?
(22:08:12) jamesyonan: ack
(22:08:18) mattock: ok
(22:08:30) mattock: anything else on this topic?
(22:09:47) mattock: if not, I don't think we yet discussed this one: "Anoth=
er bug being debugged with OpenBSD as well, which krzee discovered lately -=
  broken topology subnet"
(22:10:14) ***dazo resends krzee observation
(22:10:15) dazo: so here is the other things with openbsd:  topology subnet=
 is broken, no errors but good config doesnt work.   on fbsd/openbsd i test=
ed that using ipconfig-push <ip> <subnet> does not give an error when using=
 net30 (but i believe it should / the code exists)... so it gives a topolog=
y subnet type ifconfig, which obviously doesnt work
(22:14:41) jamesyonan: Are you saying that ifconfig of tun interface on Ope=
nBSD using the <ip> <subnet> form doesn't work?
(22:16:00) ***dazo looks up the conversation in his history
(22:17:08) jamesyonan: i.e. is the bug something in OpenVPN or is it just t=
hat OpenBSD can't handle ifconfig <ip> <subnet> on tun interfaces?
(22:18:41) dazo: I think it is related to some OpenBSD syntax ... I found s=
omething now ... putting on pastebin now
(22:19:09) dazo: jamesyonan:  http://pastebin.com/ErrCTMss
(22:19:35) dazo: so it actually do configure the tun device correctly ... b=
ut it stops there
(22:20:51) dazo: more info: http://pastebin.com/sz5nSTmj
(22:21:57) mattock: ok, I'll leave now. Have a nice rest of the meeting! By=
e!
(22:22:08) mattock: I'll write the summary tomorrow as usual
(22:22:15) dazo: mattock:  thx!
(22:22:20) mattock: and create the HTTP_PROXY feature request
(22:22:28) dazo: lovely!
(22:22:41) ***dazo needs to go in a few minutes as well
(22:23:18) mape2k ha abbandonato il canale (quit: Read error: Operation tim=
ed out).
(22:24:25) jamesyonan: well if this is a bug, isn't it just a matter of adj=
usting the ifconfig command issued on OpenBSD?
(22:25:00) dazo: Yeah, I just noticed cron2's suspicion ... so I think that=
 if he's right about that, there is something more deeper going on here
(22:25:25) dazo: fkr on this channel is doing the OpenVPN packages for Open=
BSD, so he might be able to help out
(22:26:13) dazo: but we can make this a follow-up task ... and make sure th=
at it gets attention by someone in the community who have overview over this
(22:30:38) ***dazo needs to go now
(22:31:42) dazo: jamesyonan:  thanks for joining today!  And you did indeed=
 surprise with your willingness to move away from SVN ... I was not expecti=
ng that at all!=20
(22:34:06) dazo: bye bye!

--------------060402050902070801040701--

