From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
References: <cde19afd-b6cb-3b99-b346-1cfcdcebbbe2@...515...>
Message-ID: <c31ed4c7-5451-cca7-1ba2-6a7a0eeecb59@...515...>
Date: Wed, 24 Jun 2020 14:10:07 +0300
MIME-Version: 1.0
In-Reply-To: <cde19afd-b6cb-3b99-b346-1cfcdcebbbe2@...515...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="cexjo3jMpOPZClky6Bq6jFhV9FTru3gWV"
Subject: [Openvpn-devel] Summary of the community meeting (24th June 2020)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--cexjo3jMpOPZClky6Bq6jFhV9FTru3gWV
Content-Type: multipart/mixed; boundary="WO3W9gglDhAlh80zBP1xM3pCx8wjATTHh"

--WO3W9gglDhAlh80zBP1xM3pCx8wjATTHh
Content-Type: multipart/mixed;
 boundary="------------41E909FA1BAC145173A8A569"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------41E909FA1BAC145173A8A569
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

Hi,

Here's the summary of the IRC meeting.

---

COMMUNITY MEETING

Place: #openvpn-meeting on irc.freenode.net
Date: Wed 24th June 2020
Time: 11:30 CEST (9:30 UTC)

Planned meeting topics for this meeting were here:

<https://community.openvpn.net/openvpn/wiki/Topics-2020-06-24>

Your local meeting time is easy to check from services such as

<http://www.timeanddate.com/worldclock>

SUMMARY

cron2, dazo, lev, mattock, plaisthos and uip participated in this meeting.

---

Talked about the status of OpenVPN 2.5:

<https://community.openvpn.net/openvpn/wiki/StatusOfOpenvpn25>

Ordex promised to have a look at the async-cc patches this week.
Plaisthos, dazo and cron2 will follow-up on the review comments to get
them resolved quickly.

OpenVPN 2.5 MSI looks surprisingly good. Mattock was able to produce
tap-windows6 MSM ("merge module") which he then used to produce OpenVPN
2.5-based MSI installer. The only significant challenge is adding
code-signing support to openvpn-build/generic.

Automating MSI builds also seems easier than expected, given that the
existing openvpn-build buildslave can perform the actual build and push
the artifacts to the Windows packager, which can then build and push the
results to build.openvpn.net.

Code-vise 2.5-alpha1 is in a good shape, mainly missing

- compression
- async cc
- VRF (which is quite trivial)

The auth-token fixes are corner-cases and it was agreed that that can be
resolved between 2.5-alpha1 and 2.5-beta1.

---

Talked about moving 2.3 into "oldstable" support mode. Previously we had
agreed to do that when 2.3.19 was released. However, 2.3.18 was released
a long while ago and there's nothing queued for 2.3.19. So it was
decided to move 2.3 to "oldstable" now instead of later.

---

Talked about starting the deprecation of "--ncp-disable". The idea is
that --ncp-disable has been mostly a debug feature and as we move
forward and want to be able to manage VPN security more from server
side, we want to abandon the possibility to ignore NCP.

This is tied with deprecation of --cipher for everything except p2p:

https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg20062.h=
tml

Uip will bring these topics up with syzzer a.s.a.p.

---

Talked about OpenVPN 2.6. There are several things that are 2.6 material:

- Kernel acceleration module (client-side only beta ~next week)
- Work related to "making DNS handling nice"

It is possible that we'd also need to postpone the --ncp-disable and
--cipher changes.

However, it was agreed that doing a "quick" 2.6 release in, say, early
2021 is doable. It was also agreed that supporting both 2.5 and 2.6 as
"stable" for a while would be acceptable, as the changes would be mostly
in OpenVPN and the same release and automation tooling could be used for
both.

---

Talked about our use of IV_*. Agreed that rather than having tons of
IV_FOO=3D1 options IV_PROTO should be considered a wire-protocol-only
64-bit mask field and IV_FEAT would be a new 64-bit mask field
indicating which features the local side supports.

OpenVPN will need to handle a remote side not providing IV_FEAT.
Default behaviour when this field is missing must be documented.
IV_FEAT should be sent by OpenVPN 2.6 and newer. This approach allows
easier deprecation of features as well.

--

Full chatlog attached

