From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
References: <5913da48-b476-7922-4248-8700ba21aa61@...515...>
Message-ID: <30a502f8-99c0-a8d2-a955-ef56ee325bdb@...515...>
Date: Wed, 19 May 2021 16:31:20 +0300
MIME-Version: 1.0
In-Reply-To: <5913da48-b476-7922-4248-8700ba21aa61@...515...>
Content-Type: multipart/mixed; boundary="------------0324E65DB9E312ED808EA081"
Content-Language: en-US
Subject: [Openvpn-devel] Summary of the community meeting (19th May 2021)
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
--------------0324E65DB9E312ED808EA081
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

Here's the summary of the IRC meeting.

---

COMMUNITY MEETING

Place: #openvpn-meeting on irc.freenode.net
Date: Wed 19th May 2021
Time: 14:00 CET (12:00 UTC)

Planned meeting topics for this meeting were here:

<https://community.openvpn.net/openvpn/wiki/Topics-2021-05-19>

Your local meeting time is easy to check from services such as

<http://www.timeanddate.com/worldclock>

SUMMARY

cron2, dazo, d12fk, lev, mattock, ordex, plaisthos and syzzer 
participated in this meeting.

---

Noted that native OpenVPN 2.5 on ARM64 (OpenVPN build, MSI, 
dependencies, etc) is progressing very nicely. We could build an 
ARM64-compatible 2.5.2 installer with fairly small amount of manual 
tinkering now. Only Wintun support would be missing. The msibuilder VM 
in openvpn-vagrant may need to be upgraded to install WiX 3.14 (that has 
ARM64 support).

---

Noted that openvpn.net domain is still missing IPv6. No changes since 
last week as far as we know.

---

Talked about removing --no-replay option. Noted that it was to be 
removed in 2.5, but we backpedaled on that decision and forgot to change 
our documentation. It was also noted that that option changes the wire 
format.

Noted that --cipher none --auth none and --no-replay are quite 
intertwined. Getting rid of these options would be good from security 
perspective, but it was also noted that plain-text OpenVPN tunnels do 
have some advantages over the alternatives like GRE tunnels.

Summarizing the discussion:

1) OpenVPN 2.6: reject configs where --no-replay is used without --auth 
none.
2) OpenVPN 2.7: remove --no-replay
3) Add clear warnings to 2.5 and 2.6 about 1) and 2)

---

Noted that mattock buildbot setup is shaping up nicely. There are a ton 
of workers and code and data are quite well separated. Mattock is now 
working on limiting concurrent builds on the docker host, then moving on 
to t_client tests.

---

Full chatlog attached


--------------0324E65DB9E312ED808EA081
Content-Type: text/plain; charset=UTF-8;
 name="openvpn_irc_meeting_chatlog_2021-05-19.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="openvpn_irc_meeting_chatlog_2021-05-19.txt"

(14:57:15) ordex: heya
(14:59:19) plaisthos: hey
(14:59:25) dazo: hey!
(14:59:33) d12fk: hi
(15:00:25) mattock: hi
(15:01:12) lev__: Hi
(15:03:25) cron2: ohaiu
(15:03:43) ordex ha scelto come argomento: https://community.openvpn.net/=
openvpn/wiki/Topics-2021-05-19
(15:04:07) ordex: added point 3
(15:05:37) mattock: all ready?
(15:05:42) cron2: this cloudflare shitshow with the URL massacring is ann=
oying
(15:05:43) plaisthos: yeah
(15:05:46) dazo: yeah
(15:06:40) cron2: booting FreeBSD/Arm64 right now... $something is insane=
ly slow...
(15:06:57) mattock: ah, I got the topic page now :)
(15:07:00) mattock: sync up
(15:07:21) plaisthos: cron2: on your m1 mac?
(15:07:23) cron2: yep
(15:07:29) cron2: (in parallels)
(15:08:02) cron2: might just be the virtual CD rom, will see after instal=
lation
(15:08:10) cron2: win10 sort of felt normal
(15:10:21) cron2: so, meeting? :)
(15:10:55) ***dazo is ready
(15:11:07) mattock: yes, sync up
(15:11:45) cron2: I have not much to report... I broke one of the patches=
, and the other did not apply anymore (*selfslap*), but a v3 is there whi=
ch I haven't looked at yet...
(15:12:34) cron2: today and tomorrow is RIPE meeting, so busy.  Friday+we=
ekend looking good.
(15:14:06) cron2: lev__, d12fk and selva seem to do a great job on the AR=
M64 installer
(15:14:29) ordex: plaisthos you should be sending rebased patches soon, r=
ight? (for the x/7 patchset)
(15:14:40) d12fk: mostly the other two
(15:14:47) plaisthos: yeah
(15:14:57) lev__: yeah after openvpn-build PR is merged, arm64 should be =
done (except wintun)
(15:14:58) plaisthos: I need to fixup the connect patch to work with p2p =
first :/
(15:15:03) syzzer: hi :)
(15:15:16) d12fk: hi syzzer
(15:15:24) lev__: hi syzzer!
(15:15:24) mattock: hi!
(15:15:44) ordex: !
(15:15:52) ordex: plaisthos: ah right
(15:17:45) plaisthos: I am probably opting for a hacky solution as the wh=
ole code block gets removed eventually by the p2p ncp and S_GENERATED_KEY=
 anyway
