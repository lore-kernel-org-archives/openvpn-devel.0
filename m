From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
References: <d54b01ca-1001-ccfc-cb97-1e1a826a5f94@...515...>
Message-ID: <5935538d-d1bc-3c70-835c-0b7bf11ed46f@...515...>
Date: Wed, 20 Mar 2019 13:53:41 +0200
MIME-Version: 1.0
In-Reply-To: <d54b01ca-1001-ccfc-cb97-1e1a826a5f94@...515...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="mJi9Lme3rFWUFuqFcRaHkEuDWk0l1hkcV"
Subject: [Openvpn-devel] Summary of the community meeting (20th Mar 2019)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--mJi9Lme3rFWUFuqFcRaHkEuDWk0l1hkcV
Content-Type: multipart/mixed; boundary="fBIEQWMbHE0ExsT1WzgXHsNvpIVTHVU8V";
 protected-headers="v1"
From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
To: openvpn-devel@lists.sourceforge.net
Message-ID: <5935538d-d1bc-3c70-835c-0b7bf11ed46f@...515...>
Subject: Summary of the community meeting (20th Mar 2019)
References: <d54b01ca-1001-ccfc-cb97-1e1a826a5f94@...515...>
In-Reply-To: <d54b01ca-1001-ccfc-cb97-1e1a826a5f94@...515...>

--fBIEQWMbHE0ExsT1WzgXHsNvpIVTHVU8V
Content-Type: multipart/mixed;
 boundary="------------39509973AFA02C733E0BABF1"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------39509973AFA02C733E0BABF1
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

Hi,

Here's the summary of the IRC meeting.

---

COMMUNITY MEETING

Place: #openvpn-meeting on irc.freenode.net
Date: Wednesday 20th March 2019
Time: 11:30 CET (10:30 UTC)

Planned meeting topics for this meeting were here:

<https://community.openvpn.net/openvpn/wiki/Topics-2019-03-20>

The next meeting has not been scheduled yet.

Your local meeting time is easy to check from services such as

<http://www.timeanddate.com/worldclock>

SUMMARY

cron2, dazo, janjust, mattock, ordex, plaisthos and syzzer participated
in this meeting.

--

Discussed the OpenVPN T-shirts. Mattock has them but has
(unsurprisingly) been extremely slow in starting the shipping process.
Fortunately there's a deadline which mattock needs to meet [for a big
chunk of the shirts] and that deadline is quickly approaching.

If you've been promised a T-shirt and you have not sent your postal
address to mattock: please sent it now.

--

Discussed the Windows MSI PR in openvpn-build:

https://github.com/OpenVPN/openvpn-build/pull/141

Mattock will try out the cures to the tar.exe problem suggested by Selva
and report back. Once that problem is fixed everyone seems to feel
comfortable with merging the PR.

--

Discussed the Travis-CI base OS update PR:

https://github.com/OpenVPN/openvpn-build/pull/149

No obvious problems were spotted in it and mattock merged it during the
meeting.

--

Discussed tap-windows6 HLK testing / WHQL certification. Not much has
happened: we're close, but not there yet. Stephen said he'd be able to
pick up pace soon.

Some internal pressure is building up at OpenVPN Inc. because right now
we're prevented from building new tap-windows6 versions, even for
trivial reasons like changing the driver name as seen by Windows.

Mattock is leaning towards setting up a dedicated HLK testing
environment in-house, as outsourcing the testing would probably involve
considerable overhead (plus considerable fixed costs for each release/OS
combination). Also, we'd need to understand the test setup in order to
document it for the outsourcing company. Mattock will reopen discussions
about getting a Windows Server 2016 box for this purpose.

--

Discussed the current meeting schedule, which seems to be suboptimal for
some. Ordex will create a Doodle poll to understand what options we have.

--

Discussed our OpenVPN 2.5 patch backlog. People are trying to pick up
pace, but that has proven to be quite difficult.

--

Full chatlog attached.



--------------39509973AFA02C733E0BABF1
Content-Type: text/plain; charset=UTF-8;
 name="openvpn_irc_meeting_chatlog_2019-03-20.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="openvpn_irc_meeting_chatlog_2019-03-20.txt"