--------------41E909FA1BAC145173A8A569
Content-Type: text/plain; charset=UTF-8;
 name="openvpn_irc_meeting_chatlog_2020-06-24.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="openvpn_irc_meeting_chatlog_2020-06-24.txt"

(12:29:37) cron2: oh, a rare guest :-) - good morning uipko
(12:30:10) uip: morning
(12:30:21) dazo: hey!
(12:30:46) uip: trying to join the meetings more often
(12:31:59) dazo: that's great!
(12:32:34) plaisthos: hey
(12:32:39) lev__: hello
(12:32:52) uip: probably mainly reading/listening most of teh time ;)
(12:33:56) cron2: oh, feel free to take over and tell us what to do :-)  =
(poking ordex and looking for lev__ ever so often starts to get boring)
(12:34:46) cron2: where is ordex anyway? :)
(12:35:09) dazo: Good question! :)
(12:35:36) mattock: hi!
(12:36:39) mattock: 2.5 updates first?
(12:37:11) mattock: https://community.openvpn.net/openvpn/wiki/Topics-202=
0-06-24
(12:37:13) vpnHelper: Title: Topics-2020-06-24 =E2=80=93 OpenVPN Communit=
y (at community.openvpn.net)
(12:37:32) cron2: first things first, and that's topic #1 :-)
(12:37:54) dazo: :)
(12:38:07) lev__: I will reply to plaisthos mail about optional compressi=
on, rebase my "fix some warnings" patch and write a test script/suite for=
 testing async-cc (with the help of openvpn inc qa guy)
(12:38:24) dazo: So #1 means https://community.openvpn.net/openvpn/wiki/S=
tatusOfOpenvpn25  :)
(12:38:25) vpnHelper: Title: StatusOfOpenvpn25 =E2=80=93 OpenVPN Communit=
y (at community.openvpn.net)
(12:38:32) lev__: sorry, was busy lately with corp stuff and midsommer ce=
lebration
(12:38:58) dazo: corp/kernel module stuff ;-)
(12:39:25) cron2: lev__: happy dance :-)
(12:40:32) dazo: ordex promised to have a look at the async-cc patches th=
is week.  plaisthos and I can follow-up on review comments, to get them r=
esolved quickly
(12:41:20) cron2: I expect that this will be somewhat more work than "jus=
t review comments" (restructure more, change patch granularity) - but I'm=
 here to help as well.  Just not tomorrow, $kid[1] birthday
(12:41:56) mattock: MSI looks surprisingly good - openvpn-build/generic j=
ust needs code signing support
(12:42:03) cron2: my plate for 2.5 is emptying (and this is good).  Worki=
ng on some trac tickets, windows tap config (with /64 or not? for tun mod=
e or tap mode?) and the VRF patch
(12:42:12) mattock: I was able to produce tap-windows6 MSM (merge module)=
 and use that to produce OpenVPN 2.5 MSI installer
(12:42:26) dazo: cron2: man-pages would really need some additional revie=
w before submitting patches to ML
(12:42:32) cron2: mattock: another happy dance :-)
(12:42:56) cron2: dazo: let's poke wiscii :-)  (but yeah, I'll see what I=
 can get done)
(12:43:21) lev__: for async-cc testing I was planing to have 2 machines. =
One machine runs server with async-cc and few secs sleep, another one run=
s hundreds of clients which attempt to connect and disconnect, and some l=
ogic to check that all clients connected successfully
(12:43:26) cron2: .oO(did I mention that unit tests, autoconf, and shared=
 library building across BSD, Linux and MacOS really take too much time?)=

(12:43:47) lev__: I did something like that back in 2014 when we took tha=
t patch into use for freedome vpn
(12:44:21) mattock: also, automating the MSI builds may not be that horri=
ble, either - I can reuse the openvpn-build buildslave to run openvpn-bui=
ld/generic, sign the files and scp them over to a dedicated Windows box, =
which checks the file timestamps and triggers a build if those change -> =
scps results to build.openvpn.net
(12:44:34) mattock: no need for Samba afaics
(12:44:38) cron2: lev__: yep, that's about what I did for the async-auth-=
pam setup.  One client is connected all the time, and noping verifies tha=
t ping works all the time, and "n" other instances connecting in a loop -=
 some succeeding, some failing