(15:17:53) cron2: syzzer! welcome back :-)
(15:18:38) ordex: plaisthos: if that code gets removed, might it make sen=
se to merge the two patches back2back ?
(15:18:55) ordex: rather than fixing a case that is broken for one commit=
 only?
(15:18:57) cron2: that was my idea as well
(15:19:20) ordex: it feels like "it's a needed step towards salvation", s=
o probably acceptable
(15:19:26) cron2: if we have two ACKed and "together everything passes" p=
atches, we could do that
(15:19:33) plaisthos: if that is okay I can do that too
(15:19:36) cron2: (if the patch in between only breaks a corner case)
(15:19:42) ordex: yeah
(15:20:07) ordex: implementing "a hacky transient solution" doesn't sound=
 any better after all, something might still be broken
(15:20:41) plaisthos: basically non-ncp code paths are broken in the patc=
h
(15:20:49) plaisthos: cron2: did you have tests with ncp-disable?
(15:20:56) plaisthos: they *might* be broken too
(15:20:58) ordex: the patch breaking tls/p2p is 1788 ?
(15:21:00) cron2: wait
(15:21:21) cron2: plaisthos: not on the server
(15:21:37) cron2: there are a few client instances that do ncp-disable, a=
nd these pass
(15:22:18) cron2: both "ncp-disabled client -> server+1788" and also "cli=
ent+1788 +ncp-disable -> older server"
(15:22:34) cron2: but no "server+1788 + ncp-disable"
(15:22:45) plaisthos: yeah client has the read/write key2 methods in the =
different order andere therefore doesn't break
(15:23:47) ***cron2 notes "add server instance with ncp-disable"
(15:23:59) plaisthos: cron2: maybe not
(15:23:59) plaisthos: :)
(15:24:10) plaisthos: 5 patches later we remove ncp-disable
(15:24:20) cron2: that would break my server config!
(15:24:24) ***ordex swims in the patches
(15:24:59) ***cron2 waits until ordex resurfaces and will then ask for gu=
idance :)
(15:25:10) ordex: :D
(15:25:28) ordex: how can I help?
(15:28:34) mattock: cron2 dove into patches? :)
(15:28:45) ***cron2 waits for IPv6 on community
(15:28:48) ordex: he went deep I think
(15:29:04) ***ordex bets on Italy reaching 90% coverage before ipv6 can h=
it community
(15:29:14) mattock: what is the coverage now?
(15:29:20) ordex: 5% ?
(15:29:30) cron2: nah, this patchset is definitely above what I can manag=
e to understand in between a RIPE meeting :-) - so I wait for ordex and p=
laisthos to tell me "this + that, back2back" :-)
(15:29:31) mattock: I might have IPv6 now, not sure, changed to 5G connec=
tion
(15:29:38) d12fk: coverage is the future, just like ipv6
(15:29:40) ordex: cron2: oky
(15:29:55) mattock: anything more on 2.5 / 2.6?
(15:30:44) cron2: hailstorm
(15:32:00) ordex: patchstorm you mean ?
(15:32:02) ordex: so #2 ?
(15:32:12) cron2: nah, weather outside
(15:32:21) mattock: nothing new on #2 afaik
(15:32:29) mattock: the famous .com migration is ongoing
(15:32:35) mattock: whatever that means exactl
(15:32:36) mattock: y
(15:32:38) cron2: but anyway, 2.5 - not much has happened.  We could rele=
ase a test installer of 2.5.2 with arm64 eventually...
(15:32:46) cron2: openvpn.com has IPv6 address 2606:4700::6812:1069
(15:32:56) cron2: *that* sounds quite good
(15:33:39) mattock: what is the level of buildsystem kludginess required =
by arm64 msi now, lev?
(15:33:41) cron2: ordex might reach this over v6 now!
(15:34:03) ordex: /o/
(15:35:16) ordex: I can, with 10ms latency
(15:35:19) ***ordex drinks
(15:35:24) ordex: now, #3?
(15:35:39) cron2: mattock: selva and d12fk fixed stuff yesterday
(15:35:47) mattock: good!
(15:35:54) plaisthos: does anyone know if no-replay changes wire format o=
r not?
(15:36:10) cron2: yes
(15:36:30) cron2: oh
(15:36:31) cron2: maybe not
(15:36:38) ***cron2 confuses with --no-iv
(15:37:06) ordex: maybe syzzer knows
(15:37:11) ordex: I thought it would not affect the wire format
(15:37:16) plaisthos: hm
(15:37:20) plaisthos: looks like it does
(15:37:26) ordex: omg
(15:37:36) dazo: I also did not expect wire format change
(15:37:39) ordex: why would it ?
(15:37:45) plaisthos: it seems to toggle inclusion of packet id in the wi=
re format
(15:37:46) ordex: isn't it just a check on the packet # ?
(15:38:01) ordex: so --no-reply will remove the packet id ?
(15:38:27) ordex: *replay
(15:38:48) ordex: it is also part of the OCC
(15:38:49) ordex: string
(15:38:53) dazo: Perhaps we should just write a new OpenVPN protocol and =
fix all these ambiguities ..........
(15:39:09) dazo: (and leave the current one as is)
(15:39:15) cron2: one should write an RFC to document what we have, so we=
 can look up the wire format in the standard...
