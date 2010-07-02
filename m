Message-ID: <4C2DA3FC.3090105@...515...>
Date: Fri, 02 Jul 2010 11:31:56 +0300
From: =?ISO-8859-15?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------020409010308060200080905"
Subject: [Openvpn-devel] Summary of the IRC meeting (1st Jul 2010)
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
--------------020409010308060200080905
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable

Hi,

Here's the summary of the previous community meeting.

---

COMMUNITY MEETING

Place: #openvpn-devel on irc.freenode.net
Date: Thursday, 1st Jul 2010
Time: 18:00 UTC

Planned meeting topics for this meeting were on this page:

<https://community.openvpn.net/openvpn/wiki/Topics-2010-07-01>

Next meeting next week, same place, same time. Your local meeting time
is easy to check from services such as

<http://www.timeanddate.com/worldclock>

or with

$ date -u


SUMMARY

Discussed forums.openvpn.net. Announced August 13th (Friday, of course)
as the launch date. Data and users will be migrated from ovpnforums.com.
Server setup is done jointly by our community (Eric) and the company
(Samuli, Andrew and Patel).

--

Discussed Wiki usage. Agreed that our Trac wiki should be used as the
official OpenVPN wiki:

<https://community.openvpn.net/openvpn/wiki>

Also discussed backing up the Trac server to Secure Computing. Agreed
that it makes sense to have at least data backups in a
community-maintained server. Currently the LDAP directory, Trac database
& configs and /etc are being pushed to a (Eric's) Secure Computing
servers. These should be enough to restore Trac and LDAP users in case a
disaster happens. The backups should be tested to validate this, though.

--

Discussed BuildBot build failure notifications. Agreed that
notifications should be sent to the #openvpn-devel IRC channel in the
following fashion:

- Supybot (the famous vpnHelper) monitors BuildBot's RSS feed web page
- Supybot pushed the RSS notifications to #openvpn-devel channel

Also agreed that build failures should be sent to a mailinglist as
developers are not guaranteed to be on IRC all the time. Openvpn-devel
list could be used for this; however, ~500 people have subscribed to it
and maybe 10 are interested in build failures. If failures are not
frequent, this might not be an issue. The alternative is to create a new
mailinglist (e.g. openvpn-builds) and use that instead.

--

Discussed limiting access to BuildBot web interface (status display) for
security reasons. Agreed that access to it should be limited to core
community members. Agreed that eating our own dogfood makes sense, so
access to BuildBot would be granted with OpenVPN "testing" + LDAP
authentication. An alternative would be HTTPS+BASIC AUTH from LDAP.

--

Discussed where to get BuildSlaves for Buildbot. Agreed that a basic set
of i386/amd64 BuildSlaves could be simple virtual machines. Additional
architectural coverage could be obtained from volunteer community members.

--

Discussed build triggers BuildBot will use. Agreed that reading the
SF.net Git RSS feed would make most sense. Samuli agreed to see if this
is possible without hacking with Python.

The alternative approach is to make BuildBot read commits from commit
mails in a mailing list. A read-only openvpn-commits list would make
most sense from security perspective.

--

Discussed the Beta2.2 branch which lives in openvpn.net SVN repository.
The Git<->SVN interaction has a number of unsolved issues: see 22:17 -
22:29 in the full chatlog. Agreed that until we get James' view on those
issues we should maintain beta2.2 branch in Git instead of SVN.

---

Full chatlog as an attachment

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock







--------------020409010308060200080905
Content-Type: text/plain; charset="utf-8";
 name=openvpn_irc_meeting_chatlog_2010-07-01.txt
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
	filename="openvpn_irc_meeting_chatlog_2010-07-01.txt"

(21:06:28) mattock: let's start the meeting, shall we?
(21:06:44) dazo: +1
(21:06:45) cron2: I just wanted to suggest that, yes :-) we have some items=
 that don't need James
