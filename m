References: <d642abed-a224-f94a-5546-08c234e7c957@...515...>
From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
Message-ID: <bfc75b57-e160-dad1-46b6-73427766403b@...515...>
Date: Tue, 14 Jun 2016 09:41:14 +0300
MIME-Version: 1.0
In-Reply-To: <d642abed-a224-f94a-5546-08c234e7c957@...515...>
Content-Type: multipart/mixed; boundary="------------1556AA34153BAAA7335C76E9"
Subject: [Openvpn-devel] Summary of the IRC meeting on 13th June 2016
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------1556AA34153BAAA7335C76E9
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: quoted-printable

Hi,

Here's the summary of today's IRC meeting.

---

COMMUNITY MEETING

Place: #openvpn-meeting on irc.freenode.net
Date: Monday 13th June 2016
Time: 20:00 CEST (18:00 UTC)

Planned meeting topics for this meeting were here:

<https://community.openvpn.net/openvpn/wiki/Topics-2016-06-13>

The next meeting has not been scheduled yet.

Your local meeting time is easy to check from services such as

<http://www.timeanddate.com/worldclock>

SUMMARY

cron2, jamesyonan, mattock and syzzer participated in this meeting.

---

Discussed the v2 of the cipher negotiation patchset:

<http://article.gmane.org/gmane.network.openvpn.devel/11869>
<http://article.gmane.org/gmane.network.openvpn.devel/11872>
<http://article.gmane.org/gmane.network.openvpn.devel/11873>

These v2 patches required modifications to make them behaviorally=20
identical with OpenVPN 3.x code. Syzzer sent v3 versions to the mailing=20
list after the meeting.

---

Reviewed the private "dev/query-user-v4" branch from dazo:

<https://gitlab.com/dazo/openvpn/commits/dev/query-user-v4>

Some clarifications and modifications are necessary before the patches=20
can be ACKed (see the inline comments).

--

Full chatlog has been attached to this email.

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock


--------------1556AA34153BAAA7335C76E9
Content-Type: text/plain; charset=UTF-8;
	name="openvpn_irc_meeting_chatlog_2016-06-13.txt"
Content-Disposition: attachment;
	filename="openvpn_irc_meeting_chatlog_2016-06-13.txt"
Content-Transfer-Encoding: quoted-printable

(21:00:06) mattock: hi all!
(21:00:11) syzzer: meeting \o/
(21:00:32) syzzer: mattock: heard anything from james?
(21:01:02) ***cron2 is already totally exhausted :)
(21:02:15) mattock: hmm, no response from James
(21:03:25) mattock: I'll ask in the company chat
(21:07:46) mattock: shall we start with dazo's patches?
(21:07:58) mattock: in case James turn up (I'll also send him another ema=
il reminder)
(21:10:25) syzzer: is dazo around?
(21:10:43) mattock: no clue, I hope he is
(21:10:48) cron2: let's have a look :) - I think we did a lot of work on =
the crypto stuff today and thursday, so we really could use a bit of Jame=
s for that now :-)
(21:11:04) cron2: haven't seen him, he said something about "vacation, bu=
t he would checkin every now and then"
(21:11:08) mattock: I just sent james email
(21:11:37) mattock: james said he'll try to join
(21:11:46) cron2: great
(21:12:37) jamesyonan [~jamesyona@...2094...] =C3=
=A8 entrato nella stanza.
(21:12:49) mattock: hi jamesyonan!
(21:13:00) cron2: cool :) - hi jamesyonan
(21:13:00) jamesyonan: Hi mattock
(21:13:05) jamesyonan: hi guys
(21:13:06) mattock: great that you could join at such as short notice (as=
suming my email #1 went to /dev/null)
(21:13:29) jamesyonan: actually I did get your email but got sidetracked
(21:13:42) syzzer: hi james :)
(21:13:55) jamesyonan: hi syzzer
(21:14:29) mattock: so topics are here: https://community.openvpn.net/ope=
nvpn/wiki/Topics-2016-06-13
(21:14:31) vpnHelper: Title: Topics-2016-06-13 =E2=80=93 OpenVPN Communit=
y (at community.openvpn.net)
(21:14:44) mattock: now that james is here we can review the cipher negot=
iation patches
(21:15:27) mattock: syzzer: any introduction to the remaining three patch=
es?
(21:15:56) syzzer: uhm, yeah, so I've finally find enough focused time to=
 work on NCP
