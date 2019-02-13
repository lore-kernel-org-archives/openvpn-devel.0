From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
References: <b5f2ab31-3e15-932e-87dd-ddf068b8dee6@...515...>
Message-ID: <3d3fd560-be51-5095-1c83-78f51effb8f4@...515...>
Date: Wed, 13 Feb 2019 14:04:08 +0200
MIME-Version: 1.0
In-Reply-To: <b5f2ab31-3e15-932e-87dd-ddf068b8dee6@...515...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="EgyP1dG4Vko3OjO5RASurEd58vUsChsvH"
Subject: [Openvpn-devel] Summary of the community meeting (Wed,
 13th Feb 2019)
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
--EgyP1dG4Vko3OjO5RASurEd58vUsChsvH
Content-Type: multipart/mixed; boundary="DtWJAtBHFtkPGDlYQeahdWpWuwl6L6QzL";
 protected-headers="v1"
From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
To: openvpn-devel@lists.sourceforge.net
Message-ID: <3d3fd560-be51-5095-1c83-78f51effb8f4@...515...>
Subject: Summary of the community meeting (Wed, 13th Feb 2019)
References: <b5f2ab31-3e15-932e-87dd-ddf068b8dee6@...515...>
In-Reply-To: <b5f2ab31-3e15-932e-87dd-ddf068b8dee6@...515...>

--DtWJAtBHFtkPGDlYQeahdWpWuwl6L6QzL
Content-Type: multipart/mixed;
 boundary="------------5D0FF607D66D42699E2F2DBC"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------5D0FF607D66D42699E2F2DBC
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

Hi,

Here's the summary of the IRC meeting.

---

COMMUNITY MEETING

Place: #openvpn-meeting on irc.freenode.net
Date: Wednesday 13th February 2019
Time: 11:30 CET (10:30 UTC)

Planned meeting topics for this meeting were here:

<https://community.openvpn.net/openvpn/wiki/Topics-2019-02-13>

The next meeting has not been scheduled yet.

Your local meeting time is easy to check from services such as

<http://www.timeanddate.com/worldclock>

SUMMARY

cron2, dazo, Derek_OSTIF, mattock, ordex and syzzer participated in this
meeting.

--

Discussed the Plugin API for 2.5.0 and the potential OpenVPN Meek
plugins that OSTIF.org would like to develop. Meke is described here:

https://trac.torproject.org/projects/tor/wiki/doc/meek

It was agreed that there is significant overlap between this project and
Operator Foundation's pluggable transport API work. OSTIF's goal is to
improve the usability of domain fronting - right setting it up is a
nightmare. With an OpenVPN plugin the setup would be greatly simplified.
OSTIF will move forward with this project on various fronts.

--

Talked about OpenVPN 2.5 release date. It was agreed that review of the
large patchsets is taking a lot of time. Hence it was agreed that "after
the holiday season" is reasonable (i.e. August/September).

--

Derek from OSTIF mentioned that QuarksLab did a review of OpenVPN 2.4.6
with ANNSI and that they found no issues.

--

Discussed OpenVPN 2.4.7 release. Agreed that 2.4.7 should be tagged the
upcoming Monday, so that it can go to Debian 10. The patches that we
still need or would like to have are:

- script-security vs. GUI
- auth-token-hmac (fairly intrusive but well-isolated)

Mattock said that we should have everything we need to make the release:

- (Vagrantified) capability to build Debian/Ubuntu packages
- (Vagrantified) capability to build Windows (NSIS) installers
- A valid Windows code-signing key (valid until Oct 2019)
- Valid security@...515... key (for mattock)

Hence release early next week is a reasonable proposition.

--

Discussed tap-windows6 HLK testing / WHQL certification. The HLK tests
require some tricks related to bridging, in particular allowing flooding
of unknown unicast packets. Cron2 created a patch for OpenVPN to help
Stephen get that issue resolved.

--

Full chatlog attached.