(15:39:37) mattock: I recall dazo was at some point writing an RFC
(15:39:45) dazo: well, that too ... but then we need to understand the co=
de deeply to understand it
(15:39:51) plaisthos: for aead/ofb/cfb packetid is the same IV
(15:39:58) plaisthos: for cbc iv and packet id are distinct
(15:40:22) dazo: I do have a skeleton ready, which covers most of the con=
trol channel ... but the protocol is highly adoptable according to enable=
d features
(15:40:30) dazo: many not pushable
(15:41:01) ordex: btw you can check the function crypto_adjust_frame_para=
meters() to see how the packet ID affects the frame siz calculation (henc=
e the wire format)
(15:41:07) ordex: we even have two packet ID formats
(15:41:12) ordex: affecting the size differently
(15:41:13) dazo: yes
(15:41:28) plaisthos: openvpn_encrypt_v1 also has code that only writes p=
acket id when it is enabled
(15:41:40) plaisthos: so yes no-replay is part of the wire protocol
(15:41:57) ordex: FWIW an alternative could be to just go with "remove th=
e knob and assume always enabled, without changing the logic"
(15:42:14) ordex: just to avoid people from activating --no-reply
(15:42:25) cron2: replay
(15:42:26) cron2: :)
(15:42:49) ordex: in any case, the setups we would break are those with a=
uth/cipher none and no-replay enabled - they would need to deactivate it =
on the other side
(15:42:52) dazo: well, that's they suggestion from syzzer .... but that w=
ill break configs explicitly using --no-replay today
(15:42:53) ordex: yeah, thanks :D replay
(15:43:33) plaisthos: Yeah not sure syzzer was aware of the wirelevel cha=
nge when he made his suggestion
(15:43:41) dazo: but I'm not sure I care enough for --no-replay users at =
all .... it feels more like a debug/testing feature than something you re=
ally want in production
(15:43:49) ordex: dazo: yes, but I'd argue it is meaningful for these peo=
ple to realize they are doing something wrong (i.e. using md5 for a certi=
ficate hash)
(15:43:57) ordex: dazo: exactly
(15:44:40) plaisthos: the whole discussion basically boils down to one th=
ing: how important is cipher none and compatibility with setups using it
(15:44:49) dazo: This option definitely falls into the "security related"=
 category
(15:45:37) ordex: plaisthos: I think for security sake, we can break thos=
e setups and tell people that no-reply has to be set for none
(15:45:58) dazo: "cipher none" is also something which should only be use=
d for testing/debugging in my view.  If you really want to have authentic=
ated packets, the crypto overhead the last 10 years should be fairly negl=
igible
(15:46:13) ordex: yap yap
(15:46:14) plaisthos: we also don't win much in that case since we still =
carry around the code for both scenarios
(15:46:28) dazo: If you expliclty want to use a clear-text tunnel, a GRE =
tunnel is most likely more useful
(15:46:29) ordex: imho it's a marginal number of users who get affected a=
nd those can deal with the understanding the setting they have to use mov=
ing forward
(15:46:51) plaisthos: which would imply, deprecating it in 2.6 and remove=
 it in 2.7?