(12:44:47) mattock: (our Windows node all have SSH enabled)
(12:44:51) cron2: mattock: more happy dances :)
(12:46:49) dazo: We have 6 more days for the code release ... are there i=
tems in the "must have" list we should reconsider?  Or some we will allow=
 appearing a bit later after code freeze?
(12:48:13) cron2: there's not much left, actually, code-wise
(12:48:27) cron2: compression, async cc, VRF
(12:48:50) dazo: I'm wondering how much work the VRF will imply, and how =
well will we test it?
(12:48:51) cron2: the auth-token stuff is more "fixing corner case bugs",=
 that can happen in beta I would say
(12:49:09) dazo: agreed
(12:49:10) cron2: I think the VRF stuff is totally trivial, I've just sta=
lled for silly reasons
(12:49:26) dazo: okay, if it's trivial ... then this is doable
(12:50:12) cron2: it's not really "VRF" but "bind to device" - I wanted t=
o get this "right" in a as generic fashion as possible, which took too mu=
ch time.  Max only wants (and tests) Linux, so this got stuck.  But, this=
 week :-)
(12:50:36) cron2: if I do not have to build another MacOS test setup for =
engine tests...=20
(12:52:25) cron2: anyone else on 2.5?
(12:54:07) cron2: uip: anything from your end that you think we should ad=
dress in 2.5?
(12:56:04) cron2: seems "nothing more on 2.5"
(12:56:10) cron2: topic #2 - "moving 2.3 into old stable"
(12:56:49) dazo: I spotted we said 2.3 would go into old stable with 2.3.=
19 ... but we haven't released anything there in quite some time and noth=
ing planned/queued
(12:57:14) cron2: actually there is nothing in the release/2.3 branch aft=
er 2.3.18
(12:58:26) dazo: Which is why I think 2.3 is ready for old-stable support=
 :)
(13:00:12) cron2: doesn't look like i have to actively *do* anything for =
that, so I'm not objecting
(13:00:16) dazo: And we can consider what to do after 2.5 is released
(13:00:40) dazo: All needed is to update the wiki page
(13:01:12) dazo: 2.4 is aging and I would expect most users who would car=
e to be on 2.4 already
(13:01:19) cron2: I would hope so
(13:02:23) dazo: alright, so unless noone disagrees ... lets move it to o=
ld-stable, to at least signal that
(13:02:45) dazo: s/noone/any one/
(13:03:03) dazo: gee my typing is horrendous today
(13:03:15) cron2: shall we do that togehter with the 2.5.0 announcement? =
 or "now!"
(13:03:57) dazo: I would do it now, just to not needing to think about it=

(13:04:23) dazo: once the 2.5.0 stable is out, we can decide if we're mov=
ing 2.3 to "git tree only"
(13:05:05) cron2: ok.  #3 now?  "start depreciation of --ncp-disable"?
(13:05:55) dazo: plaisthos, this topic is probably something you can help=
 us with
(13:07:23) dazo: the idea is that --ncp-disable has been more a debug fea=
ture ... and as we move forward and want to be able to manage VPN securit=
y more from server side, we want to abandon the possibility to ignore NCP=

(13:07:24) uip: Sorry, had also a stand-up meeting..
(13:07:44) mattock: uip: np
(13:08:41) plaisthos: I posted an idea how to handle that to the mailing =
list
(13:08:52) plaisthos: basically depreacted --cipher for everything but p2=
p
(13:08:53) dazo: This one, I believe: https://www.mail-archive.com/openvp=
n-devel@lists.sourceforge.net/msg20062.html
(13:08:54) vpnHelper: Title: Re: [Openvpn-devel] [PATCH] systemd: Change =
the default cipher to AES-256-GCM for server configs (at www.mail-archive=
=2Ecom)
(13:09:16) plaisthos: yes
(13:09:18) cron2: that's more topic #4 :)
(13:09:21) uip: I don't have any issue's. Last week we got a issue report=
 from a user about fragmentation, but looks like a config issue. Not clea=
