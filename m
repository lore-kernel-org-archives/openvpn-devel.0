Message-ID: <4BD19F53.50905@...515...>
Date: Fri, 23 Apr 2010 16:23:31 +0300
From: =?ISO-8859-15?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------040701000906060402010606"
Subject: [Openvpn-devel] Summary of the IRC meeting (22nd Apr 2010)
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
--------------040701000906060402010606
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable

Hi,

Here's the summary of the previous community meeting.

---

COMMUNITY MEETING

Place: #openvpn-devel on irc.freenode.net
Date: Thursday, 22nd March 2010
Time: 18:00 UTC

Planned meeting topics for this meeting were on this page:

<https://community.openvpn.net/openvpn/wiki/Topics-2010-04-22>

Next meeting next week, same place, same time. Your local meeting time
is easy to check from services such as

<http://www.timeanddate.com/worldclock>

or with

$ date -u


SUMMARY

The following three issues originates from this thread:

<http://thread.gmane.org/gmane.network.openvpn.devel/3446>


Discussed the "InternetQueryOption API" issue. Decided to ask if a
Windows developer could fix it. If not, bring the issue to James in next
meeting. Samuli agreed to verify that all current versions of Windows
support this API.


Discussed "Enabling auto-proxy to work in configs that contain both UDP
and TCP-based "<connection>" profiles" and "nobind doesn't work under
udp" issues. These issues are interrelated:

<http://sourceforge.net/tracker/index.php?func=3Ddetail&aid=3D2945147&group=
_id=3D48978&atid=3D454720>

Agreed that some analysis is needed to see what happens when
<connection> blocks are used in conjunction with mssfix, nobind,
fragment and auto-proxy. Samuli agreed to dig deeper into this issue.


Discussed the "Unnecessary script-security warning?" issue:

<https://community.openvpn.net/openvpn/attachment/wiki/Topics-2010-04-22/sc=
ript_security_warning.txt>

Agreed that this is a bug. Dazo will provide a patch.


Discussed a few high-level development things briefly. Agreed that
current handling of bugs works pretty well:

- try to find resolution in the mailing lists
- if no resolution is reached, bring the issue to an IRC meeting

Agreed that we should file placeholder bug reports for bugs which are
fixed before anyone reports them as bugs. This allows users to check if
the bugs they encounter have already been fixed.


Agreed that we should try to get James to put his "task list" into a
public tracker (=3DTrac). This would allow community members to work on
those tasks, too.


Agreed that we should start discussing OpenVPN's roadmap on the mailing
list. If James can participate in this ml discussion, all the better. If
not, the suggested roadmap can be presented to him in these meetings.


Agreed that we need to discuss how to manage the entire development
process (testing->stable->release). Samuli agreed to send mail to -devel
explaining the current situation and ask for suggestions. If James can
participate in this ml discussion, all the better. If not, the
suggestions can be presented to him in these meetings.


Agreed to add 1-2 feature requests from ovpnforums.com to each IRC meeting:

<http://ovpnforum.com/viewforum.php?f=3D10&sid=3Db3d35dc6937bfdde0721ae69ae=
e59858>


Samuli gave an update of the status of the community site services. In a
nutshell the infamous "LDAP user self-service registration service
(pwm)" now works. Only some editing of JSP pages is needed to clean up
the interface.

---

Full chatlog as an attachment

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock




--------------040701000906060402010606
Content-Type: text/plain; charset="utf-8";
 name=openvpn_irc_meeting_chatlog_2010-04-22.txt
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
	filename="openvpn_irc_meeting_chatlog_2010-04-22.txt"

