From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
References: <b99b879f-d0c1-af75-b2f9-cda3fa5ef526@...515...>
Message-ID: <7c12c1cb-cc6e-5276-ca33-1274434c1805@...515...>
Date: Wed, 30 Sep 2020 15:25:26 +0300
MIME-Version: 1.0
In-Reply-To: <b99b879f-d0c1-af75-b2f9-cda3fa5ef526@...515...>
Content-Type: multipart/mixed; boundary="------------D366267C8F446D582161B45A"
Content-Language: en-US
Subject: [Openvpn-devel] Summary of the community meeting (30th September
 2020)
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
--------------D366267C8F446D582161B45A
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

Hi,

Here's the summary of the IRC meeting.

---

COMMUNITY MEETING

Place: #openvpn-meeting on irc.freenode.net
Date: Wed 30th September 2020
Time: 11:30 CEST (9:30 UTC)

Planned meeting topics for this meeting were here:

<https://community.openvpn.net/openvpn/wiki/Topics-2020-09-30>

Your local meeting time is easy to check from services such as

<http://www.timeanddate.com/worldclock>

SUMMARY

becm, cron2, dazo, lev, mattock, plaisthos and zx2c4 participated in
this meeting.

---

OpenVPN 2.5-rc2 was tagged before the meeting started. It was released
later, just before this summary was sent. Packages for Red Hat were also
made available via Copr.

Noted that we may need to do an RC3 because of various Windows-related
issues and patches.

Discussed the possibility of moving away openvpnmsica (MSI custom
actions) and tapctl.exe source code from openvpn.git. That way we would
not have to do a full release if the changes only affect Windows installers.

Talked about the "MSM: Incomplete old driver removal" tap-windows6 issue:

<https://github.com/OpenVPN/tap-windows6/issues/129>

We (possibly) leave behind driver files in System32\drivers and "break"
some registry entries. If that is not an issue then we're "ok". Lev
suggested giving this issue to OpenVPN Inc. QA for testing. It was
agreed that plan makes sense.

---

Zx2c4 mentioned that he plans on moving away from MSM distribution for
Wintun to make it more difficult for different consumers of Wintun to
step on each other's toes. He'll keep the OpenVPN project posted about it.

---

Talked about OpenVPN 2, 3 and NetworkManager. There is hope that
NetworkManager could integrate more easily with OpenVPN 3 than OpenVPN
2. What really happens remains to be seen.

---

Noted that right now the OpenVPN 2.5-rc2 MSI installer does not upgrade
the tap-windows6 driver properly. This is being looked into and a fix
will follow soon.

--

Full chatlog attached

--------------D366267C8F446D582161B45A
Content-Type: text/plain; charset=UTF-8;
 name="openvpn_irc_meeting_chatlog_2020-09-30.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="openvpn_irc_meeting_chatlog_2020-09-30.txt"

(12:30:58) ***plaisthos whistles
(12:31:42) cron2: oh, indeed
(12:32:05) mattock: hello
(12:33:43) lev__: hi
(12:33:53) ordex: hi
(12:36:03) becm: hi
(12:36:05) cron2: s
(12:36:07) cron2: oops
(12:36:35) mattock: ok let's start
(12:36:45) mattock: I'll try to inch the release forward while the meetin=
g is ongoing
(12:37:16) mattock: https://community.openvpn.net/openvpn/wiki/Topics-202=
0-09-30
(12:37:39) mattock: then we have https://github.com/OpenVPN/tap-windows6/=
issues/129
(12:37:41) vpnHelper: Title: MSM: Incomplete old driver removal =C2=B7 Is=
sue #129 =C2=B7 OpenVPN/tap-windows6 =C2=B7 GitHub (at github.com)
(12:39:23) mattock: so, who wants to start?
(12:39:45) ordex: I guess we go with a recap of the 2.5 status first ?
(12:39:52) ordex: as far as I understood rc2 was just tagged, right ?
(12:40:07) cron2: yes
(12:40:18) cron2: tagged and pushed, and installers are building
(12:40:28) dazo: hey!
(12:40:46) ordex: cool
(12:40:58) ordex: is there anything pending that we already know should g=
o in a potential rc3?
(12:40:58) dazo: I'll get the Copr (RPM) builds running too
(12:41:12) ordex: or we have to get rc2 out and see what comes back?
(12:41:21) plaisthos: from my tree only the cipher none patch
(12:41:39) ordex: ok
(12:41:40) cron2: I was about to say "need to go through the plaisthos pa=
tches", and "none" was high on my list
(12:41:50) cron2: nothing else I'm aware of right now
(12:41:54) dazo: plaisthos: does that requires another RC round from your=
 point of view?  Or is it ready for final release?