(21:16:16) syzzer: not sure if you've seen the patches?
(21:17:16) syzzer: cron2 and plaisthos have been busy finding corner case=
s that may not be handled properly
(21:17:31) jamesyonan: looking at them now...
(21:18:21) syzzer: one thing that cron2 noticed is that my current implem=
entation doesn't deal well with clients that don't send a pull request (i=
t will never generate data channel keys), how does ovpn3 deal with that?
(21:18:44) jamesyonan: so are you taking IV_NCP=3D2 to mean that AES 128,=
192,256 are supported?
(21:19:02) syzzer: yes, indeed (although I dropped=20
(21:19:05) syzzer: argh
(21:19:24) syzzer: droppen AES-192-GCM from the default config for now - =
nobody seems to use AES-192 anyway
(21:19:37) jamesyonan: ovpn3 basically falls back to non-negotiated proto=
col if client doesn't push IV_NCP=3D2
(21:20:08) syzzer: do non-pull clients send IV_* values/
(21:20:13) cron2: yes
(21:20:28) syzzer: ok, so what about a client that sends IV_NCP=3D2, but =
no pull request?
(21:21:31) jamesyonan: right now ovpn3 wouldn't allow a client to connect=
 that didn't do a pull request
(21:21:40) jamesyonan: but ovpn3 doesn't support static key mode
(21:22:08) syzzer: ovpn2 currently also support tls-mode without pull/pus=
h
(21:22:33) syzzer: that's also not available in ovpn3?
(21:23:06) jamesyonan: ovpn3 doesn't support tls-mode without pull/push
(21:23:31) syzzer: ah, well that indeed solves the problem :p
(21:23:45) cron2: we can't do that for v2 without breaking client configs
(21:26:23) jamesyonan: can you make the push/pull request part of the neg=
otiation criteria, i.e. IV_NCP is only considered to be 2 if the client a=
lso does a push request?
(21:27:03) syzzer: yes, we could do that, and that would indeed make sens=
e
(21:27:25) syzzer: thanks!
(21:27:44) cron2: it would still be somewhat tricky to get right, as we'l=
l have to peek at IV_NCP=3D2 being set in two different places
(21:28:11) syzzer: no, a client should just push send IV_NCP=3D2 if it ha=
s --pull configured :)
(21:28:12) cron2: (when composing PUSH_REPLY, and when deciding whether t=
o expand keys or not "right away") - but at least there is no ambiguity a=
nymore
(21:28:17) syzzer: *not* configured
(21:28:45) cron2: the client side is easy, the server side needs that inf=
ormation in two different places
(21:29:25) cron2: we'd need to sort of formalize the "what does IV_NCP=3D=
2 signal?" document regarding --pull
(21:29:52) jamesyonan: can't you just tag the client instance object with=
 the IV_NCP value?
(21:30:33) cron2: we'll need to extract it earlier, but then we can tag, =
yes
(21:31:10) syzzer: we can also just generate the keys immediately when th=
ere's no IV_NCP=3D2, right?  or can we not detect that easily/
(21:31:27) jamesyonan: I would say that IV_NCP=3D2 indicates that the cli=
ent supports pushable auth and cipher directives, and that specifically A=
ES-GCM 128, 192, and 256 are supported
(21:31:54) cron2: syzzer: that's what I meant - we need to look at the IV=
_NCP=3D2 setting in two different places in the server now, when deciding=
 whether to do the keys right away or deferred, and when composing the PU=
SH_REPLY
(21:32:07) syzzer: ah, right
(21:32:08) cron2: but this is just technicalities, no protocol / client b=
ehaviour ambiguity anymore
(21:32:33) cron2: jamesyonan: "... and the client will always send a PUSH=
_REQUEST", we should spell this out
(21:32:39) syzzer: jamesyonan: auth too?  I explicitly disabled that for =
now, since it wasn't in the NCP=3D2 spec
(21:32:41) cron2: syzzer: "pushable auth"
(21:32:42) cron2: :)
(21:33:10) jamesyonan: I think with when IV_NCP=3D2 you have to do deferr=
ed crypto initialization, i.e. the server can't initialize the crypto con=
text until it gets all the right negotiation signals, i.e. client submits=
 IV_NCP=3D2, client does push request, etc.
(21:33:32) jamesyonan: and the client can't initialize crypto context unt=
il it receives the push reply
(21:35:25) jamesyonan: agreed, pushable auth is tricky because auth direc=
tive also controls tls-auth HMAC which needs to be known prior to beginni=
ng of TLS handshake
(21:36:26) jamesyonan: pushable auth (on data channel) also doesn't make =
sense for GCM ciphers of course because they combine cipher and auth in a=
 single alg
