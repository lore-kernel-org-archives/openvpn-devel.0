From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
References: <5913da48-b476-7922-4248-8700ba21aa61@...515...>
Message-ID: <bb2c6340-1d7f-c51a-fad5-7b7d9829fa4a@...515...>
Date: Wed, 12 May 2021 16:22:58 +0300
MIME-Version: 1.0
In-Reply-To: <5913da48-b476-7922-4248-8700ba21aa61@...515...>
Content-Type: multipart/mixed; boundary="------------6092F446647B12CF3535689E"
Content-Language: en-US
Subject: [Openvpn-devel] Summary of the community meeting (12th May 2021)
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
--------------6092F446647B12CF3535689E
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit


Hi,

Here's the summary of the IRC meeting.

---

COMMUNITY MEETING

Place: #openvpn-meeting on irc.freenode.net
Date: Wed 12th May 2021
Time: 14:00 CET (12:00 UTC)

Planned meeting topics for this meeting were here:

<https://community.openvpn.net/openvpn/wiki/Topics-2021-05-12>

Your local meeting time is easy to check from services such as

<http://www.timeanddate.com/worldclock>

SUMMARY

cron2, dazo, d12fk, lev, mattock, ordex and plaisthos participated in 
this meeting.

---

Talked about OpenVPN 2.6 patches that are a requirement for the upcoming 
DCO patches:

- Two patches are related to refactoring the TLS state machine
- The p2p ncp/remove ncp-disable pair is a fairly large change
- cmake build/autoconf patches
- a few other patches

---

Talked about ARM64 support in MSI installer. Lev was able to work around 
the various problems and thinks the next OpenVPN 2.5 MSI installer could 
have arm64 support. No code changes were required for OpenVPN, but the 
build system did require some work.

Current limitations of MSI + ARM64 are

1) no pkcs11
2) no wintun
3) no multiline and non-english strings in openvpn-gui

The first two may solveable fairly easily if they can be built natively 
for arm64.

The third is because openvpn-gui resources are not compatible with msvc 
resource compiler (which doesn't recognize multiline strings). So right 
now arm64 version uses a special msvc-compatible resource file created 
from the english original with all multiline strings trimmed.

D12fk volunteered to have a look at the multi-line issue tomorrow. Lev 
will look into wintun and pkcs11.

---

Noted that there are various ways to run Windows 10 on ARM64:

- Raspberry PI4 (apparently "proof of concept"-slow)
- Amazon Linux ARM64 instance with QEMU on top
- Apple M1 arm64 laptops with virtualization
- Linux x86 with qemu and arm64 VM

---

Noted that openvpn.net domain is still missing IPv6. No changes since 
last week as far as we know.

---

Full chatlog attached


--------------6092F446647B12CF3535689E
Content-Type: text/plain; charset=UTF-8;
 name="openvpn_irc_meeting_chatlog_2021-05-12.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="openvpn_irc_meeting_chatlog_2021-05-12.txt"

(14:59:33) d12fk: good day
(14:59:33) cron2: mahlzeit :)
(14:59:33) d12fk: ah another early bird
(14:59:33) d12fk: i thought I heard an echo
(14:59:33) ***: Playback Complete.
(14:59:37) mattock: hi
(14:59:45) lev__: hyv=C3=A4=C3=A4 p=C3=A4iv=C3=A4=C3=A4
(14:59:51) cron2 ha scelto come argomento: https://community.openvpn.net/=
openvpn/wiki/Topics-2021-05-12
(15:00:12) dazo: Hey!
(15:01:38) ordex: hi hi
(15:03:42) mattock: short topic list
(15:04:13) ordex: something is missing from last week
(15:04:59) ordex: please refresh
(15:05:00) ordex: :)
(15:06:17) d12fk: can someone check my email addr in trac pls
(15:06:22) mattock: +1
(15:06:30) d12fk: thinking it might point to my old employer
(15:06:46) d12fk: was: refresh =3D)
(15:06:47) mattock: you have to change it from the "account" menu
(15:06:51) mattock: d12fk
(15:06:56) d12fk: not without a password
(15:07:04) mattock: mkay
(15:07:08) ordex: he is chickened
(15:07:09) cron2: wait
(15:07:12) mattock: chickened and egged
(15:07:13) plaisthos: moin moin
(15:07:16) ordex: needs an egg
(15:07:19) ordex: moin
(15:07:32) mattock: I need to play some ldap games then
(15:07:37) d12fk: start with a mcnugget
(15:07:38) mattock: I will start mentally preparing for it
(15:07:44) cron2: can't you change that in the admin interface?
(15:08:10) mattock: pwm does have an admin interface but that's disabled
(15:08:30) mattock: the ldap server has an admin interface which does not=
 work for me and I have not bothered to look into it :D
