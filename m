From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
References: <4bb3330d-f9eb-4e95-1514-21519d27f506@...515...>
Message-ID: <7b8ffe3d-2ad5-008f-7550-1053782b139a@...515...>
Date: Wed, 13 Mar 2019 14:00:51 +0200
MIME-Version: 1.0
In-Reply-To: <4bb3330d-f9eb-4e95-1514-21519d27f506@...515...>
Content-Type: multipart/mixed; boundary="------------7B1991056A7FD1C513E097BB"
Content-Language: en-US
Subject: [Openvpn-devel] Summary of the community meeting (Wed,
 12th Mar 2019)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------7B1991056A7FD1C513E097BB
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit

Hi,

Here's the summary of the IRC meeting.

---

COMMUNITY MEETING

Place: #openvpn-meeting on irc.freenode.net
Date: Wednesday 12th March 2019
Time: 11:30 CET (10:30 UTC)

Planned meeting topics for this meeting were here:

<https://community.openvpn.net/openvpn/wiki/Topics-2019-03-12>

The next meeting has not been scheduled yet.

Your local meeting time is easy to check from services such as

<http://www.timeanddate.com/worldclock>

SUMMARY

cron2, dazo, mattock, plaisthos and rozmansi participated in this
meeting.

--

Discussed the OpenVPN 2.5 release. Agreed to strip out obsolete
deadlines from the status page:

https://community.openvpn.net/openvpn/wiki/StatusOfOpenvpn25

Also agreed that "this year" is a reasonable goal.

--

Discussed tap-windows6 HLK testing / WHQL certification. Not much has
happened: we're close, but not there yet.

--

Talked about release OpenVPN 2.x Windows installers with OpenSSL 1.1.1.
Agreed that this makes sense as people (on forums for example) already
take 2.4.x and replace the OpenSSL libraries forcibly. Mattock tested
openvpn-build with OpenSSL 1.1.1b and there were no issues - a NSI
installer was produced. The next Windows installer release will thus
have latest OpenSSL 1.1.1 version. If serious issues are found we can
always have separate installer releases for OpenSSL 1.1.0 and 1.1.1
versions.

--

Talked about the auto-gen-token patch set. The consensus seems to be
that the --tls-crypt-v2-genkey option should be renamed. Dazo or
plaistohs will send a rename patch soon.

--

Agreed to start having weekly meetings again. Hopefully this helps the
OpenVPN 2.5 release move forward at a quicker pace.

--

Full chatlog attached.

--------------7B1991056A7FD1C513E097BB
Content-Type: text/plain; charset=UTF-8;
 name="openvpn_irc_meeting_chatlog_2019-03-12.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="openvpn_irc_meeting_chatlog_2019-03-12.txt"