(21:00:22) mattock: ok, it's time
(21:00:48) mattock: shall we start from the top, as usual
(21:00:49) mattock: ?
(21:00:50) ecrist: dazo: let me know when it compiles so I can submit
(21:00:54) krzee: mattock, joo see what i requested get talked about at som=
e point?
(21:01:07) krzee: we can use socks daemons, but only if they are open to th=
e world
(21:01:07) krzee: it would be nice to have a way to auth against the socks =
daemon
(21:01:13) mattock: krzee: will do
(21:01:30) dazo: ecrist:  I will ... I need to get some ACKs to 3 patches, =
and then it'll compile ... all in the same mail thread
(21:02:25) dazo: mattock:  we can ... but I have no idea about the first to=
pic ... I'm trying to stay away from Windows as much as I can :-P
(21:02:52) mattock: can any of us discuss the first topic intelligently? ;)
(21:03:08) Kasx ha abbandonato il canale (quit: *.net *.split).
(21:03:08) vpnHelper ha abbandonato il canale (quit: *.net *.split).
(21:03:09) openvpn ha abbandonato il canale (quit: *.net *.split).
(21:03:10) dazo: mattock:  but for me it is obvious that this needs to be f=
ixed, as I can understand OpenVPN uses a legacy API now, which is gone in n=
ewer IE versions
(21:03:21) mattock: "(Windows) All error codes when using the InternetQuery=
Option? API are lost. Openvpn 2.1 uses the "old" IE4 API."
(21:03:30) mattock: dazo: agreed
(21:04:19) dazo: mattock:  we, simply need to find someone who can voluntee=
r to take that task, who got enough Windows skills
(21:04:40) mattock: james? ;)
(21:04:41) cron2: so
(21:04:42) cron2: hi
(21:04:47) mattock: hi cron2!
(21:04:53) ***krzee wonders if the person who pointed it out on the mail li=
st would care to help
(21:04:56) dazo: ahh! cron2!
(21:05:06) mattock: krzee: let's ask him
(21:05:21) mattock: too bad we have too many windows users and too few wind=
ows developers
(21:05:41) krzee: too many indians not enough chiefs ;]
(21:05:51) mattock: +1
(21:05:53) dazo: heh :)
(21:06:01) ***Bloodsong wonders if using CUDA processors to handle enc/dec =
on windows would free-up enough processor time to see a marked improvement =
in throughput.
(21:06:16) Bloodsong: (for openvpn tunnels :P)
(21:06:38) cron2: well, that's something for openssl to investigate...
(21:06:48) krzee: is cpu usage a big factor in throughput these days?
(21:06:59) Bloodsong: Probably not, but something's slowing down the darn w=
indows machines :P
(21:07:10) cron2: krzee: don't get dazo started on this :-)
(21:07:12) dazo: Bloodsong:  Yes, I believe so ... I think I read about som=
e OpenSSL patches for offloading the heavy stuff to CUDA ... but it was not=
 aimed for stable environment ... only a research project .... and if you g=
et it into OpenSSL, OpenVPN supports it indirectly
(21:07:33) cron2: bloodsong: "throughput" or "100% CPU"?
(21:07:33) mattock: ok, so let's ask the author of this "InternetQueryOptio=
ns API" issue if he'll fix the issue
(21:07:38) Bloodsong: dazo: Yeah that's sort of what I figured, a matter of=
 having the Libs.
(21:07:39) krzee: i think threading over cores would be a better idea than =
CUDA personally, and much much more commonly used
(21:07:50) mattock: and if that fails, bring the matter to James
(21:07:52) cron2: krzee: now that's exactly dazo's point :-)
(21:08:17) cron2: mattock: ack, but it's also important to know which windo=
ws versions are supported by this new API thingie
(21:08:24) mattock: cron2: true
(21:08:42) dazo: krzee:  not for the symmetric encryption ... ie when then =
SSL session is established ... but the asymmetric part used to agree on the=
 temporarily symmetric encryption key is CPU intensive .... but you won't n=
otice that before you have many key negotiations in parallel
(21:08:50) Kasx [~Kasx@...1321...] =EF=BF=BD=EF=BF=BD entrato nel canale.
(21:08:50) vpnHelper [~vpn@...1336.../krzee/bot/vpnhelper] =EF=BF=BD=EF=BF=
=BD entrato nel canale.
(21:08:50) openvpn [openvpn@...1356...] =EF=BF=BD=EF=BF=BD entrato nel cana=
le.
(21:08:50) modalit=EF=BF=BD=EF=BF=BD (+v Kasx   ) da card.freenode.net
(21:08:57) krzee: good point cron2
(21:10:21) krzee: mattock, +1
(21:10:30) mattock: hmm... InternetQueryOptions API seems to have been arou=
nd ~2003 at least in some form
(21:10:33) mattock: http://www.derkeiler.com/Newsgroups/microsoft.public.pl=
atformsdk.security/2003-09/0194.html
(21:10:35) vpnHelper: Title: microsoft.public.platformsdk.security: problem=
 in using "InternetQueryOption" API (at www.derkeiler.com)
