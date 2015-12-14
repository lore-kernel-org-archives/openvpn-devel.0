Date: Mon, 14 Dec 2015 23:45:04 +0200
From: Samuli =?UTF-8?B?U2VwcMOkbmVu?= <samuli@...515...>
Message-Id: <20151214234504.9c3a73e36096e05d8df2a1cb@...515...>
In-Reply-To: <20151214172340.9332784c61ebaccf5b94a6ae@...515...>
References: <20151214172340.9332784c61ebaccf5b94a6ae@...515...>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="Multipart=_Mon__14_Dec_2015_23_45_04_+0200_Pk2_CDzYPk1oE1Jo"
Subject: Re: [Openvpn-devel] Topics for today's (Monday,
 14th Dec 2015) community meeting
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Samuli =?UTF-8?B?U2VwcMOkbmVu?= <samuli@...515...>
Cc: openvpn-devel@lists.sourceforge.net

--Multipart=_Mon__14_Dec_2015_23_45_04_+0200_Pk2_CDzYPk1oE1Jo
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi,

Here's the summary of today's IRC meeting.

- - ---

COMMUNITY MEETING

Place: #openvpn-devel on irc.freenode.net
Date: Monday 14th Dec 2015
Time: 20:00 CET (19:00 UTC)

Planned meeting topics for this meeting were here:

<https://community.openvpn.net/openvpn/wiki/Topics-2015-12-14>

The next meeting has not been scheduled yet, but will probably be arranged =
two weeks from now.

Your local meeting time is easy to check from services such as

<http://www.timeanddate.com/worldclock>

SUMMARY

cron2, ecrist, lev, ltfish, mattock, rafaelgava100, syzzer and valdikss par=
ticipated in this meeting.

- ---

Discussed the "=E2=80=8BMake ValdikSS's DNS leak fix platform agnostic" pat=
ch:

<http://thread.gmane.org/gmane.network.openvpn.devel/10746>

Several new versions of the patch were created and tested during the meetin=
g. The final version worked on enough mingw-w64 and Visual Studio versions =
to allow giving it an ACK.

- ---

Discussed the "=E2=80=8BAdded two feature to Network Address Translator" pa=
tch:

<http://thread.gmane.org/gmane.network.openvpn.devel/10047>

None of the attendees knew the affected codepaths well enough, so mattock s=
ent email to jamesyonan, asking him to review the patch.

- ---

Discussed the "=E2=80=8BDistribute the GUI to run with highest privilege av=
ailable" patch to openvpn-gui:

<http://thread.gmane.org/gmane.network.openvpn.devel/10761>
<https://github.com/OpenVPN/openvpn-gui/pull/6/commits>
<http://thread.gmane.org/gmane.network.openvpn.user/36387/focus=3D36417>

The approach taken in the patch seems sane. Mattock will do some basic test=
ing with the patched OpenVPN-GUI and if all goes well, merge it into offici=
al installers. The testing does not have to postpone the 2.3.9 release, as =
new Windows installers can be released soon after initial 2.3.9 Windows ins=
tallers are out.

The alternative approach of using level=3D=E2=80=9DrequireAdministrator=E2=
=80=9D seems to have the potential to break valid cases where the user _doe=
s_ have the privileges required for OpenVPN to work, but _does not_ have ad=
min privileges.

- ---

Discussed OpenVPN 2.3.9 release. Here is the release plan:

- - mattock posts changes.rst to list
- - cron2 adds changes.rst, updates ChangeLog and version.m4
- - mattock builds 2.3.9 installers with all the new stuff
- - if that is good, cron2 tags and we ship

In addition:

- - the initial windows installers will not have the openvpn-gui changes
- - mattock will provide test installers with the changes and send a link t=
o the list
- - if the test installers work fine for people, new official installers wi=
ll released

- ---

Full chatlog has been attached to this email.

- --=20
Samuli Sepp=C3=A4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAlZvOGAACgkQwp2X7RmNIqO06QCfYWe5I34JUsOIMHP8bIUqBMeD
laQAn0wF15O1NMd+whDYcje2p/dmERs1
=3DnSlq
-----END PGP SIGNATURE-----

--Multipart=_Mon__14_Dec_2015_23_45_04_+0200_Pk2_CDzYPk1oE1Jo
Content-Type: text/plain;
 name="openvpn_irc_meeting_chatlog_2015-12-14.txt"
Content-Disposition: attachment;
	filename="openvpn_irc_meeting_chatlog_2015-12-14.txt"
Content-Transfer-Encoding: quoted-printable

(21:02:34) mattock: hi
(21:02:46) ecrist: hey, mattock
(21:02:50) lev__: hi
(21:02:50) mattock: hi ecrist!
(21:02:56) mattock: ready to start the meeting?
(21:03:01) mattock: https://community.openvpn.net/openvpn/wiki/Topics-2015-=
12-14
(21:03:03) vpnHelper: Title: Topics-2015-12-14 =E2=80=93 OpenVPN Community =
(at community.openvpn.net)
(21:04:49) syzzer: hi, yes, ready!
(21:04:58) mattock: is the topic list ok? anything to remove or add?
(21:05:14) cron2_: lev__: if you close 637, we can just have it done on the=
 agenda :)
(21:05:38) lev__: cron2_: I would like to but don't have trac admin rights
(21:05:51) cron2_: oh?  mattock: can you fix that, please? :-)
(21:05:57) cron2_: (trac name is "stipa")
(21:06:06) mattock: cron2_: ok
(21:06:17) WayneD ha abbandonato la stanza (quit: Remote host closed the co=
nnection).
(21:06:57) mattock: done
(21:06:58) gava100: hi, I'd like to ask you guys about a patch: "Allow the =
user to use the string 'client-ip' on the  client-nat network configuration=
 as a convenient way to use  the leased IP address received from OpenVPN se=
