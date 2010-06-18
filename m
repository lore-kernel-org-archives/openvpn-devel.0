Message-ID: <4C1B490F.1040605@...515...>
Date: Fri, 18 Jun 2010 13:23:11 +0300
From: =?ISO-8859-15?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------090808060509010901020206"
Subject: [Openvpn-devel] Summary of the IRC meeting (17th Jun 2010)
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
--------------090808060509010901020206
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable

Hi,

Here's the summary of the previous community meeting.

---

COMMUNITY MEETING

Place: #openvpn-devel on irc.freenode.net
Date: Thursday, 17th Jun 2010
Time: 18:00 UTC

Planned meeting topics for this meeting were on this page:

<https://community.openvpn.net/openvpn/wiki/Topics-2010-06-17>

Next meeting next week, same place, same time. Your local meeting time
is easy to check from services such as

<http://www.timeanddate.com/worldclock>

or with

$ date -u


SUMMARY

Discussed the "Choose a different field in X509 to be username" patch:

<http://thread.gmane.org/gmane.network.openvpn.devel/3765>

Decided to merge the patch into feat_misc branch. Agreed that after
applying this patch the use of "common_name" in code is confusing and
decided to discuss the alternatives on the devel mailinglist.

--

Discussed the "Fixed client hang when server don't PUSH" patch:

<http://thread.gmane.org/gmane.network.openvpn.devel/3760>

This patch is better known by it's nickname, "NO_SOUP_FOR_YOU". James
ACK'd this patch so it will be merged into "testing".

--

Discussed an old bug, "TCP and UDP connections aren't possible in client
mode":

<https://community.openvpn.net/openvpn/ticket/16>

We now have two sets of broken configuration files in the SF.net
tracker. Samuli volunteered to ask for log files, too.

--

Samuli gave an update on the status of community services. Link from
openvpn.net to community.openvpn.net (trac+registration service) should
be in place within two weeks. Work on forums has been started. Building
of the CI/packaging/publishing server ("buildbot") has also begun.

---

Full chatlog as an attachment

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock





--------------090808060509010901020206
Content-Type: text/plain; charset="utf-8";
 name=openvpn_irc_meeting_chatlog_2010-06-17.txt
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
	filename="openvpn_irc_meeting_chatlog_2010-06-17.txt"

(21:07:29) jamesyonan: hi
(21:07:43) mattock: hi james
(21:08:19) mattock: ok, so there are a few people present... anything to ad=
d to the topic list?
(21:08:24) krzee: i guess i can ask a question that isnt on the list
(21:08:31) mattock: krzee: please do
(21:09:43) mape2k ha abbandonato il canale (quit: Read error: Operation tim=
ed out).
(21:10:20) dazo [~dazo@...1382...] =EF=BF=BD=EF=BF=BD entrato nel canale.
(21:10:20) modalit=EF=BF=BD=EF=BF=BD (+o dazo) da ChanServ
(21:11:05) krzee: ok, who should i go to when i see things on the web site =
that should be changed, here is 2 examples:   a) in the FAQ on /30, it uses=
 the subnet of 192.168.0.x i feel that should be 10.8.0.x   b) redirects on=
 betaman lose the # tag, like #lbDa or whatever
(21:12:18) mattock: ok, so right now you should send mail to frank at openv=
pn... hopefully soon you can just mail me and I'll make any fixes necessary
(21:14:21) krzee: ok cool, you're my goto guy, i wont spam this chan with i=
t anymore =3D]
(21:14:27) mattock: great!
(21:14:39) mattock: ok, I'll begin my monologue then...
(21:15:15) mattock: it's been pretty slow on the patch side lately... I don=
't think any of the patches require in-depth discussion here
(21:15:41) dazo: It would be great to get a review of the patch I sent the =
other day ;-)
(21:15:48) krzee: i know HanX has a question
(21:15:53) mattock: dazo: oh, you're here :)
(21:15:59) krzee: err chantra does
(21:16:04) HanX: yep
(21:16:24) mattock: hanx: what do you have in mind?
(21:16:28) dazo: mattock:  yeah :)  I figured I could manage it today :)
(21:16:37) HanX: mattock: i sent a patch today
(21:16:44) HanX: (i'm emilien mantel)
(21:16:47) mattock: oh, yes
(21:17:04) mattock: dazo: have you already taken a look at emilien's patch?
(21:17:18) mattock: alon already gave so useful feedback on it
(21:17:25) mattock: ...some useful
(21:17:31) dazo: mattock:  I haven't had time to do that yet ... I think it=
 was sent very recently, right?
(21:17:36) mattock: yep, today
(21:17:40) HanX: i think we need to rename all vars/functions "common_name"=
 to "username"
(21:17:48) ***dazo almost just completed breakfast :)
(21:18:48) krzee: HanX, i disagree, common-name and username are 2 distinct=
 things