(12:43:31) plaisthos: it is a fairly small patch. I have tested it and so=
me users of my app screaming at me also seem to be happy with it
(12:43:53) dazo: then I'm leaning towards release ready
(12:44:11) plaisthos: and unless you have cipher none in use it doesn't c=
hange the code
(12:44:21) cron2: I am a bit more careful with the windows installer issu=
es
(12:44:37) plaisthos: the biggest change of it is that remote_cipher beco=
mes 'none' instead
(12:44:44) plaisthos: of [null-cipher]
(12:44:48) cron2: there is a patch from rozmansi regarding win7/msica tha=
t nobody understands, and the tap-windows6 issue above
(12:45:05) dazo: cron2: but are the windows installer issues related to t=
he openvpn codebase itself now?
(12:45:12) cron2: sometims :)
(12:45:22) cron2: openvpnmsica lives in the openvpn git repo
(12:45:28) cron2: msm lives in the tap-windows6 git repo
(12:45:38) cron2: other stuff lives in the openvpn-build repo
(12:46:01) cron2: so, depending on *where* we need to fix the driver stuf=
f, it might affect the openvpn git repo, or "just a new installer"
(12:46:10) mattock: yep
(12:46:16) lev__: I can ping rozmansi and ask for clarification regarding=
 that patch
(12:46:19) cron2: as for "openvpn git repo -> src/openvpn/" I think we're=
 fairly release ready
(12:46:45) lev__: I gave my comments but haven't got a reply yet
(12:46:54) cron2: yeah, seen that
(12:48:14) lev__: and tap-windows6 is not a regression, it has been there=
 "forever", it should not stop us from releasing
(12:48:25) lev__: I can have a look after finishing some corp stuff
(12:48:46) dazo: alright ... I see that we the tapctl and openvpnmsica st=
uff is fairly isolated to Windows install/tap driver management ... so af=
ter the 2.5 release, we should consider if that really belongs in the cor=
e openvpn 2.x codebase or if somewhere else would be more appropriate
(12:49:01) becm: lev__: the 129 issue is introduced by MSI.
(12:49:28) dazo: (neither of them seems to pull in code from include/ or =
src/openvpn)
(12:49:32) becm: 2.4.x just did not care to remove old drivers
(12:50:23) lev__: becm: does it mean that from end-user perspective resul=
t is the same (old driver not removed) ?
(12:50:44) becm: different :)
(12:50:46) lev__: or have MSI introduced any breakage ?
(12:50:57) mattock: dazo: I agree with openvpnmsica belonging "elsewhere"=

(12:51:06) mattock: I don't want to do full releases when the changes onl=
y affect windows
(12:51:29) lev__: mattock: dazo there is also tapctl
(12:51:39) mattock: that one as well -> outside of openvpn
(12:51:57) becm: MSI "breaks" driver/service references (at least for me)=

(12:51:58) lev__: you just don't like windows specific code
(12:52:11) dazo: We can discuss the openvpnmsica + tapctl relocation afte=
r the 2.5 release.
(12:52:17) mattock: dazo: +1
(12:52:21) cron2: I think the argument back then was along the lines of "=
it is built together with openvpn.exe in the mingw builds, so it's all in=
 one place" or so.  But moving this to, say "openvpn-windows" and adjusti=
ng openvpn-build to pull both repos might be a good plan
(12:52:37) cron2: I object to git submodules
(12:52:55) mattock: I tend to agree there (git submodules)
(12:53:28) dazo: that's a different topic, for later .... but I'd like to=
 better understand why you dislike submodules