(21:06:54) mattock: https://community.openvpn.net/openvpn/wiki/Topics-2010-=
07-01
(21:06:55) vpnHelper: Title: Topics-2010-07-01 =EF=BF=BD=EF=BF=BD=EF=BF=BD =
OpenVPN (at community.openvpn.net)
(21:07:19) mattock: ok, for your information we set the launch date for for=
ums.openvpn.net
(21:07:24) mattock: which is...
(21:07:31) mattock: August 13th (Friday, of course :)
(21:07:53) mattock: one topic covered!
(21:08:06) ecrist: currently, openvpn tech folks are to be skinning the site
(21:08:15) mattock: yep
(21:08:19) ecrist: mattock is supposed to be working on integrating the aut=
hentication=20
(21:08:24) ecrist: I am relaxing.
(21:08:34) cron2: ecrist: good planning :)
(21:08:37) dazo: ecrist:  job well done in other words!
(21:08:48) krzee: ecrist++
(21:09:14) mattock: I'll start working on the forums on monday
(21:09:34) mattock: I have a couple of tasks which should be finished in a =
day or two
(21:09:35) ecrist: let me know if there are php modules missing, etc
(21:09:53) mattock: ecrist: ok
(21:10:04) mattock: although I think I'll just install any missing ports my=
self
(21:10:48) mattock: ok, shall we move on to BuildBot stuff?
(21:10:54) ***krzee hears "ports", its fbsd?
(21:10:57) krzee: good stuff
(21:11:25) mattock: krzee: yep
(21:11:48) ecrist: krzee: of course
(21:11:51) ecrist: only the best
(21:12:11) krzee: =3D]
(21:12:11) mattock: sending mail to james...
(21:12:32) cron2: shall we cover the wiki thing in between?
(21:12:39) dazo: +1
(21:12:47) cron2: I basically want feedback on two things
(21:13:09) cron2: - is this the right wiki?  do we want stuff to go to wiki=
.secure-computing.net or something on community.openvpn.net?
(21:13:15) cron2: (I saw that one article already moved)
(21:13:41) cron2: - and then I'd like some help on actual wiki formatting, =
something isn't working out with my lists and the </ol> bit :)
(21:14:14) mattock: cron2: I just got write access to openvpn.net, so I'll =
soon link from there to community.openvpn.net
(21:14:20) mattock: so it should start seeing more traffic soon
(21:14:31) krzee: the first question is a good question... i guess it comes=
 down to taste
(21:14:56) cron2: krzee: I'm neutral on this, and do not want to step someo=
ne's toes :-) - which is why I'm bringing it up
(21:15:02) krzee: personally i like mine being on SCN, although i dont mind=
 if its mirrored on ovpn's
(21:15:21) mattock: there are a few issues here... having two wikis tends t=
o fragment the content
(21:15:59) cron2: yep
(21:16:09) dazo: we can't restrict non-official wiki's to appear ... and I =
see it as good as we have the secure-computing wiki available ... but I'd s=
ay that core developers (yes, that includes you cron2) should probably put =
more official stuff on the community wiki
(21:16:14) mattock: I don't mind adding links from openvpn.net to wiki.scn,=
 but the community.openvpn.net wiki will need to be the "official" wiki
(21:16:58) ecrist: I have no real opinion.
(21:17:21) krzee: now that i see lots of activity from the real openvpn.net=
 i dont have much opinion either, but i still remember what happened to the=
 last official wiki/forum
(21:17:22) ecrist: the wiki at SCN isn't going anywhere, and I'm not really=
 interested in it becoming the 'official' wiki
(21:17:35) ecrist: krzee++
(21:17:55) cron2: krzee: yes, I can understand that (but then, google will =
always have a copy forever :) )
(21:18:06) krzee: not forever
(21:18:08) ecrist: cron2: that's not true
(21:18:14) mattock: krzee, ecrist: that's why I want you to have data backu=
ps and/or acecss to  new "official" wiki + forums
(21:18:33) ecrist: right, not trying to rehash that old argument, mattock.
(21:18:34) krzee: +1 to that
(21:18:36) dazo: that concern I do share with ecrist and krzee .... not kno=
wing the whole history, I believe we now are building a real community comp=
ared to earlier attempts
(21:18:53) cron2: anyway - I think in the current framework it makes sense =
to put the page into the "official" wiki and have a pointer in SCN wiki
(21:19:06) krzee: so heres my take on this...  official stuff goes on the o=
fficial wiki, anyone can add to SCN if they like
(21:19:08) cron2: if things go downhill again, I can always move that
(21:19:25) mattock: krzee: +1
(21:19:27) cron2: is the official wiki using the same syntax as the SCN wik=
i?
(21:19:28) ecrist: I take nightly backups of the forum server, so I'll have=
 db and such for that
(21:19:30) dazo: and if going downhill again ... ecrist will have a copy of=
 the trak wiki
(21:19:44) ecrist: I do not have shell access to the wiki host, however.
(21:20:05) mattock: ecrist: would you need it?
(21:20:28) ecrist: only if the intent is for SCN to maintain a backup
(21:20:42) ecrist: unless you're pushing backups to me
(21:20:50) ecrist: either way works, really
(21:20:54) cron2: I think it would relieve some worries if we had a backup =
at SCN...
(21:21:01) mattock: you mean full backup?
(21:21:03) mattock: system backu
(21:21:04) mattock: p
(21:21:09) ecrist: aye
(21:21:42) cron2: dunno, "whatever is needed to avoid losing content"
(21:21:50) mattock: ok, I wanted to save your diskspace by only backing up =
data (database, LDAP) to SCN. I can push the whole thing there, too
(21:22:04) ecrist: mattock, I have 'oodles' of disk space
(21:22:06) mattock: however, restoring the data into a new Trac instance is=
 trivial