--------------5D0FF607D66D42699E2F2DBC
Content-Type: text/plain; charset=UTF-8;
 name="openvpn_irc_meeting_chatlog_2019-02-13.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="openvpn_irc_meeting_chatlog_2019-02-13.txt"

(12:29:25) mattock: meeting time!
(12:29:35) Derek_OSTIF: !
(12:31:57) mattock: we have an early bird here
(12:31:59) cron2: mattock1: Derek has been patiently waiting for you sinc=
e an hour... :-)
(12:31:59) mattock: a hero almost
(12:32:14) ***dazo is here
(12:32:15) mattock: don't tell me it's not 10:30 UTC
(12:32:21) mattock: uh, it is
(12:32:26) dazo: it is
(12:32:27) mattock: I was not misleading derek then
(12:32:28) mattock: :P
(12:32:40) mattock: anyways, shall we start?
(12:32:43) cron2: just take the blame so we can go on :)
(12:33:21) mattock: ok, let's do that :)
(12:33:47) mattock: https://community.openvpn.net/openvpn/wiki/Topics-201=
9-02-13
(12:33:49) vpnHelper: Title: Topics-2019-02-13 =E2=80=93 OpenVPN Communit=
y (at community.openvpn.net)
(12:33:55) mattock: derek: plans to get back to bed after this one?
(12:34:02) mattock: we could probably cover your topic first
(12:34:04) Derek_OSTIF: yeah, for sure
(12:34:21) mattock: Plugin API for 2.5.0 and the potential Meek plugins t=
hat OSTIF.org would like to develop
(12:34:25) mattock: care to elaborate?
(12:35:48) Derek_OSTIF: So we are working on building a plan to develop a=
 plugin for the existing version of Meek, that does basic domain fronting=
 as well as responding to "probes" by the great firewall. Additionally, w=
e want to develop a version 2.0 that will enable encrypted SNI, which wil=
l make domain fronting harder to detect
(12:36:42) Derek_OSTIF: We need help understanding how complex integratio=
n into openvpn might be for Meek, I would expect integrating other plugin=
s after the first would be easier after we have a greater understanding o=
f the API and how it works
(12:37:30) cron2: what is "Meek"?
(12:37:49) Derek_OSTIF: Meek is an obfuscation proxy that is used for dom=
ain fronting
(12:37:58) Derek_OSTIF: primarily developed by Tor
(12:38:28) Derek_OSTIF: it makes your proxy server look like an https ser=
ver on a major CDN like AWS, CloudFlare, Azure, Google Cloud, etc
(12:38:36) mattock: https://trac.torproject.org/projects/tor/wiki/doc/mee=
k
(12:38:37) vpnHelper: Title: doc/meek =E2=80=93 Tor Bug Tracker & Wiki (a=
t trac.torproject.org)
(12:39:28) Derek_OSTIF: The end-goal is to bring Meek in it's current for=
m, and an improved version, to OpenVPN as plugins to make things substant=
ially easier to use
(12:39:46) dazo: This does have quite an overlap with Jigsaw and the work=
 Operator Foundation has been doing in regards to the plug-in API .... Me=
ek sounds a lot like what the Google project manager talked about though,=
 but not sure if it targets the same plug-able interface