(21:10:53) mattock: I can take a better look tomorrow
(21:11:13) mattock: shall we move on to this: "Enabling auto-proxy to work =
in configs that contain both UDP and TCP-based "<connection>" profiles"?
(21:11:35) mattock: (the full topic list is here: https://community.openvpn=
.net/openvpn/wiki/Topics-2010-04-22)
(21:11:37) vpnHelper: Title: Topics-2010-04-22 =EF=BF=BD=EF=BF=BD=EF=BF=BD =
OpenVPN (at community.openvpn.net)
(21:13:00) dazo: mattock:  that behaviour on UDP is different from Windows =
clients and Linux clients, IIRC
(21:13:33) mattock: dazo: different how?
(21:13:40) cron2: what is auto-proxy, btw?
(21:13:53) krzee: dont proxies only work on tcp anyways?  (except socks pro=
xies which i dont think are supported by auto-proxy stuff)
(21:13:57) dazo: mattock:  sorry .... I was on the wrong topic :-$
(21:14:51) dazo: not sure I understand the issue .... so if someone can she=
d a bit more light on this one, I'd be grateful
(21:15:33) mattock: do we have any links (to bug reports, mails, something.=
..)?
(21:15:53) mattock: i.e. where did this issue originate from?
(21:16:35) krzee: no idea, there was a thread about auto-proxy on the mail =
list tho
(21:16:39) krzee: might have been from that
(21:17:02) mattock: ok, I'll try to find clarifications to this issue
(21:17:05) krzee: i dont rememeber it talking about UDP tho... but i didnt =
pay much attention to it as it wasnt something i had played with / could ch=
ime in on
(21:17:18) ***dazo might have found it .... finding the Gmane URL now
(21:18:17) krzee: http://article.gmane.org/gmane.network.openvpn.devel/3446=
/match=3Dauto+proxy
(21:18:20) vpnHelper: Title: Gmane -- Mail To News And Back Again (at artic=
le.gmane.org)
(21:18:35) dazo: nope not that one ... but very close
(21:18:47) dazo: 'how to use "auto-proxy"'
(21:18:55) krzee: ahh
(21:19:58) krzee: last message in the thread i mentioned says something bou=
t talking about it in the meeting
(21:20:05) krzee: http://thread.gmane.org/gmane.network.openvpn.devel/3446
(21:20:06) vpnHelper: Title: Gmane Loom (at thread.gmane.org)
(21:20:25) krzee: oh hey thats where topic #1 comes from!
(21:20:48) dazo: http://thread.gmane.org/gmane.network.openvpn.user/29329
(21:20:49) vpnHelper: Title: Gmane Loom (at thread.gmane.org)
(21:20:57) mattock: krzee: I'll add the link to agenda
(21:21:09) krzee: > note to the developers: all error codes when using the=
=20
(21:21:09) krzee: > InternetQueryOption API are lost ... also read
(21:21:09) krzee: >   http://support.microsoft.com/kb/226473
(21:21:09) krzee: > Openvpn 2.1 uses the "old" IE4 API .
(21:21:09) krzee: >=20=20=20
(21:21:10) krzee: Another note to developers. Can they work on enabling aut=
o-proxy to work
(21:21:10) vpnHelper: Title: How to programmatically query and set proxy se=
ttings under Internet Explorer (at support.microsoft.com)
(21:21:12) krzee: in configs that contain both UDP and TCP-based "<connecti=
on>" profiles?=20
(21:21:14) krzee: In a similar vein, the following ticket is in the bug tra=
cking system -
(21:21:16) krzee: there seems to be a general problem with mixing TCP and U=
DP options (eg
(21:21:18) krzee: mssfix, nobind, fragment)
(21:21:55) krzee: this thread seems to cover #1 and #2 from our topic list
(21:22:00) dazo: yeah
(21:22:44) krzee: mattock, it was JJK who mentioned the IE4 API
(21:22:47) mape2k [~mape2k@...1306...:6f8:133b:0:21f:3bff:fe27:21a9] =EF=BF=
=BD=EF=BF=BD entrato nel canale.
(21:22:51) mattock: krzee: yep
(21:23:15) dazo: This needs some analysis to see what happens when you use =
<connection> blocks, and how that interfere with mssfix, nobind, fragment -=
 and auto-proxy