(21:19:18) HanX: krzee: openvpn uses x509 common_name "CN" as username
(21:19:21) ***dazo tend to agree to krzee=20
(21:19:30) HanX: with my patch you can use another field
(21:19:40) HanX: in my case, I use UID
(21:19:41) krzee: no, it does not, unless you use --commonname-as-username
(21:19:54) krzee: or whatever that command is
(21:20:16) dazo: --username-as-common-name
(21:20:35) dazo: which indicates that CN is the key
(21:21:42) dazo: I am sceptical to do such a change in general, unless it r=
eally clarifies something unclear
(21:22:13) dazo: But as OpenVPN are very PKI centric, common_name is the ce=
rtificate identification field, in that regards
(21:22:47) HanX: the problem: in some cases, CN is not uniq
(21:24:32) HanX: the advantage of my patch : if you wan to match with anoth=
er field you can...
(21:24:42) dazo: agreed,=20
(21:24:47) ***dazo reads patches now
(21:25:15) dazo: HanX:  it's indeed a patch which seems very useful ... so =
this is a worthy candidate to go into the feat_misc branch
(21:25:44) HanX: :)
(21:25:45) dazo: I am just concerned about renaming common_name to username=
, as that really implies different things under normal situations
(21:26:27) dazo: client_userid might be a better wording than username ....=
 to avoid confusion with the --auth-user-pass feature, which uses usernames
(21:27:11) mattock: I'm a little confused... what does the common_name in c=
ode refer to?
(21:27:16) mattock: is it the CN in certs?
(21:27:20) dazo: yes
(21:28:11) mattock: ok, then I don't see a point in changing it to "usernam=
e"
(21:28:20) dazo: I think even Alon Bar-Lev's suggestion ... x509_field give=
s an even better indication=20
(21:28:35) HanX: (i wrote the patch for my studies, are you agree I save th=
is conversation?)
(21:28:45) dazo: mattock:  with this patch, you can use other X509 fields f=
or identifying the client, than just CN
(21:28:59) mattock: yep, that's what I thought
(21:29:08) krzee: why would you need another identifier field???  if you ar=
e making a new cert why not just use a new common-name
(21:29:08) dazo: HanX:  sure! This channel is already logged
(21:29:28) krzee: yup, vpnHelper logs this and #openvpn
(21:29:37) HanX: thanks
(21:29:38) dazo: krzee:  you are not guaranteed that the CN is different, e=
ven though the certificate is another cert
(21:29:49) mattock: hanx: I'll send this chatlog to openvpn-devel mailingli=
st along with the meeting summary
(21:29:56) krzee: but you are making the new cert, you should make it diffe=
rent!
(21:30:12) mattock: but if you're not making a new cert?
(21:30:23) mattock: rather, using old ones where CN is not unique
(21:30:30) mattock: existing PKI
(21:30:38) krzee: if you're not making a new cert, you dont have something =
unique in the new field
(21:30:59) krzee: existing PKI wont have his special field with a new uniqu=
e identifier in it
(21:31:11) dazo: krzee:  say you have personified certs ... and give one ce=
rt for the users laptop and one cert for his mobile phone ... it would then=
 ideally have the same CN