(12:54:24) cron2: what we had with cmocka was complicated and fragile, an=
d there was no obvious benefit to offset the complications
(12:54:35) lev__: becm: what does "breaking driver/service" reference mea=
n for users?
(12:55:17) lev__: (apart from old driver is not removed)
(12:56:51) becm: lev__: it IS removed. That's why during update some inva=
lid/bad state is reached
(12:57:35) becm: this then leads to the effect that on a later UNINSTALL,=
 tap0901.sys is not removed from System32\drivers directory
(12:57:35) cron2: so the binary is removed but the references in windows =
are still there?  (I do not understand anything, just trying to visualize=
)
(13:02:54) ***lev__ still confused and doesn't understand what is means f=
or users=20
(13:03:02) becm: cron2: some binaries are removed (DriverStore) are remov=
ed. This had to be done manually with NSIS.
(13:04:49) becm: lev__: depends on the user sopistication level. We (poss=
ibly) leave behind driver files and "break" some registry entries
(13:05:07) ***plaisthos has no idea what this all means
(13:06:28) becm: summary, i'f a left-over file in System32\drivers and so=
me "strange" registry entries are not an issue it's "fine".
(13:07:12) mattock: (debian packages building)
(13:10:39) lev__: so, what is estimated date for release
(13:10:58) mattock: (windows binaries building)
(13:11:36) mattock: yes and how, if any, will attempt to fix the issue be=
cm described
(13:11:41) mattock: I mean _who_
(13:11:42) mattock: :)
(13:11:48) lev__: we can think more about test plan and give it to our qa=

(13:11:59) ordex: <o>
(13:11:59) mattock: not a bad idea
(13:12:16) lev__: just need to notify them a bit in advance
(13:12:48) becm: this might not be "our" issue and also apply to WINTUN
(13:12:51) dazo: mattock: have you uploaded the signed source tarballs, s=
o I can get the Copr builds running?
(13:13:08) lev__: I can have a look soon
(13:13:38) lev__: but I wouldn't mind if someone would jump in
(13:14:25) mattock: dazo: yes, to build.openvpn.net
(13:14:31) lev__: becm: but it doesn't apply for wintun when it is instal=
ler as part of WG?
(13:14:38) mattock: I don't want to upload them to swupdate until I'm 100=
% positive the release is solid
(13:14:55) mattock: otherwise there'll be a cache clearing hell
(13:15:19) lev__: I can smoke test windows installers
(13:15:39) mattock: they'll be ready "soonish"
(13:15:50) mattock: I had to destroy and rebuild my "msibuilder" VM as Wi=
nRM had stopped working for reasons unknown
(13:16:17) mattock: I'll test Windows 10 x86_64/amd64
(13:16:20) mattock: real laptop
(13:16:21) becm: not shure how WireGuard behaves on driver update. Would =
have to investigate
(13:16:39) mattock: becm: I believe Wireguard uses the same basic strateg=
y (MSM)
(13:16:54) mattock: of course the exact behavior is probably different
(13:17:09) zx2c4: you must use the MSM for wintun
(13:17:17) zx2c4: however, we're working on a better long term strategy
(13:17:22) zx2c4: ill let you guys know when we have that together
(13:17:28) mattock: great!
(13:17:39) zx2c4: it'll simplify distribution of wintun and ensure that d=
ifferent consumers of it don't step on eachother by not following the rul=
es
(13:17:44) mattock: I'm just waiting for 32-bit Windows and Windows 7 to =
fully die
(13:17:47) zx2c4: (right now the rules are: use the MSM, or ill be upset)=

(13:18:11) lev__: zx2c4: we do use MSMs
(13:18:19) zx2c4: I know
(13:18:22) mattock: also for tap-windows6
(13:18:27) zx2c4: hopefully in the future that wont be required
(13:18:29) zx2c4: for wintun
(13:18:30) zx2c4: ill keep you posted
(13:18:33) mattock: thanks!
(13:20:03) plaisthos: zx2c4: do you already have a VPN company that knew =
"better"?
(13:20:16) zx2c4: wha?
(13:20:33) zx2c4: i dont have a vpn company at all... wireguard is a comm=
unity project
(13:20:39) zx2c4: but knew better about what?
(13:21:42) becm: pure speculation on driver issue is disabled drivers kee=
ping references to removed drivers, new driver gets installed AFTER remov=
e of old.
(13:21:48) plaisthos: In my experience these VPN provider that sell "use =
our vpn to make your Internet safe again" always know stuff better than u=
psteam and do strange stuff. I was just wondering if that already happend=
 with the wintun driver