(12:40:38) Derek_OSTIF: Jigsaw and meek are very similar, yes. However, G=
oogle has weird policies about domain fronting on Google Cloud, which lea=
ds us to believe that Jigsaw may not have a long life.
(12:42:12) dazo: IIRC, they had some "setup how-to" which was based on di=
gital ocean :-P
(12:42:20) Derek_OSTIF: Cloudflare on the other hand, has already impleme=
nted the current draft version of encrypted SNI, and is encouraging its u=
se. They are sufficiently large enough that censors won't risk blocking t=
hat whole cert tree
(12:42:22) mattock: yes that is correct
(12:42:40) cron2: oh
(12:42:40) mattock: the setup-howto
(12:42:51) Derek_OSTIF: yeah, setting up meek right now is a nightmare
(12:43:07) dazo: the Jigsaw guys are aware that lots of the potential use=
rs don't like Google .... so they have guides how to set up this stuff wi=
thout being directly tied to Google's "universe"
(12:43:08) cron2: I was about to say "can't we just use our existing conn=
ect-over-ssl-webproxy function", but then remembered that we do not suppo=
rt connect-over-ssl-proxy
(12:43:19) dazo: ;-)
(12:43:41) Derek_OSTIF: you have to install libraries, configure them, in=
stall meek on both ends, and if the guides don't match your exact setup y=
ou're pretty much unable to use it as a regular user
(12:44:06) dazo: yeah, sounds like the good old obfsproxy days as well
(12:44:18) Derek_OSTIF: yeah, similar to a obfs4 setup now
(12:45:07) Derek_OSTIF: so, more or less, the gameplan is to rally the VP=
N providers behind developing these obfs plugins to make it easy enough t=
o use that it'll get widely deployed
(12:45:26) dazo: makes sense
(12:45:42) Derek_OSTIF: we just need to gauge the difficulty
(12:45:49) Derek_OSTIF: and hence the cost
(12:46:01) dazo: and that's the overall idea of the transport plugin API =
as well .... to allow easy set up of such things on the client and server=
 side (given you control both)
(12:46:37) dazo: enable the plug-ins with the proper arguments, and you'r=
e set
(12:46:44) Derek_OSTIF: yeah precisely, if we can get it to a point where=
 all you need is the cert to point to and some extra commands in a config=
 file, that is a gigantic leap forward in usability
(12:48:04) Derek_OSTIF: we are considering working directly with the oper=
ator foundation on it, but we don't know those guys well. I have heard th=
at the code that they've submitted for the plugin system was high quality=
=2E Do you guys know how long they were working on it?
(12:49:53) dazo: I don't recall exactly the time spent, but effective tim=
e was probably 3-4 months or so for a couple of the iterations .... they'=
re quite busy and we couldn't jump on the review instantly, so it the fee=
dback loop made it fairly slow
(12:50:26) Derek_OSTIF: that's not unreasonable at all for decent code an=
d some communication lag
(12:51:17) Derek_OSTIF: my other question is what would be the best setup=
 for developing and integrating these plugins? Fork the whole thing to a =
separate project? Something else?
(12:51:23) dazo: ordex is the one who has been doing most of the work on =
our side, and they've been very reasonable to work with as I could unders=
tand
(12:51:45) ***dazo looks up some git repos
(12:52:18) ***syzzer_ present too now
(12:52:46) mattock: hi syzzer!
(12:52:48) cron2: Derek_OSTIF: if you say "fork the whole thing", which "=
thing" do you mean? Meek, OpenVPN, openvpn-with-transport-api-branch?
(12:53:06) syzzer_: (took until lunch time here for the interrupts from $=
colleagues to stop...)
(12:53:35) dazo: I would say starting poking at ordex work-tree including=
 the transport-plugin stuff would be a good place to get to know the need=
ed code and APIs
(12:53:46) Derek_OSTIF: I don't know the exact mechanics of the plugin sy=
stem, but my understanding is that it would be a completely separate inst=
aller and build, right?
(12:53:55) dazo: and there's a simple obfuscation plugin provided as well=

(12:54:06) cron2: derek_ostif: yes. openvpn produces an openvpn-plugin.h =
file, which is about all you need
(12:54:34) cron2: (but of course you need an openvpn binary which has the=
 necessary plugin APIs, so for that you need the tree from ordex)
(12:54:46) dazo: Derek_OSTIF: basically, build the openvpn with this new =
plug-in interface .... then you start build your own plug-in, all you nee=
d is the header file cron2 mentioned, which results in a .so file which y=
ou load via plug-in option in openvpn
(12:55:05) Derek_OSTIF: Alright, and where would we want the actual final=
 product to be hosted when it is ready?