(15:08:42) cron2: I thought you could do that in the trac admin interface=
, but no, that's all nonclickable
(15:08:43) mattock: though I can check if trac maintains its own email ad=
dress setting
(15:08:52) cron2: (and indeed, it's the old address)
(15:09:14) ordex: d12fk: squeeze your brains and remember that password!
(15:09:15) ordex: :D
(15:09:20) d12fk: not an pressing issue anyways
(15:09:47) d12fk: will try a few password until i'm locked out
(15:10:00) mattock: ok
(15:11:12) ordex: so
(15:11:15) ordex: we go with #1 ?
(15:12:11) ordex: for 2.6 we have two more patches that were ACK'd (still=
 about refactoring the TLS state machine) - the rest will have to be reba=
sed by plaisthos and resent because new changes were introduced in the mi=
ddle
(15:12:15) ordex: due to review
(15:12:33) ordex: plaisthos: how many pre-dco patches do we have after th=
is batch is merged?
(15:12:57) plaisthos: lets see
(15:14:34) plaisthos: the p2p ncp/remove ncp-disable pair is another bigg=
er patch
(15:14:51) d12fk: found password, ldap also has the private email, probab=
ly still graylisted, that's why I didn't get anything
(15:15:04) d12fk: \o/
(15:15:08) plaisthos: then 3-5 smaller ones
(15:15:50) plaisthos: there is also some patches that are unrelated to DC=
O still in my tree, like all the patches belonging to the whole cmake bui=
ld/autoconf
(15:16:04) ordex: ok
(15:16:08) lev__: yay, cmake
(15:16:13) ordex: but they can be done in parallel
(15:16:23) ordex: or in any order we like
(15:16:31) ordex: plaisthos: about p2p-ncp there were 3 patches on the li=
st
(15:16:33) ordex: 1 was merged i think
(15:16:41) plaisthos: yes
(15:16:43) ordex: 1 is waiting (remove --ncp-disable) and one has to be r=
esent
(15:16:53) ordex: other than those you have mre patches in your tree abou=
t this topic ?
(15:16:56) ordex: *more
(15:17:00) plaisthos: I want ncp-disable/add p2p ncp to in together
(15:17:10) ordex: yeah
(15:17:12) ordex: ok
(15:17:31) plaisthos: because ncp-disable breaks the non pull codepath un=
til the p2p ncp is in
(15:17:34) ordex: then we will finish with the TLS restructuring (getting=
 there...) and then you will send this new pbatch for ncp/p2p ?
(15:17:39) ordex: yeah
(15:17:43) plaisthos: basically p2p directly goes from never ncp to alway=
s ncp
(15:17:54) ordex: :D yeah
(15:18:47) ordex: so we will see that patchset once we are done with the =
tls state machine, right?
(15:18:54) plaisthos: but no, there no more p2p ncp patches in there
(15:18:59) plaisthos: ordex: yes, for now :)
(15:19:08) ordex: ok :)
(15:19:10) ordex: goood
(15:19:15) ordex: anything else on 2.5/2.6 ?
(15:19:36) lev__: I think we can have MSI installer for the next 2.5 rele=
ase
(15:19:57) lev__: I mean ARM64 MSI installer :)
(15:19:58) cron2: "MSI installer with arm64", I think :)
(15:19:59) cron2: yeah
(15:20:05) ordex: cool
(15:20:22) lev__: just submitted PR to openvpn-build
(15:20:27) plaisthos: ordex: 2.7-master can then remove all the leftover =
states/variables that are still needed for non-TLS state
(15:20:45) mattock: \o/
(15:20:53) lev__: no code changes are required for openvpn, just playing =
a bit with build system
(15:20:56) cron2: lev__: I saw your patch & PR, but did not have time to =
look more closely
(15:21:25) ordex: plaisthos: 2.7 ? you mean after the 2.6 release?
(15:21:50) lev__: current limitations are 1) no pkcs11 2) no wintun 3) no=
 multiline and non-english strings in openvpn-gui