(13:22:25) becm: *disabled adapters
(13:22:38) zx2c4: plaisthos: oh haha thats what you mean
(13:22:39) mattock: "VPN providers that do strange stuff with VPN"=20
(13:22:45) mattock: with Wireguard
(13:22:53) zx2c4: no, that's not the motivation
(13:23:05) zx2c4: things are so far working well with the MSM
(13:23:10) zx2c4: its jst that i think we could do better and
(13:23:19) zx2c4: i get kind of obsessive and codegolfy with making thing=
s perfect
(13:23:35) zx2c4: so far no VPN providers who are abusing wintun, that i =
know of at least
(13:23:38) zx2c4: but i guess we'll see
(13:23:46) zx2c4: but anyway, not requiring "rules" to use it is always a=
n improvement
(13:24:03) mattock: (debian/ubuntu packages in the apt repos)
(13:25:31) mattock: anything else for today? approaching the magical limi=
t of one hour
(13:26:05) plaisthos: sppeaking of broken VPN implementation, my app alre=
ady uses master code and apart from the cipher none problem, people still=
 relying on BF-CBC and PIA with their broken server, there was almost no =
hickup due to new NCP code
(13:26:18) cron2: cool
(13:26:24) cron2: any word from PIA on this?
(13:26:37) dazo: mattock: just pushed the Copr builds now .... https://co=
pr.fedorainfracloud.org/coprs/dsommers/openvpn-beta/build/1689647/
(13:26:38) vpnHelper: Title: Build 1689647 in dsommers/openvpn-beta (at c=
opr.fedorainfracloud.org)
(13:26:41) mattock: dazo: thanks!
(13:27:06) plaisthos: cron2: no apart from an intial thanks for notifying=
 nothing
(13:27:11) mattock: dazo: I'm actually using your packages from that repo=
 :)
(13:27:21) mattock: Fedora 32
(13:27:23) plaisthos: I even proposed a quick fix for them (push --cipher=
 then our client will ignore occ ciphers)
(13:27:23) cron2: plaisthos: how nice
(13:27:24) dazo: cool!
(13:27:32) mattock: so far they've served me well
(13:28:07) dazo: mattock: then you should also try the openvpn3 repo too!=
 :-P  https://copr.fedorainfracloud.org/coprs/dsommers/openvpn3/
(13:28:08) vpnHelper: Title: dsommers/openvpn3 Copr (at copr.fedorainfrac=
loud.org)
(13:28:52) mattock: I know, but I had a large number of VPN connection fi=
les that "just work" and migrating to Fedora 32 took enough time as-is :)=

(13:28:57) mattock: but yes, I should try out openvpn3-linux as well
(13:29:17) dazo: I'll be working on RPM of the packaging ovpn-dco module,=
 and I'll put it in the openvpn3 repository for now .... the next openvpn=
3-linux v11_beta release will be ovpn-dco ready, just requiring the kerne=
l module
(13:29:35) mattock: if it would directly support updating systemd-resolve=
d per-domain DNS server IP addresses I'd definitely be interested
(13:29:49) mattock: now I use the de facto script from Joe Random
(13:29:58) dazo: mattock: it does .... didn't you read the v10_beta rleea=
se notes? ;-)
(13:30:00) mattock: I mean "per-interface DNS"
(13:30:03) mattock: no, I did not :D
(13:30:11) mattock: may I'll give it a spin soonish
(13:30:48) dazo: ahh, you mean split-DNS ... that is partially supported =
=2E.. as long as DNS domains are pushed/configured together with DNS serv=
ers
(13:31:30) dazo: v10_beta which got released some weeks back had systemd-=
resolved integration as the main feature, v11_beta focuses on ovpn-dco
(13:31:30) mattock: yes that
(13:31:52) cron2: .oO(someone needs to fix NM interaction with auth-token=
=2E..)
(13:31:55) dazo: mattock: https://www.mail-archive.com/openvpn-devel@...1514...=
s.sourceforge.net/msg20607.html
(13:31:56) vpnHelper: Title: [Openvpn-devel] OpenVPN 3 Linux client - v10=
 beta released (at www.mail-archive.com)