(12:55:11) ***ordex is here
(12:55:14) ordex: sorry for the delay
(12:55:15) mattock: hi ordex!
(12:55:26) dazo: great"!
(12:55:26) cron2: Derek_OSTIF: that depends on who maintains it, I'd say
(12:55:38) Derek_OSTIF: We could make a custom site, point people to the =
github, let the operator foundation handle it, etc
(12:56:04) dazo: I'm not opposed to host this under the OpenVPN umbrella,=
 as long as we have people willing to maintain it
(12:56:08) Derek_OSTIF: It likely would be the operator foundation, based=
 on what i'm hearing about them.
(12:56:37) dazo: well, they're contractors ... so I don't expect them to =
support/maintain this for a longer time unless someone pays them
(12:56:43) Derek_OSTIF: We would.
(12:56:47) ordex: are they aware they will be the maintainers? :D they ar=
e normally busy on several fronts, so I am not sur ethey can commit long-=
term on maintaining something like this
(12:57:04) ordex: they normally develop and move on (as far as I understo=
od)
(12:57:12) ordex: (like it is happening with the transport-API)
(12:57:28) dazo: yeah, that's my main concern as well .... but if they're=
 willing to do so (whatever agreement the commitment is based on), it cou=
ld work out
(12:57:41) ordex: unless you find somebody funding them all along, then t=
hey will find a way to make this work, I guess, but I am still not sure i=
t fits them
(12:58:14) Derek_OSTIF: Yeah, ive seen that from their previous projects.=
 We plan to have maintenance planned into any agreement that we enter wit=
h them. We may have to find other developers to maintain it though, perha=
ps some of the financial contributors can put in some dev time as well.
(12:59:32) Derek_OSTIF: alright my only other question relates to OpenVPN=
 2.5.0, i know we have the VLAN tagging system, etc still coming in. Is t=
here a possibility of a very rough estimate? 2 months? 6? 12?
(13:00:16) cron2: "end of the year" was the plan
(13:00:27) cron2: we removed specifics on *which year*, so this plan is s=
till valid...
(13:00:33) dazo: :-P
(13:00:34) Derek_OSTIF: haha
(13:00:38) ordex: lol
(13:00:39) ordex: :D
(13:01:11) cron2: seriously, we have not made good progress with the larg=
e patch sets we want to get in, so it's very hard to estimate
(13:01:38) cron2: I hope for "less than 6 months", but I'm fairly sure th=
at "2 months" will not be the answer
(13:01:49) Derek_OSTIF: I mean i'm comfortable with "2H 2019"
(13:02:14) Derek_OSTIF: I'm just trying to make some ugly timetables on w=
hen things might happen.
(13:03:46) dazo: It would be good to have the 2.5 release out during the =
autumn (March + 6 months =3D> August)
(13:04:29) Derek_OSTIF: Alright, that was all the info that i needed. I'm=
 sure I'll have more questions as things coalesce and i'll ask Mattock.
(13:04:33) cron2: dazo: any particular reason for autumn? Or just "not Au=
gust, either before or after that"?
(13:04:39) dazo: given that July is a typical holiday season too ... so e=
ither before end of June or soon after August would be the alternatives .=
=2E. and June might be too tight
(13:04:45) cron2: (March + 6 mo =3D September anyway :)) )
(13:05:08) dazo: duh, I need to re-learn counting! :-P
(13:05:16) cron2: let's see what we can do... I agree that holiday season=
 is bad, though this is "August till mid September" here
(13:05:27) dazo: yeah
(13:07:00) Derek_OSTIF: I'll get some more info on the project, talk to t=
he operator foundation, see if any VPNs are willing to commit dev time on=
 maintenance, and get back to you guys if i hit any technological hurdles=
=2E
(13:07:31) ordex: that sounds good
(13:07:37) dazo: actually getting more people helping maintaining openvpn=
 would be highly appreciated

---