r yet what he actually did..
(13:09:36) dazo: it's all tangled together ... --ncp-disable is just the =
first step :)
(13:09:56) cron2: I'd really like to hear syzzer's (and uip's!) thoughts =
on --ncp-disable and --cipher
(13:10:11) cron2: crypto people think different than network people
(13:11:42) dazo: We don't need to conclude today, but get the discussion =
and process started ... and if uip would like to dig into he topic first,=
 that's fine for me.  But probably followup quickly on the ML
(13:11:52) cron2: yeah
(13:12:35) uip: I (also) have to discusse that syzzer (not enough cryptop=
eople yet ;)
(13:12:37) dazo: Since this is strictly not adding a new feature, we coul=
d probably allow related changes post code-freeze
(13:13:37) dazo: at the same time, I'm concerned how it may impact the re=
lease plan
(13:16:12) cron2: this is why I've put #5 on the agenda :)
(13:17:25) uip: I'll pick this up with syzzer ASAP
(13:17:26) dazo: An alternative is that we just adds lots of warnings wit=
h related options for 2.5.0 + warn about these changes in release notes .=
=2E.. and then complete the transition in 2.5.3+ or so
(13:17:27) plaisthos: We can also ada that later
(13:17:37) cron2: uip: this is good, thanks
(13:17:49) dazo: plaisthos: "later" is kinda short time ... considering c=
ode freeze is in 6 days
(13:17:54) dazo: next meeting in 8 days
(13:18:14) cron2: dazo: doing possibly disruptive things in 2.5.*3* sound=
s like really bad plan
(13:18:26) cron2: we do if we must, but we do not *plan* on doing so
(13:18:28) dazo: cron2: agreed ... I don't like it either
(13:19:15) cron2: well
(13:19:27) dazo: uip: would you be able to follow up on ML later this wee=
k after discussing with syzzer?
(13:19:42) cron2: one idea, to test the waters: are we able to do a *quic=
k* 2.6.0 release?  like, early 2021?
(13:19:58) mattock: what is the schedule of the kernel module?
(13:20:08) mattock: that is "2.6 stuff" probably, if it is available
(13:20:27) cron2: these IV_PROTO changes you have suggested are something=
 that can be done, but needs consideration, synchronization with AS relea=
se
(13:20:56) dazo: mattock: first public beta of kernel module with client-=
only support is expected next week
(13:21:09) cron2: so this whole "make DNS nice!" thing is not something w=
e can get into 2.5 unless we postpone
(13:21:20) mattock: let's do quick 2.6 rather
(13:21:22) mattock: imho
(13:21:49) uip: dazo: it could be that syzzer is on holliday this week
(13:21:51) mattock: 2.5 has had its share of postponing already
(13:22:18) dazo: yeah ... but lets also keep the deprecated list in our m=
inds at the same time ... https://community.openvpn.net/openvpn/wiki/Depr=
ecatedOptions ... we might need to reconsider some of them if 2.6 comes v=
ery early
(13:22:19) vpnHelper: Title: DeprecatedOptions =E2=80=93 OpenVPN Communit=
y (at community.openvpn.net)
(13:23:24) dazo: alternatively, we keep 2.5 as a stable release for a lon=
ger period (now it is 6 months after last major release)
(13:23:34) dazo: well, minimum it says
(13:24:23) mattock: from my perspective maintaining 2.5 and 2.6 would be =
ok for a while
(13:24:24) cron2: I'm not holding my breath on "very early" :-)
(13:24:32) cron2: what mattock says
(13:24:41) mattock: unlike with 2.4 and 2.5 there would not many differen=
ces, mostly openvpn code
(13:24:51) mattock: 2.4 =3D NSIS, 2.5 =3D MSI, 2.6 =3D MSI
(13:25:12) mattock: same tooling can be used for 2.5 and 2.6 releases and=
 automation
(13:25:22) cron2: doubleplusgood
(13:25:56) mattock: so a "quick" 2.6 release with possibly overlapping 2.=
5 and 2.6 "stable" support period is fine by me
(13:26:17) mattock: plus we would not have to postpone 2.5 _again_ and ge=
t more stuff queued and then have to postpone it _again_ :D
(13:27:00) cron2: yeah
(13:27:01) mattock: better draw a line and just accept that some stuff wi=
ll have to come later
(13:28:48) cron2: dazo, plaisthos, lev__: thoughts?
(13:29:25) cron2: (I wonder if we should try jitsi with video for one of =
the next meetings... so we can see if one of you has just wandered away a=
nd it's no use waiting...)
(13:30:21) dazo: Yeah, I do not disagree ... that said, when plaisthos an=
d I discussed the IV_PROTO stuff, we didn't really have that in the "we n=
eed this in 2.5".  If changes are untrivial, that's a different story ...=
 but if it trivial and not putting anything at risk for the code-freeze, =
"why not"
(13:30:33) dazo: hehehe
(13:31:08) cron2: changing IV_ and figuring out who might interpret what =
on the other and, and how to avoid "interesting" complications is nontriv=
ial
(13:31:37) cron2: AS has certain ideas on IV_ things...  people are runni=
ng old AS release...
(13:32:03) cron2: so I'd like to see this documented *very soon*, but the=
 actual code change to happen "in master after the 2.5.0 release"
(13:32:22) dazo: IV_PROTO changes is not risky, as that just documents co=
ming features .... and we only have two valid values (1, 2) which fits wi=
thin a bitmask
(13:32:30) cron2: (also, I do not like overloading IV_PROTO with "non pro=
tocol related" things, so I'd go for IV_DNS=3D<bits>)
(13:32:53) cron2: it is, if we decide to remove IV_TCPNL=3D1 - this is re=
ally just a proto bit - but having that one go away will upset AS
(13:33:28) dazo: AS has been considered and we will handle that easily, s=
o I'm not concerned with AS
(13:33:56) dazo: and by not using these new "DNS features", OpenVPN shoul=
d behave as before
(13:34:04) lev__: I like IV_DNS
(13:34:35) dazo: We also want to reduce the number of IV_* stuff ... as t=
hat buffer is limited
(13:34:48) cron2: I really feel a bit strongly about IV_PROTO being "on t=
he wire" bits, and other IV_ variables governing "what can happen with op=
tions"
(13:35:03) dazo: we consider IV_PROTO to be 64 bits ... it's more than en=
ough space
(13:35:04) cron2: so, kick out IV_TCPNL=3D1, use these bytes for IV_DNS=3D=

(13:35:18) cron2: but removing IV_TCPNL is not without risk
(13:35:22) dazo: Lets also think broader than just DNS
(13:35:27) cron2: I do :)
(13:35:53) dazo: That's why IV_DNS is limited ... IV_FEAT would probably =
be a better naming
(13:35:54) cron2: the compression stuff is PROTO in my mental image
(13:36:15) dazo: yeah, but we want to get rid of compression ... so we de=
cided to keep it out of IV_PROTO
(13:37:28) plaisthos: lets focus on 2.5 now
(13:37:35) plaisthos: and try to make 2.6 quicker
(13:37:42) plaisthos: and maybe not with as many big changes
(13:37:54) mattock: +1
(13:38:11) dazo: plaisthos: thoughts on the  IV_* discussion?
(13:38:13) cron2: as long as we have compression, it might make sense to =
get these signalled more efficiently... I've just grepped on IV_ in one o=
f my client logs, and about half the variables are "compression" (LZ4, LZ=
4v2, COMP_STUB, COMP_STUBv1, LZO)
(13:38:44) cron2: s/v1/v2/
(13:39:27) dazo: yeah
(13:39:46) plaisthos: ignore AS consideration
(13:39:51) plaisthos: I will take care of AS
(13:40:05) ***cron2 likes that
(13:40:25) plaisthos: basically we want get rid of zillion IV_FOO=3D1 and=
 therefore have something like a bitfield=20
(13:40:48) cron2: I'm totally OK with that basic idea
(13:40:58) plaisthos: to extend IV_PROTO seemed like a good idea since th=
at is already there
(13:41:45) dazo: and IV_PROTO is a nummeric field too
(13:41:48) plaisthos: we can also split it arbitrarely in to IV_FEAT and =
IV_PROTO if you pref
(13:42:40) lev__: we have changed IV_PROTO to 2 because we changed wire p=
rotocol
(13:43:02) lev__: DNS stuff is client behavior and not related to protoco=
l
(13:43:13) cron2: this :-)
(13:43:29) cron2: I would feel better about IV_PROTO only being "wire pro=
tocol" - and IV_FEAT or IV_WHATEVER
(13:43:32) cron2: but that is too long :)
(13:44:10) dazo: alright, I'm fine with defining supported features in IV=
_FEAT and keep IV_PROTO strictly wire protocol
(13:44:57) dazo: and if we now define these as 64bit fields, we should be=
 fairly future proof
