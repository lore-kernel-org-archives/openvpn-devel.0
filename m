From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
References: <420f8ab2-24ed-e57d-cc83-1c3b4beaea92@...515...>
Message-ID: <6f059ce3-12ff-b46b-655b-447f8e8cf340@...515...>
Date: Wed, 25 Aug 2021 16:40:01 +0300
MIME-Version: 1.0
In-Reply-To: <420f8ab2-24ed-e57d-cc83-1c3b4beaea92@...515...>
Content-Type: multipart/mixed; boundary="------------5F6E4349F1E97315BC9E3147"
Content-Language: en-US
Subject: [Openvpn-devel] Summary of the community meeting (25th August 2021)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel <openvpn-devel@lists.sourceforge.net>

This is a multi-part message in MIME format.
--------------5F6E4349F1E97315BC9E3147
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

Here's the summary of the IRC meeting.

---

COMMUNITY MEETING

Place: #openvpn-meeting on libera.chat
Date: Wed 25th August 2021
Time: 14:00 CET (12:00 UTC)

Planned meeting topics for this meeting were here:

<https://community.openvpn.net/openvpn/wiki/Topics-2021-08-25>

Your local meeting time is easy to check from services such as

<http://www.timeanddate.com/worldclock>

SUMMARY

cron2, dazo, d12fk, mattock, Pippin and plaisthos participated in this 
meeting.

---

Talked about the recent SM2 cipher security issue in OpenSSL. Noted that 
OpenVPN does not use the SM2 cipher normally, nor does it construct asn1 
strings by itself. So OpenVPN is not vulnerable.

---

Talked about the layout of the forum boards. In particular some sort of 
"open source client" forum board is missing. Pippin had designed a new 
forum board layout a while back, so a more major layout, or at least a 
discussion about it, is in order.

---

Talked about getting IPv6 to the openvpn.net domain by flipping a switch 
in Cloudflare. Mattock heard from reliable sources that there's nothing 
really blocking the flipping of the switch anymore. So from now on its 
all about pressure and coordination.

---

Noted that plaisthos has added openvpn://import-profile/https://some/url 
support to his OpenVPN for Android client. This allows triggering a 
profile import by clicking a URL from a server without having the user 
to having to choose "open with this app".

---

Mattock has refactored openvpn-build/windows-msi packaging system to be 
independent of openvpn-build/generic (the cross-compile buildsystem). 
This means fully native OpenVPN building and packaging on Windows. 
Signing with signtool is done except for signing of the MSI package.

Mattock is still blocked from upgrading the production buildmaster due 
to lack of repository access. Mattock will continue bugging ops team 
about it.

---

Noted that Daynix (HCR/HLK-CI people) want to test dco-win driver as 
well. Tap-windows6 testing is already in place.

---

Talked about COVID-19 and the 2021 hackathon. Noted that it makes sense 
to avoid buying any plane tickets or booking accommodation that can't be 
cancelled. The recent rise of COVID-19 infections in Europe may give 
rise to more restrictions and thus ruin the hackathon.

-- 

Full chatlog attached

--------------5F6E4349F1E97315BC9E3147
Content-Type: text/plain; charset=UTF-8;
 name="openvpn_irc_meeting_chatlog_2021-08-25.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="openvpn_irc_meeting_chatlog_2021-08-25.txt"

(15:01:35) mattock: hello
(15:01:37) plaisthos: hey all
(15:02:26) ordex: hi!
(15:03:21) d12fk: hey
(15:03:23) plaisthos: I am releasing a new version of my client with the =
new OpenSSL
(15:03:39) plaisthos: just because I wanted to do a release soon anyway
(15:03:43) ordex: plaisthos: do you know if OpenVPN by itself is affected=
?
(15:04:08) d12fk: plaisthos: have you looked into how exactly the ASN.1 i=
ssue is exploitable?
(15:04:08) plaisthos: SM2 is a cipher we don't use by default. You could =
configure it to use it but normally we don't
(15:04:38) ***ordex hasn't read the advisory=20
(15:05:55) d12fk: SM2 is a Chinese chiper. likely that ppl will have rese=
rvations using it, much like with GOST
(15:06:16) plaisthos: I don't think we are affected by the asn.1 issue as=
 we don't construct asn1 strings ourselves
