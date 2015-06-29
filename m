Message-ID: <5591A0C4.3000803@...515...>
Date: Mon, 29 Jun 2015 22:47:16 +0300
From: =?ISO-8859-15?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
MIME-Version: 1.0
References: <5591170F.2020608@...515...>
In-Reply-To: <5591170F.2020608@...515...>
Content-Type: multipart/mixed; boundary="------------090006020105090606080409"
Subject: Re: [Openvpn-devel] Topics for today's (Monday,
 29th June 2015) community meeting
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
--------------090006020105090606080409
Content-Type: text/plain; charset="iso-8859-15"; format=flowed
Content-Transfer-Encoding: quoted-printable

Hi,

Here's the summary of the previous IRC meeting.

---

COMMUNITY MEETING

Place: #openvpn-devel on irc.freenode.net
Date: Monday 29th June 2015
Time: 20:00 CET (18:00 UTC)

Planned meeting topics for this meeting were on this page:

<https://community.openvpn.net/openvpn/wiki/Topics-2015-06-29>

Next meeting is scheduled to two weeks from now:

<https://community.openvpn.net/openvpn/wiki/Topics-2015-07-13>

Your local meeting time is easy to check from services such as

<http://www.timeanddate.com/worldclock>;

SUMMARY

cron2, mattock and syzzer participated in this meeting.

---

Discussed replacing openvpnserv.exe with NSSM. Everybody was ok with the=20
plan of (mattock) writing a HTML application (.hta) that allows=20
simplified management of nssm+openvpn. Technically this application will=20
combine some HTML with Javascript and Windows Script Host (shell)=20
commands to produce a simple OpenVPN-specific NSSM configuration GUI.

---

Discussed the recent malicious project file modifications by SourceForge:

<https://notepad-plus-plus.org/news/notepad-plus-plus-leaves-sf.html>
<https://mail.gnome.org/archives/gimp-developer-list/2015-May/msg00144.html>

As our project does not host (recent) files on SF.net we don't _need_ to=20
leave immediately. However, the old (obsolete) files that we have lying=20
around in SF.net should be deleted unless we can disable the "Files"=20
feature in SF.net altogether. Mattock will take care of this.

We will for now continue using the SourceForge.net mailing lists. If=20
SF.net continues its malpractices we can easily export subscriber lists=20
and move our mailing list hosting elsewhere.

---

Moved tickets to appropriate milestones. It was noted that there were=20
plenty of Windows tickets that will get fixed by

- The Interactive Service (various permission-related issues)
- NSSM integration (various suspend/hibernate/startup issues)

Not all "release 2.4" tickets could be categorized and the work will=20
continue outside the meeting.

---

Full chatlog is attached.

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock


--------------090006020105090606080409
Content-Type: text/plain; charset=UTF-8;
	name="openvpn_irc_meeting_chatlog_2015-06-29.txt"
Content-Disposition: attachment;
	filename="openvpn_irc_meeting_chatlog_2015-06-29.txt"
Content-Transfer-Encoding: quoted-printable

(21:01:03) mattock: oh, we forgot to cover these topics: https://communit=
y.openvpn.net/openvpn/wiki/Topics-2015-06-29
(21:01:05) vpnHelper: Title: Topics-2015-06-29 =E2=80=93 OpenVPN Communit=
y (at community.openvpn.net)
(21:01:31) mattock: so we have cron2 and syzzer here
(21:01:34) mattock: who else?
(21:03:17) ***cron2 sees a number of mattocks
(21:04:11) mattock: yes, the other one won't be of much help
(21:04:29) mattock: shall we cover the discussion topics (2 and 3) first?
(21:04:49) syzzer: fine by me
(21:05:17) mattock: #2 is mostly about "does anyone get offended of a HTM=
L app bundled with OpenVPN Windows installer?"=20
(21:05:39) ***cron2 now understands why so much commercial software uses =
html frontends :)
(21:05:56) mattock: the alternatives look pretty grim, and writing HTML +=
 Javascript/VBScript apps seems the de facto standard on Windows