(21:23:10) mattock: I'm pretty sure everything needed to rebuild the server=
 + data is already included in SCN backup
(21:23:16) mattock: I can verify that, though
(21:24:48) mattock: I'll check it now, takes a minute
(21:25:44) mattock: yes, nothing's missing
(21:26:00) cron2: anyway - I think I'll try to move the article in the next=
 days, and then I'll come back and ask for help on the formatting side of t=
hings
(21:26:07) mattock: Trac database, LDAP directory, config files, /etc
(21:26:41) cron2: (and some feedback on the content, of course :), but I th=
ink I'll need to chase mape2k on this, as everybody else has no OpenWRT exp=
erience either)
(21:26:47) dazo: cron2:  if you look at the agenda topics wiki's you usuall=
y get the idea of the formatting there ... it's pretty stupidly simple
(21:27:06) mattock: and even everything related to the registration service=
 (pwm) is being backed up to SCN=20
(21:27:29) cron2: dazo: I have struggled with trac wiki at a customer's sit=
e, so it's different from SCN, but I should find my ways
(21:27:48) mattock: cron2: it's a little different from mediawiki, but not =
much
(21:28:15) waldner: https://community.openvpn.net/openvpn/wiki/WikiFormatti=
ng
(21:28:17) vpnHelper: Title: WikiFormatting =EF=BF=BD=EF=BF=BD=EF=BF=BD Ope=
nVPN (at community.openvpn.net)
(21:28:25) mattock: waldner: you were faster than me
(21:28:26) mattock: :)
(21:28:29) dazo: cron2:  yeah, the trac wiki is a bit different, but simple=
r than mediawiki ... but mediawiki differs also, depending on installed mod=
ules etc, etc ... as the trac wiki .... anyhow the trac wiki is really simp=
le in formatting right now
(21:28:41) krzee: !learn wikiformatting as https://community.openvpn.net/op=
envpn/wiki/WikiFormatting to see info on wiki formatting
(21:28:41) vpnHelper: krzee: Error: You don't have the factoids.learn capab=
ility. If you think that you should have this capability, be sure that you =
are identified before trying again. The 'whoami' command can tell you if yo=
u're identified.
(21:28:44) krzee: heh
(21:28:52) dazo: krzee:  is even smarter!
(21:28:57) cron2: I'll give it a try and ask mattock or dazo if I get stuck=
 :)
(21:29:01) krzee: !learn wikiformatting as https://community.openvpn.net/op=
envpn/wiki/WikiFormatting to see info on wiki formatting
(21:29:02) vpnHelper: krzee: Joo got it.
(21:29:03) dazo: :)
(21:29:34) krzee: (the factoids here are separate from ##openvpn)
(21:29:36) ecrist: cron2/all: if you 'move' an article from SCN to the 'off=
icial' wiki, do not delete it from SCN, simply mention at the top the artic=
le has moved, please.
(21:30:06) mattock: krzee, ecrist: are you content with the current backups=
 from community.openvpn.net?
(21:30:13) mattock: or do you want full system backups?
(21:30:14) cron2: ecrist: ok
(21:30:51) ***ecrist looks
(21:31:24) krzee: i dont know specifics about the backups, so i differ to e=
crist=20
(21:31:29) krzee: defer*
(21:32:11) krzee: im just glad they exist =3D]
(21:32:35) mattock: in two places actually...
(21:32:44) mattock: our own backup server and mr.garrison
(21:32:52) ecrist: cursory glance, they look OK
(21:33:59) mattock: ok
(21:34:12) krzee: so that covers that topic i believe
(21:34:17) mattock: +1
(21:34:30) cron2: +1
(21:34:30) mattock: although testing the backups would be beneficial anyways
(21:34:37) mattock: but lets save that for later
(21:34:54) mattock: so next topic would be buildbot
(21:35:04) mattock: I wrote some questions/ideas to the topic page
(21:35:18) mattock: "How to inform developers of build successes/warnings/f=
ailures?"
(21:35:25) krzee: an IRC bot in this channel gets my vote
(21:35:34) mattock: krzee: good idea
(21:35:41) mattock: is it enough?
(21:35:44) cron2: mmmh, warnings can be quite lengthy
(21:35:54) mattock: or do we want a mail notifier, too?
(21:36:01) krzee: cron2, privmsg for more detail?
(21:36:26) dazo: I'd say it's not enough ... developers might not be on irc=
 when a failure happens ... but irc as a supplement to e-mail gets my vote