(21:23:18) mattock: ok, so the first three issues today originate from the =
same mail thread=20
(21:23:49) dazo: seems so
(21:24:36) dazo: mattock:  I suggest that this needed analysis goes into ou=
r TODO list ... and that we follow this one up regularly on the meetings
(21:24:45) dazo: until someone got time to have a look at it
(21:24:47) krzee: +1
(21:24:49) mattock: +1
(21:25:07) ***cron2 wants to see a proper bug report, as in "!logs"
(21:25:16) mattock: the topic list is now fixed
(21:25:42) dazo: mattock:  can you follow up the sf.net tracker and ask for=
 logs?
(21:25:58) dazo: (with verb 5 log level)
(21:26:09) mattock: dazo: will do
(21:26:31) dazo: mattock:  thx!
(21:27:45) dazo: mattock:  anyhow, for the meeting minutes ... make a note =
to this topic that this is a mixture, which seems to involve usage of <conn=
ection> blocks ... just so that we remember that
(21:28:03) mattock: dazo: ok
(21:28:48) mattock: what about this, then: Unnecessary script-security warn=
ing?
(21:29:04) mattock: more information here: https://community.openvpn.net/op=
envpn/attachment/wiki/Topics-2010-04-22/script_security_warning.txt
(21:29:05) vpnHelper: Title: Attachment =EF=BF=BD=EF=BF=BD=EF=BF=BD OpenVPN=
 (at community.openvpn.net)
(21:29:21) krzee: from the way high verb dumps config at the start, i assum=
e the config is scanned before the warning pops out
(21:29:27) dazo: agreed ... that warning should only appear if using any of=
 the script hooks
(21:29:38) krzee: ild think there could be a flag like IS_A_SCRIPT which an=
y script would set to 1
(21:29:42) dazo: krzee:  sometimes yes, sometimes no
(21:29:48) krzee: then the warning should only appear if that is 1
(21:29:58) dazo: agreed
(21:31:08) dazo: there are 9 script hooks, afaicu .... so they should trigg=
er this warning
(21:31:23) dazo: mattock:  I can have a look at a patch this evening .... s=
hould be trivial
(21:31:31) mattock: dazo: that'd be great!
(21:31:33) krzee: well ild think some scripts dont care bout --script-secur=
ity
(21:31:42) krzee: like --down for example ;]
(21:32:53) dazo: krzee:  all of the hooks should do that ... iirc, it descr=
ibes how the script is executed ... and what kind of execution is allowed
(21:33:26) dazo: krzee:  for example script-security 0 should disable also =
--down
(21:33:40) dazo: 0 -- strictly no calling of external programs"
(21:33:50) krzee: o_O i must remember bad, i thought it was a matter of wha=
t vars they could access
(21:34:17) cron2: I think the warning should be printed if and only if a sc=
ript is configured but not executed due to script-security
(21:34:19) krzee: oh right
(21:34:31) dazo: krzee:  well, you might remember correctly according to on=
e of the earlier RC versions ... this did change a few times during the RC =
cycle
(21:34:55) dazo: cron2:  good point
(21:35:03) dazo: that might make a patch simpler
(21:35:16) krzee: kinda
(21:35:24) krzee: theres still 3 -- Allow passwords to be passed to scripts=
 via environmental variables (potentially unsafe).
(21:35:45) krzee: we'ld still want that person to see the warning
(21:35:57) dazo: but hopefully not more than once ;-)
(21:36:30) krzee: (the script would run, but not work if we did what cron2 =
said ^ )
(21:36:39) krzee: so no warning
(21:36:59) cron2: krzee: oh, good point.  so this needs some tweaks :)
(21:37:16) krzee: i think a good enough solution is what dazo said
(21:37:28) krzee: any script being called, give the warning and let them so=
rt it out
(21:37:40) dazo: I don't want to spam the log with repeating messages .... =
so once should be enough ... if a person don't notice that one, that's his/=
hers problem
(21:37:54) krzee: agreed
(21:37:59) cron2: so just set a "have_sent_warning=3Dtrue;" flag...
(21:38:08) dazo: yup
(21:38:20) krzee: or like i said above, have a var that you wanna print the=
 warning
(21:38:31) krzee: you can set it to 1 9 times, it'll still only print once
(21:39:02) dazo: krzee:  I prefer working with booleans in C :-P
(21:39:23) krzee: ya im not a coder ;]
(21:39:45) krzee: my skills stop after the shell scripts
(21:39:50) dazo: anyhow, this setting will not be user exposed ... it'll be=
 inside the OpenVPN code ... but I'll have a look at it