(12:28:46) L'argomento di #openvpn-meeting =C3=A8: Next meeting on 13/Feb=
/2019 at 11:30CET. Agenda at https://community.openvpn.net/openvpn/wiki/T=
opics-2019-02-13
(12:28:46) L'argomento per #openvpn-meeting =C3=A8 stato impostato da ord=
ex!~linuxaro@...2309.../batman/ordex a 11:35:02 su 13/02/2019
(12:30:56) ordex: meeting ?
(12:31:00) mattock: yes
(12:31:06) ***syzzer present :)
(12:31:15) mattock: hi syzzer and ordex!
(12:32:17) janjust [~janjust@...1423.../community/support/janjust] =C3=A8 en=
trato nella stanza.
(12:32:48) syzzer: hi mattock1 :)
(12:32:55) janjust: hi all
(12:33:06) ordex: hi
(12:33:11) ordex: dazo said will be a bit late
(12:33:44) mattock: do we have our leader, cron2? :P
(12:33:48) janjust: hi mattock1 , just a quick question before we start: =
I've not received the hackathon t shirt yet. did you send it already?
(12:34:27) mattock: no, I have been shamefully slow
(12:34:34) mattock: but I do have a deadline and it is almost here
(12:34:40) janjust: no problem :)
(12:34:56) janjust: I just wanted to know if I should start badgering som=
e postal people=20
(12:35:15) ordex: mattock1: does it mean you will send the first day afte=
r the deadline ?
(12:35:15) ordex: :D
(12:35:30) ordex: oh I have an address in EU if you want to send somethin=
g to me too :-P
(12:35:36) janjust: hehe
(12:35:56) mattock: ordex: you're absolutely correct there! :D
(12:36:02) cron2_: ho
(12:36:03) cron2_: sorry
(12:36:06) mattock: I will postpone until I have to send the T-shirts wit=
h super-express-fast mail
(12:36:09) mattock: :P
(12:36:13) cron2_: got stuck in a meeting
(12:36:16) janjust: yo syzzer , btw: I am still digging into that 'auth t=
oken before payload' question. The *spec* might state that it is sent fir=
st, but I cannot find it in the *code*
(12:36:47) janjust: mattock1, just do a world tour to drop by each of us =
individually with a gift-wrapped shirt
(12:36:51) mattock: https://community.openvpn.net/openvpn/wiki/Topics-201=
9-03-20
(12:36:52) vpnHelper: Title: Topics-2019-03-20 =E2=80=93 OpenVPN Communit=
y (at community.openvpn.net)
(12:37:11) janjust: hiya cron2_=20
(12:37:16) mattock: janjust: that's an idea :)
(12:37:34) janjust: most expensive hackathon t shirt ever :)
(12:37:36) ***cron2_ sees syzzer and ordex - cool :)
(12:37:48) mattock: added one topic to the list
(12:37:55) mattock: anything to add to the topic list?
(12:38:30) janjust: I've got something I'd like to discuss, but could be =
done on the devel list also
(12:38:48) ordex: list looks good to me
(12:39:13) ordex: I just have an update on transport-api - will fit in #1=

(12:39:21) syzzer: janjust: auth token is something david and arne know m=
ore about than me
(12:39:26) syzzer: I just reviewed the original patch
(12:39:44) janjust: syzzer, nah not *that* auth token, it's about the pac=
ket format question from Pieter
(12:39:57) syzzer: ah, the tag
(12:40:08) janjust: ah right, the auth *tag*
(12:40:39) ordex: :D
(12:40:56) syzzer: so, #1 ?
(12:40:58) mattock: yes
(12:41:05) mattock: https://github.com/OpenVPN/openvpn-build/pull/141
(12:41:08) mattock: MSI PR
(12:41:08) vpnHelper: Title: Windows MSI Packaging by rozmansi =C2=B7 Pul=
l Request #141 =C2=B7 OpenVPN/openvpn-build =C2=B7 GitHub (at github.com)=

