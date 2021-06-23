From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
References: <48241a88-28ce-5a08-6dc8-34423634f092@...515...>
Message-ID: <ff6f8d96-709e-b3a1-aa81-3666c439005b@...515...>
Date: Wed, 23 Jun 2021 18:51:49 +0300
MIME-Version: 1.0
In-Reply-To: <48241a88-28ce-5a08-6dc8-34423634f092@...515...>
Content-Type: multipart/mixed; boundary="------------350E91CBD07FBE7CFD0B7D55"
Content-Language: en-US
Subject: [Openvpn-devel] Summary of the community meeting (23rd June 2021)
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
--------------350E91CBD07FBE7CFD0B7D55
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

Here's the summary of the IRC meeting.

---

COMMUNITY MEETING

Place: #openvpn-meeting on libera.chat
Date: Wed 23rd June 2021
Time: 14:00 CET (12:00 UTC)

Planned meeting topics for this meeting were here:

<https://community.openvpn.net/openvpn/wiki/Topics-2021-06-23>

Your local meeting time is easy to check from services such as

<http://www.timeanddate.com/worldclock>

SUMMARY

cron2, dazo, d12fk, lev, mattock, MaxF, novaflash, plaisthos and zx2c4 
participated in this meeting.

---

Talked about OpenVPN 2.5.3. It is in the queue of getting through the 
community testing in Fedora 34. Fedora Copr repos (F33, EPEL-7, EPEL-8) 
are already out and published in the openvpn-release copr repo.

---

Noted that "magic code" was found in windows stderr handling, which 
breaks MSVC compiled binaries on latest Win10 insider builds. So we 
might need a 2.5.4 eventually. Cron2, selvanair and lev are pulling 
their hair to fix it.

---

Noted that latest OpenVPN GUI has the SSO patches. Also noted that 
OpenVPN GUI in OpenVPN 2.5.3 Windows installer has those as well, as it 
includes the latest GUI available at release time.

---

Noted that 2.6 will probably move forward a bit slower as ordex is on 
his vacation.

---

Plaisthos will probably post a patch in next few days/weeks to remove 
__DATE__ and __TIME__ from the version to make builds reproducible iff 
the git tree is clean. The goal is to enable reproducible builds.

---

MaxF (from Fox-IT) gave an update on OpenVPN-NL. They're almost ready to 
release the first 2.5-based OpenVPN built on top of 2.5.3.

---

Talked about building Wintun and having reproducible builds. According 
to zx2c4 wintun builds might be reproducible, but he's not 100% sure. 
While we currently distribute (old) Wintun MSMs as-is, we'd like to 
build as many of our dependencies as possible to reduce the likelihood 
of supply chain attacks.

--

Full chatlog attached

--------------350E91CBD07FBE7CFD0B7D55
Content-Type: text/plain; charset=UTF-8;
 name="openvpn_irc_meeting_chatlog_2021-06-23.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="openvpn_irc_meeting_chatlog_2021-06-23.txt"

(14:58:30) plaisthos: breedbanddelft.nl sounds like Fox IT :P
(14:59:22) MaxF: Dark Fiber!
(14:59:25) mattock_: hello!
(14:59:53) MaxF: hello!
(15:01:06) dazo: hehe
(15:01:10) dazo: hi!
(15:01:18) lev__: hi
(15:02:37) cron2: yo!
(15:04:40) plaisthos: the topics in the topics are from 3 weeks ago %)
(15:04:53) mattock_: they're always the same topics anyways?
(15:04:55) mattock_: :)
(15:05:55) d12fk: hi
(15:07:30) ***cron2 has added moar topics
(15:07:54) plaisthos: to the agenda of the 2nd june? :)
(15:08:07) cron2: no, to 06-23
(15:08:18) cron2 ha scelto come argomento: https://community.openvpn.net/=
openvpn/wiki/Topics-2021-06-23
(15:08:28) cron2: now I get that part of the joke :)
(15:09:30) ***d12fk doesn't
(15:10:06) cron2: well, the first 2 items never change, but if the /topic=
 points to the agenda of 3 weeks ago, it's not surprising that the agenda=
 does not change at all...
(15:11:14) cron2: shall we start?
(15:11:20) plaisthos: sure
(15:11:29) dazo: to get #2 done quickly .... we have gotten some new peop=
le to push and annoy internally to attempt to move forward on IPv6 ... so=
 it's "moving" forward, somehow
(15:11:40) cron2: dazo: thanks
(15:13:15) cron2: so, #1 - anything on 2.5.x?
(15:14:24) dazo: 2.5.3 is in the queue of getting through the community t=
esting in Fedora 34.  Fedora Copr repos (F33, EPEL-7, EPEL-8) are already=
 out and published in the openvpn-release copr repo