(21:40:42) mattock: enough --script-security? :)
(21:41:00) dazo: it's pretty clear to me
(21:41:29) mattock: I have a couple of "extra" issues we could perhaps disc=
uss a little
(21:41:53) ***cron2 needs to leave at 21:00, but that's 19 minutes to go :)
(21:42:06) mattock: cron2: let's keep the discussion short :)
(21:42:33) dazo: cron2:  have you read the scrollback here?   could you ple=
ase do some new ACKs?  to the ./configure stuff .... you had some comments =
I've fixed up
(21:42:54) dazo: cron2:  http://thread.gmane.org/gmane.network.openvpn.deve=
l/3410/focus=3D3491
(21:42:55) vpnHelper: Title: Gmane Loom (at thread.gmane.org)
(21:43:21) dazo: cron2:  and http://thread.gmane.org/gmane.network.openvpn.=
devel/3410/focus=3D3555
(21:43:23) vpnHelper: Title: Gmane Loom (at thread.gmane.org)
(21:43:32) cron2: dazo: I've seen your mail, but only done a cursory look y=
et.  It's definitely more readable now :-)
(21:43:50) dazo: cron2:  we have a non-buildable allmerged tree at the mome=
nt :(
(21:43:51) cron2: haven't been near my keyboard today, so mail is backlogged
(21:43:57) cron2: dazo: huh, why?
(21:43:58) krzee: dazo, you are david sommerseth??
(21:44:05) dazo: krzee:  yeah
(21:44:09) krzee: whoa cool
(21:44:26) mattock: ok, so first I'd like to say that our current bug track=
ing model is working quite nicely... meaning that the issues are discussed =
in the next IRC meetings if no resolution is reached on the mailing lists.
(21:44:36) dazo: cron2:  because there's some issues with wrong dependency =
tracking to configure.h ... it does not get built
(21:45:05) cron2: dazo: ah.  ACK on the configure patch
(21:45:36) dazo: mattock:  you grab that one into the minutes? ^^=20
(21:45:37) cron2: ah, now I understand.  It's actually all the 4 patches th=
at need to get ACKed.  Yes, ACK :-)
(21:45:46) mattock: dazo: yep
(21:45:47) dazo: cron2:  yup!
(21:45:59) cron2: will ACK on the list, but that will have to wait until to=
morrow
(21:46:32) dazo: cron2:  no prob ... as long as I know it will come, and ma=
ttock get it that you promised it in the meeting, I'm more than happy
(21:47:18) cron2: mattock: so what's that you want to discuss?
(21:47:42) dazo: (sorry for hijacking the agenda a little bit)
(21:47:50) mattock: so (refering to myself above) I think we should continu=
e what we're doing and only use a bug tracker for issues that don't get res=
olved immediately (for whatever reason)... what do you think?
(21:48:16) dazo: yes, agreed
(21:48:47) mattock: I think the IRC meetings have been beneficial in handli=
ng old (and new) bugs fast=20
(21:48:47) cron2: mattock: I like bug trackers, as a focal point where "use=
rs" can drop their bugs in a well-defined way, and can also see whether it =
has been fixed and how
(21:49:13) cron2: for reports of bugs, it's a bit hard to figure out what t=
he status of a given bug is (I think)
(21:49:27) cron2: the development model is working well, agree
(21:49:45) cron2: it's just about "how do user issues get onto our agenda"
(21:50:37) dazo: +1
(21:50:41) mattock: cron2: you bring up a good point... even if we fix a bu=
g, it won't reach most end-users anytime soon=20
(21:51:12) mattock: so it'd be nice for them to check a bug tracker to see =
if the issue has been reported/fixed already
(21:51:40) mattock: however, not having to file a bug report for issues tha=
t are fixed in 1-2 weeks is also nice=20
(21:52:11) dazo: but also being able to mark bugs as duplicates is also an =
important feature in that regards
(21:53:42) mattock: I guess what I'm getting at is: should we file bug repo=
rts for bugs which we fix before anybody reports them (using a bug tracker)?
(21:53:54) mattock: am I confusing enough? ;)
(21:54:04) cron2: mattock: I'
(21:54:06) cron2: argh
(21:54:21) cron2: I'd say "yes", so that people that experience a problem c=
an find it in the bug tracker
(21:54:21) dazo: mattock:  if we notice the bug before it is fixed, yes, I =
would say we should
(21:54:27) cron2: and won't report it again
(21:54:39) dazo: and also to help us having a proper list of unsolved things
(21:54:54) dazo: (and log of when we solved it)
(21:55:13) cron2: acl
(21:55:14) cron2: ack
(21:55:25) cron2: (grrr, laptop keyboard, parents' sofa :) )
(21:55:30) dazo: :-P
(21:56:04) mattock: ok, so let's file bug reports (for communication purpos=
es) for bugs that never had a chance to reach the bug tracker :)=20
(21:56:23) dazo: yeah, that's sensible
(21:56:40) mattock: then I'd like to hear your opinion about a couple of hi=
gh-level development things...
(21:57:05) mattock: roadmap and release management
(21:57:15) dazo: mattock:  it would even be great if James could fill out h=
is "task list" over things which he has not had time to do as well ... that=
 way, someone might be encouraged to try to submit patches=20