(13:08:55) mattock: uh, pidgin crashed
(13:09:12) Derek_OSTIF: I was talking to QuarksLab about OpenVPN, and the=
y did a review of 2.4.6 with ANNSI and found *NOTHING*
(13:09:14) Derek_OSTIF: so nice work
(13:09:20) ordex: wow
(13:09:24) dazo: cool!
(13:09:24) cron2: \o/
(13:09:43) mattock: \o/
(13:09:54) syzzer_: oh, nice!
(13:09:55) ordex: <o>
(13:10:14) mattock: shall we move on then?
(13:10:20) Derek_OSTIF: alright guys, goodnight!
(13:10:24) cron2: good night :)
(13:10:28) Derek_OSTIF ha abbandonato la stanza.
(13:10:29) mattock: good night! I hope you get additional sleep now!
(13:10:37) mattock: 2.4.7?
(13:11:16) cron2: yep
(13:11:23) ordex: hi syzzer_ :)
(13:12:09) cron2: so, 2.4.7
(13:12:30) cron2: topic one: we should keep the release date, then berniv=
6 will manage to get it into the next debian release
(13:13:06) cron2: topic two: timeline - mattock1: this is mainly on you. =
If I tag the tree monday evening, is that good for you?
(13:13:28) dazo: good ... what's missing for that release? any patches ne=
eding review? (auth-token-hmac is still on my plate, which would probably=
 be good to have)
(13:13:29) cron2: topic three: "is something missing" - I have --script-s=
ecurity vs. GUI on my list
(13:14:06) mattock: I have the vagrantified capability to build debian, u=
buntu and windows packages
(13:14:13) cron2: nice
(13:14:20) mattock: so I don't see any reason why we could not release 2.=
4.7 "at whatever time"
(13:14:39) mattock: the only thing I need to check is the windows code-si=
gning keys
(13:14:41) cron2: dazo: how intrusive is this patchset? Is there a risk i=
t might break "things"?
(13:14:43) dazo: that's great! I'd like to peek over your shoulders when =
running this :=3D
(13:15:22) cron2: I agree it might be good to have, but if it needs somet=
hing like "rewrite half the TLS layer" (exaggerating) this would be a bit=
 of short notice...
(13:15:26) ordex: auth-token-hmac feels much like a really new feature no=
? rather than a fix?
(13:15:40) ordex: yeah what cron2 says basically
(13:15:41) cron2: if it only affects existing auth-token code, I'm okayis=
h
(13:15:50) dazo: cron2: from what I've seen so far, it changes the --auth=
-gen-token feature and adds a few new options to have a possibility to au=
thenticate existing tokens either across server processes or through rest=
arts
(13:15:58) dazo: with a better expiry mechanism
(13:16:22) dazo: so it is semi-intrusive, but fairly isolated
(13:16:43) ordex: dazo: why does it require yet another option? isn't it =
a change in the original behaviour of --auth-gen-token ?
(13:16:52) cron2: let's get it a good review
(13:17:16) dazo: ordex: to have persistence through restarts, you need to=
 have a persistent key for the HMAC signature
(13:17:35) dazo: (and sharing that key across server processes, gives a p=
ossibility to authenticate across several servers)
(13:19:07) ordex: ok
(13:19:08) dazo: the token --auth-gen-token produces to day is 256 bits o=
f randomness ... this new patch-set takes this randomness, adds some time=
stamps and a HMAC signature ... and that's being sent to the clients
(13:19:27) dazo: so when clients re-authenticate with the token, server c=
an validate the HMAC signature and decode the timestamps
(13:19:42) ordex: what I want to say is: will the current --auth-gen-toke=
n behaviour be deprecated after this patchset? or we'll have to support t=
he current behaviour *and* the new behaviour?
(13:20:20) dazo: it will replace the current behaviour .... but that does=
n't change anything for clients (they just store and re-send the token to=
 the server)