(12:41:11) janjust: question/topic I'd like to add:   is there any way th=
at an OpenVPN client can determine the version of the OpenVPN server it i=
s connecting to?  If not, how easy is it to add?
(12:41:32) cron2_: it's a question on whether we want it
(12:41:46) cron2_: if you enable push-peer-info on the server, you get al=
l the peer-info variables on the client
(12:41:53) cron2_: like IV_VER
(12:42:10) janjust: huh? I thought that was a one-way thing... client-> s=
erver only.  Let me test that
(12:42:18) cron2_: "back then" we decided that we want to send data clien=
t->server always, and server->client only on request
(12:42:32) janjust: ah okay... question answered for now :)
(12:42:36) janjust: thx cron2_=20
(12:42:41) cron2_: janjust: the actual handshake is symmetric in that reg=
ard (as it comes from the peer-to-peer mode times)...
(12:44:52) cron2_: reading the discussion in pr 141 now...
(12:46:55) mattock: I would be inclined to just merge PR#141 unless we ca=
n spot some obvious problems in the review comments - the tar.exe issue c=
ould be counted as one, though
(12:47:14) mattock: documenting or fixing it as Selva proposes would be g=
ood
(12:48:40) janjust: just reading it: if I understand correctly, we need G=
NU tar otherwise it breaks, right?
(12:49:12) mattock: yes, at the moment
(12:49:25) mattock: and in powershell tar.exe is some bsd tar variant
(12:49:32) janjust: how about requiring gtar.exe then  - that should alwa=
ys be gnu tar
(12:50:04) mattock: that's probably a good approach if we can't fix the p=
roblem
(12:50:04) janjust: plus, you can then probably do stuff like "gtar xzf .=
=2E."=20
(12:50:25) mattock: what I can do is test the fix proposals and report ba=
ck
(12:50:37) janjust: +1
(12:50:51) mattock: but besides that one problem: do you guys feel comfor=
table in merging that mega-PR?
(12:51:00) cron2_: yes
(12:51:00) mattock: I would, as it is well-isolated from the rest of the =
build
(12:51:03) mattock: ok good
(12:51:16) mattock: then we would have full MSI support in "master" (open=
vpn + openvpn-build)
(12:51:19) cron2_: the msi itself got quite a bit of testing from tincant=
ech (thanks), and you tested building
(12:51:28) mattock: yeah
(12:51:38) mattock: enough of MSI then :P
(12:51:39) janjust: I tested earlier revs of the msi
(12:51:47) cron2_: of course we need to test more :-) - like "produce .ms=
i from the buildslaves from now on", so we'll find the remaining warts
(12:51:50) janjust: and it seems the way forward for windows installs any=
ways
(12:52:25) mattock: I'm actually wondering if we should at some point swi=
tch to building OpenVPN for Windows on Windows...=20
(12:53:04) mattock: the process with MSI is getting convoluted (cross-com=
pile on linux, sign on linux or windows, package on windows)
(12:53:19) janjust: has advantages but definitely also disadvantages... "=
back then" openvpn on windows could be built only using visual studio, ii=
rc
(12:53:21) mattock: plus linux code-signing is soon going to stop working=

(12:53:23) cron2_: I hear you :-) - as long as I do not have to point and=
 click somewhere and can get meaningful results out of a build failure, "=
works for me"...
(12:53:38) ordex: can we use a windows host from corp for that?
(12:54:03) cron2_: mingw right now is nice because I can ssh to it, run "=
build-snapshot" and have normal unixy error messages, git, ...
(12:54:04) mattock: I already have a Vagrant-based VM in openvpn-build ("=
msibuilder"), but yes, we could have a more static node
(12:54:30) mattock: cron2: yeah, I'm not looking forward to the move to W=
indows  building, either
(12:54:40) ***dazo is here
(12:54:43) mattock: hi dazo!
(12:55:03) mattock: anyways, we don't need to make any decisions now - ju=
st something to keep in mind
(12:55:13) mattock: next topic?
(12:55:13) cron2_: yes
(12:55:29) mattock: https://github.com/OpenVPN/openvpn-build/pull/149
(12:55:30) vpnHelper: Title: travis-ci: switch to xenial image by chipits=
ine =C2=B7 Pull Request #149 =C2=B7 OpenVPN/openvpn-build =C2=B7 GitHub (=
at github.com)
(12:55:53) mattock: a similar thing was done for openvpn's travis, right?=