(21:39:23) jamesyonan: so yes, pushable auth probably doesn't need to be =
in NCP=3D2 spec
(21:39:25) syzzer: indeed - I have a proof-of-concept patch that adds a -=
-tls-auth-digest option to separate that from --auth (the ssl/crypto code=
 can handle different auth/tls-auth algorithms already, I changed that a =
little while ago)
(21:40:45) jamesyonan: interesting
(21:44:14) syzzer: but for now, I think just allowing AES-GCM should be f=
ine
(21:45:33) cron2: syzzer: so what does "cipher AES-GCM-128" do?  will it =
just plain ignore "auth xx" setting, given that AEAD has builtin auth?
(21:45:43) syzzer: cron2: yes
(21:46:04) ***cron2 wonders if there is a reasonable use case for AEAD+ex=
plicit HMAC  (and excuse the silly question if it is)
(21:47:53) jamesyonan: I don't think so, AEAD is really for the use case =
where you want to combine crypto with integrity checking
(21:49:41) jamesyonan: AES is so ubiquitous these days it might make sens=
e to support an alternative just in case=E2=80=A6  maybe twofish or three=
fish?
(21:50:00) syzzer: indeed.  otherwise you'd choose a non-AEAD cipher and =
a separate auth
(21:50:22) syzzer: jamesyonan: I'd rather add chacha20-poly1305
(21:50:32) syzzer: but that is not yet supported by most crypto libs
(21:51:01) ***cron2 seconds having an alternative "new" cipher around...
(21:51:52) syzzer: the advantage of chacha20-poly1305 is that it performs=
 very well on mobile devices
(21:54:17) cron2: so... what about the specific implementation (v2)?
(21:54:45) syzzer: also, the WWW-world is moving to AES-GCM as default, w=
ith chacha20-poly1305 as backup/alternative
(21:55:37) syzzer: (I'm trying to add the IV_NCP=3D2 check while we're ch=
atting)
(22:01:29) syzzer: how will future NCP versions work?  Does IV_NCP=3D3 im=
ply support for IV_NCP=3D2 (i.e. should I use if(ncp =3D=3D 2), or if(ncp=
>=3D2))?
(22:04:04) mattock: syzzer: do you know how to proceed with the patches n=
ow?
(22:05:04) cron2: mattock: we know answers to a few strategic questions, =
but a review of the actual (proposed) implementation would certainly be w=
elcome
(22:05:18) mattock: is the current proposed implementation reviewable?
(22:05:38) mattock: or should we review later, when the patches have been=
 modified according to the strategic plan?
(22:05:38) ***cron2 did dazo in the meantime, and the patch set is not re=
ady to go, as it does not address a major issue about the previous patch =
set - I commented on gitlab
(22:05:53) mattock: cron2: ok, great!
(22:06:14) cron2: mattock: the current patch set is reviewable, modulo th=
e "it does not handle the IV_NCP=3D2<->PUSH_REQUEST dependency yet"
(22:06:33) mattock: jamesyonan: still with us?
(22:06:36) mattock: ^^^
(22:06:38) cron2: but the way key init is postponed could use a *good* lo=
ok from someone who is familiar with the code =3D jamesyonan :)
(22:07:06) cron2: *I* think the changes look very logical and the explana=
tion from syzzer convinced me, but I might not see caveats
(22:08:51) jamesyonan: on ovpn3, I am currently checking if IV_NCP >=3D 2
(22:10:18) syzzer: ok, then I will do the same
(22:19:16) mattock: I need to split soon
(22:21:13) mattock: perhaps jamesyonan could review those of the patches =
which don't need modifications
(22:21:24) cron2: all 3 need :)
(22:21:41) mattock: oh well, then my earlier question did not transmit 10=
0% :D
(22:21:45) syzzer: even so, feedback is very welcome
(22:22:10) cron2: the thing is: the places where changes are needed are w=
ell-understood and "isolated"
(22:22:16) cron2: feedback on the rest is still valuable
(22:22:20) mattock: jamesyonan: any comments on the patches at this point=
?
(22:23:07) jamesyonan: yes I can look at them, but I would advise especia=
lly to do run-time testing (such as with valgrind) to ensure that the def=
erred crypto setup doesn't introduce any issues
(22:24:18) jamesyonan: running through coverity would be a good idea as w=
ell
(22:30:28) syzzer: yes, that's very useful.  but those won't tell me of t=
he approach makes sense at all - and since you're the authority on that..=
. ;)
(22:30:52) cron2: syzzer has something setup with github, travis and cove=
rity already - and we'll do valgrind :)  (though valgrind has a hard time=
 finding leaks in "global gc"s)
(22:32:55) mattock: okay, got to go
(22:33:10) mattock: feel free to go on as needed
(22:34:02) ***cron2 waves :-) - and I won't provide much more useful inpu=
t today either, that was good but exhausting :)
(22:34:04) mattock: I'll write the summary tomorrow (should not be too ha=
rd today :D)
(22:34:55) mattock: yep, we made some progress even though not much seeme=
d to happen :P
(22:35:03) mattock: laters!
(22:54:19) syzzer: there we go - working code with a no-pull client, now =
time to clean up

--------------1556AA34153BAAA7335C76E9--