(15:06:40) d12fk: ah it is C-sting -> ASN.1 string
(15:06:53) cron2_: oh, meeting
(15:07:05) d12fk: the cron2_ is here!
(15:07:19) d12fk: thought you are on vacation
(15:07:20) mattock: hi!
(15:07:22) cron2_: I am
(15:07:44) cron2_: we just finished a very luxurious lunch, and I am enti=
tled to use the laptop between "lunch is done" and "15:00"
(15:07:47) cron2_: so, just in time
(15:07:57) cron2_: family vacation rules :-)
(15:08:00) ordex: :D
(15:08:14) d12fk: checks out with me =3D)
(15:08:17) ordex: "cleared for openvpn meeting. copy"
(15:10:35) cron2_: so, please meet on!
(15:11:40) dazo: oh, meeting started
(15:11:45) d12fk: is there much to meet on?
(15:11:55) mattock: two topics
(15:12:14) mattock: selva wanted to open a discussion about having a dedi=
cated forum board for client topics
(15:12:29) mattock: as most of us know, the forum boards we have now are =
a bit wonky in that regard
(15:12:35) mattock: client questions don't belong anywhere
(15:12:55) cron2_: sounds like a good idea to me
(15:13:00) dazo: +1
(15:13:02) d12fk: general client or GUI?
(15:13:02) mattock: yes, agreed
(15:13:08) plaisthos: I have no idea about forums
(15:13:11) mattock: I guess general client would be better
(15:13:20) mattock: any client-related questions
(15:13:21) plaisthos: I never go there, so I have no opinion
(15:13:30) mattock: that kind of naturally leans towards users as opposed=
 to admins
(15:13:40) d12fk: hm, makes sense if the client authors stick around ther=
e, thinking of the tunnelblick guy
(15:14:01) d12fk: or is it a first level support kind of thing
(15:14:05) dazo: Perhaps we should have a closer look at all the sub-foru=
ms we have ... and consider consolidating some of them?  to make them mor=
e "target audience" focused than product/project focused?
(15:14:06) mattock: I think they might, and there could be subboards for =
different well-known clients
(15:14:26) ***d12fk also has no clue about what is going on on the forum
(15:14:43) mattock: in the case of clients like openvpn-guil and tunnelbl=
ick I think having a dedicated board would be good
(15:14:46) dazo: https://forums.openvpn.net/
(15:15:04) ordex: what are the "clients" ?
(15:15:17) ordex: because we already have sections about Connect for iOS =
and Android IIRC
(15:15:33) dazo: openvpn 2.x with --client, openvpn3-linux, openvpn conne=
ct, openvpn for android, etc, etc
(15:15:40) cron2_: at least Windows GUI and Tunnelblick...
(15:15:58) mattock: "open source clients" board maybe with sub-boards
(15:16:07) dazo: tunnelblick and GUI as well, yes
(15:16:33) dazo: mattock: do we really need to separate open source clien=
ts from other clients?
(15:16:45) mattock: we could start with just one
(15:16:48) mattock: ah
(15:16:50) mattock: mm
(15:17:07) mattock: well, not really,  but right now we separate "open so=
urce" and "enterprise business" already
(15:17:18) mattock: the division has already been made
(15:17:22) ordex: yeah
(15:17:27) dazo: yeah, and I'm not sure that division helps us
(15:17:38) ordex: I think the subforums in the business area work somewha=
t ok
(15:17:40) cron2_: complain to corp :)
(15:17:46) ordex: people simply look at what they are using and open that=
 forum