(12:55:59) cron2_: I'm a bit confused about that - as in "I was not aware=
 that we have travis-y things for openvpn-build"
(12:56:02) cron2_: what does that do?
(12:56:41) cron2_: (as a side note: syzzer, do we want to have the 3 trav=
is-related patches in relese/2.4 as well?  your ACK :) )
(12:57:24) plaisthos: sorry, completely missed the meeting
(12:57:28) mattock: it runs openvpn-build (generic and windows-nsis)
(12:57:45) mattock: so similar to the old "windows buildslave", but does =
not produce any artefacts
(12:58:12) syzzer: cron2_: yeah, those can go into 2.4 too
(12:59:01) plaisthos: syzzer: davids want me to rename --auth-token-secre=
t-genky to --genkey-auth-token-secret. I named it after --tls-crypt-v2-ge=
nkey. If we do that I would also rename that one to --genkey-tls-crypt-v2=
? Any opinions on that? (I don't care much either way as long as it is co=
nsistent)
(12:59:08) cron2_: mattock1: if you understand what that does, I'm fine w=
ith the patch :)
(12:59:18) cron2_: syzzer: ok, good
(12:59:20) ordex: mattock1: so it basically means that is just tests that=
 the build still works
(12:59:23) cron2_: I'll merge that into one...
(12:59:29) ordex: seems good to have :)
(12:59:36) plaisthos: janjust: what's your question on auth token?
(12:59:41) syzzer: plaisthos: we had that discussion too when I introduce=
d the option
(12:59:51) janjust: plaisthos, nah, is a question on auth *tag*
(12:59:59) ordex: if that travis-ci.yml has been tested, I think it makes=
 sense to merge the PR
(13:00:01) mattock: cron2: I try not to understand Travis-CI, but I hear =
you :P
(13:00:03) syzzer: I strongly prefer namespacing per functionaltity. ie, =
group all tls-crypt stuff
(13:00:35) dazo: syzzer: the challenge comes with --auth-gen-token-genkey=
 ... which gets a lot of gen
(13:00:40) janjust: syzzer +
(13:00:41) janjust: +1
(13:01:20) syzzer: dazo, then get rid of the extra gen?
(13:01:24) syzzer: why is it in there anyway
(13:01:34) dazo: because we have the function --auth-gen-token
(13:01:36) syzzer: --auth-token-genkey
(13:01:36) janjust: although --tls-crypt-v2-genkey is ugly IMHO with the =
v2 in there :)
(13:01:52) dazo: syzzer: and --auth-token is what the client receives via=
 PUSH_REPLY
(13:01:56) mattock: merged https://github.com/OpenVPN/openvpn-build/pull/=
149
(13:01:57) vpnHelper: Title: travis-ci: switch to xenial image by chipits=
ine =C2=B7 Pull Request #149 =C2=B7 OpenVPN/openvpn-build =C2=B7 GitHub (=
at github.com)
(13:02:08) mattock: change of topic on the fly, but that's good :P
(13:03:52) syzzer: that whole group should have been --auth-token-* to pr=
event that, but that's too late :p
(13:03:52) dazo: syzzer: --auth-token goes back to v2.1 days .... --auth-=
gen-token is a new v2.4 feature, where openvpn server can generate tokens=
 sent as --auth-token to the client