(21:36:27) mattock: cron2: I think it's possible to customize the IRC warni=
ng... at least email notifications can be customized
(21:36:32) cron2: mattock: I think we could combine it - mail notifier for =
build failures, and IRC bot with privmsg for everythign
(21:36:53) mattock: +1 for using both IRC and email
(21:37:11) cron2: failures should be sufficiently infrequent that it warran=
ts a mail
(21:37:31) cron2: .oO(and whoever caused the build failure has to buy a rou=
nd of beer)
(21:37:38) mattock: should we have a separate openvpn-build mailinglist for=
 the build failures?
(21:37:49) ecrist: how about an RSS feed, which an IRC bot could monitor?
(21:38:06) mattock: cron2: buildbot can detect who messed up and "blame" th=
at developer
(21:38:06) cron2: ecrist: that would work for me as well
(21:38:08) mattock: :)
(21:38:25) dazo: actually the irc notification don't need to be verbose ...=
 just a link to the web page with the error
(21:38:31) mattock: ecrist: that's doable, but would require writing a cust=
om notifier module in Python
(21:39:02) cron2: mattock: dunno about the extra mailinglist - no strong op=
inion for "new list" or "on openvpn-devel"
(21:39:44) mattock: I think the "new list" vs. "openvpn-devel" depends on h=
ow often build failures occur... there are ~500 people on -devel and 490 of=
 them are not interested in receiving build failure notifications
(21:39:47) ecrist: I vote for RSS, it's pretty simple to write.
(21:39:55) cron2: mattock: yes.
(21:40:30) mattock: ecrist: why not just use the build-in IRC notifier in b=
uildbot?
(21:41:14) mattock: oh, there _is_ RSS support in buildbot
(21:41:18) mattock: let's see...
(21:41:32) mattock: "/rss This provides a rss feed summarizing all failed b=
uilds. The same query-arguments used by 'waterfall' can be added to filter =
the feed output."
(21:41:40) mattock: so a RSS feed is available from the web interface
(21:42:03) cron2: perfect
(21:42:11) cron2: now that one was easy :-) - next topic? :))
(21:42:28) mattock: cron2: +1
(21:42:32) mattock: which is still related to buildbot :)
(21:42:33) ecrist: supybot already does RSS reading, so that's done, too
(21:42:41) mattock: ecrist: great!
(21:42:48) mattock: "Should we limit access to the buildbot web interface?"
(21:42:51) ecrist: all kinds of win today
(21:43:09) cron2: mattock: I'd go for "limit access" - if nobody needs it, =
no need to provide attack surface
(21:43:20) dazo: cron2++
(21:43:51) cron2: as for the specifics, no opinion
(21:43:52) mattock: I agree that we should limit access somehow...
(21:44:15) mattock: if we could use BASIC AUTH and the LDAP credentials the=
n that'd be nice
(21:44:30) mattock: not too bureaucratic, but still provides some protection
(21:44:44) mattock: although not against targeted attacks
(21:44:47) cron2: can we https that (so no auth sniffing)?
(21:44:55) mattock: cron2: we definitely should
(21:45:10) mattock: I don't want the LDAP credentials going anywhere in pla=
in text
(21:45:22) cron2: +1, then
(21:45:44) mattock: ok, I'll check if that's doable...
(21:45:52) mattock: any other opinions on this matter?
(21:46:03) dazo: mattock:  BASIC AUTH against LDAP over https sounds reason=
able
(21:46:15) ecrist: why not setup a vpn (I hear openvpn is pretty good) for =
community members for the build system and those other back-end systems?
(21:46:30) mattock: ecrist: that's one good option, too :)
(21:46:46) dazo: true ... could even use auth-ldap for user/pass authentica=
tion and not use client certs
(21:46:54) cron2: this openvpn thing is so complicated... *duck*
(21:47:02) mattock: :)
(21:47:05) ecrist: crap, this is all starting to make sense.
(21:47:36) dazo: heh
(21:47:37) mattock: openvpn + ldap auth would be nice, as long as we don't =
allow "random" people access to the VPN
(21:47:41) cron2: seriously - I find https+auth more convenient for occasio=
nal access to a web(!) site
(21:48:14) cron2: otherwise I'd have to start openvpn, enter credentials, o=
pen web browser, enter credentials again (so the web site knows who I am)
(21:48:19) ecrist: you were the one that brought up attack vectors.
(21:48:34) dazo: that's true ... but on the other hand, implementing openvp=
n makes us also eat our own dog food
(21:48:46) mattock: cron2: I guess that depends on how "heavy" user of the =
OpenVPN community services you are... for occasional access BASIC AUTH _is_=
 more convenient