(15:17:33) lev__: mattock_: is 2.5.3 using gui with crtext support
(15:17:58) lev__: it was merged into master before 2.5.3 was built
(15:20:16) mattock_: 2.5.3 uses whatever was in openvpn-gui "master" at r=
elease time
(15:21:24) mattock_: so the answer is "yes"
(15:22:19) lev__: danke shon
(15:23:12) MaxF: Since this is my first meeting, I'm not sure if you're i=
nterested in hearing about OpenVPN-NL ;)
(15:23:31) cron2: MaxF: we are :-) - let's do a quick round on 2.5/2.6 st=
atus first, then NL
(15:23:45) plaisthos: I am interested what happens there even if it just =
out of curiosity
(15:24:12) mattock_: +1
(15:24:32) cron2: so, from my side on 2.5 - there is a... "magic code" in=
 the windows stderr handling, which breaks MSVC compiled binaries on late=
st Win10 insider builds (arm64 *and* amd64).  So we might need a 2.5.4 ev=
entually... lev is working on it, selva and I are pulling our hair on the=
 code
(15:24:46) cron2: plus, we need to followup on the CVE documentation for =
3606
(15:24:47) novaflash [~novaflash@...2592...] =C3=A8 e=
ntrato nella stanza.
(15:24:51) cron2: whichever century
(15:25:20) novaflash: i feel so liberated
(15:25:27) lev__: cron2: I've sent a patch already
(15:25:30) cron2: (in case you missed it, the 2021- morphed to 2121- at s=
ome point)
(15:25:42) cron2: lev__: I've seen the patch, but want to understand bett=
er if this is what we want
(15:25:57) cron2: "just drop stuff" is tempting, but I'd expect it to be =
there for a reason...
(15:26:13) cron2: like, you can run "openvpn --log file.txt --config my.o=
vpn" and still see the prompts...
(15:26:24) novaflash: wish i could drop that mr incredible meme here with=
 "PATCH IS PATCH!!" text
(15:26:51) cron2: there is a german word "batsch!" which sounds similar :=
-)
(15:27:15) lev__: well that prompt has never worked with redirect, as it =
turned out, it was always written to redirected log
(15:27:25) plaisthos: lev__: are the SSO patches already in OpenVPN GUI?
(15:27:35) plaisthos: (I didn't actively follow that)
(15:27:35) cron2: plaisthos: the CRTEXT stuff, yes
(15:27:37) lev__: the code hasn't changed since beta21
(15:27:47) plaisthos: ah cool
(15:27:56) cron2: lev__: maybe it worked on XP...
(15:28:20) cron2: but seriously, if we can find a way to repair it, this =
would be good.  If not, rip it out, document, move on...
(15:28:24) lev__: and since no-one ever complained except you with newest=
 insider build..
(15:29:05) cron2: yeah, maybe really nobody runs openvpn from the windows=
 command line with --log $file
(15:29:10) lev__: I played a bit with DuplicateHandle but no help
(15:29:32) lev__: plus management interface
(15:29:59) cron2: oh, you do not need management interface to trigger tah=
t code path... --auth-user-pass will use the same function
(15:30:16) cron2: so --auth-user-pass (or keys with passphrase) + --log $=
file would also lose the prompts
(15:31:03) cron2: maybe we should just not redirect stderr instead, on wi=
ndows, for the main process (it's useful for scripts, tho)
(15:31:50) cron2: but seems this isn't interesting anyone here, so maybe =
move it to the list and discuss there...
(15:32:12) cron2: dazo: do you have what you need to update the Security-=
Page with the CVE information?
(15:33:27) d12fk: iirc, I just acked the fact that there's no password pr=
ompt when writing the mgmt itf support for the gui
(15:33:53) dazo: cron2: I think so ... and in regards to the 2121/2021 mi=
x-up, we'll just mention it there.  Can also add a 'git notes' which we p=
ush out too
(15:34:03) cron2: thanks
(15:34:58) lev__: d12fk: feel free to ack my patch then :)
(15:36:52) d12fk: a prompt would habe been nicer tho
(15:37:12) d12fk: it will probably break the gui if it appears all of a s=
udden however
(15:37:15) cron2: if the management interface is running, the prompting g=
oes to mgmt if
(15:37:29) cron2: not sure which prompty d12fk is missing
(15:37:55) d12fk: not sure either, it was a decade ago or so
(15:38:18) plaisthos: I vaguely remember management prompos something lik=
e=20
(15:38:19) cron2: "lev__ and my" prompts are non-management ones, where s=
tderr cannot be written to because it has been redirected to --log $file
(15:38:22) d12fk: just recall something odd, however it is a brain so don=
't worry
(15:38:23) plaisthos: > Password:type
(15:38:45) novaflash: oh no. a brain.
(15:38:56) d12fk: old too =3D)
(15:39:09) cron2: (and it is triggered because write() fails in win10/lat=
est and openvpn then just aborts...)
(15:40:25) cron2: vpnhelper is still not working right, otherwise we coul=
d blame it all on d12fk :)
(15:40:52) d12fk: good boy vpnhelper
(15:41:09) dazo: :D
(15:42:45) cron2: so, anything noteworthy on 2.6?  Not much from my end (=
working on the already-ACKed TLS patches)
(15:43:36) dazo: ordex having a few days off, so it will probably be a bi=
t slower on that side this and next week
(15:45:06) cron2: enjoying the last days of freedom
(15:46:10) mattock_: "The long gone days"
(15:46:12) dazo: heh
(15:46:37) cron2: MaxF: so, the floor is yours!
(15:46:41) mattock_: +1
(15:47:12) plaisthos: I will probably post a patch in next few days/weeks=
 to remove __DATE__ and __TIME__ from the version to make builds reproduc=