(13:47:36) mattock: enough talk about this topic? :P
(13:47:53) ***plaisthos like his IV_ variables green
(13:48:00) dazo: hahaha
(13:48:17) dazo: plaisthos: I'll add a special patch colouring the logs, =
just for you
(13:48:27) cron2: plaisthos: log colouring is a GUI thing :-)
(13:48:50) plaisthos: cron2: IV_PROTO_green
(13:49:24) cron2: IV_LOGCOLOR=3Dblue
(13:49:30) cron2: IV_BIKESHED=3Dred
(13:50:04) mattock: as long as anyone can have their choice of log color =
I'm fine with this
(13:50:40) dazo: so ... the conclusion is:   IV_PROTO is considered a 64-=
bit mask field and IV_FEAT will be a new 64-bit mask field indicating whi=
ch features the local side supports.
(13:50:56) dazo: should we also declare that IV_FEAT will always be sent =
to the remote side?
(13:51:50) dazo: Anyone disagreeing?
(13:51:52) cron2: on the server side you need to handle "no IV_FEAT" (old=
 client)
(13:52:09) cron2: on the client side you can mandate "always send IV_FEAT=
 with all you can do"
(13:52:27) dazo: yes
(13:53:38) dazo: mattock: you're able to grasp that conclusion?
(13:53:48) mattock: I believe so yes
(13:53:57) dazo: good :)
(13:54:36) dazo: Anything else?
(13:56:02) mattock: please review:
(13:56:04) mattock: Talked about our use of IV_*. Agreed that rather than=
 having tons of  IV_FOO=3D1 options IV_PROTO should be considered a wire-=