(13:32:20) cron2: dazo: is there any way to use NM with 3?
(13:32:40) dazo: cron2: not yet, but that feature request is getting high=
er up on the todo list
(13:32:57) cron2: (I do not use NM, but those poor souls that do suffer f=
rom "when the network changes, openvpn is restarted and token is lost")
(13:33:55) mattock: I would probably use network-manager-openvpn if it di=
d not suck as much as it does
(13:33:56) dazo: ahhh .... oh, that situation .... I discussed that with =
the NM guys long back .... it will require a bigger change in the main NM=
 code, to _not_ tear down VPNs when primary interfaces disappears
(13:34:38) dazo: mattock: I have some hopes that the NM integration with =
openvpn3 can be better ...
(13:35:02) dazo: because with openvpn3, NM doesn't "own" the openvpn proc=
ess - which it does with OpenVPN 2.x
(13:38:01) cron2: do not underestimate the creativity of the NM folks :)
(13:39:03) cron2: but actually, it might be possible even with 2.x to get=
 this done properly - NM could leech off the token from OpenVPN, and for =
a newly started process, just pass in "auth-token $oldtoken"...
(13:39:26) cron2: so a process restart could be done without losing the t=
oken (parking it in NM for the time)
(13:40:54) plaisthos: oh wow
(13:41:27) plaisthos: that might work and is the kind of horrible, yet so=
mehow very well hack that will survive us all
(13:41:41) cron2: yes! true openvpn style! :-)
(13:41:51) cron2: (or just throw away nm-openvpn2-integration and go for =
3)
(13:42:21) cron2: but even then it will be a challenge to keep the token =
around if told to tear down the VPN
(13:43:33) mattock: https://build.openvpn.net/downloads/releases/OpenVPN-=
2.5-rc2-I601-amd64.msi
(13:44:03) mattock: this is the most horrible part of the release process=
: does the Windows installer work and if it does, is it actually composed=
 of the correct parts?
(13:44:12) mattock: anyhow, I will start writing the summary now
(13:44:15) mattock: 14 minutes overtime
(13:44:30) mattock: lev and anyone else: feel free to test
(13:45:32) dazo: cron2: I don't think openvpn accepts auth-token unless i=
t's pushed
(13:46:13) plaisthos:          VERIFY_PERMISSION(OPT_P_ECHO);
(13:46:21) dazo: for the nm-openvpn3 integration ... I'll think of someth=
ing clever here, so that the openvpn session is not torn down but rather =
paused when the connection goes away
(13:46:21) plaisthos: it has a very strange permission indeed
(13:47:22) dazo: (so that a NM triggered disconnect only happens when the=
 _user_ chooses to disconnect)