(21:48:56) mattock: dazo: +1 to eating our own dogfood
(21:49:19) cron2: ecrist: yes, I wouldn't want a random script suite access=
ible on the "naked internet" - but I tend to trust Apache to get SSL+AUTH r=
ight without security issues
(21:49:31) cron2: but of course "eat own dogfood" is a valid argument
(21:49:39) mattock: but then again, there's nothing stopping us from doing =
both (OpenVPN + LDAP and BASIC AUTH + LDAP)
(21:49:41) ***cron2 wants IPv6 on these servers
(21:50:09) cron2: mattock: you would need both, no?  Otherwise the web serv=
er wouldn't know who the user is
(21:50:11) mattock: cron2: I think they do support IPv6, they're Debian
(21:50:26) cron2: :)
(21:50:33) dazo: cron2:  that's also why I suggested without client certs, =
only --auth-user-pass .... just to avoid needing client certificates to avo=
id installing certs on all machines we may use
(21:50:35) mattock: cron2: oh yes
(21:50:49) cron2: dazo: yes, understood that, +1
(21:51:06) mattock: is everybody ok with OpenVPN access?
(21:51:17) mattock: and no separate authentication in BuildBot?
(21:51:47) cron2: no objections
(21:51:53) dazo: from the peek view I've had on BuiltBot ... I don't see an=
y issues
(21:52:03) mattock: that's easier for me, too... don't have to SSL-enable s=
ome random Python webserver (Twisted)
(21:52:36) mattock: anybody familiar with OpenVPN LDAP integration? Can we =
easily limit access by LDAP group or something?
(21:52:38) cron2: ok, I thought this was using a standard apache(etc) as we=
b facing server
(21:52:47) mattock: cron2: nope
(21:52:48) cron2: in that case - yes, go with OpenVPN
(21:52:58) mattock: and "testing" version of course :)
(21:53:04) mattock: with cron2's IPv6 stuff
(21:53:27) dazo: +1
(21:53:28) cron2: +128
(21:53:35) cron2: \o/
(21:53:35) dazo: haha
(21:53:43) mattock: oh, 129 ACK's :)
(21:53:51) mattock: ok, next topic?
(21:54:03) mattock: "What setup do we want to use to trigger builds?"
(21:54:03) ***cron2 installed ecrist's openbsd-testing port on the corporat=
e openvpn server today... "works" :-)
(21:54:15) cron2: (just as a side note)
(21:54:31) cron2: mattock: you skipped one :) - but anyway
(21:54:40) krzee: hey cool i didnt know ecrist maintained an openbsd port t=
oo
(21:54:41) mattock: cron2: good point
(21:54:50) mattock: "Where do we get the BuildSlaves?"
(21:55:06) mattock: please read the background section before commenting :)
(21:55:06) cron2: krzee: it's in the official ports tree!
(21:55:09) dazo: After having though about build triggers ... I think e-mai=
l trigger makes sense if we enable sending commits to an e-mail list when I=
 push stuff to the repository
(21:55:09) mattock: in the topic page
(21:55:45) mattock: should we have a separate commit list? or is -devel eno=
ugh?
(21:55:52) krzee: the buildslaves could all be virtual machines
(21:55:57) cron2: regarding triggers: since dazo maintains the git tree, I =
think that this is really something for dazo and mattock to figure out
(21:56:02) ecrist: krzee: I don't, they share ports between the BSDs
(21:56:11) krzee: ecrist, ahh coolness
(21:56:19) dazo: mattock:  I think that should go to an own -commit list, t=
bh
(21:56:33) mattock: ecrist: that's nice - we have "testing" for OpenBSD too=
=20
(21:56:41) mattock: with zero effort
(21:56:51) ecrist: and netbsd
(21:56:55) dazo: neat!
(21:57:00) krzee: if only the linux's did stuff like that ;)
(21:57:07) cron2: ecrist: netbsd users ports?  I have only seen pkgsrc there
(21:57:07) dazo: heh
(21:57:26) cron2: (no openvpn-devel in pkgsrc yet)
(21:57:42) ecrist: I think a ports tree is installable on netbsd, iirc
(21:57:43) cron2: s/users/uses/
(21:57:44) mattock: dazo: so will the SF.net git send the mail to -commits?
(21:58:08) dazo: mattock:  if we add a one of those mailer scripts we looke=
d at, yes it will
(21:58:10) ecrist: so SF.net git have RSS?
(21:58:17) cron2: regarding buildslaves: I think for the i386/amd64 operati=
ng system variants, virtual machines should be fine
(21:58:18) ecrist: s/so/does/
(21:58:24) mattock: ecrist: don't know, could be
(21:58:28) dazo: ecrist:  yeah, should be some kind of RSS feed, iirc
(21:58:47) krzee: even osX can be run in a VM
(21:58:48) cron2: we might want to have a few non-i386 buildslaves, like "S=
olaris10/Sparc64" (different byte order!)
(21:58:50) dazo: http://openvpn.git.sourceforge.net/git/gitweb.cgi?p=3Dopen=
vpn/openvpn-testing.git;a=3Drss;opt=3D--no-merges
(21:58:52) vpnHelper: Title: SourceForge - openvpn/openvpn-testing.git/rss =
logSourceForge - openvpn/openvpn-testing.git/rss logFixed issue where bad c=
reds provided by the management interface (at openvpn.git.sourceforge.net)
(21:59:10) mattock: ecrist: you said supybot supports RSS feeds... does it =
live in a place where it can access BuildBot through an OpenVPN tunnel?
(21:59:20) dazo: http://openvpn.git.sourceforge.net/git/gitweb.cgi?p=3Dopen=
vpn/openvpn-testing.git;a=3Drss;h=3Drefs/heads/allmerged;opt=3D--no-merges =
 (this is allmerged)