rver"
(21:07:36) cron2_: it's on the agenda
(21:07:54) gava100: oh great, thx!
(21:07:57) cron2_: (though I'm not sure if mattock linked the right mail)
(21:08:24) mattock: yes, I did
(21:08:36) mattock: unless there is a version 2 or something
(21:08:58) mattock: I'll check the previous discussion regarding that patch
(21:09:31) gava100: exactly. The version 2 is only for this client-ip strin=
g.
(21:09:48) cron2_: regarding fish's v2 patch - "close, but no cigar" - it i=
s removing all #if _WIN32_WINNT >=3D 0x0600 lines, but some of them should =
actually be #if defined(WIN32) - those in init.c, for example, because othe=
rwise it will fail non-windows builds
(21:10:20) ltfish: i see
(21:10:30) gava100: I think we should consider it instead of the previous p=
atch.
(21:10:38) cron2_: ltfish: so init.c needs to change the #ifdef - I think t=
he rest is good (comparing with master)
(21:11:06) ltfish: cron2_: let me fix it in init.c and test the build for l=
inux as well
(21:11:09) ltfish: cron2_: sorry for that
(21:12:02) cron2_: ltfish: we all do this all of the time :-) - so I've lea=
rned what to look for  (last time d12fk broke all the BSDs...)
(21:13:09) cron2_: mattock_: you shouldn't close #637, just give lev__ the =
privileges to do so himself :-) - he did the work, he should have the privi=
lege to close the ticket
(21:13:12) ltfish: cron2_: instead of just completely remove "block_outside=
_dns" option for linux builds, is it better to leave a error message for li=
nux clients with that option enabled?
(21:13:43) mattock: cron2_: that one is also doable
(21:14:24) mattock: as we're apparently already discussing topic #2 ("2.3.9=
 release") let's cover that, then move to other patch review
(21:14:39) mattock: I can give a very brief summary of "moneyz" (topic #1) =
at the end
(21:14:41) cron2_: ltfish: we discussed this in the context of valdikss' pa=
tch, and the general opinion was that platform-specific options are "just n=
ot there" on other platforms, so "unknown option" errors will result (which=
 can be turned into warnings)