(21:57:26) mattock: dazo: agreed
(21:57:38) krzee: +1
(21:58:19) mattock: ok, so should we start discussing the roadmap on the ma=
iling list starting next week?
(21:58:36) mattock: if james participates in that discussion - great... if =
not, we can discuss it in these meetings
(21:58:37) cron2: dazo: +1
(21:58:39) dazo: Yes, please ... that's high time now to get that ball roll=
ing
(21:58:43) cron2: +1
(21:58:51) krzee: +1
(21:59:16) mattock: and another thing... currently we have Dazo's "testing"=
 tree. And then we have James' "stable" tree. And then we have releases... =
and then we don't have anything that ties these together.
(21:59:27) mattock: so no complete development process from "testing" to re=
lease
(21:59:34) mattock: I think we should start discussing that, too, on the ml
(21:59:42) cron2: mattock: weeeellll
(21:59:58) cron2: I agree that we have no way to get things moved
(22:00:05) cron2: but I don't know what the ML can do here
(22:00:16) krzee: my understanding is that james has to decide what he want=
s to pull out of the testing tree himself, is that right?
(22:00:17) cron2: for me, this seems to be a "James decides this" thing
(22:00:32) krzee: cron2, exactly
(22:00:32) cron2: krzee: same for me
(22:00:59) dazo: James need to pick out what he finds reasonable to put int=
o a release, which he feels have been tested well enough
(22:01:38) dazo: but, I'd like to see that he has confidence enough in the =
-testing tree that he don't delay things too much
(22:01:39) krzee: hrm, so maybe there could be snapshots of testing for eva=
l purposes? (or is there already?)
(22:01:59) dazo: krzee:  we're trying that with ecrist snapshots
(22:02:02) mattock: krzee: there are some snapshots available already
(22:02:06) krzee: gotchya
(22:02:51) mattock: we could discuss the development process (testing->stab=
le->releases) on the ml and bring the results/suggestions to james=20
(22:03:00) mattock: unless he takes part in that discussion himself
(22:03:27) mattock: there are lots of bright minds on -devel who could help=
 us figure out the best way to manage the process in it's entirety
(22:03:32) mattock: =3Dthe whole process
(22:04:03) ecrist: krzee: there's even a -devel port in freebsd ports tree
(22:04:12) dazo: but, the overall idea with how I've laid out the git tree =
... is that all major features do have separate branches ... so that he can=
 pick out those patches (or group of patches) individually to implement int=
o his tree .... and then there's the bugfix2.1, feat_misc and frp which are=
 more mixed, but small enough changes that they can more easily be cherry p=
icked
(22:04:32) dazo: krzee:  and guess who's behind that one now ;-)
(22:04:39) ***dazo points at ecrist=20
(22:05:02) dazo: mattock:  agreed
(22:05:27) cron2: ok folks - need to leave now (drive to the datacenter, sw=
ap a broken router).  I'll send comments on the ML then.
(22:05:30) cron2: bye
(22:05:36) dazo: cron2:  bye!
(22:05:38) krzee: adios cron2=20
(22:05:39) mattock: what if I write a mail to -devel next week / week after=
 that... explaining the current situation and asking for suggestions how to=
 manage the entire process