ible iff the git tree is clean
(15:47:26) dazo: +1
(15:47:43) MaxF: well, on our end, we're about ready to release 2.5.3 as =
our first 2.5.x release
(15:47:55) novaflash: yes. it's about time we got rid of such ancient con=
cepts as time
(15:48:40) MaxF: the holdup is that we need to build and sign our own win=
tun driver, and I'm still waiting on getting a Windows Hardware Developer=
 account
(15:48:57) MaxF: (well, not our own driver, our own build of the wintun d=
river)
(15:49:16) lev__: MaxF: do you use wintun 0.8 ?
(15:49:44) MaxF: yes, I've heard that they changed a lot in later version=
s
(15:50:08) MaxF: so you're planning on switching to a driver of your own
(15:51:25) MaxF: it would be convenient if ovpn-dco-win would have reprod=
ucible builds. Do you think it's worth it if I look into that?
(15:51:26) lev__: cannot you use existing wintun msm=20
(15:51:46) lev__: MaxF: sure
(15:52:01) MaxF: well, it works, but we want to guarantee that the binary=
 we distribute is built from the published source code
(15:52:13) dazo: MaxF: Performance wise, it is definitely worth some inve=
stigation for you
(15:52:39) dazo: but reproducible builds is something we should aim for i=
n all our projects, I agree there
(15:53:48) plaisthos: reproducible builds for openvpn itself have appeare=
d on my todo list
(15:53:53) lev__: MaxF: I see. Simon has own openvpn fork where he added =
support for new wintun API, but he hasn't sent patches yet
(15:54:48) plaisthos: zx2c4: do you know if wintun has reproducible build=
s. So it might be an option for MaxF to produce a local build that matche=
s the official build to be to say with certainity that published and sour=
ce are identical (from a 3rd party perspective)
(15:55:06) dazo: +1
(15:55:09) lev__: but last time I checked, binary-wise openvpn is compati=
ble with latest wintun despite calling driver api directy
(15:55:50) MaxF: why do you use the old version, then?
(15:56:09) cron2: we were told "the API has changed"
(15:56:19) lev__: yeah that's a long story
(15:56:46) plaisthos: MaxF: short (maybe too short story) is that our cur=
rent approach does just directly call the kernel apis
(15:57:01) lev__: for example our installer uses wintun MSM, and the late=
st version doesn't distibute msm nor has code for building msm
(15:57:29) MaxF: the most recent version says you can just drop the dll n=
ext to your binary
(15:57:30) plaisthos: the new approach of wintun instead uses a dll that =
you link/add to your software to achieve that functionality
(15:58:47) cron2: and this we do not want
(15:59:05) plaisthos: and with that dll we either rebuilt it ourselves (w=
hich is discourage if I remember correctly) or find a way to reproduce th=
e official build to verify that it is okay
(15:59:35) zx2c4: cron2: why dont you want to use wintun.dll?
(16:01:53) mattock_: we build all our dependencies from source
(16:04:16) mattock_: anything else to cover? we're four minutes overtime
(16:05:22) MaxF: I've got nothing to add
(16:05:33) ***cron2 needs coffee
(16:05:42) mattock_: ok, let's call it a meeting then :)
(16:05:55) d12fk: MaxF: anyways, welcome
(16:06:02) MaxF: thank you!
(16:06:03) mattock_: welcome!
(16:06:17) d12fk: have you heard about the hackathon leter this year?
(16:06:29) lev__: MaxF: feel free to ping me if you have any questions on=
 ovpn-dco-win