(21:05:56) cron2: works for me...
(21:06:42) mattock: ok, good
(21:06:51) mattock: I'll do a PoC in the next few weeks
(21:06:52) ***cron2 has *no* idea how to do that and would likely go figh=
t c#, but then, my C is better than my JavaScript :)
(21:06:57) syzzer: yes, no compliants
(21:07:07) cron2: and I will look very interested at what you'll produce =
- always willing to learn
(21:07:16) mattock: I've never written Javascript but it seems pretty str=
aighforward
(21:07:30) cron2: *sigh* gmane broken, I can't get an URL for plaisthos' =
bugfix
(21:07:45) mattock: I've never written C# either so I'd gain nothing ther=
e, plus I'd need to learn Windows GUI programming :|
(21:07:52) mattock: yeah, gmane has sucked quite a bit lately
(21:08:01) mattock: anyways, topic #3 is "SourceForge's modifications of =
project files"
(21:08:13) mattock: I assume you've heard of this
(21:08:29) syzzer: yes, sucks. time to leave sf
(21:08:31) cron2: we've briefly discussed this here 1-2 weeks ago, I thin=
k while you were sailing
(21:08:38) mattock: ah
(21:08:49) mattock: so what do you think?
(21:09:06) mattock: the only real problem in leaving SF.net are the maili=
ng lists
(21:09:09) cron2: dazo and I were more opinioned of "just leave the stuff=
 where it is for now", as there is nothing crucial there - like, no windo=
ws installers they could mess with, and the git repo is also at github
(21:09:27) mattock: there are some really old openvpn tarballs I believe
(21:10:02) cron2: we could move the lists elsewhere, but halfway reasonab=
le list anti-spamming is *WORK*.
(21:10:06) syzzer: I agree there is no need to leave in a rush
(21:10:12) mattock: yeah
(21:10:27) mattock: what I could do is disable the "Files" feature in the=
 project
(21:10:40) mattock: the "latest" file in there is openvpn 1.6.3 rpm
(21:10:40) cron2: that makes sense, we have no files there anymore
(21:10:43) cron2: lol
(21:10:51) cron2: what century was that released?
(21:11:08) mattock: probably in the late Middle Ages
(21:11:29) mattock: actually there are quite a few files there: https://s=
ourceforge.net/projects/openvpn/files/OldFiles/
(21:11:32) vpnHelper: Title: OpenVPN - Browse /OldFiles at SourceForge.ne=
t (at sourceforge.net)
(21:11:49) mattock: including Windows installers which SF.net could pollu=
te
(21:12:22) cron2: there actually is a 2.0_beta1
(21:12:36) syzzer: oh, wow!
(21:13:03) syzzer: right around the time of 'git epoch'
(21:13:04) cron2: wow indeed, 1.0.tar.gz
(21:13:08) cron2: 2002-03-24
(21:13:26) cron2: mattock: I hope you have copies of that stuff?  I think=
 these need to be preserved in the company museum
(21:14:40) syzzer: so, back-up all files and see if they can be removed f=
rom sf?
(21:14:57) syzzer: they are still generating downloads: http://sourceforg=
e.net/projects/openvpn/files/OldFiles/openvpn-2.0_rc18-install.exe/stats/=
timeline
(21:14:58) vpnHelper: Title: Download Statistics: OldFiles/openvpn-2.0_rc=
18-install.exe (at sourceforge.net)
(21:15:03) mattock: I'll check if we have those somewhere else
(21:15:24) mattock: wow, 20-40 downloads a day
(21:15:44) cron2: the fact that people are still downloading them is a ba=
d sign, so they are not finding the new stuff -> away with it (and maybe =
have the very latest .tar.gz + signature only?)
(21:15:59) syzzer: yes, and that's not just bots, because only 'the newes=
t' has these numbers of downloads
(21:16:21) mattock: ok, I can't get rid of Files completely right now
(21:16:22) mattock: -> todo
(21:17:07) cron2: who is Benjamin Gatti?  (klicking on "jimyonan" leads t=
o the "vertical windmills project", which looks totally awesome in a tota=
lly different way :) )
(21:19:31) syzzer: heh, indeed
(21:20:58) mattock: I have no clue who Benjamin Gatti is
(21:20:59) syzzer: so files are on the todo. what about the mailing lists=
? should we start looking for alternatives? i guess that moving the list =
is going to be tough...
(21:21:10) mattock: yeah, it would be painful
(21:21:27) mattock: also for our users unless we think of some really fan=
cy migration strategy
(21:22:24) mattock: actually, I'll check if we could export the user data=
 from mailmail