(22:05:42) mattock: cron2: bye!
(22:05:50) dazo: mattock:  sounds good!
(22:05:52) cron2: mattock: +1 (and bye)
(22:06:43) krzee: very nice eric
(22:08:05) mattock: has anything been done regarding the "TCP-over-TCP issu=
e"? There's been lots of talk, but did somebody have a good suggestion how =
to make things better? Auto-tuning connection parameters comes to mind...
(22:08:11) mattock: krzee, perhaps?
(22:08:44) krzee: im curious what they are doing to make it not suck
(22:08:59) mattock: krzee: who are they? :)
(22:09:09) krzee: then it can be said whether or not its possible to autoco=
nfig or not
(22:09:14) krzee: mattock, very good question!
(22:10:01) mattock: I intended to ask about tcp-over-tcp from James today, =
but that failed for obvious reasons=20
(22:10:42) dazo =EF=BF=BD=EF=BF=BD ora conosciuto come dazo_afk
(22:10:43) mattock: ok, so no magical cure has arrived yet...
(22:11:00) mattock: have we covered everything already?
(22:11:14) krzee: in james' slide show tcp over tcp sucking is a selling po=
int for openvpn
(22:11:24) mattock: :D
(22:12:46) mattock: btw. the famous "LDAP user self-service registration se=
rvice (pwm)" now works
(22:12:54) dazo_afk =EF=BF=BD=EF=BF=BD ora conosciuto come dazo
(22:13:30) mattock: I may need to modify a few JSP pages (JavaServer Pages)=
 to remove the disabled functionality from the views, but otherwise it work=
s like a charm
(22:13:45) ***dazo lost the connection for a little while
(22:13:49) mattock: so we can soon open the community site Trac for wider a=
udience
(22:13:55) mattock: and then move on to forums
(22:14:23) mattock: and to migrating data to Trac
(22:15:07) mattock: anything else we'd like to / need to discuss?
(22:16:55) ***dazo don't have anything else now
(22:17:15) krzee: lemme look at the wishlist
(22:18:15) krzee: http://ovpnforum.com/viewforum.php?f=3D10
(22:18:16) vpnHelper: Title: OpenVPN Forum View forum - Wishlist (at ovpnfo=
rum.com)
(22:18:30) krzee: heres a couple ideas
(22:19:24) krzee: http://ovpnforum.com/viewtopic.php?f=3D10&t=3D3790  http:=
//ovpnforum.com/viewtopic.php?f=3D10&t=3D383    http://ovpnforum.com/viewto=
pic.php?f=3D10&t=3D624
(22:19:25) vpnHelper: Title: OpenVPN Forum View topic - authenticate to soc=
ks daemon (at ovpnforum.com)
(22:19:35) ***krzee smacks vpnHelper=20
(22:19:50) krzee: damn urltitle
(22:19:51) krzee: http://ovpnforum.com/viewtopic.php?f=3D10&t=3D383
(22:19:53) vpnHelper: Title: OpenVPN Forum View topic - bind to multiple po=
rts (at ovpnforum.com)
(22:19:58) krzee: http://ovpnforum.com/viewtopic.php?f=3D10&t=3D624
(22:20:00) vpnHelper: Title: OpenVPN Forum View topic - Auto-tune mtu (at o=
vpnforum.com)
(22:20:03) mattock: krzee: we could sneak those in one/two at a time in eve=
ry meeting
(22:20:24) mattock: what do you think?
(22:20:31) krzee: sure!
(22:20:41) dazo: sounds good!
(22:21:43) mattock: just let me know which one to add in the next week's to=
pic
(22:22:03) dazo: mattock:  begin at the top? ;-)
(22:22:10) mattock: as usual :)
(22:22:12) dazo: we seem to be good at that :-P
(22:22:36) mattock: well, I don't think it's any worse than moving forward =
randomly :)
(22:23:11) mattock: I think we're done for today... agreed?
(22:23:17) dazo: +1
(22:23:21) krzee: yupyup
(22:23:25) ***dazo realises he is too tired to look at a patch this evening=
 ... will look at it again tomorrow instead
(22:23:28) mattock: great!
(22:23:46) mattock: (referring to end of meeting, not dazo's tiredness) :)
(22:23:57) mattock: ok, see you later, guys!
(22:23:59) dazo: lol
(22:24:02) dazo: c'ya!
(22:24:28) krzee: lol

--------------040701000906060402010606--