(12:30:13) rozmansi: hi
(12:31:12) mattock: hi!
(12:32:08) dazo: Hey!
(12:32:55) mattock2 ha abbandonato la stanza (quit: Quit: IRC for Sailfis=
h 0.9).
(12:33:32) mattock: cron2?
(12:35:45) mattock: in any case, here's the topic list:https://community.=
openvpn.net/openvpn/wiki/Topics-2019-03-12
(12:35:47) vpnHelper: Title: Topics-2019-03-12 =E2=80=93 OpenVPN Communit=
y (at community.openvpn.net)
(12:36:02) mattock: while we're waiting and discussing I will retry the m=
si build
(12:36:19) mattock: the last time I ran into completely unrelated samba i=
ssues
(12:40:51) cron2_: I'm here
(12:40:52) cron2_: sorry
(12:40:57) cron2_: got stuck in a *cough* meeting
(12:41:04) mattock: hi!
(12:41:57) mattock: so: https://community.openvpn.net/openvpn/wiki/Topics=
-2019-03-12
(12:41:59) vpnHelper: Title: Topics-2019-03-12 =E2=80=93 OpenVPN Communit=
y (at community.openvpn.net)
(12:42:11) mattock: gcoxmoz requested updating https://community.openvpn.=
net/openvpn/wiki/StatusOfOpenvpn25
(12:42:12) vpnHelper: Title: StatusOfOpenvpn25 =E2=80=93 OpenVPN Communit=
y (at community.openvpn.net)
(12:42:19) mattock: I think that makes perfect sense
(12:42:44) mattock: maybe start with 2.5 status update and go on from the=
re?
(12:43:13) cron2_: well, nothing has really changed since that page was w=
ritten, except that we slightly missed the schedule
(12:43:32) cron2_: so I'd remove the details from "Schedule" and replace =
this by "should happen this year"...
(12:43:37) mattock: ok
(12:43:44) mattock: objections?
(12:44:04) dazo: ack
(12:44:51) mattock: I shall get rid of the schedule
(12:48:09) dazo: lets just remove the dates .... the release process look=
s reasonable
(12:48:30) cron2_: +1
(12:49:50) mattock: updated
(12:50:34) mattock: tap-windows6 updates next?
(12:50:42) mattock: "almost there, but not quite"
(12:50:54) cron2_: haven't heard anything new from Stephen
(12:51:22) cron2_: so, yes, what mattock1 said :-) - "almost there, but i=
t's software, so 'not quite' could easily take a while"
(12:53:49) cron2_: so... rozmansi: using the time :-) - what's the curren=
t status of the MSI work?  Are we waiting for you, are you waiting for us=
?
(12:53:56) cron2_: (everybody waiting for mattock1)
(12:53:56) rozmansi: Just a quick status update - MSI support for 2.5 is =
more or less finished. Few things still missing are user manual and testi=
ng-testing-testing. I am struggling to find time to address those.
(12:54:47) dazo: rozmansi: could you just add that into the status field =
of the 2.5 status page?  And put you alongside with the mattock?  (It's t=
he first "must have" item for 2.5)
(12:54:58) mattock: I'll try to do smoke-testing of the openvpn-build par=
t of MSI now
(12:55:07) dazo: but this is quite good progress after all on the MSI stu=
ff
(12:55:08) mattock: I have vagrantified the msibuilder setup
(12:55:30) mattock: the last time I failed because of dependency issues (=
gzip.exe etc.)
(12:55:30) cron2_: rozmansi: which of the bits are waiting on us?  openvp=
n-build PRs?
(12:55:34) cron2_: for us
(12:55:40) mattock: at least those cron2
(12:56:18) eworm [~eworm@...2498.../developer/eworm] =C3=A8 entrato nella =
stanza.
(12:56:50) rozmansi: dazo: status page updated
(12:56:53) dazo: thx!
(12:58:12) rozmansi: cron2_: yep, openvpn-build PR is still waiting to ge=
t merged. Probably after mattock1 (and I) decide it's stable enough.
(12:58:46) cron2_: for whatever reason, github does not send me mails for=
 openvpn-build PRs... thanks for the update
(13:00:03) mattock: rozmansi: does openvpn-build's feature/windows-msi st=
ill require a special version of openvpn to work?
(13:00:44) rozmansi: nope. All required commits were merged into openvpn/=
master repo. Thanks, cron2.
(13:01:37) rozmansi: openvpn/master is fully up-to-date regarding MSI. I =
have no pending commits.
(13:01:50) mattock: \o/
(13:02:08) mattock: I'll produce a tarball based on latest master code an=
d use that for openvpn-build
(13:02:24) mattock: we're out of topics
(13:02:26) mattock: or are we?
(13:02:54) mattock: unless "what do we do to get openvpn 2.5 moving forwa=
rd" counts as one :P
(13:03:14) plaisthos: sorry for being so late
(13:03:39) mattock: hi plaisthos!
(13:03:59) cron2_: hah
(13:04:13) cron2_: we have "review patches" on our TODO and I have one fo=
r plaisthos :-) (2.4 PSS padding)
(13:04:19) cron2_: https://patchwork.openvpn.net/patch/697/
(13:04:21) vpnHelper: Title: [Openvpn-devel,for,2.4] Handle PSS padding i=
n cryptoapicert - Patchwork (at patchwork.openvpn.net)
(13:04:48) plaisthos: cron2_: I have not reviewd that yet because the que=
stion is "Do we want OpenSSL 1.1.1 in Windows 2.4"
(13:05:20) cron2_: since we merged all the TLS1.3 related stuff to 2.4, t=
he answer seems to be "yes"
(13:05:54) dazo: Yeah, I agree ... I don't see the harm here
(13:06:12) cron2_: (at least to the question "do we want to have nice 1.1=
=2E1 support in 2.4" - the question "how shall we build official packages=
?" is related but needs to be discussed separately)
(13:06:14) dazo: due to the tls1.3 pieces already being here
(13:06:24) dazo: agreed
(13:07:12) cron2_: people are discussing in the forums how to take an off=
icial 2.4 installer and then replace libssl.dll to get TLS 1.3 support...=
 which I find slightly scary, so better ship with 1.1.1 right away :)