(13:47:38) cron2: OPT_P_ECHO? wtf is that
(13:48:01) plaisthos: it is for echo and auth-token :)
(13:48:07) cron2: mattock: do we have an .exe installer already?
(13:48:08) dazo: :-D
(13:48:16) plaisthos:     else if (streq(p[0], "echo") || streq(p[0], "pa=
rameter"))
(13:48:23) plaisthos: this is something I never heard off
(13:48:29) cron2: dazo, plaisthos: one of you might be able to explain "e=
cho" to me...
(13:48:59) dazo: cron2: connect to the management interface .... when an =
echo option is pushed, it appears there
(13:49:06) plaisthos: probably some forgotten feature for old OpenVPN con=
nect clients that allowed to push some extra stuff
(13:49:06) cron2: yeah, but what then?
(13:49:29) plaisthos: the old connect client have some very very question=
able features
(13:49:45) plaisthos: like executing a pushed script or sending you versi=
ons of installed software
(13:49:48) cron2: echo is never logged, and masked in PUSH, so this is ve=
ry magic
(13:49:55) cron2: oh wow :)
(13:50:16) plaisthos: it might be for that
(13:51:32) plaisthos: or might be for custeroms
(13:52:21) dazo: cron2: actually, OpenVPN 2 Cookbook describes how you ca=
n use it, iirc
(13:52:25) ***dazo digs up the book
(13:52:26) plaisthos: you can set client properties in access server and =
it will then push those strings base64 encoded to the client via echo
(13:53:12) dazo: oh that book is old now ... "New features of OpenVPN 2.1=
 and OpenVPN 2.2" :-P
(13:53:15) plaisthos: management-notes.txt describes it actually
(13:54:51) dazo: ahh, no ... the Cookbook used a different approach to sh=
ow a pop-up with a server pushed message (page 158)
(13:55:53) dazo: plaisthos++
(13:57:07) plaisthos: the random example stuff I found in an old document=
 decodess to:
(13:57:21) plaisthos: {b'script_stdin': b'{"auth_cookie": "a274c1c9f1c6e9=
bd16705c5dd7c01ac0"}', b'script.all.user.connect': b'#!/usr/bin/env pytho=
n\n\n# client-side connect script that securely receives argdict\n# from =
server side post_auth script (pasvar.py).\n\nimport sys, json\nargdict =3D=
 json.loads(sys.stdin.read())\nprint "ARGDICT: %r" % (argdict,)\n'}
(13:58:36) plaisthos: let's better ignore 'echo' :D
(14:00:19) cron2: yeah... scares...
(14:00:58) dazo: :-D
(14:02:43) cron2: well, management-notes.txt explains how the GUI can sub=
scribe to "echo", but not what echo commands have been defined, if "defin=
ed" is the right word here
(14:04:51) dazo: I don't think it's been defined .... it's depending on t=
he GUI ;-)
(14:11:18) mattock: smoke-testing windows installers now, then announceme=
nts
(14:11:26) mattock: also fixing the builder buildslave which was not full=
y fixed
(14:12:02) lev__: mattock: lemme test too
(14:14:16) plaisthos: https://openvpn.net/vpn-server-resources/explanatio=
n-of-client-side-scripting-with-simple-examples/
(14:14:17) vpnHelper: Title: Explanation of client-side scripting with si=
mple examples | OpenVPN (at openvpn.net)
(14:15:12) mattock: lev: thanks!
(14:16:01) mattock: "seems to work
(14:16:06) mattock: I will try out a clean install as well
(14:16:12) mattock: was upgrade from rc1 to rc2
(14:18:28) mattock: clean install looks good as well
(14:18:40) mattock: will update the download page next
(14:19:14) lev__: tap version is 9.24.4.601 from 27.8.2020
(14:19:30) lev__: isn't it supposed to be updated
(14:21:23) mattock: yes and it has been updated
(14:21:27) mattock: according to my installation
(14:21:35) mattock: did you do an upgrade?
(14:21:56) mattock: I unfortunately did not check tap-windows6 version _b=
efore_ trying the "clean install" approach
(14:22:09) mattock: let me double-check something
(14:24:56) mattock: I don't see anything wrong in tap-windows6 repo (e.g.=
 there's no "PRODUCT_CODE" to update)
(14:25:38) mattock: maybe the upgrade logic does not work correctly for t=
ap-windows6?
(14:27:40) lev__: (I upgraded from rc1 to rc2)
(14:27:40) lev__: also noticed that uninstallation of Connect 2.x stops i=
nteractive service
(14:27:40) lev__: with clean install I got 9.24.5.601
(14:27:40) lev__: yeah, reproduced again
(14:27:40) lev__: upgrade from rc1 to rc2 doesn't upgrade drivers
(14:27:40) Hai abbandonato il canale
(14:28:20) L'argomento di #openvpn-meeting =C3=A8: Agenda at https://comm=
unity.openvpn.net/openvpn/wiki/Topics-2020-09-24
(14:28:20) L'argomento per #openvpn-meeting =C3=A8 stato impostato da daz=
o a 21:01:44 su 24/09/2020
(14:28:25) mattock: lev: ok, not good
(14:28:30) mattock: but fixable without a full release
(14:29:03) lev__: assuming that problem is not in msica
(14:29:07) mattock: lev: are you interested in figuring out the "why"?
(14:30:22) lev__: I guess I have to
(14:39:15) mattock: that would be very helpful
(14:39:44) mattock: you're becoming our resident Windows MSI/WiX/tap-wind=
ows6 expert slowly :)
(14:40:01) cron2: plaisthos: magic indeed

--------------D366267C8F446D582161B45A
Content-Type: application/pgp-keys;
 name="pEpkey.asc"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="pEpkey.asc"