(15:21:52) plaisthos: yes
(15:22:02) plaisthos: basically when we remove --secret support
(15:22:02) ordex: oky
(15:22:06) ordex: yeah
(15:22:07) ordex: cool
(15:22:12) ordex: a lot of code pruning :)
(15:23:28) ordex: ok
(15:24:01) ordex: lev__: those limitations will be overcome later? or the=
re is something else to solve?
(15:24:34) cron2: lev__: what is breaking with the gui strings?
(15:25:57) lev__: openvpn-gui resources are not compatible with msvc reso=
urce compiler (which doesn't recognize multiline strings). So I had to cr=
eate a special msvc-compatible resource file from -en version and trim al=
l multiline strings
(15:26:21) cron2: and openvpn-gui is mingw-compiled today?
(15:26:27) lev__: yes
(15:26:51) lev__: for arm64 everything is compiled with msvc
(15:26:53) cron2: so you're actually shiping a "pure arm64" code bundle, =
not "an installer that puts intel binaries into emulation mode"?
(15:27:10) lev__: exactly
(15:27:14) cron2: nice
(15:27:25) cron2: (not that the performance of openvpn-gui would be very =
interesting... but still, nice :-) )
(15:29:08) lev__: I could try to build wintun arm64 msm based on 0.8 vers=
ion we currently use
(15:29:28) d12fk: lev__: so the .rc issues are resolved?
(15:29:41) lev__: d12fk: no no
(15:30:05) mattock: the less tricks we have to play with the installer th=
e better imho
(15:30:43) lev__: localization is missing and multiline strings and conve=
rted to single line with rest of lines removed
(15:30:45) mattock: we have the snapshot nsis installer for the poor soul=
s who need 2.5 and use arm64 on windows
(15:32:51) lev__: there are no much changes to the installer
(15:34:23) lev__: also they're "backward compatible" - if there is no "..=
/generic/image-arm64" directory it just skips arm64 msi build
(15:34:48) cron2: so what is the way forward for the .rc stuff?
(15:34:54) cron2: we'd miss our multiline strings...
(15:35:21) lev__: I think d12fk volunteered yesterday to look into in
(15:35:55) d12fk: yeah will have time tomorrow
(15:36:47) lev__: I can look into pkcs11 msvc build
(15:38:25) mattock: windows on arm64 just became a first-class citizen in=
 the OpenVPN project :)
(15:38:35) mattock: anything else on arm64?
(15:38:42) cron2: I really need to install parallels+arm-win on my M1 now=
!
(15:39:38) lev__: cron2: I can provide a signed ARM64 MSI to test
(15:39:45) ordex: but doesn't qemu support arm64 (on x86 host)?
(15:40:25) ordex: there is aarch64
(15:40:34) ordex: wouldn't that help to run windows for testing?
(15:40:49) cron2: ordex: yeah, but why, if I have a laptop with an M1 CPU=
? :-)
(15:40:55) ordex: ah sure :)
(15:41:07) ordex: I Was looking at what options I have
(15:41:34) lev__: rpi4 ?
(15:41:36) cron2: not sure if qemu supports win10 guests...
(15:41:39) plaisthos: judging from how sluggish Android on arm64 is ...
(15:41:47) plaisthos: cron2: it does
(15:41:52) cron2: supposedly an rPI4 works, but I've heard that it's "pro=
of of concept slow"
(15:42:00) plaisthos: cron2: all the kvm emulation on linux is also qemu =
:)
(15:42:07) ordex: windows on rpi ?
(15:42:18) mattock: yes, that is possible
(15:42:25) ordex: must be slow yeah :p
(15:42:38) ***ordex recompiles qemu with aarch64 support
(15:42:57) plaisthos: I have also seen a qemu + windows on mac m1
(15:42:59) cron2: plaisthos: yeah, but "amd64", so I wasn't sure if you n=
eed stuff like "an arm64 bios" etc. to make Windows happy
(15:43:48) ordex: I'll let you know :p
(15:44:03) ordex: should we move on?
(15:44:08) ordex: or we have more for msi and windows?
(15:44:35) cron2: where would one find a windows/arm64 demo iso?
(15:45:19) ordex: good question
(15:45:22) ordex: on thepiratebay ?
(15:45:26) ***ordex hides
(15:45:37) plaisthos: https://winaero.com/install-windows-10-arm-qemu/
(15:45:44) plaisthos: that might have links
(15:45:59) ***cron2 klicks
(15:46:06) mattock: the evalution windows versions are freely available
(15:46:08) mattock: not sure of arm64
(15:46:32) mattock: they have an expiration timer which you can reset man=
ually some times
(15:46:34) ordex: that link uses a strange procedure
(15:47:22) d12fk: lol at the boot logo "windows on arm"
(15:47:45) plaisthos: yeah that is the logo from the uefi bios
(15:48:08) plaisthos: normally you get a HP/Dell whatever logo
(15:48:27) plaisthos: or a "REPULIK OF GAMERS" if you have an ASUS gaming=
 mainobard