(21:22:27) mattock: mailman :)
(21:22:45) cron2: normally the list owner should be able to get a subscri=
ber list
(21:23:29) cron2: forgot to explicitely state it before: I do not have st=
rong feelings either way today - if they do not get worse, I'm fine to st=
ay, if you all distrust them enough, I'm fine to move on.
(21:23:34) mattock: yeah, I can get subscriber lists
(21:23:49) cron2: our most valuable stuff is "git" and "windows installer=
s" and I do not see acute danger there
(21:23:51) mattock: I'm fine with staying for now, as I'm lazy and have o=
ther things to do
(21:24:09) mattock: technically we could move the mailing lists elsewhere=
 with some effort
(21:24:43) syzzer: ok, lets leave it like this for now
(21:24:44) mattock: so "disable files, wait and see what stupid SF.net do=
es next"
(21:24:50) cron2: +1
(21:25:00) syzzer: yes
(21:25:09) mattock: if the Files feature can't be disabled I can probably=
 delete all the existing files
(21:25:18) mattock: (after addding them to the company museum)
(21:26:02) mattock: move on topic #4?
(21:26:56) cron2: what is this windows stuff you're talking about?
(21:27:11) mattock: its the most loved and used operating system on deskt=
op computers
(21:27:34) mattock: https://community.openvpn.net/openvpn/ticket/399
(21:27:36) vpnHelper: Title: #399 (Issue with register-dns in Windows 8.1=
) =E2=80=93 OpenVPN Community (at community.openvpn.net)
(21:27:48) cron2: mattock1: used maybe, loved, certainly not :)
(21:27:58) mattock: "Child processes are executed non elevated. Which is =
a problem."
(21:28:04) mattock: yeah :P
(21:28:18) mattock: I believe the meat of ticket #399 is ^^^
(21:28:18) cron2: looking at #516 right now, and that really seems to be =
"openvpn is just not running with admin privs"
(21:28:42) cron2: so it would go away with the iservice, or by running op=
envpn from service/nssm, or by running the gui as admin
(21:28:45) cron2: done
(21:29:08) cron2: the fact that openvpn is able to configure an IP addres=
s on the tap interface if not running privileged is actually a bug in my =
eyes
(21:29:31) cron2: (because it hides the fact that it's lacking the needed=
 privileges to do stuff like "setup routing" etc)
(21:29:40) cron2: *and* the fact that "install IPv4 routes" fail silently
(21:29:59) cron2: remedy: get the iservice up and running as quickly as p=
ossible
(21:31:40) mattock: iService will be a remedy for many bugs
(21:31:50) mattock: bugs/annoyances
(21:31:56) ***syzzer wakes up again
(21:32:02) syzzer: right, iservice
(21:32:09) cron2: thought we'd scared you away :)
(21:32:37) syzzer: no, just in need of coffee
(21:33:41) syzzer: I'll have to invest a bit more in doing proper windows=
 builds, but this Sebastian guy suddenly kept me busy ;)
(21:33:56) cron2: yeah, a bit of it spilled over :-)
(21:34:06) cron2: mattock1: as a side note, could you point #565 at james=
?
(21:35:30) mattock: just a sec
(21:36:18) mattock: I've actually pointed James at the "OpenVPN Technolog=
ies, Inc products" report in Trac a while back
(21:36:29) mattock: I have no clue if he looks at it or not, but he shoul=
d
(21:36:47) mattock: I assigned the ticket to him, so he should receive an=
 email