(15:18:04) dazo: if it has a clear goal ... or that the discussions on so=
me boards are heavily towards one part of the product/project, that's ano=
ther issue ... but lets split that out after we see how the discussion tr=
affic flows
(15:19:38) mattock: so one "open source clients" board or what?
(15:20:01) ***Pippin_ proposed new forum layout a while ago, still have e=
xample: http://31.151.32.90:11080/phpbb/phpBB3/
(15:20:09) mattock: oh yes
(15:20:26) plaisthos: for my client you could also make a sticky post to =
https://github.com/schwabe/ics-openvpn/discussions
(15:20:39) Pippin_: after proposal only Inc. side was changed
(15:21:13) mattock: looks pretty good and I don't want to bikeshed about =
the details
(15:21:20) mattock: but a more major overhaul was the diea
(15:21:21) mattock: idea
(15:21:30) mattock: I think this was just never moved forward
(15:21:43) dazo: Pippin_: ahh!  I had forgotten some of you already dug i=
nto this matter
(15:21:45) Pippin_: yes and possably an archive of current forum
(15:22:03) dazo: lets start with what Pippin_ and those involved there do=
es
(15:22:20) d12fk: q
(15:22:25) mattock: shall we coordinate this on openvpn-devel?
(15:22:38) Pippin_: possibly an archive link in new forum
(15:22:38) dazo: I still think the "OpenVPN Inc" section could be merged =
into the rest ... but that's nit-picking
(15:22:51) dazo: mattock++
(15:23:31) mattock: ok that's settled then
(15:23:45) mattock: pippin: that URL can be shared on openvpn-devel, righ=
t=3D
(15:23:46) mattock: ?
(15:24:26) dazo: Pippin_: Just one thought ... perhaps flip the Linux, Wi=
ndows, Other OS  vs  server/client around ... have "Server" and "Client" =
forums, with OS being sub-forums of those major groups
(15:24:27) Pippin_: yes, vm will be online about 2 hours from now
(15:24:43) mattock: ah ok, then it won't help much
(15:24:57) mattock: but I can compile a list of boards, no need to be tha=
t fancy
(15:24:59) ***Pippin_ has no 24/7 net
(15:25:38) mattock: dazo: I chose _not_ to start arguing what you're argu=
ing :)
(15:25:40) mattock: anyhow
(15:25:49) dazo: ;-)
(15:25:50) mattock: let's move on
(15:25:58) mattock: ipv6 updates
(15:26:02) mattock: in fact there are updates
(15:26:10) ordex: <o/
(15:26:11) cron2_: wot
(15:26:12) dazo: I hope cron2 is sitting
(15:26:22) ordex: everybody quiet!!
(15:26:24) cron2_: not sure I remember, but I'm all ears
(15:26:25) mattock: I heard  from a very reliable source that there is no=
w courage to turn on IPv6 on openvpn.net
(15:26:38) cron2_: you read it in the sunday times?
(15:26:44) mattock: Cloudflare has agreed to turn IPv6 off again _if_ (wh=
ich seems unlikely) there are major issues
(15:26:44) dazo: :D
(15:26:59) cron2_: this is, indeed, great news :-)
(15:27:03) plaisthos: so ipv6 is a one way switch?
(15:27:03) mattock: and the man in charge said "ok" to doing the switch f=
lipping at some point
(15:27:12) mattock: so, no time or date, but there's an "ok"
(15:27:25) mattock: plaisthos: yes, apparently it is
(15:27:25) cron2_: "at some point" diminishes the greatness again, alas
(15:27:36) mattock: yeah, but previously there was fear about flipping th=
e switch
(15:27:43) mattock: so we're one step further in the process
(15:27:54) dazo: we're going to continue pushing for this to happen in no=
t too far future
(15:27:58) mattock: and now people like my reliable source can push towar=
ds flipping it
(15:28:08) mattock: it is just about coordinating the thing
(15:28:12) cron2_: \o\ \o/ /o/
(15:28:59) plaisthos: semi OT: I added openvpn://import-profile/https://s=
ome/url to my client
(15:29:47) plaisthos: so you can trigger import by clicking a URL from a =
server without having the user to having to choose "open with this app" w=
hen "only" the mime type is correct
(15:29:53) cron2_: I've seen that hack used in omnigraffle to control con=
fig stuff from help pages (omnigraffle://set-some-switch=3Dtrue)
(15:32:18) plaisthos: It is more about having a bit more reliable than an=
ything else
(15:34:11) dazo: Anything else on the agenda?
(15:34:24) mattock: buildbot update
(15:35:12) mattock: I refactored windows-msi and made buildbot able to bu=
ild openvpn-gui and to sign all the files
(15:35:15) mattock: among other things
(15:35:28) mattock: in other words, windows-msi is no longer dependent on=
 the "generic" buildsystem
(15:35:37) mattock: which means we can do builds 100% natively on Windows=

(15:35:44) plaisthos: OpenVPN 2.x version icsopenvpn/v0.7.24-0-g0c4b34fe
(15:35:44) plaisthos: OpenVPN 3.x version icsopenvpn/v0.7.24-0-g9c8b4931
(15:35:56) plaisthos: hm git tag does not really produce useful stuff
(15:35:58) mattock: the only bit missing is MSI signing, but that's quite=
 trivial with all the legwork done
(15:36:01) plaisthos: %)
(15:36:22) mattock: I'm not sure if I have access to the Terraform repo I=
 was talking about, which blocks production buildbot upgrade