(13:03:52) plaisthos: janjust: oh then it is more for syzzer, syzzer answ=
er that I would know more about it seems like it was auth-token
(13:03:53) janjust: plaisthos, yes my bad... auth tag, auth token... we a=
re good at confusing ourselves with nomenclature, it seems :)
(13:04:00) plaisthos: but yes, I would agree that tag after encrypted is =
better for hw implementation
(13:04:26) dazo: syzzer: so since we have --genkey for the static secrets=
, we could have --genkey-tls-crypt-v2 and --genkey-auth-token ... which g=
roups the usage .... all of these are also "single operations"
(13:05:02) syzzer: that
(13:05:36) syzzer: that's not really a group, just similar things for dif=
ferent groups...
(13:06:51) janjust: plaisthos, my suspicion is that that is exactly what =
we're doing for AEAD, regardless of what the spec says; I just need to pr=
ove it :)
(13:07:00) syzzer: janjust: no
(13:07:06) syzzer: we are putting the tag in front
(13:07:18) syzzer: I didn't like it, but it's what were doing
(13:07:39) ordex: from the user perspective all the --genkey-* might be s=
een as "this is the group of things I can generate and put in the config"=
 .. so it makes some sense, but I guess we have to deal with our legacy :=
)
(13:07:44) janjust: tag =3D HMAC key?
(13:07:52) ordex: should we go back to our agenda?
(13:07:58) janjust: ordex: yes
(13:08:23) ordex: I wanted to add to #1:
(13:08:30) syzzer: (janjust: no, the key should never be on the wire ;-) =
)
(13:09:00) ordex: Operator Foundation picked up plaisthos' reviews for th=
e transport-api and dropped on me some *new* patches. I will integrate th=
em with the original PR (some rebase and squash) and post a v2 of the pat=
chset in a week or so
(13:09:11) dazo: syzzer: that's just a different view ... I see it as a g=
roup of "generate keys" when it starts with --genkey .... you want to gro=
up all operations of features, prefixed by the feature
(13:09:13) janjust: ah nomenclature again!!!  let's take that offline for=
 now
(13:10:58) syzzer: let's move the name bikeshedding to the end of the mee=
ting indeed :)
(13:11:06) janjust: dazo, I see your point, but in that case I would sugg=
est to use --genkey  for all of them and add an option to that parameter =
to specify what you're generating, e.g.   --genkey   authtoken ,  --genke=
y  tls-crypt, --genkey tls-crypt-v2 etc
(13:13:11) ordex: #2 ?
(13:13:21) dazo: janjust: that's a good alternative as well
(13:16:25) mattock: so bikeshed outside of the meeting? :P
(13:16:34) mattock: and move to #2 as suggested by ordex?
(13:16:34) dazo: I'm fine with that
(13:16:37) dazo: yeah
(13:16:44) syzzer: :-#
(13:16:47) mattock: #2 is quick
(13:17:05) mattock: stephen expects to pick up the pace soon
(13:17:15) mattock: but no particular measurable progress
(13:18:50) mattock: I've started to get some pressure from the company ab=
out this
(13:19:16) mattock: basically there's the need to rename the tap-windows6=
 driver but right now it is not possible because of the WHQL thingy=20
(13:19:51) mattock: rename the driver as seen by Windows, that is
(13:20:51) mattock: I'm also thinking that the least bad solution would b=
e to setup our own physical HLK test environment once Stephen has documen=
ted all the special knobs in his
(13:21:14) mattock: I was not particularly impressed by the HLK test outs=
ourcing company tbh
(13:21:57) mattock: lots of overhead in getting even the basic things rig=
ht
(13:21:57) cron2_: oops
(13:22:06) ***cron2_ got sucked away for 20 minutes... "I'm back"
(13:22:17) mattock: time for tap-windows6 updates
(13:22:21) mattock: anything to add to ^^^
(13:23:05) ordex: < mattock1> I was not particularly impressed by the HLK=
 test outsourcing company tbh <<< didn't we quit this long time ago?
(13:23:43) mattock: I mean even the basic HLK testing part
(13:23:54) mattock: the bugs in tap-windows6 were way beoynd their capabi=
lity
(13:24:06) mattock: but assuming those are all fixed - they would probabl=
y still struggle with the testing
(13:24:14) mattock: setting up the environment etc.
(13:24:18) cron2_: mattock1: no news from my side, waiting for stephen.  =
He had some issues with bridging and timing, and I'm not sure what came o=
ut of that yet
(13:24:38) cron2_: and indeed, what mattock1 says - the test rig needed f=
or tap-windows HLK testing is complicated
(13:25:28) cron2_: after we reach the "all tests pass!" bit we need to me=
rge Stephen's enhancements and try to actually rebuild a test environment=
 so we can reproduce the results...