(21:14:51) lev__: ltfish: warning maybe? otherwise .ovpn will be platform-d=
ependent
(21:15:28) cron2_: lev__: you can always have --ignore-unknown-option block=
-outside-dns in it (and on push, it will be a warning anyway)
(21:15:37) valdikss: lev__: cron2_ said it's better use setopt or ignore un=
knows option
(21:15:54) ***cron2_ defers to plaisthos - but I agree.  Less code.
(21:15:56) valdikss: lev__: and it won't fail if you push it from server
(21:16:43) ltfish: so I suppose it's OK to wrap the whole option with `#ifd=
ef WIN32`
(21:16:47) lev__: well, I have no strong opinion on that
(21:17:14) cron2_: ltfish: this is how the code in master looks like right =
now - it's in an #ifdef WIN32 block anyway, if I remember right
(21:17:28) cron2_: yes, it is
(21:17:47) valdikss: By the way, that's the difference between ifdef WIN32 =
and if defined(WIN32)?
(21:18:10) ltfish: cron2_: yep, let me reread valdikss's patch
(21:18:11) cron2_: valdikss: just stylistic, techically exactly equivalent
(21:18:35) cron2_: if defined(WIN32) can be combined, like #if defined(WIN3=
2) || defined(LINUX) - you can't do that with #ifdef WIN32
(21:18:39) valdikss: cron2_: OpenVPN uses both and I didn't know what shoul=
d I use and where
(21:19:18) cron2_: valdikss: 10 year old code base, a large number of contr=
ibutors, and not always a strict regime on coding style...
(21:19:25) cron2_: apologies for the mess
(21:19:38) cron2_: (*I* did not do it, and tried my best to not make it wor=
se)
(21:19:41) mattock: the mess is only partially our fault :P
(21:19:57) valdikss: cron2_: you shouldn't apologise.
(21:21:06) cron2_: so, while ltfish is working on v3 - I seem to hear that =
"the windows team" wants to take this approach?
(21:21:06) mattock: actually, I think we have done a pretty good job in cle=
aning up the mess
(21:21:23) mattock: if I can avoid building several different binaries I'm =
all for it
(21:21:39) mattock: the build/release process is complex enough as-is
(21:21:59) cron2_: you already build different installers for xp and vista+=
... so adding a patch to the vista+ building does not sound overy difficult
(21:22:06) cron2_: overly
(21:22:34) mattock: not really, I build different installers for tap-window=
s and tap-windows6 on the other hand, and 32-bit and 64-bit on the other
(21:22:42) cron2_: (but that patch would actually not be totally trivial to=
 do... adding the configure bits fro mmaster)
(21:22:58) plaisthos: hi
(21:23:02) cron2_: mattock_: these could become "xp" and "vista+" then...
(21:23:03) plaisthos: today no sport for me=20
(21:23:03) mattock: hi plaisthos!
(21:23:13) cron2_: plaisthos: hi!  you're missing your sports for us!
(21:23:18) plaisthos: not really
(21:23:27) plaisthos: my shoulder does not feel good=20
(21:24:05) mattock: cron: so without ltfish's patch I'd need to use differe=
nt configure flags for XP and Vista+, right?
(21:25:03) valdikss: mattock_: yes
(21:25:14) mattock: ok, that is doable
(21:25:18) cron2_: mattock_: right - effectively, a patch to configure woul=
d be needed
(21:25:28) valdikss: mattock_: with ltfish patch you have one binary. That'=
s the only difference.
(21:25:51) mattock: yeah
(21:26:41) mattock: I prefer the one binary approach at least in the long r=
un, but I we can release 2.3.9 without ltfish's patch if needed
(21:26:45) cron2_: flags alone might bring in the libraries but will fail f=
inding inet_pton() I think, so f96baabc6c would be needed plus the configur=
e.ac patch from 5fcd4933681
(21:27:38) ltfish: I think in the long run, unless 2.4 or master supports W=
inXP, it will be one binary for Windows anyways
(21:27:55) mattock: master does not suppot winxp now
(21:28:04) mattock: a few things are broken on XP already
(21:28:08) ltfish: I might wanna try to make master support WinXP though. D=
on't really have time to see how difficult it is
(21:28:21) cron2_: ltfish: master/2.4 won't support XP unless some really s=
uprising reason shows up to apply your changes to master as well, plus the =
equivalent for GetIpRoute2() etc.
(21:28:57) ltfish: cron2_: my patch should work on master without any major=
 change - I can make it happen
(21:29:01) cron2_: we officially do not care for XP in master :-) - we'll c=
ontinue supporting 2.3 for quite sometime, and after that, XP should be dead
(21:29:20) ltfish: cron2_: GetIpRoute2() is a different story... I'll try i=
f I have cycles
(21:29:23) cron2_: ltfish: this part, yes, but other parts also need vista+=
 now - that's the 5fcd493368120 commit
(21:29:23) mattock: I would love it to be dead already
(21:29:50) cron2_: ltfish: I actually think we should *not* go there for ma=
ster, at least not without a strong reason
(21:30:00) mattock: dropping XP support (=3Dreleasing 2.4.0) would allow us=
 to drop tap-windows (non-6) for good
(21:30:06) ltfish: cron2_: sure
(21:30:25) ltfish: cron2_: personally I have dropped Xp support in my own f=
ork a long time ago
(21:30:32) cron2_: I'm not totally happy with "copy all the API bits into a=
 private header file, assuming that they won't change" - maybe they will ne=
ver change, but still
(21:30:51) cron2_: but anyway, 2.3 - you guys decide, I merge
(21:31:00) ltfish: cron2_: I was just proposing to fix master in case it's =
something you guys want, but no one has time to do it :-)
(21:31:11) ltfish: v3 patch is ready to be sent
(21:31:17) cron2_: seems everyone is in favour of "apply ltfish v3, single =
binary for 2.3" anyway...?
(21:31:37) mattock: anyone else in favor of that besides me?
(21:31:42) valdikss: cron2_: I don't care, you should ask buildsystem guys.
(21:31:45) mattock: or somebody opposing it?
(21:31:47) valdikss: cron2_: it works either way
(21:31:53) cron2_: valdikss: buildsystem guy is "mattock" :)
(21:32:18) valdikss: cron2_: mattock_: if this patch really ease building p=
rocess, apply it.
(21:32:19) cron2_: (and lev__, for MSVC)
(21:32:49) syzzer: I prefer single binary too (since I'm occasionally a bui=
ld system guy too ;) )
(21:33:23) cron2_: ok... I'll apply as soon as it arrives in my mailbox.  W=
ho is going to ACK it?
(21:33:29) ltfish: mattock_: i'm im favor of that, obviously
(21:33:35) mattock: ltfish: yep :)
(21:34:07) cron2_: mattock_: can you add a windows snapshot builder that al=
so auto-builds and auto-uploads release/2.3 snapshots?
(21:34:34) cron2_: the auto-build-master thingie is totally great, saved me=
 quite a lot of time yesterday
(21:35:10) mattock: cron2: hmm, yes, I think that's fairly straightforward
(21:35:25) mattock: lev__: you now have ticket modify rights in Trac
(21:35:32) lev__: mattock_: ack
(21:35:48) lev__: does that patch work on MSVC2013 ?
(21:36:32) mattock: lev__: could you test it now?
(21:36:37) mattock: before anyone gives an ACK
(21:36:46) mattock: we could move forward while waiting
(21:37:00) cron2_: lev__: it should (test v3, please)
(21:37:25) ltfish: lev__: I couldn't test it on MSVC2013 since I don't have=
 a build system for it right now
(21:37:38) ltfish: lev__: I can test in on MSVC2010 though
(21:37:39) valdikss: I can test it on 2015
(21:38:07) lev__: where I can get v3?
(21:38:55) cron2_: ltfish: I think lev__ broke MSVC2010 recently... and sup=
posedly options.c kills 2015
(21:39:51) ltfish: lev__: v3 just went out
(21:40:02) ltfish: cron2_: :-( Maybe I'll fix that...
(21:40:56) plaisthos: you can always use the experiemental clang stuff for =
msvc :)
(21:41:14) ltfish: plaisthos: I have never tried that though. only for 2015?
(21:41:25) cron2_: ah, v3 is on the list
(21:41:40) cron2_: http://article.gmane.org/gmane.network.openvpn.devel/107=
93
(21:41:41) vpnHelper: Title: Gmane -- PATCH v3 Make block outside dns optio=
n platform agnostic (at article.gmane.org)
(21:41:56) cron2_: ltfish: what does -lrpcrt4 do?
(21:42:17) cron2_: (well, link librpcrt4.so, but why do we need it)
(21:42:18) plaisthos: ltfish: yeah, with the ms backend
(21:42:25) ltfish: plaisthos: nice
(21:42:34) plaisthos: you can full llvm compiler for older msvc though
(21:42:40) plaisthos: clang-cl.exe
(21:42:44) ltfish: cron2_: I think I used one of the API from rpcrt4.dll
(21:42:48) ltfish: cron2_: let me check
(21:42:49) plaisthos: with cl.exe compatible command line interface
(21:42:57) valdikss: It's for UUID
(21:42:59) valdikss: or something
(21:44:08) ltfish: cron2_: UuidCreate()
(21:44:25) cron2_: ah
(21:44:48) cron2_: so librpcrt4 is available on XP, and libfwpuclnt isn't?
(21:45:01) lev__: is it for master / 2.3 ?
(21:45:05) cron2_: 2.3
(21:45:06) ltfish: I don't think XP has support for WFP
(21:45:11) cron2_: it hasn't
(21:45:35) ltfish: "Windows Filtering Platform (WFP) is a network traffic p=
rocessing platform designed to replace the Windows XP and Windows Server 20=
03 network traffic filtering interfaces."
(21:46:02) ltfish: rpcrt4.dll should be available since Windows 2000
(21:46:29) cron2_: ltfish: is ConvertInterfaceIndexToLuid() also vista+?
(21:46:45) ***ecrist shudders seeing "vista"
(21:46:47) cron2_: (I was wondering why you LoadLibrary(iphlpapi.dll) which=
 we link
(21:46:58) valdikss: cron2_: yes
(21:47:03) cron2_: ok
(21:47:17) ltfish: cron2_: confirmed
(21:47:28) cron2_: just checked msdn, and it agrees :) -ok
(21:47:35) valdikss: cron2_: oh no, probably luid is available on XP
(21:47:49) ltfish: cron2_: iphlpapi.dll changes a lot from XP to Vista
(21:47:55) cron2_: https://msdn.microsoft.com/en-us/library/windows/desktop=
/aa365826(v=3Dvs.85).aspx says "Vista"
(21:48:05) valdikss: cron2_: you're right
(21:48:18) valdikss: Let me quickly build with v3
(21:48:27) cron2_: ltfish: I noticed with inet_pton()/inet_ntop()... but th=
e *Luid() stuff sounds a lot like "windows always has *uuid for anything" :)
(21:48:44) ltfish: cron2_: they love UUIDs
(21:48:52) cron2_: yeah, testing by valdikss and lev__ would be appreciated
(21:49:17) ltfish: cron2_: I'll see if I can compile it on VC2010
(21:49:41) ltfish: with testing in progress, maybe the meeting can be moved=
 on?
(21:50:04) ltfish: I feel kinda bad for creating a patch that takes so long=
 to discuss...
(21:50:24) cron2_: valdikss' patch reached v9 and it took 4 or 6 weeks :)
(21:50:37) plaisthos: ltfish: don't be
(21:50:43) ltfish: cron2_: I saw that...
(21:50:49) plaisthos: we are a bit special when it comes to accepting patch=
es
(21:50:55) mattock: I'm fine with moving on
(21:51:04) plaisthos: A lot of project do the commit and see if something b=
reak approach
(21:51:51) cron2_: "CERT will let us know if we broke something important"
(21:52:00) ltfish: cron2_: lol
(21:52:59) mattock: next topic?
(21:54:14) cron2_: windows :)
(21:54:28) cron2_: or you could give us a short overview about moneyz in be=
tween?
(21:54:45) gava100: I would suggest the NAT patch. :-)
(21:55:13) mattock: let's do the NAT patch now
(21:55:17) mattock: it's about 2 months old already
(21:55:18) cron2_: no
(21:55:29) mattock: ACK or NACK, but a resolution
(21:55:48) gava100: please, let me explain a little bit about the NAT patch.
(21:55:57) cron2_: yeah, but then dazo's and plaisthos' patches need review=
 as well
(21:56:42) mattock: yeah, we have plenty...
(21:56:45) gava100: In fact, I was owing you guys a re-submission to this p=
atch. In fact I was just requesting to consider the client-ip feature and d=
rop the ftp-nat one.
(21:57:03) mattock: that was what I gathered from the email thread
(21:57:12) mattock: and the client-ip feature seemed less controversial
(21:58:22) gava100: exactly. I resent a patch on oct, 26th with just the cl=
ient-ip feature. And not sure if you guys had time to review it.
(21:58:49) cron2_: gava100: the problem with that review is that it needs p=
rior understand of the whole --client-nat option - which I still have not y=
et read up on.  So it's a patch to improve an unknown-to-me options, which =
I just can't properly review yet.  Apologies for being so slow, this code b=
ase is huge and not all of us understand all corners well enough yet
(21:59:37) cron2_: plaisthos: I assume that this is something your users do=
n't use at all, right?
(22:00:11) mattock: jamesyonan knows the client-nat stuff
(22:00:20) mattock: I'll send him email and ask if he could join
(22:00:33) mattock: or if he could do a review of the patch, if he can't at=
tend
(22:00:35) plaisthos: cron2_: the client-nat?
(22:00:37) plaisthos: cron2_: no
(22:00:40) gava100: I understand. That is the reason that I'm asking you gu=
ys to consider just the email sent on Oct, 26th. The changes is small and s=
imple.
(22:00:49) plaisthos: cron2_: I don't need to routing features
(22:01:28) plaisthos: on android you can connect on a 192.168.0.0/24 to a V=
PN that provides 192.168.0.0/24 and everything works fine
(22:01:29) gava100: if you guys don't mind I can resend it right now or pas=
te it on this conversation.
(22:01:34) cron2_: mattock_: review would be more useful, I think.  We have=
 way more on our agenda today than we can handle - if we start going into a=
 detailed patch review (of anything) time will be over before we finished t=
he first one
(22:02:00) cron2_: you have a very optimistic world view on reviewing compl=
ex patches :-)
(22:02:42) cron2_: (and we still haven't finished item 2. - GUI and privile=
ges...)
(22:02:57) mattock: yeah, but that could potentially become a bike-shedding=
 discussion
(22:03:19) mattock: gava100: can you resend you patch, and I'll link it to =
jamesyonan
(22:03:21) ***cron2_ abstains because he does not understand windows privil=
eges
(22:03:23) ecrist: I like red, just for the record.
(22:03:37) cron2_: (nor manifests)
(22:03:39) ecrist: Or green, each has it's merits.
(22:03:46) mattock: ecrist: I prefer navy blue
(22:04:01) gava100: sure. :-)
(22:04:05) mattock: great!
(22:04:09) cron2_: mattock_: why re-send?  It's on the list already, and th=
e surrounding code has not changed much, so it should apply fine
(22:04:16) mattock: gmane does not have it
(22:04:24) mattock: could be on sf.net archives, though
(22:04:37) cron2_: http://article.gmane.org/gmane.network.openvpn.devel/104=
20
(22:04:37) vpnHelper: Title: Gmane -- PATCH Added client ip option to NAT (=
at article.gmane.org)
(22:04:39) cron2_: of course gmane has it
(22:04:57) mattock: ok, thanks, missed it :)
(22:06:05) cron2_: if gmane is working, it's quite nice :-) - and with the =
message-id lookup function (curl -D- http://mid.gmane.org/$messageid |grep =
Location:) it is quick as well
(22:06:08) gava100: yes, the patch is this one from gmane. So should I stil=
l resend it?
(22:07:13) mattock: gava100: no need anymore
(22:07:20) mattock: I send james a request for review
(22:07:24) gava100: ok, thx!
(22:07:31) cron2_: mattock_: thanks
(22:08:07) cron2_: so, gui privileges - I think my users would like it if i=
t "just works" - would that change be the equivalent of "[x] always run as =
administrator" or would it do something else?
(22:08:46) valdikss: cron2_: from what I understand, it would do just that.
(22:09:19) cron2_: in that case, using it on builds that have no iservice y=
et (<<-- remember to turn it off again :) ) sounds good to me
(22:09:30) cron2_: I know that d12fk does not like it
(22:09:49) mattock: if I understood the idea correctly, it would not reques=
t admin privileges, but "highest available" privileges
(22:10:12) mattock: so if the user has (for whatever reason) privileges to =
create routes, but not generic admin privileges, OpenVPN would still work
(22:10:22) cron2_: valdikss, lev__: any test results yet?  release/2.3 + fi=
sh v3 compiles on linux just fine and passes all self tests - so basic sani=
ty checks on the #ifdef passed
(22:10:25) mattock: that said, I'm not sure how Windows determines "highest=
 privileges"
(22:10:40) ltfish: cron2_: it has troubles compiling on VC2010
(22:10:44) cron2_: ok, we need a windows privilege training...
(22:10:45) ltfish: cron2_: trying to fix that right now
(22:11:15) cron2_: ltfish: more complex than the declaration right in the m=
iddle of add_route_ipv6()?  Just move that up to the function start...
(22:11:44) ltfish: cron2_: I fixed that, maybe I'll send out a different pa=
tch later
(22:12:07) ltfish: cron2_: I'm trying to find an elegant way to support nam=
eless union in MSVC...
(22:12:16) ltfish: any suggestions?
(22:12:31) valdikss: cron2_: My W10 VM is semi-broken, launching another on=
e.
(22:12:41) syzzer: man, I'm looking forward to the day we can drop support =
for all non-C99-compliant compilers :p
(22:12:44) cron2_: ltfish: where are we doing this?
(22:13:02) ltfish: cron2_: in the struct definition I ripped from MinGW
(22:13:09) cron2_: aaaargh.
(22:13:18) cron2_: "give them a name" :)
(22:13:27) ltfish: maybe I can just make them named...
(22:13:42) lev__: MSVC 2013 says "win32_wfp.h(185): error C2061: syntax err=
or : identifier '__C89_NAMELESS'"
(22:13:47) ltfish: but it's not as elegant as a simple #define (if there is=
 any)
(22:13:51) ltfish: yep
(22:13:54) ltfish: exactly the same issue
(22:14:28) ***cron2_ rolls eyes (so we're now finally broken on 2010, 2013 =
*and* 2015)
(22:15:17) cron2_: so how do the windows WFP headers deal with that?
(22:15:40) ltfish: cron2_: let me see
(22:16:46) mattock: I'm looking into the "Run with highest privileges" thin=
g to figure out how it works...
(22:17:15) gava100: excuse me guys. BRB.
(22:17:21) gava100 ha abbandonato la stanza (quit: Remote host closed the c=
onnection).
(22:17:39) valdikss: v3 works as expected on Windows 10
(22:17:46) valdikss: Compiles file for Linux too
(22:17:48) cron2_: valdikss: built with mingw?
(22:17:50) valdikss: fine*
(22:17:53) valdikss: cron2_: yes
(22:18:17) ltfish: cron2_: MS header files just don't have "_C89_NAMELESS" =
stuff
(22:18:21) ltfish: cron2_: let me release a v4
(22:18:22) cron2_: ok, cool.  So it's "just" MSVC that is finally and compl=
etely broken...
(22:18:45) cron2_: ltfish: well, does it work if you insert #define __C89_N=
AMELESS before the definitions?
(22:19:08) cron2_: ("define to nothing")?  MINGW might actually *need* this=
... or at least we need to test again
(22:20:58) ltfish: cron2_: I'll test and see how to make MSVC and MinGW bot=
h happy
(22:23:34) lev__: ltfish: I can help with MSVC2013 testing
(22:24:57) ltfish: lev__: thanks! give me a few minutes and I'll release v4
(22:31:10) mattock: it looks like "Run with highest privileges" allows bypa=
ssing the UAC prompt
(22:31:48) mattock: at least some apps have a checkbox for it (e.g. "Task m=
anager" and "Schedules tasks")
(22:32:03) mattock: I suppose it can be set in the application manifest
(22:32:17) ltfish: mattock_: if the highest privilege is Administrator, the=
n yes
(22:34:50) mattock: and if I've understood correctly, using level=3D=E2=80=
=9DrequireAdministrator=E2=80=9D would break valid cases where the user _do=
es_ have the privileges required for OpenVPN to work, but _does not_ have a=
dmin privileges
(22:35:22) mattock: if so, I think we should merge Selva's one-liner: https=
://github.com/OpenVPN/openvpn-gui/pull/6/files
(22:35:23) vpnHelper: Title: Run with highest privilege available by selvan=
air =C2=B7 Pull Request #6 =C2=B7 OpenVPN/openvpn-gui =C2=B7 GitHub (at git=
hub.com)
(22:36:57) valdikss: v3 works 'fine' on XP
(22:37:01) mattock: I can do some light testing before merging it, though
(22:37:15) cron2_: please :)
(22:37:18) valdikss: GUI waits alot and fails with generic error
(22:37:33) valdikss: It seems that openvpn dies too quickly for gui
(22:37:58) cron2_: die'ing on command line parsing is not something the gui=
 handles well
(22:37:59) mattock: valdikss: with v3 applied?
(22:38:08) cron2_: as in "not at all" :(
(22:38:44) cron2_: oh
(22:39:02) cron2_: we might need to revisit the decision to make "cannot in=
itialize wfp" M_FATAL
(22:39:45) cron2_: (which is what msglevel_fc does for options from config =
files or command line does, IIRC)
(22:39:48) cron2_: plaisthos: ?
(22:40:34) ltfish: alright, it complies for me on VC2010
(22:40:41) ltfish: phew
(22:40:47) mattock: btw. Selva's one-liner does not need to postpone the 2.=
3.9 release... I can create new Windows installers after it has been proven
(22:41:34) cron2_: mattock_: well, that will only delay building of the win=
dows installers...
(22:42:12) valdikss: mattock_: yes
(22:42:14) ltfish: v4 is sent
(22:42:23) mattock: I mean we can just release 2.3.9 without the patched GU=
I, and quickly after that release installers with the patch
(22:42:23) lev__: ltfish: ack
(22:42:30) ltfish: valdikss: lev__: could you please test it for me?
(22:42:36) valdikss: ltfish: sure
(22:42:41) ltfish: awesome :-)
(22:42:51) valdikss: ltfish: what has changed?
(22:43:04) cron2_: ltfish: that is "mingw and msvc2010" safe?  (why isn't m=
svc2010 bombing on lev__'s patch to route.c??)
(22:43:34) ltfish: cron2_: with my own MSVC2010 patches, it works
(22:43:48) ltfish: cron2_: I'll submit MSVC2010 patches later, maybe not fo=
r release 2.3.9
(22:43:49) cron2_: ltfish: so, other patches in tree to make it work?
(22:43:53) cron2_: ah
(22:44:11) ltfish: cron2_: yep. I patched several __attribute__ and noretur=
ns
(22:44:17) ltfish: cron2_: and also the route.c thingy
(22:44:22) cron2_: oops
(22:44:38) cron2_: ok, v4 on list
(22:44:51) ltfish: cron2_: is there any preferred way to patch __attribute_=
_ for MSVC2010 in OpenVPN code?
(22:45:01) ltfish: cron2_: I guess I can do it real quick
(22:45:18) cron2_: ltfish: could you point me at an example?
(22:45:43) ltfish: const cipher_kt_t *cipher_ctx_get_cipher_kt (const ciphe=
r_ctx_t *ctx) __attribute__((nonnull));
(22:45:47) ltfish: from crypto_backend.h
(22:46:07) ltfish: __attribute__ is not supported by MSVC2010
(22:46:18) ***cron2_ has no idea and defers to syzzer... maybe just #define=
 __attribute__(x) =20
(22:46:22) lev__: ltfish: that's what I did https://github.com/OpenVPN/open=
vpn/commit/123092a7a95f13f0509d2dc52ec049f91a02686d#diff-721cc86acd0ddab116=
db5d0d7f03ef7dR50
(22:46:23) vpnHelper: Title: This fixes MSVS 2013 compilation. =C2=B7 OpenV=
PN/openvpn@...2105... =C2=B7 GitHub (at github.com)
(22:46:51) syzzer: hmm, I think we did something like that in master
(22:47:22) mattock: I wonder how old Visual Studios we want to / need to su=
pport...
(22:47:23) cron2_: src/openvpn/syshead.h:#define __attribute__(x)
(22:47:25) cron2_: indeed
(22:47:36) cron2_: (this is from master)
(22:48:38) syzzer: yes, Lev fixed it in 123092a
(22:50:09) ltfish: is that commit not applied to release/2.3?
(22:51:15) cron2_: no, because part of it are master (like the comp.c, comp=
stub.c addition to vcproj)
(22:51:27) cron2_: so the syshead.h part could nicely go to 2.3
(22:51:46) cron2_: and the config-msvc.h
(22:52:18) cron2_: wth is WINBOOL vs. BOOL... *scratch head*
(22:52:30) ltfish: uh, so I think it's better for lev__ to submit a patch f=
or that to release/2.3, and then I can happily just #include "syshead.h" in=
 error.h and crypto_backend.h
(22:52:31) cron2_: all the other changes v3->v4 look reasonable
(22:52:47) ltfish: cron2_: WINBOOL is something special in MinGW...
(22:53:03) cron2_: ltfish: most likely it's already included anyway, via op=
envpn.h or such
(22:53:27) ltfish: "Mingw-w64 headers do use WINBOOL instead of BOOL as boo=
lean data type to not conflict with ObjectiveC (GNUStep) BOOL definition"
(22:53:36) ltfish: so I simply changed it to BOOL
(22:54:13) ***cron2_ learned too much that he did not want to know today :)
(22:54:16) ltfish: cron2_: nice, you are right
(22:54:39) ltfish: just adding that line to syshead.h worked
(22:54:49) ***cron2_ thanks lev__ :)
(22:55:02) ltfish: since it was lev's patch orignally, I think it's reasona=
ble for him to submit the patch to release/2.3
(22:55:15) ltfish: unless he'd like me to do it?
(22:56:08) lev__: ltfish: up to you, I can do it as well
(22:56:42) cron2_: valdikss: to make it work, you need to call "setenv opt =
block-outside-dns", I think
(22:57:09) cron2_: this will make msglevel_fc M_WARN, so if it cannot open =
WFP or it's a 2.3.8 binary, it will not abort
(22:57:32) cron2_: scary innards of options.c
(22:58:04) ltfish: lev__: please do so to keep your author attribution!
(22:58:54) valdikss: cron2_: ltfish: w10 works, w7 works, testing xp
(23:02:52) lev__: yay, build success on MSVC2013
(23:03:25) valdikss: ltfish: cron2_: works fine with setenv opt block-outsi=
de-dns on XP but not with ignore-unknown-option
(23:04:13) cron2_: valdikss: yes, with the patch, the option is not "unknow=
n" - so that part does not even see it
(23:04:38) valdikss: cron2_: I see
(23:04:46) mattock2 [~mattock@...1423.../corp/admin/mattock] =C3=A8 entrato ne=
lla stanza.
(23:05:09) mattock: mattock2 again
(23:05:48) mattock: I need to split soonish, but mattock2 who refused to wo=
rk with my IRC bouncer will monitor the channel for a while
(23:05:55) cron2_: lol
(23:06:13) cron2_: anyway, I think we're good to go as soon as Lev__ is als=
o happy with the patch
(23:06:22) mattock2 ha abbandonato la stanza (quit: Remote host closed the =
connection).
(23:06:28) cron2_: it is already sitting in my tree waiting for me to add a=
 "tested-by:" and pushing it...
(23:06:33) mattock2 [~mattock@...1423.../corp/admin/mattock] =C3=A8 entrato ne=
lla stanza.
(23:07:07) cron2_: mattock473: while we wait for lev__ - could you give us =
the 2-minute update on moneyz?
(23:09:29) mattock: let me
(23:09:39) valdikss: Is it normal for XP version to fail IPv6 route?
(23:09:56) cron2_: sortof
(23:09:56) mattock: no more updates on Flattr, I discussed it a bit with Fr=
ancis
(23:10:17) cron2_: valdikss: stock XP has no v6, so you need to do "netsh i=
nterface ipv6 install" first
(23:10:27) mattock: except that he seemed ok-ish with it, although would pr=
efer not to take (and manage) donations
(23:10:30) cron2_: before that, the whole ipv6 subsystem is "just not there=
" - no v6 dns, ...
(23:11:07) valdikss: cron2_: you're right
(23:11:13) cron2_: openbsd has an "openbsd foundation", which is a canadian=
 non-for-profit org, has two retired coders guarding it, and they never rec=
eive money out of the pot
(23:11:22) mattock: the OSTIF.org kickstarter campaign is ongoing, but unle=
ss they manage to convince VPN providers and others to donate soonish, they=
 will never reach their quite lofty goals
(23:11:29) cron2_: (so no "put money into your own pocket")
(23:11:57) lev__: works on Win7 - I see WFP related messages in log
(23:12:05) valdikss: v4 works fine on XP, 7 and 10
(23:12:11) cron2_: cool
(23:12:17) mattock: personally I think splitting the huge kickstarter proje=
cts into smaller per-project (openvpn, openssl, etc) chunks might have been=
 a better idea, but we'll see
(23:12:53) valdikss: Bitcoin?
(23:13:10) mattock: the main problem with Flattr as far as the company is c=
oncerned is probably the bookkeeping etc.
(23:13:32) mattock: moving around the money, possibly paying taxes for the =
work being performed, etc.
(23:14:01) cron2_: yep...
(23:14:04) valdikss: Bitcoin?
(23:14:19) mattock: moving the money is not an issue really, whether flattr=
 or bitcoin
(23:15:03) mattock: it would be trivial to donate to a single person
(23:15:20) mattock: donating to a corporation is more tricky
(23:15:34) mattock: and I don't see anyone creating an "OpenVPN foundation"=
 quite yet
(23:16:03) cron2_: yeah, not before we have lots more money coming in (so t=
axes get a larger issue)
(23:16:15) mattock: having an external party handle the donations would act=
ually be what I prefer
(23:16:25) cron2_: so... as a side note... you're all good to go with fish =
v4?
(23:16:44) mattock: anyways, I think we should see how the OSTIF.org thing =
turns out eventually
(23:17:11) mattock: iff they can raise money and are otherwise reasonable, =
I would not mind saying "just give money to them"
(23:17:31) mattock: especially if they had separate venues for different pr=
ojects
(23:17:37) mattock: but let's not get ahead in things :)
(23:18:00) valdikss: cron2_: works for me on XP, 7 and 10.
(23:19:13) mattock: enough coverage for an ACK?
(23:19:37) cron2_: I'm fine ACKing it if valdikss and lev__ are fine with t=
he result :-)
(23:20:20) lev__: cron2_: v4 compiles with MSVC2013 and runs on Win7
(23:20:25) cron2_: \o/
(23:20:26) cron2_: go
(23:20:45) mattock: I will mention that the patch was ACKed then
(23:20:47) ltfish: btw, I assume we don't want that patch in master
(23:20:47) cron2_: (as a side note, I have rarely seen *so* much red in the=
 builder list...)
(23:20:58) mattock: :P
(23:21:13) ltfish: what does red mean?
(23:21:19) cron2_: ltfish: right.  Master is just vista+, using normal head=
er files.  We might come back to it :-)
(23:21:19) mattock: build breaks
(23:21:26) cron2_: ltfish: "broken builds"...=20
(23:21:38) ltfish: :-(
(23:21:38) cron2_: which has nothing to do with *your* patch... that was sy=
zzer and me behind your back
(23:22:18) cron2_: we committed something to master which is useful and wor=
ked for both of us, but uses a function not available in older openssl vers=
ions, so it broke basically everything still using 0.9.8 or 0.9.9
(23:22:26) syzzer: yep, trying to figure out for which versions of openssl =
to work around the brokenness...
(23:22:47) ltfish: i see
(23:22:48) mattock: are you guys ready to call this a day?
(23:22:57) mattock: I'm about to press "Send" on the summary
(23:23:02) cron2_: wait :)
(23:23:06) mattock: ok
(23:23:09) cron2_: how do we move ahead with 2.3.9?
(23:23:30) valdikss: What about admin GUI?
(23:23:42) cron2_: maybe you can just send your changes.rst proposal to the=
 -devel list, and I take it, commit it, update ChangeLog and tag?
(23:23:42) valdikss: Release 2.3.9 then update installers?
(23:23:46) mattock: I will test the "highestavailable" GUI
(23:24:00) mattock: valdikss: possibly yes
(23:24:17) mattock: depends on whether we want to be really safe
(23:24:40) mattock: if we want safe, then I will produce installers with th=
at feature turned on, and send a link to ml for testing
(23:24:55) mattock: if we think it won't break things, then I can release i=
t in first 2.3.9 installers
(23:25:18) mattock: somebody might want to have a quick look at the Changes=
.rst: http://build.openvpn.net/Changes.html
(23:25:26) mattock: that's more pretty than the rst version
(23:26:01) cron2_: maybe add the name of the option --block-outside-dns?
(23:26:04) valdikss: mattock_: I can't be sure it won't break things. I mea=
n, it should work for most of people, but what if it breaks a setups with s=
ervices?
(23:26:26) cron2_: and "behavioural changes" is just wrong regarding "proto=
 udp" - we must not just copy stuff from master, as *trees are different*
(23:26:48) valdikss: mattock_: I suppose there are people who use gui from =
a restricted users and have service correctly configured. Would it break th=
ings for them?
(23:26:49) cron2_: well, is that for 2.4 or for 2.3?
(23:26:51) lev__: should I add async-push and inotify to 2.4 changes
(23:27:18) cron2_: lev__: please send a patch to git master Changes.rst - i=
t's "what plaisthos found easily", not complete yet
(23:27:23) mattock: cron2_: what are you referring to with "proto udp"?
(23:27:55) mattock: "proto udp and proto tcp specify to use IPv4 and IPv6."?
(23:28:03) cron2_: mattock_: I was confused that you did put both into the =
same file.  I would just not do that - someone looking at 2.3 Changes.rst i=
s not intersted in stuff he has not in there
(23:28:16) mattock2 ha abbandonato la stanza (quit: Remote host closed the =
connection).
(23:28:27) mattock: well, actually he might be interested
(23:28:31) cron2_: the 2.3 section is missing block-outside-dns, though :-)
(23:28:33) mattock2 [~mattock@...1423.../corp/admin/mattock] =C3=A8 entrato ne=
lla stanza.
(23:28:36) mattock: and drop 2.3 in favor of 2.4/master
(23:28:45) mattock2 ha abbandonato la stanza (quit: Client Quit).
(23:28:56) cron2_: but then he can go to the web and look there, or do a gi=
t clone - but it does not belong into a release/2.3 tar ball
(23:29:13) mattock: you're being a purist :P
(23:29:24) mattock: of course it does not belong there, but do we care enou=
gh?
(23:29:26) cron2_: (we'd have to do updates to 2.3 every time we add a git =
master feature - I don't think that is useful :-) )
(23:29:32) ***cron2_ cares, always
(23:29:41) cron2_: and I'm willing to do most of the commit work
(23:29:42) mattock: well yes, it can get messy
(23:29:44) mattock: fine
(23:30:08) cron2_: just throw text fragments at me - as with ChangeLog and =
version.m4 today...
(23:30:11) mattock: so do we want this type of Changes.rst for "master", an=
d only the 2.3 stuff for release/2.3?
(23:30:22) gava100 [~gava100@...2106...] =C3=A8 entrato nella stanza.
(23:30:40) mattock: or only 2.3 -> 2.4 stuff for master?
(23:31:20) mattock: the usual approach would be to have all changes since t=
he beginning for the "master" changes.rst
(23:31:30) cron2_: I'd do 2.3->2.4 stuff in master, 2.2->2.3 stuff in relea=
se/2.3  (but maybe not 2.2, as that was really long ago - maybe just 2.3.8-=
>2.3.9)
(23:32:09) mattock: shall we remove the old ChangeLog (=3Dtext file)?
(23:32:22) cron2_: I'd keep that, it has different details
(23:32:28) mattock: ^ sounds fine, keeps the files small
(23:32:43) cron2_: (and is not hard to do, as it basically comes from git -=
-shortlog)
(23:32:48) mattock: yeah
(23:33:27) mattock: do we want an "Overview of changes" section as well as =
more fine-grained sections per-release, like there are now?
(23:33:34) cron2_: hrmph, this syzzer guy wins again... 11 commits 2.3.8->2=
.3.9... plaisthos and I have 7 each...
(23:33:57) cron2_: mattock_: I think this is good, though twice the updates
(23:34:12) mattock: ok, so just split it into pieces for master and 2.3
(23:34:39) mattock: I think the "Overview" part is most useful
(23:34:47) mattock: for people upgrading from previous major releases
(23:34:59) cron2_: yep
(23:35:17) cron2_: so, next steps:
(23:35:24) mattock: if we keep the ChangeLog, which essentially has the "gi=
t shortlog", then that part could be scrapped from Changes.rst with the pos=
sible exception of "changes in the very latest release"
(23:35:33) cron2_: - mattock posts changes.rst to list
(23:35:44) cron2_: - cron2 adds changes.rst, updates ChangeLog and version.=
m4
(23:35:59) cron2_: - mattock builds a test 2.3.9 installer with all the new=
 stuff
(23:36:07) cron2_: - if that is good, cron2 tags and we ship
(23:36:09) cron2_: plan?
(23:36:19) mattock: yes, sounds good
(23:36:20) cron2_: (and then we bug syzzer about 2.3.10)
(23:36:32) mattock: and the initial windows installers will not have the op=
envpn-gui change
(23:37:00) mattock: but mattock will provide test installers, send a link t=
o the list, and if all goes well, mattock can produce new official windows =
installers soonish
(23:37:07) cron2_: +1 .)
(23:37:11) mattock: rather that, than break one million configurations out =
there
(23:38:12) cron2_: cool.  Now this was a good meeting - but I think you can=
 see now why I was fairly sure we wouldn't have time for more patch review =
:-)
(23:39:08) cron2_: lev__: saw your ACK, will merge when time
(23:39:26) lev__: so, can we call it a day?
(23:39:33) cron2_: good night!
(23:39:35) gava100: Please guys but what was the veredict for NAT client-ip?
(23:39:50) gava100: I missed some parts of the meeting. :-)
(23:40:07) mattock: gava100: no conclusion, James has not replied to me yet
(23:40:09) lev__: good night!
(23:40:13) mattock: I will bug him about it until he responds
(23:40:24) mattock: good night!

--Multipart=_Mon__14_Dec_2015_23_45_04_+0200_Pk2_CDzYPk1oE1Jo--