(15:36:27) mattock: I'll keep bugging ops about it
(15:36:29) cron2_: mattock: nice.  So we're (nearly) back to windows snap=
shot builds
(15:36:35) mattock: yes
(15:36:39) mattock: also
(15:36:58) mattock: daynix (the HL/HCR CI guys) want to test dco-win as w=
ell
(15:37:22) mattock: I recall some work was already done by lev to get dco=
-win to behave in HLK tests
(15:37:49) mattock: tap-windows6 HLK tests have been running for a while,=
 but as there have not been many/any PRs not much has happened in practic=
e
(15:38:39) mattock: that's all from my end
(15:39:13) cron2_: I won't have time to play with my buildslaves this and=
 next week, but then it would be great to start the migration to python3
(15:39:33) mattock: there will surely be glitches and things I need to fi=
x for the production buildbot
(15:39:44) cron2_: there always is
(15:39:58) mattock: there are some vagrant-specifisms lurking there surel=
y, plus ec2 glitches
(15:41:50) mattock: anything else for today?
(15:41:56) dazo: I'd just like to air a few things related to the Hackath=
on, no need for a long discussion now ... but as the COVID-19 infections =
are increasing a lot over all of Europe again, maybe we need to consider =
a plan B ... This is also tied to vaccination status and travel restricti=
ons and such.
(15:42:45) cron2_: we've said "everybody attending needs to be vaccinated=
", but this might not be enough if the numbers continue to go up, alas :-=
(
(15:42:52) dazo: Today a new variant of delta has been discovered in Denm=
ark, with concerns of being even more infectious ... November is still a =
bit into the future
(15:43:15) dazo: yeah, that's my thinking as well, cron2 ... I don't like=
 it, it would be great to meet ... but not at all costs
(15:44:16) dazo: I don't have any ideas or proposals now ... just wanted =
to raise my concern for the current situation
(15:44:19) mattock: I guess "delay commitment" is a good way forward
(15:44:25) mattock: nobody buy any tickets they can't cancel
(15:44:33) dazo: yupp
(15:44:47) plaisthos: At the same time if the restrictions continue to be=
 about what they are at right now the hackathon is not really much more r=
isk then just "normal" living=20
(15:45:08) cron2_: yeah to mattock, dazo, plaisthos :-)
(15:45:26) dazo: being at the hackathon is one thing ... longer travels t=
o getting there is another challenge
(15:45:39) plaisthos: I broke ExpressVPN with my client  by updating to o=
penvpn master and no longer supporting --key-size
(15:45:51) dazo: congrats, plaisthos!
(15:46:19) dazo: some consumer VPNs deserve punishments :-P
(15:46:20) cron2_: air travel / public transport in general, confined spa=
ce, random people - indeed
(15:46:28) cron2_: plaisthos: you evil man! (well done :-) )
(15:46:41) plaisthos: dazo: yeah that is why I said current restrictions.=
 Going grocery shopping in Netherland (that does not have a mask mandate)=
 is probably more risky than air travel