(21:36:59) cron2: yeah, but that one looks like it needs a bit of attenti=
on - if Connect crashes OSX 10.10.3, you'll hear more about that
(21:37:07) cron2: thanks anyway
(21:37:21) mattock: I can poke at him, but don't expect miracles :P
(21:38:31) cron2: yeah :)
(21:39:11) mattock: sent email
(21:39:30) cron2: the version selector field in trac is so totally misord=
ered...
(21:39:35) ***cron2 wonders what makes that happen
(21:40:04) cron2: mattock1: oh, and what about #395?
(21:40:38) syzzer: yeah, I was looking at that one too
(21:41:18) mattock: are you referring to https://community.openvpn.net/op=
envpn/ticket/395#comment:8 ?
(21:41:20) vpnHelper: Title: #395 (Evaluating quoted path & file config s=
tatements syntax (Win32)) =E2=80=93 OpenVPN Community (at community.openv=
pn.net)
(21:41:31) cron2: I was wondering why it's still on milestone 2.3.7
(21:41:53) mattock: hmm
(21:42:01) mattock: didn't we take care of that ticket already?
(21:42:32) cron2: " I'll also create a separate tickets for the connectio=
n block issue."
(21:42:50) cron2: so, I think, this is what is left to do :) - and refere=
nce and close it
(21:43:05) cron2: won't decrease the number of open tickets, but will cle=
an milestone 2.3.7 :)
(21:43:51) mattock: there is no connection block bug report? I can take c=
are of that...
(21:44:08) cron2: as far as meeting topic #4 goes - I think there really =
is no way to "fix" this without the iservice (or installing openvpngui to=
 run with increased privileges, but d12fk always vouches against that)
(21:44:53) mattock: which brings us to topic #1 which probably includes i=
Service also
(21:45:21) cron2: so which tickets do you want us to categorize?
(21:46:11) cron2: "milestone 2.4"?
(21:46:32) mattock: yeah, basically clean up any ticket mess there might =
be
(21:46:58) mattock: to get an idea what is missing from the first 2.4 alp=
ha
(21:47:24) mattock: let's see what milestones we have in Trac...
(21:47:34) cron2: the big things are not really there yet - iservice, rou=
te-gateway for ipv6
(21:47:53) cron2: AEAD is there, but what should it be?
(21:48:19) mattock: so we have "alpha 2.4", "beta 2.4", "rc 2.4" and "rel=
ease 2.4"
(21:48:33) mattock: all the big stuff should probably go into "alpha 2.4"
(21:48:53) cron2: hah, 557 is mine
(21:49:10) syzzer: iservice, aead -> alpha
(21:49:31) syzzer: #545 -> alpha ? or even 2.3.8 ?
(21:50:15) cron2: lemme check...
(21:50:43) cron2: definitely alpha, maybe even 2.3.8, depending how intru=
sive the change is
(21:51:37) syzzer: I looked into that one a bit, because I ran into it my=
self and thought the 138-bytes packets were ridiculous
(21:52:10) syzzer: changing to a new 'fixed-with-comfortable-headroom'-va=
lue should be simple
(21:53:36) mattock: https://community.openvpn.net/openvpn/ticket/569
(21:53:38) vpnHelper: Title: #569 (White space before end tags can break =
the config parser) =E2=80=93 OpenVPN Community (at community.openvpn.net)
(21:53:40) cron2: yeah, I run into this all the time when waiting for age=
s for the handshake with ecrist's test server :) - but haven't had time t=
o look into it
(21:54:36) cron2: what is with all these people that fill in whitespace i=
n places... #567 is about whitespace in the very first line...
(21:55:25) mattock: ok, I'm back
(21:56:00) syzzer: cron2: the hard part is probably figuring out what exa=
ctly is correct behaviour. then you just replace the frame_set_mtu_dynami=
c() call in tls_init_control_channel_frame_parameters() (ssl.c) to someth=
ing more sane
(21:56:01) mattock: lol, there's a milestone 2.2.2
(21:57:17) cron2: trac is hating me today
(21:58:03) mattock: I moved the 2.2.2 tickets to release 2.4
(21:58:09) vpnHelper: RSS Update - tickets: #569: White space before end =
tags can break the config parser <https://community.openvpn.net/openvpn/t=
icket/569>
(21:59:19) cron2: syzzer: yeah, but I'm not comfortable enough with the c=
ode to just say so, need to stare at it a bit more.  In principle, since =
James moved to 1200 in OpenVPN 3, it should be fine from the network side=
 of things