(16:06:49) MaxF: when is the hackathon?
(16:07:01) plaisthos: MaxF: sending you the doodle link in priv message
(16:07:11) zx2c4: mattock_: ahh so its a control thing?
(16:07:15) d12fk: MaxF: iirc somewhere in november
(16:07:25) zx2c4: but arent you already distributing the MSM?
(16:07:32) zx2c4: which has a pre-built DLL=20
(16:07:34) zx2c4: and a pre-built SYS
(16:07:41) zx2c4: not sure your reasoning is totally coherent
(16:07:58) mattock_: it's not
(16:07:59) zx2c4: dont you also distribute the msvc runtime libs?
(16:08:49) zx2c4: if the question is, "how can we trust that the binaries=
 from wintun.net match the source?" i'd be happy to take patches that mak=
e that sort of verification easier
(16:10:01) dazo: zx2c4: is reproducible builds possible with wintun today=
?  I think would be the easiest way of verification
(16:10:10) plaisthos: I think that is something after the supply chain ha=
cks is affecting anyone now more and more to ensure to minimise the suppl=
y chain attacks that are possible
(16:10:11) zx2c4: ive never really looked into it
(16:10:30) plaisthos: so there is now a lot more scruntinity than there w=
as before
(16:10:35) zx2c4: it'd probably be easy enough to do a reproducble-light =
where you just disassemble the whole thing
(16:10:54) dazo: plaisthos++
(16:11:03) zx2c4: re:supply chain attack - do you need a gpg signature?
(16:11:20) zx2c4: we can do end-to-end verification with the build machin=
e easy enough
(16:11:26) dazo: MaxF: ^^^  would that help your concern?
(16:12:32) zx2c4: (in some sense, there's *already* an HSM signature over=
 the wintun dlls anyway by virtue of wireguard's latest.sig file)
(16:12:59) dazo: But to be really picky on the supply chain attack vector=
 ... a reproducible build would help the cases where the official build h=
ost could be compromised (and provided compromised builds with a valid si=
gnature).  So it would be a way to validate the whole build chain as well=

(16:13:23) zx2c4: and microsoft's compiler too?
(16:13:36) zx2c4: sky's the limit there
(16:13:46) dazo: (if build environment A produces the exact same output a=
s build environment B and C .... the chances of a compromise is fairly lo=
w)
(16:13:47) zx2c4: but anyway- as i said, i'd be happy to have wintun repr=
oducable stuff
(16:13:59) zx2c4: and it might already be so
(16:14:12) zx2c4: after you strip signatures, anyway
(16:15:07) dazo: cool!  lets see what's possible and who got time to dive=
 into that.  It would be great if Fox-IT/MaxF would have a chance to dive=
 into it though
(16:16:22) lev__: dazo: note that currently openvpn doesn't know about wi=
ntun.dll
(16:16:52) MaxF ha abbandonato la stanza (quit: Ping timeout: 246 seconds=
).
(16:17:06) dazo: right ... but there's still more code being built than w=
intun.dll alone
(16:17:46) zx2c4: from my perspective, they're inseparable=20
(16:19:32) MaxF [~MaxF@...2624...] =C3=A8 entra=
to nella stanza.
(16:23:58) MaxF: I'll look into it, it would make my life much easier.
(16:24:08) dazo: thx!
(16:24:13) MaxF: but openvpn works also with the most recent DLLs?
(16:26:32) lev__: MaxF: openvpn doesn't work with wintun.dll, it talks di=
rectly to driver via DeviceIOControl calls
(16:28:52) MaxF: earlier you said:
(16:28:54) MaxF: > but last time I checked, binary-wise openvpn is compat=
ible with latest wintun despite calling driver api directy
(16:29:37) d12fk: driver api in this context =3D=3D DeviceIOControls, not=
 the dll
(16:32:29) lev__: yes, wintun.dll incorporates wintun driver plus middle =
layer, which also takes care on adding/removing adapter etc. openvpn is n=
ot aware of that middle layer
(16:32:44) dazo: anything else?  Or are we done?  30 min past the hour ma=
rk
(16:37:31) plaisthos: MaxF: got the message with doodle link?
(16:38:02) MaxF: yes, I'm still waiting for my registration e-mail so I c=
an message you back
(16:38:46) MaxF: (also, sorry to everyone I'm not answering right now ;))=

(16:39:27) d12fk: dazo: i'm gone for good already =3D)
(16:39:37) plaisthos: MaxF: lol
(16:41:08) plaisthos: I can also give you other contact details if that i=
s the problem
(16:41:26) plaisthos: MaxF: let me remove my flag that I set to avoid spa=
mbots from me
(16:41:39) MaxF: I just got the mail
(16:42:09) plaisthos: theere was a spam wave of bots that send random mes=
sages and only allowing mesages from registred users was a good alternati=
ve

--------------350E91CBD07FBE7CFD0B7D55--