(21:59:22) vpnHelper: Title: SourceForge - openvpn/openvpn-testing.git/rss =
- 'refs/heads/allmerged' branch logSourceForge - openvpn/openvpn-testing.gi=
t/rss - 'refs/heads/allmerged' branch logFixed static defined length check =
to use sizeof() (at openvpn.git.sourceforge.net)
(21:59:30) krzee: ya its on butters (my box) in ecrist's house
(21:59:47) mattock: cron2: +1 on virtual machines
(21:59:55) krzee: and i have no problem with that tunneling to buildbot
(21:59:57) cron2: dazo: cool
(22:00:07) mattock: however, I think the core community members could be tr=
usted to provide additional architectural coverage
(22:00:19) dazo: mattock:  could we make buildbot read RSS?
(22:00:25) mattock: let me check
(22:00:38) dazo: (for build triggers, that is)
(22:00:49) cron2: dazo: do you want to have it build after every single com=
mit?  you might have transient trees that are known to fail building
(22:01:02) mattock: dazo: I don't think so... only reference to RSS is the =
RSS view in web interface
(22:01:15) mattock: cron2: you mean temporarily broken trees?
(22:01:17) dazo: cron2:  no, not after each commit ... that's waste ... as =
a push might have many commits
(22:01:36) krzee: dazo, doesnt sound too hard to write a script to trigger =
buildbot from RSS input
(22:01:42) cron2: mattock: yes, like "this feature needs 4 commits to compi=
le", so there are commits that shouldn't trigger a build
(22:01:46) cron2: dazo: exactly
(22:01:50) mape2k [~mape2k@...1306...:6f8:133b:0:21f:3bff:fe27:21a9] =EF=BF=
=BD=EF=BF=BD entrato nel canale.
(22:01:52) mattock: cron2: that's been taken care of by buildbot
(22:02:02) dazo: mattock:  oki ... maybe rather lookup something which can =
parse RSS for buildbot is an even better solution
(22:02:27) mattock: buildbot can be configured to wait after a commit to se=
e if anything else is coming in soon (e.g. in 5 minutes)
(22:02:28) krzee: OR
(22:02:34) krzee: a bot in here could trigger it
(22:02:38) krzee: !build
(22:02:39) vpnHelper: krzee: Error: "build" is not a valid command.
(22:02:41) krzee: heh
(22:02:42) mattock: buildbot can be extended easily if one knows python
(22:02:42) cron2: heh :)
(22:03:13) mattock: even the config file is plain python
(22:03:13) dazo: and python isn't that hard even
(22:03:33) mattock: agreed, even I have written some semi-complex stuff in =
python a few years back
(22:03:34) krzee: if vpnHelper is reading buildbot's RSS, he is already tun=
neled to buildbot, maybe we could make him trigger the building
(22:03:39) krzee: he is also python
(22:04:01) dazo: krzee:  sounds doable!
(22:04:04) krzee: (yes, its a male)
(22:04:41) mattock: krzee: but then vpnHelper would have to monitor the com=
mits
(22:04:51) krzee: not if we have !build
(22:05:04) krzee: oh but you mean automated, i see
(22:05:14) mattock: krzee: yes, automatically triggered builds
(22:05:17) dazo: krzee:  there is an API which buildbot uses, which the git=
 plugin trigger uses ... so we even have the python code for trigging it