(22:01:05) syzzer: cron2: ok. I have a patch in my tree that tries to mak=
e sure the resulting IP packet ends up at most 576 bytes (sounds familiar=
?). I can easily change that to max 1280...
(22:02:06) syzzer: it is ssl.c after all, so I felt reasonable comfortabl=
e with the code
(22:02:33) cron2: 576 is the old regime... 1280 sounds very ipv6ish :) - =
maybe aim for 1250 as James stated for 3?
(22:02:53) cron2: good argument (about ssl.c)
(22:03:30) syzzer: I'm wondering if that 1250 is before or after the cont=
rol channel overhead
(22:03:43) syzzer: previous regime was max 100 bytes *before* the overhea=
d
(22:04:40) syzzer: but 1250 is fine by me
(22:05:03) syzzer: mattock1: can I just start throwing around some of 'my=
' crypto tickets?
(22:05:04) cron2: 1250 after overhead, I'd say
(22:06:27) cron2: syzzer: what are you planning to do?
(22:06:41) mattock: syzzer: feel free
(22:08:41) syzzer: #385 -> 2.3.8
(22:10:09) mattock: should we fix this even for 2.3.x? https://community.=
openvpn.net/openvpn/ticket/68
(22:10:11) vpnHelper: Title: #68 (Windows route add command failed) =E2=80=
=93 OpenVPN Community (at community.openvpn.net)
(22:10:41) mattock: iService will fix this for 2.4, but do we want to cre=
ate a "fix" (force gui to run as admin) with 2.3.x?
(22:10:57) cron2: syzzer: ack.
(22:11:10) syzzer: mattock1: we'll have to convince d12fk ;)
(22:11:52) cron2: mattock1: well, I'm all for "install it with admin priv=
s for 2.3", but d12fk is the one who was opposing this...=20
(22:12:01) mattock: oh was he...
(22:12:04) cron2: so maybe do another round of discussion with him?
(22:12:18) cron2: yeah, something along the lines of "forgetting to remov=
e the bits later on when no longer needed" or something
(22:12:24) mattock: I think we could just leave 2.3.x in its current stat=
e
(22:13:02) mattock: things have been like this forever and there's only a=
 relatively modest outcry from users
(22:13:14) mattock: this one should be fixed, though: https://community.o=
penvpn.net/openvpn/ticket/153
(22:13:16) vpnHelper: Title: #153 (Add "RequestExecutionLevel admin" to t=
apinstall.exe manifest file) =E2=80=93 OpenVPN Community (at community.op=
envpn.net)
(22:13:32) syzzer: #554 -> 2.4 beta (?)
(22:13:56) cron2: mattock1: did you?
(22:14:11) cron2: syzzer: ack
(22:17:18) syzzer: #387 -> 2.4 beta
(22:17:24) mattock: was?
(22:17:39) syzzer: '2.4'
(22:18:14) mattock: ok so... perhaps we should raise privileges for the 2=
.3 branch once 2.4 is out: https://community.openvpn.net/openvpn/ticket/6=
8#comment:5
(22:18:15) vpnHelper: Title: #68 (Windows route add command failed) =E2=80=
=93 OpenVPN Community (at community.openvpn.net)
(22:19:37) cron2: mattock1: "did you fix 153" (as you said "should be fix=
ed")
(22:20:39) mattock: no, I did not fix, but I will fix
(22:20:44) mattock: its 2.4 alpha now
(22:21:43) mattock: this seems like one of the option parser issues: http=
s://community.openvpn.net/openvpn/ticket/78
(22:21:44) vpnHelper: Title: #78 (openvpn http-proxy auth issue with prof=
iles) =E2=80=93 OpenVPN Community (at community.openvpn.net)
(22:22:36) cron2: syzzer: yep, makes sense
(22:22:40) mattock: perhaps we should consider postponing it until 2.5 un=
less somebody feels like rewriting the option parser
(22:22:47) mattock: (ticket 78)
(22:23:50) cron2: maybe we already got this covered when plaisthos fixed =
lots of other <connection> issues...
(22:25:30) mattock: asked about that
(22:25:57) mattock: if we don't get any response I say move it to "no mil=
estone" or "2.5"
(22:26:20) cron2: mattock1: your #395 ticket refers to #395...?
(22:26:55) cron2: #569 :)
(22:27:11) mattock: lol, that is what happens when a human is a part of a=
n information system :P
(22:27:22) cron2: loops and hilarity ensues
(22:27:41) cron2: folks, I'm spent now... classifying tickets is harder t=
han actual coding
(22:28:24) mattock: it indeed is
(22:28:38) mattock: we don't need to do this in a meeting
(22:28:41) mattock: actually
(22:29:09) mattock: that said, I'd prefer moving this to "no milestone": =
https://community.openvpn.net/openvpn/ticket/325
(22:29:10) vpnHelper: Title: #325 (Windows: Lacking ASLR and DEP support)=
 =E2=80=93 OpenVPN Community (at community.openvpn.net)