protocol-only  64-bit mask field and IV_FEAT would be a new 64-bit mask f=
ield  indicating which features the local side supports.
(13:56:04) mattock: On the server side you need to handle "no IV_FEAT" (o=
ld client).
(13:56:04) mattock: On the client side you can mandate "always send IV_FE=
AT with all you can do".
(13:58:33) dazo: Can we simplify these two last lines?  cron2, what about=
:  OpenVPN will need to handle a remote side not providing IV_FEAT.  Defa=
ult behaviour when this field is missing MUST be documented.  IV_FEAT SHO=
ULD be sent by OpenVPN 2.6 and newer.
(13:59:16) cron2: wfm
(13:59:36) dazo: This can also allow the server to indicate features to t=
he client in the future.
(14:00:36) cron2: (that would even work for features going away, so "no I=
V_FEAT =3D can do DHCP, can do compression, ...", and if you/we ever rip =
out compression, that bit will be *sent* as 0, and that way it is clear t=
o the server "this is a new client and it *stopped* supporting something =
2.3 to 2.5 could do"
(14:00:54) dazo: mattock: we are in agreement then .... replace the "On t=
he (client|server)" with the "OpneVPN will need ...."
(14:00:58) dazo: cron2: exactly
(14:01:00) mattock: ok

--------------41E909FA1BAC145173A8A569--

--WO3W9gglDhAlh80zBP1xM3pCx8wjATTHh--

--cexjo3jMpOPZClky6Bq6jFhV9FTru3gWV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEbQT48bAXMRH0mXleKVhNn0CGRXgFAl7zNI8ACgkQKVhNn0CG
RXgfWQf/dEA+yGGy/5+xwqW8AAFGkdGz3t8UWZp/UzYmoEGeLPMu/aPvquWBS978
IaikhCbtxQRNnCn7nxfEkwNgrfi1ocSgIBOAJ46plH5m1LzTnXB44MHLUprH5w4F
iykm2qTfDCGRxGN+ZPSs5z3Nt7xt16XTf8S5wAeIUAV/YDQ4PRRQjay1XFCVKbId
xOvjz09HNk7G9DljcwFZskkpx4rkw1NVjAWNE/ENjmpHt2TG0LuNmG+U1+58balW
h1Lz4oy+dqeOvpMzGEgfGAuOG8R9CC3FK/dmDtJO88fGVyUFfyDqvvNzfJcjoU5M
bpjG5BBEEC0fjUgSfp+Lz0aW7ILWAw==
=wAtD
-----END PGP SIGNATURE-----

--cexjo3jMpOPZClky6Bq6jFhV9FTru3gWV--