(13:25:46) mattock: yeah, and at that point why would we need to outsourc=
e the work? :P
(13:25:51) cron2_: (of course if I say "we" it means "mattock does the wo=
rk" *duck*)
(13:25:58) mattock: well that is the case obviously :D
(13:26:02) ordex: :D
(13:26:15) mattock: I worked a lot with HLK when I still tried to make it=
 work myself, and the env setup is puppetized
(13:26:26) mattock: so that's perfectly acceptable, even though I'm not l=
ooking forward to it :D
(13:26:55) mattock: I'll send email about getting a Windows Server 2016 b=
ox @office
(13:27:00) cron2_: right now the setup needs a modified openvpn server as=
 bridge, so that needs quite a bit fo documentation :)
(13:29:55) mattock: yep
(13:30:18) mattock: I can model the environment in Vagrant as usual, but =
for actual HLK tests we need real hardware
(13:30:28) mattock: ok one hour mark reached
(13:30:32) mattock: done for today?
(13:30:55) mattock: anything else to discuss?
(13:30:59) cron2_: two quick things
(13:31:02) mattock: ok
(13:31:13) cron2_: a) meeting schedule - shall we stick to this time slow=
, now that ordex is in europe again?
(13:31:29) ordex: *slot
(13:31:40) cron2_: I would *prefer* an evening time slot (8 pm local time=
), but I can live with what we have
(13:31:45) mattock: what does "ordex is in europe again" mean?
(13:31:47) syzzer: the current timeslot is suboptimal for me
(13:31:54) cron2_: mattock1: living in italy
(13:32:03) mattock: oh, I did not know that
(13:32:09) ordex: mattock1: it means that having the meeting in the eveni=
ng is feasible again
(13:32:14) ordex: ah
(13:32:18) cron2_: right :)
(13:32:28) ordex: mattock1: sorry - not advertise that much :D
(13:32:31) ordex: *did not
(13:32:36) mattock: no problem!
(13:32:47) cron2_: dazo, plaisthos: what about you?
(13:32:59) mattock: I'm not sure if it is the time, but years ago our eve=
ning meetings seemed to have more people in them (in generla)
(13:33:01) mattock: general
(13:33:12) mattock: or maybe it was just the fact that we had regular mee=
tings then...
(13:33:51) janjust: I suppose we have a chance of seeing James if the tim=
e slot is 8 pm munich time ;)
(13:34:10) syzzer: that too
(13:34:20) syzzer: so, evening again?
(13:34:21) plaisthos: I am often away in the evening so no idea how often=
 I can make it
(13:34:25) dazo: To be honest, James is focused on quite larger projects =
these days, which doesn't touch openvpn 2.x at all
(13:34:26) ordex: we could try to move it back to 8pm and see how it goes=
 ?
(13:34:50) plaisthos: I also on't really expect James to join and really =
focus on our meetings
(13:34:53) ordex: plaisthos: you can drink your beer later :-P
(13:34:53) cron2_: +1 :) - which day?  monday, wednesday, thursday work f=
or me
(13:35:03) ordex: stick to Wed?
(13:35:04) mattock: we haven't _needed_ james in many years in OpenVPN 2.=
x
(13:35:05) dazo: The company is pleased how the community develops and ma=
intains OpenVPN 2.x so far ... plaisthos might come with features importa=
nt for Access Server every now and then, but that's essentially it
(13:35:07) janjust: "quite larger projects" dazo?    sounds intriguing
(13:35:25) ordex: janjust: corp private/closed things..not much to play w=
ith :-P
(13:35:26) mattock: plus for some odd reasons we don't have any OpenVPN 2=
=2Ex core developers from the U.S.
(13:35:29) plaisthos: I have fencing on monday and wednesday between 19:3=
0 and 22:00 CET
(13:35:38) cron2_: mattock1: actually we have - Selva
(13:35:45) mattock: oh yes forgot
(13:35:48) dazo: janjust: can't say too much ... but we're extending and =
making the Private Tunnel a lot, making it more suitable for the business=
 market