(22:05:27) mattock: buildbot can do periodic builds, too (e.g. nightly snap=
shots)
(22:05:57) mattock: builds can also be triggered from the web interface
(22:06:38) mattock: we don't want to make triggering the build too easy or =
some funny guy would probably fill buildbot with build requests
(22:06:39) mattock: :)
(22:06:54) mattock: DOS all of the buildslaves
(22:07:33) mattock: I think we had two viable options:
(22:07:59) mattock: - make buildbot read commits from RSS feeds (needs pyth=
on hacking)
(22:07:59) mattock: - create a -commits mailinglist and make buildbot read =
that=20
(22:08:08) mattock: the second option works out of the box
(22:08:22) krzee: ohhh
(22:08:23) mattock: or should work
(22:08:39) krzee: second option sounds good even if it wasnt just for build=
bot
(22:09:04) mattock: do we want -commits list anyways?
(22:09:11) krzee: [11:58]  <dazo> mattock:  I think that should go to an ow=
n -commit list, tbh
(22:09:18) ***ecrist votes (again) for RSS
(22:09:56) mattock: I have no strong opinion if somebody else takes care of=
 the python code for buildbot :)
(22:10:05) mattock: for RSS support
(22:10:13) dazo: I honestly don't see any particular reasons for a commit l=
ist .... after all, we have the commits in -devel already, and in the git l=
og ... so it seems just to duplicate and generate extra not needed data
(22:10:33) krzee: oh ok i misunderstood earlier then
(22:10:43) krzee: and i dont even commit patches, lol
(22:10:44) dazo: but -commit list seems to be the easiest to implement, tho=
ugh
(22:11:04) krzee: so RSS sounds like a winner, assuming someone here knows =
python
(22:11:31) krzee: i wouldnt be opposed to learning it for this if i wasnt s=
o swamped with work
(22:11:40) dazo: mattock:  what about to check out if someone already have =
written some RSS parsers for buildbot?
(22:11:51) mattock: krzee: I got the same problem
(22:11:54) mattock: dazo: I can do that
(22:12:21) cron2: hah, work.  I'd love to have time work work :-)  *juggle =
child to other shoulder* :))
(22:12:32) dazo: mattock:  perfect!
(22:12:35) cron2: s/work work/for work/
(22:13:21) mattock: ok, so let's try the RSS route and see how difficult it=
 becomes
(22:13:38) mattock: I think that concludes our BuildBot section today...
(22:14:01) mattock: dazo: does the Beta2.2 branch discussion require James'=
 presence?
(22:14:34) krzee: cron2, im migrating a phone system, network, database, co=
nfiguring a complicated application... with about a week to finish
(22:14:36) krzee: ;]
(22:15:17) mattock: krzee: you can always work both days and nights :)
(22:15:17) cron2: krzee: I know how these weeks feel ;-)
(22:15:21) mattock: to gain some time
(22:16:02) krzee: mattock, i do when possible, but i need to coordinate wit=
h phone companies a software company, and another company along the way
(22:16:13) krzee: anyways, sorry for that, back to business
(22:16:29) cron2: well, we're waiting for dazo to comment on this agenda it=
em anyway :)
(22:16:30) mattock: oh, I see... there's communication involved. That makes=
 things much more difficult :)
(22:16:36) mattock: dazo... :D
(22:16:39) ***dazo is back
(22:16:45) mattock: we've been expecting you
(22:17:24) mattock: dazo: does the Beta2.2 branch discussion require James'=
 presence?
(22:17:25) dazo: well, I'm just wondering if James is happy about the SVN b=
ranch I pushed out .... this push did completely rewrite all commits I merg=
ed into the beta2.2 branch
(22:18:13) dazo: setting me as the author of all commits (even the very old=
 ones from James) ... but on the other hand, I don't think there's much way=
 around this, as this is how SVN works as it is centralised and not distrib=
uted
(22:18:42) mattock: James has not responded anything... I assume he's busy =
pushing out new Access Server
(22:19:33) mattock: dazo: so the issue is that it's you that commits the ch=
anges to SVN repo? Even though the original git commits were made by variou=
s people?
(22:19:34) mape2k ha abbandonato il canale (quit: Read error: Operation tim=
ed out).
(22:19:39) dazo: might be ... so, I really need to hear his opinion about t=
his and even how a merge from his side would work out
(22:19:43) krzee: oh right, sorry i still havnt played with AS
(22:20:01) krzee: its a pima needing linux and windows for it, since i dont=
 use either one normally