(15:47:02) ordex: plaisthos: I'd say so
(15:47:09) plaisthos: and also get a ton of complains of users that are a=
ngry about removing cipher none
(15:47:27) ordex: well, we are not removing it, no?
(15:47:32) ordex: or are we already?
(15:47:36) cron2: DCO+AEAD should be faster than userspace+none
(15:48:00) dazo: plaisthos: deprecating 2.6 and removing 2.7 .... --no-re=
play or --cipher none?
(15:48:08) ordex: AEAD =3D=3D AES-GCM ?
(15:48:14) dazo: yes
(15:48:22) ordex: yeah, likely
(15:48:30) plaisthos: replay protection enabled with --auth none makes li=
ttle sense.
(15:49:03) ordex: right. ideally syzzer's last suggestion would be what w=
e want to implement in 2.7
(15:49:33) plaisthos: So either we keep the ability to disable it at leas=
t on auth none or we honestely drop cipher none as well as properly suppo=
rted cipher
(15:49:58) dazo: I'd say drop auth none and cipher none
(15:50:11) plaisthos: ordex: all aead ciphers, aes-gcm, aria-gcm, chacha2=
0-poly1305, aes-ccm
(15:50:39) plaisthos: dazo: gre doesn't do the dynamic setup for you like=
 openvpn does
(15:50:44) ordex: the idea is to also remove none from dco once we get to=
 a further stage
(15:50:51) ordex: (this was planned already)
(15:50:53) cron2: openvpn + cipher none still has benefits over GRE (name=
ly, client authentication, changing source address, and HMAC auth)
(15:51:13) cron2: so the argument "use GRE instead" does make little sens=
e
(15:51:27) plaisthos: yeah, nowadays full aes-gcm encryption is faster th=
an just auth sha1 but yes :D
(15:51:27) cron2: "DCO is faster than userland + none" is something I fin=
d more compelling :)
(15:51:56) ordex: we could start by dropping 'auth none'
(15:52:03) dazo: fair enough .... but from an OpenVPN security perspectiv=
e still supporting these "none" options also makes little sense
(15:52:07) ordex: and the pair 'auth none, cipher none'
(15:52:23) ordex: those two really make no sense, I think
(15:52:28) dazo: +1
(15:52:36) cron2: dazo: it does.  If you want authenticity, but do not ca=
re about encryption.
(15:52:46) plaisthos: oh well, trhe newest intel generation has SHA_NI, s=
o this might not be true anymore %)
(15:53:28) cron2: I'm not actually insisting on keeping cipher none, just=
 pointing out that there is something I consider a valid use case
(15:53:29) lev__: mattock: depends how installers are built for releases
(15:53:46) mattock: ok
(15:53:53) plaisthos: okay nevermind, my small intel nuc still manages to=
 have 5,7GB/s with aes-gcm and "only" 1,7 GB/s with SHA1
(15:53:54) lev__: one needs to run mbuild <magic> and copy output to imag=
e-arm64
(15:53:55) mattock: that's a vague answer but I accept it for now :)
(15:54:05) lev__: that should be enough
(15:54:11) lev__: *msbuild
(15:54:50) dazo: cron2: But is the use cases used widely enough to be wor=
th maintaining the additional code and protocol complexities this flexibi=
lity gives?
(15:55:21) cron2: as far as I understand, as long as we support non-AEAD =
ciphers, "none" is not actually that hard
(15:55:22) syzzer: woops - got distracted by $dayjob. Reading the backlog=
 now.
(15:55:23) dazo: as the --cipher none --auth none and --no-replay are qui=
te intertwined
(15:55:23) lev__: that requires cloning openvpn repo to windows builder, =
I don't think we currently do it? we build binaries on linux machine are =
copy via samba to windows, where we have openvpn-build cloned
(15:55:35) cron2: getting rid of all non-AEAD ciphers would simplify the =
code quite a bit
(15:55:54) cron2: but syzzer is more qualified to comment on complexity
(15:55:55) ordex: right cron2, but that probably is a bigger fish to catc=
h
(15:56:04) dazo: that's essentially where we're headed with DCO though
(15:56:05) lev__: so, 1) clone openvpn repo 2) run msbuild 3) copy output=
 to image-arm64