-----BEGIN PGP PUBLIC KEY BLOCK-----

mQENBF9XbKwBCADAEsX9sF+0PauqVCIX5SzteYzz2/awfjio7R4A7yGOkCPyFZui
ryItvJ9Oh21Woq2DW41JNZ16BR+3gJnWZ2wjKrYORXkk6Cq2mGfs1VHkikOXGeKh
G0kmNgewOB2xrbk27VvhALeUBRlbHF5w1XqGekm1tB/a8OThiyLA/jCzTf8LGSCq
rZoeg/DSvUNoOIuz/VzKvPRBNrvBgGfoR4qMmg5m6OaneaPckCuT58eNDMOGW3SD
f1wk31xBaqHNV2VMAyFuioxl3oyWdjp0dwdvgop+/l/8TJ/gUWqfQ8k5sik40Vlr
LrTwlR5+2/zOutJIy2N4T3xvz/4W6AthWe5BABEBAAG0JVNhbXVsaSBTZXBww6Ru
ZW4gPHNhbXVsaUBvcGVudnBuLm5ldD6JAVQEEwEIAD4WIQTUwk9SkPxedAa+noMq
Bow1gbDSfQUCX1dsrQIbAwUJAeEzgAULCQgHAgYVCgkICwIEFgIDAQIeAQIXgAAK
CRAqBow1gbDSfU62CACJBr2t6bor5THu7nx6NMTV2ubtsUYyHiLD4FeMXgRDSMhV
1GPJwSVF7qg1yNShlqco04Hykp/hDP83CG6ivZC21QACcVaUnRfACDETBGZ5ciUi
gLwjknDR9sQ9azOoqPp+bNBrlLWiQdYw7nyuNUYYGXQkv2stj7Rb11fR8IkWhIky
2VK8n5ppd3Al1nTNWxZkrTBgCO/JYXSWaZXFydwOPQxlzIBBeUoM3yoVxCP7qypu
ZbVQrDSX9L4LAFIBtgWaEBc2a2ocdlrwcQTovC8CWbg/b+0cG0FUsCuRhH4hsZOI
UiOwGGku2uLH5+JNKNDYgNmWgBZhV6wl59X4iZqguQENBF9XbKwBCADuoJFZ4PwJ
aCXWadIuuhy7pn+Gu7og85UGbb0xuI2mPtzR83V2qur/LeY8OnQSMSyy5n3ZBim5
noTe7la+9v/sYX+CC9Zj9KXXkTYiwDWtg+Pvwwjooee/ea336/kYaQSn1L2KHOJW
SgkQlfvM5FIvekQRvJ7scHn0o1tXKCtKVAOP9XIZdl2Dp+QGtKRAwJRFUiyd5oMq
7vY2x0YJoRS9Looq/+iqYNM+9zU0CjRNSXzfnKxBzSOVLtYBDFsud2LCt0bE5Gky
RFBq6cbJUt6aQInzzxVPW7kzEGKHi25AeCZ5UkX07eIGLwNO7PAX7A6YmsbF4Xbd
21sZEbb6EBVtABEBAAGJATwEGAEIACYWIQTUwk9SkPxedAa+noMqBow1gbDSfQUC
X1dsrAIbDAUJAeEzgAAKCRAqBow1gbDSfQe7CACZ6GI+rgKsIuXzhbyafZALyk55
d7I/6iFYNhCYUrVSOT187fhu1F/NTMCvcgQiOly+vvi9Xnw1JJTHVRSAmSMtCz/i
pM8mwU9HHQpHaN6adLdPsfhqsQM3/rGpQ6eGaNimfiQygA1YESvQIUC/edYw3ItF
4LOGu0Eyl5fbXV17ei21BzYiSrqtoBVfS0/G6p9fhP6j8w6OmpIc+ugSY/JmHNMb
NAjg6BR4Uuib/XeMIhtm57UmZqtJzBN0K61exQ2dJTvVdQ4X7wIqB73q3oNLJqJ1
kCZgoaLwFQhBMvRgh8zmk3Xm45RrmJAuPtgT4lzD1QcH0HZLkQFeI5QuHNC8
=3DqMWb
-----END PGP PUBLIC KEY BLOCK-----

--------------D366267C8F446D582161B45A--