(21:31:20) dazo: (or ideally, in my world, that is :))
(21:31:26) HanX: krzee: in my case PKI is linked to a LDAP...
(21:33:51) mattock: I'll take hanx's word that this patch solves a real iss=
ue with some PKI setups...
(21:34:24) mattock: dazo: did the latest patch look good enough to ACK?
(21:35:24) dazo: mattock:  I've just thrown a quick look at it now, I'd lik=
e to have a closer look at it first
(21:35:30) mattock: dazo: ok
(21:35:46) mattock: I think we should discuss the common_name renaming issu=
es on the ml
(21:35:54) dazo: agreed
(21:36:08) mattock: shall we move on?
(21:36:18) dazo: such a change would be better to be applied after this pat=
ch is in the tree
(21:36:41) mattock: agreed, the renaming is unrelated to this patch
(21:36:54) mattock: dazo: you had a patch that needed review?
(21:37:13) krzee: renaming to username would be more confusion that anythin=
g it could possibly clarify
(21:37:14) dazo: yeah, it's the bug fix=20
(21:37:20) krzee: since in reality it is not a username
(21:37:43) HanX: we need to find a good name :)
(21:37:43) mattock: krzee: agreed
(21:38:24) dazo: krzee:  that's my point ... but with this patch, the "user=
name" can be something else than CN as well .... so renaming to username, i=
s not clarifying either ... so we need to think about that
(21:38:42) dazo: HanX:  can you bring up this discussion on the ML after th=
e patch has been applied to feat_misc?
(21:39:12) krzee: username can always be something different than common-na=
me, the only time usernames exist is from verify-auth scripts
(21:39:37) krzee: auth-verify-pass or whatever it is
(21:39:39) dazo: mattock:  http://thread.gmane.org/gmane.network.openvpn.de=
vel/
(21:39:43) vpnHelper: Title: Gmane Loom (at thread.gmane.org)
(21:39:54) HanX: dazo: no problem.
(21:40:20) dazo: krzee:  yeah, agreed ... which is why I'm advocating a bet=
ter name for this information than 'username' or 'common_name'
(21:41:20) dazo: HanX:  thx!
(21:41:30) mattock: dazo: NO_SOUP_FOR_YOU-patch?
(21:41:40) krzee: LOL!
(21:41:49) dazo: mattock:  yeah, from last meeting ... I promised to look a=
t this during my flight
(21:41:58) mattock: did it take long?
(21:42:11) dazo: no, not at all
(21:42:30) mattock: great!
(21:42:50) mattock: jamesyonan: would you ACK this: http://thread.gmane.org=
/gmane.network.openvpn.devel/3760
(21:42:51) vpnHelper: Title: Gmane Loom (at thread.gmane.org)
(21:42:56) dazo: it was a lot easier than I expected ... and the fix is rat=
her simple, as the "receiving" side didn't need any change at all on empty =
replies
(21:45:41) dazo: I do see that buf_reset_len() and buf_printf() might be un=
needed ... but it's included as a defensive approach, to be really sure we =
sent an empty PUSH_REPLY to the client
(21:46:19) jamesyonan: what does the receiver do on empty push?
(21:46:53) dazo: it's a check on '\0' already in that code ... which just c=
ontinues as normal
(21:47:02) ***dazo looks up the concrete code path
(21:47:31) dazo:       const uint8_t ch =3D buf_read_u8 (&buf);
(21:47:39) dazo:       else if (ch =3D=3D '\0')
(21:47:39) dazo: 	{
(21:47:39) dazo: 	  ret =3D PUSH_MSG_REPLY;
(21:47:39) dazo: 	}
(21:47:44) dazo: tha'ts the code fragments
(21:48:03) dazo: and this section is hit on an empty PUSH_REPLY
(21:48:22) dazo: (push.c:347)
(21:48:37) jamesyonan: dazo: patch looks good
(21:49:42) dazo: jamesyonan:  thx!  I'll apply it to the bugfix2.1 branch t=
hen
(21:49:59) mattock: great!
(21:50:23) krzee: yay for NO_SOUP_FOR_YOU patch!
(21:50:30) dazo: lol
(21:50:31) mattock: +1
(21:51:06) mattock: ok, so there's this old issue which moved a little towa=
rds a resolution this week: http://sourceforge.net/tracker/?func=3Ddetail&a=
id=3D2947626&group_id=3D48978&atid=3D454719
(21:51:08) vpnHelper: Title: SourceForge.net: OpenVPN: Detail: 2947626 - TC=
P and UDP connections aren't possible in client mode (at sourceforge.net)
(21:51:12) krzee: (i was secretly hoping it would be fixed by pushing NO_SO=
UP_FOR_YOU to the client), lol
(21:51:58) mattock: so I had promised in an earlier meeting to contact the =
author of the bug report
(21:52:02) dazo: (krzee: sorry to disappoint you ... I considered it, but i=
t would require a bigger change ;-))
(21:52:40) mattock: at that time contacting failed or something... but jaso=
n haar reminded me of the issue last week... and now we have the problemati=
c config files at least
(21:52:46) mattock: I'll have to ask for logfiles, too
(21:52:59) mattock: neither of them provided any, yet
(21:53:19) krzee: lol
(21:53:36) mattock: I'll ask again for logs tomorrow=20
(21:53:47) dazo: If I've understood it correctly, it's a problem when certa=
in options are used inside a <connection/> block?
(21:54:46) mattock: here's a pretty good summary: https://community.openvpn=
.net/openvpn/ticket/16
(21:54:48) vpnHelper: Title: #16 (Problems mixing UDP- and TCP-based connec=
tion profiles) =EF=BF=BD=EF=BF=BD=EF=BF=BD OpenVPN (at community.openvpn.ne=
t)
(21:54:59) mattock: or rather, a list of sources of information
(21:55:20) dazo: ah perfect
(21:55:54) mattock: there seem to be several issues with parsing the <conne=
ction> blocks...
(21:56:30) mattock: anyways, I think we can take a closer look when we get =
the log files and see what's happening with the parser
(21:56:46) dazo: agreed
(21:57:13) mattock: anything else or shall I summarize the status of commun=
ity services?
(21:58:17) mattock: ok... so in a nutshell
(21:59:18) mattock: we should get the link from openvpn.net to community.op=
envpn.net next week or the week after that...
(21:59:35) mattock: after that the site should start seeing much more traff=
ic
(21:59:44) dazo: \o/
(22:01:00) mattock: I'll have to add Trac server to our puppet infra to get=
 service monitoring, log watching etc. installed... I don't know if the ser=