(13:08:14) cron2_: mattock1: have you tried building windows installers w=
ith 1.1.1?  Does it work, does it explode?
(13:08:38) mattock: cron2: hmm
(13:08:42) mattock: not 100% sure
(13:08:43) mattock: but I can try
(13:08:50) mattock: I have openvpn-build VM open anyways
(13:09:14) mattock: what is the latest 1.1.1 version?
(13:09:37) cron2_: 1.1.1b
(13:09:42) dazo: ack
(13:09:43) mattock: ok
(13:09:45) dazo: https://www.openssl.org/source/
(13:09:47) vpnHelper: Title: /source/index.html (at www.openssl.org)
(13:11:00) cron2_: while I have dazo and plaisthos here - how to move for=
ward with the auto-gen-token patch set?
(13:11:45) dazo: I was thinking about that as well ... currently, plaisth=
os and I figured we should rename the --tls-crypt-v2-genkey option .... p=
laisthos asked syzzer_ about his feedback but it's been silent
(13:12:00) dazo: so I proposed yesterday to just send a patch renaming it=
 ... and see the response
(13:12:13) plaisthos: 1.1.1b is out?
(13:12:19) dazo: plaisthos: yes
(13:12:28) dazo: plaisthos: 26-Feb-2019
(13:12:49) cron2_: dazo: we just need to shuffle around something in inte=
resting ways so his import to OpenVPN-NL breaks... "that will get his att=
ention"
(13:12:50) plaisthos: the changelog is really small
(13:13:12) mattock: building with 1.1.1b
(13:13:16) dazo: cron2_: hehe ... right ... as this is a brand new v2.5 f=
eature, this only impacts git master ... so this shouldn't be that intrus=
ive
(13:13:38) plaisthos: At the windwos build should work with 1.1.1b. I did=
 that build when I tested Selva's patch
(13:13:38) dazo: and it ensures our "genkey" alternatives are somewhat al=
igned from a user perspective
(13:14:27) dazo: (I doubt syzzer is doing openvpn-nl releases based on gi=
t master)
(13:15:37) dazo: otherwise, plaisthos and I did discuss what to improve p=
rivately and plaisthos laid a plan from there
(13:15:47) cron2_: cool, thanks
(13:17:12) lev__ ha abbandonato la stanza (quit: Changing host).
(13:17:12) lev__ [~lev__@...1423.../corp/lev] =C3=A8 entrato nella stanza.
(13:17:12) cron2_: I *am* a bit worried about lack of progress, but if yo=
u're been working on it, all is good :)
(13:18:24) mattock: 1.1.1b build looking good so far...
(13:18:26) dazo: yeah, we do try to follow up internally on open communit=
y tasks every week ... but we're pulled in many directions, so there's a =
hard time getting things prioritized.  But we can be even better at enfor=
cing community development time internally.
(13:19:06) cron2_: I can feel your pain :-)  - my customers are pulling e=
ven harder these days, then there's family, and openvpn...
(13:19:17) dazo: yeah
(13:19:24) mattock: I can't say that my situation is any different...
(13:21:55) mattock: so, anything else or "lets get to work"?
(13:22:23) cron2_: let's get to work :-)
(13:22:28) cron2_: (where is ordex, anyway?)
(13:22:49) mattock: 1.1.1b builds ok
(13:23:04) mattock: will try to produce MSI installer next
(13:23:28) mattock: openvpn-build from openvpn git master -> copy build f=
iles -> package as msi
(13:23:40) mattock: if that passed we can perhaps consider merging rozman=
si's openvpn-build PR
(13:24:02) mattock: and fix any problems that may arise in later PRs
(13:24:33) cron2_: cool
(13:24:41) mattock: that is my suggestion at least
(13:25:14) dazo: sounds good to me
(13:26:59) mattock: ok, meeting concluded then
(13:27:21) mattock: when do we have the next one?
(13:27:32) mattock: maybe try a semi-regular schedule at least?
(13:27:48) cron2_: we should aim for "regular, weekly, keep it quick"
(13:27:51) dazo: I would try to have one next week too
(13:27:55) mattock: ok
(13:27:57) cron2_: what we did this year was not very efficient
(13:28:01) mattock: agreed
(13:28:04) dazo: yeah, quick meetings are fine ... regularity helps progr=
ess
(13:28:17) mattock: there's always some (soft) deadline to meet that way
(13:28:41) mattock: at the very least one will get motivated by the shame=
 of not having done anything in a week :P
(13:29:37) cron2_: +1 :)
(13:33:09) mattock: did we decide to release next openvpn 2.4.x windows i=
nstaller with OpenSSL 1.1.1x?
(13:33:13) mattock: the build seems to work fine
(13:33:57) cron2_: let's go for that :-) - if it turns out there are issu=
es we can always introduce I70x builds with 1.1.0x... but I do not think =
this will be necessary
(13:34:43) mattock: +1
(13:40:55) dazo: +1

--------------7B1991056A7FD1C513E097BB--