(13:35:49) mattock: well Canada
(13:36:01) cron2_: "us-ish time zone" :)
(13:36:08) ordex: how about Tue or Thur then ?
(13:36:19) mattock: for me a meeting during daytime is better, but when e=
xactly  - I don't care much
(13:36:22) cron2_: tue I won't be home before 20:30
(13:36:38) ordex: shall we do a doodle? it seems easier
(13:36:41) ***dazo double checks calendar
(13:36:49) syzzer: Mon doesn't work for me, so that leaves Wed or Thu
(13:37:09) ordex: Wed doesn't work for plaisthos=20
(13:37:11) cron2_: we seem to be converging already... who can not make T=
hu 8pm?
(13:37:14) ordex: Thur then ?
(13:37:19) mattock: I can't
(13:37:20) syzzer: oh, no, plaisthos can't make Wed
(13:37:20) dazo: Monday is not possible for me either .... generally Tue-=
Wed-Thu are best ... but double checking
(13:37:32) ordex: :D
(13:37:36) ***ordex jumps
(13:38:01) cron2_: ordex: can you set up a doodle (with the "maybe" optio=
n enabled) and mail it around? ;-)
(13:38:08) syzzer: Thu 20:00 CE(S)T works for me
(13:38:13) mattock: let's do doodle
(13:38:16) dazo: I can manage Thu but would prefer Tue ... as that day is=
 already typically a meeting day on my end
(13:38:28) ordex: cron2_: yeah will take care of that
(13:38:37) ordex: ok, let's stop the craziness here :D and stay tuned for=
 a doodle
(13:38:39) dazo: I might not manage every Thu, but probably most
(13:38:47) dazo: thx ordex!
(13:38:49) cron2_: ordex: thanks
(13:38:51) ordex: np
(13:38:52) ordex: lunch time !
(13:39:00) syzzer: ordex++
(13:39:10) cron2_: ok, b) - how's your plans wrt moving forward with our =
heap of patches for 2.x?  Anyone with free time?
(13:39:46) syzzer: cron2_: not much free time on my end :(
(13:40:21) syzzer: I do try to pick it up again, but it's not been very s=
uccessful yet...
(13:40:48) cron2_: syzzer: who do we need to bribe, threaten, ... to impr=
ove things? ;-)
(13:41:01) cron2_: (OTOH the snowboard season is over...)
(13:41:18) mattock: ordex: in your doodle poll: can you include european =
day-times as well?
(13:42:19) plaisthos: even our local ski resort is still open=20
(13:42:25) plaisthos: (and filled with Dutch people)
(13:42:50) cron2_: we went boarding last sunday and it was Just Too Warm =
there... (though the snow was still nice)
(13:43:49) ***janjust sees that this meeting is now *definitely* over
(13:43:58) cron2_: janjust: enjoy lunch :)
(13:44:06) janjust: thx you too... until next time
(13:44:44) mattock: until next week - I won't be sending any invites
(13:44:57) mattock: we're schedule until 3rd Apr
(13:45:00) mattock: scheduled
(13:45:19) mattock: summary coming up soon

--------------39509973AFA02C733E0BABF1--

--fBIEQWMbHE0ExsT1WzgXHsNvpIVTHVU8V--

--mJi9Lme3rFWUFuqFcRaHkEuDWk0l1hkcV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEbQT48bAXMRH0mXleKVhNn0CGRXgFAlySKcUACgkQKVhNn0CG
RXgZ2AgAnRw3M4+K2IJ/I6K/zNFhs3l/zDiGWdM14Odg3Bh0KvNSalDcoFMyJqlm
PJyvcFlOnTmiiqycO22bS38I5GUPJ1luWrqz0aEUTYICTRMEqMcFGCvlaF5uhVYz
/ci4Z4m/t9PGOmzM4oq1JEJgGkavz44i53Gnsbmelz6XJabGeLqwrihKx78dlL0/
NGPjqOwWThnNeNIn/00hONIOQb9qD/xZ5SO+cY8DPAkMmeAxkSVNSUqQjlmDa8en
pICK7jWzkVQsrYWu9nz94UR/ZwG6oekge7eeOVUZytz7vr/fOYmnL7TxrbcRAfFQ
f5bM1/T60C3qAlBSPSnyy4CqkdpikQ==
=g+aU
-----END PGP SIGNATURE-----

--mJi9Lme3rFWUFuqFcRaHkEuDWk0l1hkcV--