(22:29:18) syzzer: no, but a 'gathering' does make sense to me :)
(22:29:24) cron2: yes, indeed
(22:29:29) mattock: I've poked at this every now and then and documentati=
on on the subject is scarse
(22:29:29) cron2: (what syzzer said)
(22:29:42) mattock: yes, we need to organize the milestones or we won't g=
et 2.4 out
(22:29:44) mattock: any version
(22:29:45) mattock: :P
(22:29:45) cron2: shouldn't it just be a compiler switch?
(22:29:54) mattock: in theory probably yes
(22:30:05) mattock: from what I've read odd things could start happening
(22:31:19) cron2: if I understand that right, "normal" programs should ju=
st work, only if doing tricks it might break
(22:32:09) mattock: I can at some point poke at this a bit more, but it s=
eems that very few projects are using ASLR or DEP in conjunction with min=
gw_w64
(22:32:20) mattock: according to the scarsity of search results
(22:32:49) mattock: anyways, I don't want this to be a blocker for 2.4 (a=
lpha) release as there's plenty of other more important stuff to cover
(22:33:03) mattock: but lets continue the ticket review/categorization la=
ter
(22:33:16) mattock: it's 22:33 here already, need to head to bed
(22:33:30) cron2: yeah, this sort of "we should look at it eventually, bu=
t it's not a release blocker" stuff is slightly hard to classify
(22:33:44) syzzer: I can confirm that. for openvpn-nl I did not enable it=
 for the win builds either, because mingw (or windows itself, I don't rec=
all) was not cooperating
(22:33:56) cron2: ic...
(22:33:57) mattock: ah, good to hear
(22:33:57) cron2: anyway
(22:33:59) syzzer: yes, good night :)
(22:34:06) cron2: good night, mattock :-)
(22:34:22) mattock: syzzer: I will use your experiences as an argument fo=
r keeping this in the "needs volunteer" category :P
(22:34:25) mattock: good night guys!
(22:34:31) ***cron2 will poke some more on his 2.4 open issues (namely, r=
edirecting gateway for ipv6)....
(22:34:36) cron2: should have something in 2 weeks
(22:34:50) cron2: maybe we can hit 2.4 in delft :)
(22:34:52) mattock: so next meeting in two weeks?
(22:34:56) mattock: at latest
(22:34:58) cron2: "in 2018" *duck*
(22:35:02) cron2: yes
(22:35:13) mattock: by 2018 james may have been able to release openvpn 3=
 :D
(22:35:17) mattock: like for real
(22:35:31) cron2: haha :)
(22:35:34) syzzer: I'll provide some review material for you guys ;)
(22:35:39) cron2: good
(22:35:41) mattock: great!

--------------090006020105090606080409--