(13:20:30) ordex: oh alright
(13:20:34) cron2: from what i understand, the token will look differently=
, but the behaviour is mostly the same - *plus*, I doubt many people are =
using the feature today, as it's sort of "rough edges all over"
(13:20:55) ordex: it's all on the server, so basically when you enable --=
auth-gen-token on the server you will have to supply a key as well, right=
 ?
(13:20:58) dazo: some of that roughness is handled by some other patches =
though
(13:21:40) dazo: ordex: if you don't supply a key, it will be an ephemera=
l key valid only for that process at that time ... so behaviour will be i=
dentical
(13:22:02) dazo: if adding a key, that's when you get the additional adva=
ntage
(13:22:50) ordex: ok...I am just wondering if it's good to have yet anoth=
er variance of the behaviour or if we should just enforce supplying a key=
 all the time, so user knows "that's the way it works and it does somethi=
ng meaningful"
(13:23:16) ordex: so people will just get an error as "from today you hav=
e to specify a key and it will really do what it was always supposed to" =
:P
(13:24:07) mattock: you code-signing cert is good for a while: "Not After=
 : Oct 9 12:00:00 2019 GMT"
(13:24:10) dazo: well, if adding the requirement of a key, you break exis=
ting --auth-gen-token setups .... or you need to support the old way of b=
ehaviour in parallel ... I see no real benefit for that
(13:24:22) mattock: our...
(13:24:45) dazo: I think having a random key if no explicit key in use ma=
kes sense, less code variations and doesn't break existing servers
(13:24:58) ordex: dazo: yeah, my assumption was that "you break existing =
--auth-gen-token setups" was ok, because people using --auth-gen-token al=
ready have a broken setup somehow
(13:25:03) cron2: dazo: works for me
(13:25:06) ordex: ok
(13:25:18) ordex: if the code still stays simple
(13:25:27) ordex: goed :)
(13:25:35) dazo: well, --auth-gen-token does work today .... but when ena=
bling expiry, clients misbehave and gets confused
(13:25:47) dazo: and if restarting the server, clients also misbehaves
(13:26:26) dazo: But those issues are fixed by some other patches from pl=
aisthos
(13:26:32) ordex: right
(13:26:35) dazo: (not sure if they got in yet)
(13:26:35) ordex: ok
(13:26:51) ordex: (it would be nice to have them as they really feel like=
 fixes :D)
(13:26:54) cron2: client-side token expiry stuff got in
(13:26:56) dazo: yeah
(13:27:12) dazo: oh, cool! Then auth-gen-token as it is today will even b=
ehave nicer
(13:27:15) cron2: commit 004f13b60d8
(13:27:17) cron2: Fallback to password authentication when auth-token fai=
ls
(13:27:27) dazo: right, that's the one
(13:28:29) syzzer_: in 2.4, similar behaviour can also be achieved with a=
 script: https://community.openvpn.net/openvpn/wiki/SWEET32
(13:28:30) vpnHelper: Title: SWEET32 =E2=80=93 OpenVPN Community (at comm=
unity.openvpn.net)
(13:28:49) dazo: yeah
(13:29:17) dazo: in 2.3, you mean syzzer_ :)
(13:29:31) syzzer_: 2.4 too :)
(13:29:37) syzzer_: the scripts do the hmac-stuff
(13:29:42) dazo: well, it works in 2.4 too, yeah ... instead of --auth-ge=
n-token :)
(13:29:51) syzzer_: yeah, that
(13:30:05) syzzer_: but the changes are farely isolated, so I'm fine eith=
er way
(13:30:09) syzzer_: faily
(13:30:13) syzzer_: fairly
(13:30:15) dazo: but clients would still misbehave on expiry without comm=
it 004f13b60d8
(13:31:04) cron2: so - time is running out - dazo tries to review & ACK t=
he auth-token patches for 2.4. I do Selva's --script-security stuff (most=
ly windows gui). tag + release either monday evening or tuesday morning
(13:31:14) dazo: Sounds good!
(13:31:16) syzzer_: yeah, but I mean just about whether the hmac patches =
should go into 2.4 or not
(13:31:29) syzzer_: agreed :)
(13:31:41) cron2: cool :-)
(13:32:10) cron2: so, short update on tap-windows6: we had issues with wi=
ndows test packets not propagating through either openvpn tap p2mp server=
 *or* a linux bridge bridging two openvpn p2p instances