(22:20:29) mattock: perhaps we could just use git for the beta2.2 branch an=
d pull James' stuff from his SVN...
(22:20:37) mattock: although I think we discussed that in an earlier meeting
(22:20:38) dazo: well, actually the branch James gave me was completely emp=
ty ... so when I did a git svn dcommit (pushing to SVN) ... git published a=
ll commits individually to the SVN branch, which I would say sounds correct
(22:20:40) vpnHelper: Announcement from my owner (ecrist): #openvpn-devel h=
ttp://openvpn.git.sourceforge.net/git/gitweb.cgi?p=3Dopenvpn/openvpn-testin=
g.git;a=3Drss;opt=3D--no-merges
(22:21:10) dazo: but  all those commits goes all the way back to the first =
beta 2.1 commits
(22:22:03) dazo: but this time with me as the author and not James ... whic=
h is logical, as I am the one pushing these commits .... but this is the we=
akness of SVN, it doesn't migrate or keep the original author of commits, o=
nly the one performing the commits
(22:22:17) dazo: (when committing, that is ... merging is something else)
(22:22:33) mattock: does it matter that the original committer is lost?
(22:22:48) dazo: so my worry is that this may confuse SVN when James merges=
 my branch into his beta 2.2 branch
(22:23:52) dazo: another approach would be that James gives me a branch whi=
ch is based on his last BETA21 branch ... I pull that branch, merges in the=
 changes for from -testing, and then pushes it to SVN ... then only the add=
itional patches are pushed out
(22:23:56) mattock: dazo: so it's a SVN branch, not another SVN repository?
(22:24:11) dazo: it's a branch, how I could understand it
(22:25:29) dazo: (but an empty one)
(22:25:55) dazo: (initially, that is)
(22:26:07) mattock: I think merges in SVN should work properly even if you'=
re the committer
(22:26:11) mattock: in beta2.2
(22:26:30) mattock: I don't think SVN uses the committer username for anyth=
ing, really
(22:26:32) dazo: I hope so ... but I cannot say for sure
(22:27:21) mattock: as long as git trees are kept clean from the commits pu=
shed to SVN beta2.2 we _should_ be fine=20
(22:27:37) dazo: another issue here is that each of those old commits are n=
ow duplicated in the SVN history ... one in (original one) in the BETA21 br=
anch, and the same commit (with only different commiter) in my SVN branch, =
but with different revision numbers
(22:27:41) mattock: =3Donly push from git to SVN beta2.2, not the other way=
 around
(22:28:06) mattock: oh, that's nasty
(22:28:11) dazo: well, that's the issue ... when I pushed the SVN beta2.2 b=
ranch, also my git commits got modified .... and *that* I am not so happy a=
bout
(22:28:19) cron2: I think using a pre-populated branch would be happier
(22:28:27) dazo: I have that feeling as well
(22:29:04) mattock: I think we should ask James what to do... it's his SVN =
repo, after all
(22:29:11) mattock: too bad he did not make it today
(22:29:19) dazo: so that's why I'm wondering if we should "go back to start=
", get my branches scratched, merge again and push against a pre-populated =
branch instead
(22:29:38) mattock: personally I think we could/should just use git for bet=
a2.2
(22:29:44) mattock: unless James has strong feelings about that
(22:30:37) dazo: that could really work out better .... but I don't want to=
 push James in any directions, and if he's loaded now with stuff I understa=
nd he's not willing/interested to look at new things right now
(22:30:59) dazo: and James really do need to want to do such a change prima=
rily
(22:31:24) mattock: yep
(22:31:53) mattock: so is it "wait what James has to say"?
(22:32:09) cron2: feels like it
(22:32:11) mattock: perhaps dazo could send him email?
(22:33:05) dazo: Well, I think I kind of put him explicitly on Cc on the an=
nounce mail
(22:33:16) mattock: oh
(22:33:29) mattock: I assume he's just really busy right now
(22:35:40) mattock: I think we should bombard him with emails early next we=
ek
(22:35:41) dazo: well, I can clean up the git branch completely ... ignore =
the SVN branch for now ... and we can continue preparing and testing the be=
ta2.2 branch in the community, and when James got time to look at it, we co=
uld then discuss how to get it into his SVN tree ... or if he would want to=
 switch to git, he is welcome to do so to ... but if he don't have time to =
interact too much now, I'm not sure we should halt too long
(22:36:07) mattock: I agree we should move on
(22:36:24) mattock: work in Git for now, explain the situation to James and=
 see what he thinks
(22:36:36) mattock: on reason to stop progress due to SVN issues
(22:36:42) mattock: no reason...
(22:36:53) dazo: I'll rename the current branch ... and then start from scr=
atch in git then
(22:37:23) mattock: ok, are we done for today?
(22:37:28) mattock: or is there something else?
(22:38:22) ***cron2 is fine
(22:38:26) ***dazo too
(22:38:49) mattock: the rest of the guys are passive, so I take that as a "=
I'm fine" :)
(22:39:02) mattock: I'll write summary tomorrow
(22:39:07) mattock: good meeting again!
(22:39:16) dazo: thx a lot!
(22:39:21) mattock: good night everyone!
(22:39:21) cron2: thx

--------------020409010308060200080905--