(15:48:45) dazo: In Norway these days it feels like the majority of peopl=
e, especially < 30y, insist on living like pre-2020
(15:49:14) mattock: there has been a constant party on the riverboats in =
the riverfront in Turku since June
(15:49:15) d12fk: that will continue troughout the winter
(15:49:30) mattock: people are living like there's no tomorrow
(15:49:38) mattock: young people in particular, of course :)
(15:49:40) cron2_: and they might be right, if they live on like that
(15:49:46) dazo: :-D
(15:49:46) mattock: lol yes
(15:49:57) cron2_: I want vaccinations to open for kids 9..11
(15:50:12) d12fk: last lockdown have been arued with the lack of vaccine,=
 that doesn't apply mostly anymore
(15:50:27) cron2_: and then I can go on with my life, disliking and avoid=
ing people as a matter of principle :-)
(15:50:33) d12fk: ma boy got his first shot already
(15:50:46) d12fk: cron2_: heh
(15:50:51) cron2_: d12fk: cool.  But I think he's older?
(15:51:02) d12fk: yeah a few years
(15:51:32) dazo: They've opened up for 17+ here, discussing 12-16
(15:51:51) cron2_: 12+ is open *and* recommended (finally) in DE
(15:52:18) ordex: same here
(15:52:59) mattock: I got my second last Sunday, but $daughter needs to w=
ait quite a while, she's 4
(15:53:06) mattock: anyhow
(15:53:09) ordex: hehe
(15:53:26) mattock: besides "do not commit to non-refundable plane ticket=
s and accommodation": anything else?
(15:53:44) cron2_: grumble about shortsightedness of people... :-)
(15:54:01) dazo: :-D
(15:54:06) d12fk: comes with age
(15:54:07) mattock: that's just the way people are
(15:54:49) plaisthos: biontec/pfizer already have trials for 6-12 iirc
(15:54:55) d12fk: anyway, I don't believe there will be another lockdown =
(for vaxxed peeps), so we could built on that
(15:55:25) plaisthos: yeah Germany strategy seems to be to make live for =
non vaccinated people more and more miserable
(15:55:26) d12fk: build our own little hackathon religion
(15:55:27) ***dazo googles how much helicopter transport from home to Mun=
ich will cost ...... :-P
(15:55:47) Pippin_: ethics, interresting...
(15:55:58) plaisthos: since they promised there will be no mandatory vacc=
ination
(15:56:00) d12fk: just stop after the thrid mass and you be fine
(15:56:37) plaisthos: d12fk: for a religion you have to submit your own h=
ygene concept and get it approved or you fall under the general rules=20
(15:56:40) cron2_: I'm not worrying about myself much, but catching some =
variant and then infecting the kids *is* worrying me... so, being careful=

(15:56:42) plaisthos: (at least in NRW)
(15:57:10) dazo: yeah
(15:57:12) d12fk: cron2_: that is a valid concern
(15:58:12) mattock: two minutes left
(15:58:19) mattock: we made it to the one hour mark
(15:58:21) mattock: almost
(15:58:26) mattock: any last words?
(15:58:27) d12fk: guess we drifted off-topic a while ago
(15:58:30) mattock: we sure did
(15:58:53) ***d12fk starts waving good-bye
(15:59:10) Pippin_: haha, speaking about C and "any last words" :)
(16:00:03) mattock: ok, none, the meeting shall be over then :)
(16:01:07) cron2_: perfecftly on time :)
(16:01:30) mattock: \o/

--------------5F6E4349F1E97315BC9E3147--