(15:56:12) ordex: to sum it up the proposal is: 1) we deprecate no-replay=
 in 2.6 2) we deprecate 'auth none' in 2.6 3) we deprecate 'auth none + c=
ipher none' in 2.6 ?
(15:56:18) syzzer: cron2: yes, but I think plaisthos is right that this w=
ill hurt, so rather long-term
(15:56:49) cron2: ordex: 3) is covered by 2) already :)
(15:57:33) ordex: h riiight
(15:57:37) ordex: my brain got stuck :)
(15:57:47) dazo: I wonder if --auth none and --no-reply should be coupled=
 in regards to deprecation/removal
(15:58:03) ordex: well, 1) and 2) imply that
(15:58:09) ordex: we deprecate both and remove both opions in 2.7
(15:58:14) ordex: *options
(15:58:25) ordex: we deprecate both in 2.6 and remove both opions in 2.7
(15:58:29) ordex: *options
(15:58:30) cron2: ordex: none-brain stuckee :-)
(15:58:44) mattock: lev: msbuild needs to run on Windows arm64, it's not =
cross-compilation is it?
(15:58:59) dazo: and since 3) is part of 2), and that 1) and 2) are impli=
cit ..... we end up tying them all up together :-P
(15:59:08) ordex: right
(15:59:13) ordex: couldn't be a better summary
(15:59:14) ordex: :D
(15:59:18) lev__: mattock: no I doesn't
(15:59:31) lev__: I mean it runs on x64
(15:59:34) mattock: ok
(15:59:35) plaisthos: I think getting rid of all non-AEAD cipher would be=
 nice but basically break the compability with anything before 2.4
(15:59:41) plaisthos: so I don't think we are ready for that
(15:59:43) ordex: we are hitting the 1h mark - do we feel this is a reaso=
nable plan forward?
(16:00:30) lev__: mattock: you might need to upgrade vagrant windows imag=
e to install wix 3.14
(16:00:35) dazo: plaisthos: I would say OpenVPN *community* is ready for =
it; but it depends if those packaging it is ready for it.  And that will =
keep some users on 2.5 and older for a bit longer.
(16:00:51) dazo: but once 2.6 is out ... 2.5 has at least 18 months of su=
pport from us.
(16:00:55) mattock: lev: at some point I'd like to add a real msvc buildb=
ot worker that uses msbuild
(16:01:19) dazo: and we can decide to have a bit longer 2.4 support cycle=
 if 2.5 vs 2.4 is an issue.
(16:02:01) lev__: mattock: with recent patch, msbuild buildsystem is self=
-contained, you dont need openvpn-build/msvc anymore
(16:02:07) dazo: (2.4 will need to be supported until Debian 9/10, most U=
buntu releases as well as RHEL/CentOS 8 goes EOL)
(16:02:18) lev__: someone needs to review/ack it
(16:02:25) ***lev__ looks at cron2
(16:02:30) ***cron2 looks at mattock
(16:02:30) dazo: RHEL/CentOS 7+8 actually
(16:02:37) plaisthos: dazo: I honestely do not think that complexity curr=
ently for this support those ciphers is big enough to drop support
(16:02:48) mattock: for the record: my buildbot setup in vagrant is prett=
y good shape now, tons of workers, code and data separated (simplified th=
e former a lot) - working on limiting concurrent builds on the docker hos=
t, then moving on to t_client
(16:02:54) plaisthos: we can certainly add warning messages to point user=
s to switch to better ciphers
(16:02:58) mattock: lev: yep, that was my hope
(16:03:05) ***ordex looks at the sky
(16:03:24) cron2: .oO(ordex sounded bored recently)
(16:03:29) dazo: it's not just about code complexity ... but having a cod=
e base with lesser ties to old features which we have deemed insecure
(16:03:36) syzzer: just finished reading backlog. what plaisthos says. th=
e code complexity isn't much. we'll likely not toch the old (non-AEAD) mo=
des again.
(16:04:21) ordex: basically it sounds like keeping it around some more is=
 not that problematic...later on we can still push it away, once it is sa=
fer from a compatibility perspective
(16:04:50) plaisthos: it is basically only the openvpn_encrypt_v1 and ope=
nvpn_decrypt_v1 methods that need to be kept
(16:04:53) syzzer: the thing with --auth none en --no-replay is that user=
 often don't understand the security implications