(13:32:23) dazo: well, we need it in the next Access Server release :-P .=
=2E... but I think it is a good improvement which is fairly isolated ... =
even though there is some smaller refactoring
(13:32:29) dazo: (to reuse existing code)
(13:32:44) cron2: I hacked together a "flood unknown unicast" patch for o=
penvpn tap p2mp, which should get Stephen further in having the driver te=
sted
(13:32:53) cron2: but haven't heard anything back yet...
(13:33:03) cron2: short form: "we're making progress, hopefully" :)
(13:33:08) dazo: :)
(13:33:12) dazo: good!
(13:33:49) mattock: as long as there is steady (even if slow) progress I =
don't see the need to put a fire under Stephen :P
(13:33:51) cron2: (and our bridging code is an interesting combination of=
 "just leave out things that a normal switch would do, and it still works=
, but if you add *parts* of those, things explode...")
(13:34:10) cron2: mattock1: nah, that was not my intention. Just giving a=
 status update.
(13:34:26) mattock: I did not intend to imply that
(13:34:32) cron2: since the bridge topic is really outside his tasked wor=
k and that was waiting on us to come up with good ideas...
(13:34:41) mattock: but we're not in pressure to "omg we must release now=
!"
(13:34:54) mattock: anyways
(13:34:54) ***cron2 wants at least the tap driver off his plate :)
(13:34:58) mattock: +1
(13:35:07) mattock: it lands on my plate with all the goodness
(13:35:15) cron2: need to feed the kids now... *wave* ($wife has to be at=
 school...)
(13:35:23) mattock: only three different signature versions - how much fu=
n is that to manage :P
(13:35:29) cron2: haha :)
(13:35:44) mattock: let's conclude the meeting here then, unless somebody=
 has something really important
(13:35:59) cron2: syzzer_: I hope you can keep your colleagues at bay for=
 a bit longer, so we can grab more of your time again :-)
(13:36:15) syzzer_: I'm spending my afternoon on openvpn :)
(13:36:23) mattock: \o/
(13:36:25) syzzer_: but need to get some lunch first
(13:36:34) mattock: enjoy!
(13:36:37) ordex: :) enjoy your lunch
(13:36:46) ***ordex is in post dinner mode
(13:37:02) syzzer_: well, enjoy (post) dinner then :p
(13:38:07) ordex: :p

--------------5D0FF607D66D42699E2F2DBC--

--DtWJAtBHFtkPGDlYQeahdWpWuwl6L6QzL--

--EgyP1dG4Vko3OjO5RASurEd58vUsChsvH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEbQT48bAXMRH0mXleKVhNn0CGRXgFAlxkB7gACgkQKVhNn0CG
RXhNwgf/bu1ht4cDaHGb7C1C1pQLMApkqtoX4VvEsptJUd3pD3Aeueb9Sqt/HpRi
NB4HhXq47r70wOHR1na+dSJfljRvQ7ui/Rd9VaNxC9HaF56So2rCGvoMEAtIEVQb
wQeE6mlKR3AU0tFB3d2SmWt5b8d3KB/4LX7P96dMMhNTgg1gOa0jDuqucGKMJzzP
CGWmz99sYOo2Y5Ov+I7oqTExj/OO+cojZ13/147sb5ThP1ljKGMQYLlKzALY7xos
YTpI9PVt70GD7N6KwiAy3wbbZuMMyWlCFbLhwmZCvUGTzZPSJfZKhq3XZSJhvR1E
gpHuLtd106WArT/hFuWE9PsmPzf/8w==
=1hAr
-----END PGP SIGNATURE-----

--EgyP1dG4Vko3OjO5RASurEd58vUsChsvH--