ver can handle the load that comes from openvpn.net
(22:01:14) mattock: that remains to be seen...
(22:01:19) mattock: then forums...
(22:02:03) mattock: ecrist did some software installations there a few week=
s back and I'll try to setup the LDAP auth tunnel soonish (next week or wee=
k after that)
(22:02:19) mattock: the really difficult issue will probably be migration o=
f forum user accounts to LDAP
(22:02:41) mattock: besides that I don't think there'll be big migration is=
sues=20
(22:03:32) mattock: then the CI server... I chose buildbot as the app for t=
hat
(22:04:03) mattock: it's used by some other projects, e.g. wireshark http:/=
/www.wireshark.org/docs/wsdg_html_chunked/ChIntroAutomated.html
(22:04:05) vpnHelper: Title: 1.6.?Automated Builds (Buildbot) (at www.wires=
hark.org)
(22:04:16) mattock: everything else seemed rather hackish or proprietary
(22:04:38) mattock: I started configuring it, but I expect it takes quite a=
 while to get it 100% functional
(22:05:03) mattock: ok, I guess that's all
(22:05:29) mattock: anything else? or shall we call this a day? (1:05 and c=
ounting)
(22:07:51) dazo: mattock:  CI sounds good ... I've seen a few others, but d=
on't recall the names now ... but not sure if they're bigger F/OSS projects=
 or just very project specific .... so using what wireshark does, sounds go=
od
(22:08:09) ***dazo looks forward to the buildbot to get up'n'running
(22:08:20) mattock: the fun part is that buildbot apparently does automated=
 builds, too
(22:08:44) dazo: yeah, and if it even supports building windows binaries as=
 well, that's a big pluss too
(22:09:02) mattock: and it's very OSS-centric, so there's lots of connector=
s available for email, VCS, IRC etc
(22:09:13) dazo: perfect!
(22:09:33) mattock: so if a build fails, it can send mail to patch author, =
to the devel list, IRC channel etc
(22:09:41) dazo: having an e-mail going out and irc notification on build i=
ssues would be a good hting
(22:09:43) mattock: pretty much anything you want, I guess
(22:09:59) mattock: it seems pretty complex to setup, so don't expect it to=
 be ready on monday :)
(22:10:07) dazo: :(
(22:10:08) dazo: lol
(22:10:29) dazo: well, if we can have it running before we're starting 2.2 =
alpha, that would be ideal
(22:10:34) dazo: 2.2 beta, I mean
(22:10:50) mattock: btw... buildbot requires s.c. "change sources"... meani=
ng some way to notify it that a commit has been made=20
(22:11:06) mattock: for us this mean either:
(22:11:31) mattock: - buildbot email patch parser
(22:11:31) mattock: - use of buildbot git commit hook
(22:11:56) mattock: the second also requires a separate daemon to be listen=
ing for connections from this git hook
(22:12:13) mattock: could we use the second option somehow? does sf.net pre=
vent that?
(22:12:38) dazo: the latter one is probably the best one ... but not sure h=
ow to do that right now, as the source tree is on sf.net .... but I guess w=
e can trigger it by doing a http call to the community server which trigger=
s the buildbot
(22:13:06) dazo: (git push-hook -> http://community.o.n/ -> buildbot
(22:13:07) dazo: )
(22:13:30) mattock: it'd be strange if buildbot would not support some kind=
 of polling...
(22:13:50) mattock: anyways, I'm not sure what exactly is required... I'll =
keep you updated
(22:13:57) dazo: nice!
(22:14:50) mattock: ok, are we done?
(22:15:12) krzee: not possible!
(22:15:20) krzee: im not leaving work yet, we always end when im leaving
(22:15:23) krzee: lol
(22:15:55) mattock: :)
(22:16:13) dazo: heh
(22:16:16) dazo: mattock:  I think so
(22:16:22) mattock: ok, great!
(22:16:36) mattock: this was genuinely fast, not fake-fast like last week
(22:16:46) mattock: 1:16
(22:16:50) dazo: :)

--------------090808060509010901020206--