(15:49:20) plaisthos: ordex: it might be actually be feasable to run qemu=
 with vnc on the amazon arm64 instances with a acceptable performance
(15:49:35) ***lev__ faints
(15:49:39) ordex: mah i will give qemu locally a try first
(15:49:52) cron2: are there amazon arm64 windows instances?
(15:49:57) plaisthos: cron2: yes
(15:50:03) plaisthos: no
(15:50:07) plaisthos: arm64 linux instances
(15:50:34) plaisthos: but qemu on arm64 to emulate windows arm64 is proba=
bly a lot faster than on amd64
(15:50:39) cron2: yep
(15:51:02) mattock: 10 minutes
(15:51:17) mattock: I suspect we don't have any really important topics l=
eft? :P
(15:51:28) plaisthos: ordex: or you make a point to the company that you =
need a new macbook to test windows
(15:51:31) plaisthos: :D
(15:51:35) cron2: I just got a complaint that openvpn.net has no v6
(15:52:22) ordex: plaisthos: nah
(15:52:30) ordex: better stay away from windows, officially :D
(15:52:34) ordex: cron2: eh .-.
(15:52:44) ordex: I Was hoping to have some updates from yesterday's meet=
ing...but nothing so far
(15:52:48) ordex: so "nothing has changed"
(15:53:02) cron2: people were ranting about websites that should have v6 =
but haven't, especially those with cloudflare...
(15:53:47) ordex: right
(15:53:53) ordex: because it comes for "free"
(15:57:59) mattock: 3 minutes
(15:58:17) ordex: i guess we respotpone --no-replay to next week
(15:58:31) cron2: it wasn't on the agenda when I looked :)
(15:58:54) ordex: :p
(15:59:56) d12fk: okay heading out then, byebye
(16:00:12) ordex: yeah, I guess we can conclude here :)
(16:02:31) dazo: a meeting with me just observing ..... wow! :-P
(16:02:57) cron2: we thought you fell asleep :-)
(16:03:15) ***cron2 was not very active today either... doing interesting=
 things to my fax software
(16:03:23) plaisthos: I am gathering a patch set with the "other patches"=
 that are mainly for cmake builds and other small cleanups
(16:03:45) dazo: cron2: fax still in 2021? ... that's another wow! :)
(16:03:51) mattock: that's cool cron2
(16:03:57) cron2: this customer is sending about 6000 faxes a day...
(16:04:03) cron2: so yes, still relevant
(16:04:03) mattock: I mean fax is cool technology, though I've only used =
it once in 1990's
(16:04:14) plaisthos: that is state of the art for fighting Corona in Ger=
many!
(16:04:31) dazo: If mattock children picks up their fathers interest for =
ancient things .... they will rebuild fax machines in 20 years :-P
(16:04:38) cron2: plaisthos: and *that* is why I need to touch things, ac=
tually
(16:04:45) plaisthos: lol
(16:04:48) mattock: there's something magical in putting a paper in a mac=
hine and (almost) the same paper appearing in a completely different plac=
e out of a different machine
(16:04:52) cron2: like, "300 faxes for the same machine in the queue, and=
 the receiving phone number BUSY half the day"
(16:04:58) cron2: that upsets my scheduler just a little bit
(16:05:24) plaisthos: at least you are not encrypting with ECB mode like =
Lucca!
(16:06:17) dazo: heh

--------------6092F446647B12CF3535689E--