(16:05:05) ordex: yap
(16:05:28) ordex: "I see this replay error...I add --no-replay to fix it!=
"
(16:05:31) syzzer: which is basically what dazo said :)
(16:06:55) syzzer: remove the footguns :)
(16:06:57) dazo: but that won't work if you only do it on one side; as th=
e wire format changes ..... or?
(16:07:26) syzzer: correct
(16:07:33) dazo: at which this becomes a security related issue.
(16:07:37) dazo: Btw .... https://community.openvpn.net/openvpn/wiki/Quar=
kslabAndCryptographyEngineerAudits#OVPN-03-3:Insecureconfigurationoptions=
:--no-replay
(16:08:21) dazo: "luckily" we have not committed publicly to removing it =
in a specific version in relation to a security audit (like --no-iv)
(16:08:27) ordex: :D
(16:08:56) plaisthos: Going forward, we can deprecate or refused no-repla=
y without auth none
(16:09:14) ordex: wouldn't be better toalso deprecate auth none ?
(16:09:21) syzzer: --no-replay has been deprecated for years, right?
(16:09:31) dazo: https://community.openvpn.net/openvpn/wiki/DeprecatedOpt=
ions#Option:--no-replay
(16:09:36) ordex: syzzer: I don't think we print anything
(16:09:47) plaisthos: we do but only in openvpn --help
(16:09:47) syzzer: man openvpn says "       --no-replay
(16:09:48) syzzer:               DEPRECATED This option will be removed i=
n OpenVPN 2.5.
(16:09:50) dazo: it should have been removed already, just "missed the bu=
s" due to these implications
(16:09:51) ordex: OH
(16:09:55) plaisthos: that nobody reads :D
(16:10:02) ordex: so we are discussing something that was already decided=
 and we are late !!
(16:10:10) mattock: :)
(16:10:18) ordex: I think it's ok to remove it in master then ?
(16:10:19) mattock: we should read our own man pages? :P
(16:10:27) ordex: (will be 2.6, but feels "more polite")
(16:10:33) dazo: well, if these implications hadn't been discovered ... i=
t would have been gone in 2.5, I believe
(16:10:57) dazo: we just forgot to update the man and wiki page when we d=
ecided to postpone it
(16:11:06) ordex: yap
(16:11:09) syzzer: yeah, I wrote a patch a while ago. realized the subtle=
ties, then deferred. "Will do a write-up with proposal some time"
(16:11:10) mattock: I'll start writing the summary...
(16:12:49) ordex: thanks
(16:13:52) syzzer: Do we have a conclusion on --no-replay?
(16:14:28) dazo: "We're running and circles and are totally confused by -=
-no-replay"
(16:14:40) syzzer: haha
(16:14:41) dazo: s/ and / in /
(16:17:57) syzzer: If I understand correctly, there's two options left fo=
r 2.5: 1) remove --no-replay or 2) reject configs where --no-replay is us=
ed without --auth none.
(16:18:00) syzzer: Uh, 2.6
(16:18:22) plaisthos: I would go with 2) for now
(16:18:30) syzzer: 2) resolves the footgun, but does not reduce code comp=
lexity.
(16:18:45) plaisthos: it actually reduces some of it
(16:18:47) dazo: yeah, 2) is a good start
(16:18:57) plaisthos: but it is a step in a right direction
(16:18:58) ordex: then 1 in 2.7 ?
(16:19:18) syzzer: yeah, and add clear warnings about the removal in 2.5 =
and 2.6
(16:19:20) dazo: and then --no-replay with --auth none and --cipher none =
in 2.7?
(16:19:23) plaisthos: 1) basically depends on if we want to support --aut=
h none (and --cipehr none) or not
(16:20:58) dazo: while there might be use-cases for --cipher none ... I'm=
 not convinced we as a VPN project need it, from a security perspective (=
--cipher none is essentially just a Virtual Network; not a Virtual Privat=
e Network)
(16:21:17) dazo: but we can take that discussion another time
(16:21:47) syzzer: that's what I was going to suggest. we're well past th=
e 1h mark.
(16:22:46) syzzer: oh, I didn't state explicitly: I too think that 2) is =
the right first step.
(16:23:46) dazo: \o/ ... we've reached a conclusion, where this annoying =
bastard (me!) even agrees!  :-P   "reject configs where --no-replay is us=
ed without --auth none"
(16:24:51) dazo: who picks up the task to rework the current --no-reply p=
atch?
(16:27:25) mattock: replay
(16:27:26) mattock: :D
(16:27:35) dazo: hahaha yeah!
(16:27:39) mattock: typo of the day
(16:27:44) mattock: from multiple people

--------------0324E65DB9E312ED808EA081--

