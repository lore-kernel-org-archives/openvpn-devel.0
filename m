From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
References: <e3e0bf19-c810-002a-a4fc-1e7d6b4c798a@...515...>
Message-ID: <9b176ddc-0fc6-e5f8-6c14-79adc974ef06@...515...>
Date: Wed, 19 Aug 2020 13:42:58 +0300
MIME-Version: 1.0
In-Reply-To: <e3e0bf19-c810-002a-a4fc-1e7d6b4c798a@...515...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="ArWF3diVUPhMQCRGQ7P2UOL1yxVzC5BDp"
Subject: [Openvpn-devel] Summary of the community meeting (19th Aug 2020)
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
--ArWF3diVUPhMQCRGQ7P2UOL1yxVzC5BDp
Content-Type: multipart/mixed; boundary="xCEGQ3vr16bYxpeK8V02xhV2H3la9NU4p"

--xCEGQ3vr16bYxpeK8V02xhV2H3la9NU4p
Content-Type: multipart/mixed;
 boundary="------------7912570505A87D8C903A21AA"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------7912570505A87D8C903A21AA
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

Hi,

Here's the summary of the IRC meeting.

---

COMMUNITY MEETING

Place: #openvpn-meeting on irc.freenode.net
Date: Thu 19th August 2020
Time: 11:30 CEST (9:30 UTC)

Planned meeting topics for this meeting were here:

<https://community.openvpn.net/openvpn/wiki/Topics-2020-08-19>

Your local meeting time is easy to check from services such as

<http://www.timeanddate.com/worldclock>

SUMMARY

becm, cron2, dazo, lev, mattock, ordex and plaisthos participated in
this meeting.

---

Talked about WolfSSL. Agreed that we cannot merge the WolfSSL patches to
release/2.5 branch with their current commitment level. We will merge
them to "master" and if they keep maintaining their patches actively
they will get merged into release/2.6 when the time comes. If not, we
will just have to throw out the patchset before the 2.6 release.

--

Talked about OpenVPN 2.5-beta2. Set the release date to next Wednesday
(26th Aug). It should include the following fixes:

tun.c: enable using wintun driver under SYSTEM
- https://patchwork.openvpn.net/patch/1395/

Fix client's poor man NCP fallback
- https://patchwork.openvpn.net/patch/1386/

Upgrade pkcs11-helper in MSI installers to 1.26.

Fix MSI behavior:  apparently current installer is programmed to invoke
"msiexec /repair" first time when user logs in, and it doesn't really
work well with drivers installations as it results in connection
interruption and installation prompts. Lev is discussing this with rozmansi.

Fix tap-windows6 installation on Windows 10 ARM64. It does not seem to
work. Mattock will provide install logs to rozmansi for debugging.

--

Discussed enabling IPv6 on community. Noted that krzee has spent
considerable time trying to reproduce the issue that raidz claimed had
happened "the last time" IPv6 was enabled in Cloudflare. As memories of
the original incident are very vague it is impossible to figure out if
the problem persists, or is not present/relevant anymore. Moreover,
Cloudflare only allows turning IPv6 on/off on a per-domain basis (e.g.
openvpn.net), which makes the switch scary as completely unrelated
infrastructure could break or start misbehaving. Mattock and krzee will
bring this up again in the internal ops meetings.

--

Full chatlog attached

--------------7912570505A87D8C903A21AA
Content-Type: text/plain; charset=UTF-8;
 name="openvpn_irc_meeting_chatlog_2020-08-19.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="openvpn_irc_meeting_chatlog_2020-08-19.txt"

(12:37:32) dazo: Meeting time?
(12:37:32) plaisthos: yes!
(12:37:32) lev__: hello
(12:37:32) dazo: if ordex and mattock appears now .... then the whole com=
pany is gathered before the community :-P
(12:37:32) ***ordex is here
(12:37:32) ordex: will try to stick around for the whole hour
(12:37:32) ***: Playback Complete.
(12:37:36) mattock: hello!
(12:37:51) plaisthos: company meeting in the open :P
(12:38:59) dazo: oh, there you are, mattock!
(12:39:20) dazo: anyone heard from cron2 or syzzer?
(12:39:37) dazo: or syzzer colleague?
(12:39:49) mattock: nope
(12:40:55) becm [~becm@...2573...] =C3=A8 ent=
rato nella stanza.
(12:41:06) dazo: cron2 is usually quite reliable to arrive at these meeti=
ngs, so I expect something might have come up distracting him
(12:41:10) mattock: yep
(12:41:19) mattock: so, shall we talk about 2.5-beta1?
(12:41:25) dazo: yeah ...=20
(12:41:33) dazo: any feedback so far?
(12:41:52) mattock: not really, which is a "good thing"(tm)
(12:42:02) dazo: I've seen some windows/wintun discussions  ... but not m=
uch more
(12:42:04) lev__: MSI issues on Win7, but!
(12:42:06) mattock: yeah
(12:42:23) plaisthos: there is the one NCP issue that wiscii reported
(12:42:30) plaisthos: and that has a fix on the ML
(12:42:38) lev__: I collected logs and contacted rozmansi, he said he kno=
ws what is wrong and will release a fix
(12:43:49) lev__: apparently current installer is programmed to invoke "m=
siexec /repair" first time when user logs in, and it doesn't really work =
well with drivers installations
(12:44:12) lev__: which results in connection interruption and installati=
on prompts
(12:45:11) dazo: I do see the Copr repository gets some attention too ...=
 mostly EPEL users and F32 ... I announced the beta in the Fedora devel m=
ailing list too, but no response to that mail (other than increased Copr =
numbers)
(12:45:30) mattock: lev: there is also probably a problem with tap-window=
s6 + arm64
(12:45:36) becm: mattock: any plans to get the pkcs11-helper version bump=
 into Win-releases so we can blame beta testers if it breaks something?
(12:45:38) mattock: I did not have time to really look into it
(12:45:50) lev__: also I managed to break running openvpn under SYSTEM wi=
thout iservice (just removed the code together with elevation hack), but =
fix is already on ML=20
(12:46:23) mattock: becm: to what version?
(12:46:31) dazo: Can we manage to get these changes reviewed and have a b=
eta2 out on Friday?
(12:46:39) dazo: or should we aim for rc1?
(12:47:40) mattock: mmm
(12:48:12) becm: mattock: as far as i can tell, we'd want 1.26 to include=
 the "PSS padding fix"
(12:48:39) lev__: I think we need MSI fix for beta2
(12:49:19) mattock: yeah, I'd like to minimize the number of releases we =
have to make
(12:49:41) dazo: lev__: yes
(12:49:45) mattock: so pkcs11-helper 1.26, MSI fixes
(12:49:56) dazo: + NCP fixes
(12:50:12) plaisthos: PSS padding fix?
(12:50:18) plaisthos: ah for pkcs11
(12:50:24) mattock: lev: did you contact rozmansi by email?
(12:50:33) lev__: yes
(12:50:41) mattock: you did not cc me, did you?
(12:51:06) lev__: well, you already know the answer :(
(12:51:15) mattock: yes, you did not :)
(12:51:21) mattock: I'd need to look into the arm64 tap-windows6 issue wi=
th rozmansi
(12:51:52) mattock: where would I find the MSI installer logs?
(12:52:00) mattock: or do I just google :)
(12:52:09) becm: mattock: pkcs11-helper bugfixes (pull/172) also, if it's=
 not too much to ask (possible behavioural change)
(12:52:13) lev__: you need to enable them in registry first
(12:52:27) lev__: then they'll appear in %TEMP%
(12:52:45) mattock: #172 is already in
(12:52:49) mattock: as part of #175
(12:53:17) mattock: lev: ok, I'll figure it out
(12:54:33) becm: mattock: ah, sorry.
(12:56:37) becm: mattock: did not see the update (dayjob)
(12:56:54) mattock: so, when to release and with what name?
(13:01:19) mattock: if we only intend to provide bug fixes from now on I'=
d say rc1
(13:02:19) plaisthos: do we want to send a message to wolfssl, "now is yo=
ur last chance to get into 2.5"?
(13:03:01) mattock: sounds reasonable, and give them a strict deadline
(13:03:02) plaisthos: but imo taking over a month to catch up on a mainta=
inance issue with their patch, does not feel like commitment
(13:03:51) dazo: agreed
(13:06:01) plaisthos: I would rather merged them into master
(13:06:41) plaisthos: and then see if they are commited to resolving issu=
es
(13:06:53) plaisthos: and if they don't they get thrown out before the 2.=
6 release
(13:07:47) mattock: +1
(13:07:48) ordex: I agree about master
(13:11:50) mattock: I would propose "early next week" for the next releas=
e
(13:12:10) mattock: that'd give us time to (hopefully) iron out more issu=
es, like the MSI + arm64 thing
(13:12:12) cron2: oups
(13:12:22) mattock: rozmansi might not be able to jump into it immediatel=
y
(13:12:38) mattock: that said, I think MSI + arm64 _needs_ to work in 2.5=
=2E0
(13:12:39) cron2: apologies
(13:12:45) mattock: not necessarily in beta/rc
(13:15:06) cron2: wrt beta2 - I'd suggest testing & merging what is on th=
e list right now (one patch from lev, one from plaisthos) and release bet=
a2 next wednesday, with MSI and NCP and wintun fix
(13:15:25) cron2: beta1 has only been "really released" last Friday, so t=
here was not much time to get fixes in
(13:15:34) mattock: plus pkcs11-helper 1.26?
(13:16:26) cron2: sounds good
(13:16:27) mattock: we use 1.22 now in windows installers
(13:16:53) mattock: ok, I'll note those down in the meeting summary
(13:17:16) mattock: anything else for today?
(13:18:41) cron2: have you seen krzee recently...?  community still has n=
o v6, and still annoys with the cloudflare pre-banner
(13:19:09) mattock: yes
(13:19:46) mattock: krzee tried to reproduce the issue that raidz claimed=
 had happened "the last time" IPv6 was enabled in Cloudflare
(13:19:58) mattock: krzee spent a considerable time on it
(13:20:08) mattock: he was unable to break anything by turning on IPv6
(13:20:10) cron2: I've heard about that, and ran a few test for him, and =
"no problem whatsoever"
(13:20:15) mattock: yeah
(13:20:36) mattock: now, what happened "the last time" is completely unkn=
own - raidz does not remember what happened exactly
(13:20:47) mattock: so checking if the same problem is present is impossi=
ble
(13:21:06) cron2: so why not just enable IPv6 for community?  That should=
 not impact anything else
(13:21:12) mattock: it is all or nothing
(13:21:21) cron2: wat?
(13:21:21) mattock: that is the challenge here
(13:21:27) mattock: all of openvpn.net or nothing
(13:21:41) mattock: otherwise IPv6 on community would have been turned on=
 already
(13:22:04) mattock: and of course that leads to the "shit it could break =
everything" thinking
(13:22:14) ***cron2 sighs deeply
(13:22:26) cron2: (and I cannot imagine you cannot control this on a per-=
subdomain level in cloudflare)
(13:22:30) mattock: now, what I can do is suggest some "calm" time with m=
inimal amount of uesrs
(13:22:43) mattock: where we would flip the switch
(13:22:55) mattock: I have not looked into that part myself, so can't com=
ment
(13:22:59) mattock: "I've been told so"
(13:23:04) cron2: yeah... I can help testing, when needed
(13:23:20) mattock: I'll bring this up with krzee in our ops meeting
(13:23:37) cron2: thanks
(13:23:51) mattock: I hope there is the courage to turn on IPv6
(13:24:11) mattock: backpedal if needed, after figuring out what exactly =
broke
(13:24:21) cron2: that is a reasonable way forward, yes
(13:24:47) mattock: I'm also not sure if a support ticket was filed to Cl=
oudflare asking what turning on IPv6 _could_ affect
(13:24:53) mattock: if not, we should file one
(13:25:36) cron2: well, there's two sides - IPv6 "to the world", which sh=
ould not affect anything *unless* your backend does funny things with the=
 original client IP (as presented by some header)
(13:26:00) cron2: and IPv6 "to the origin server", which might indeed cau=
se issues if the backend has slow or unreliable IPv6 connectivity
(13:26:08) cron2: this is more risky
(13:26:08) mattock: my bet is that "funny (legacy) things" _are_ happenin=
g in our infrastructure
(13:26:49) mattock: anything else?
(13:27:58) cron2: not from me, thanks
(13:30:13) cron2: next week I should arrive on time :-) - from a nice hut=
 on the beach...
(13:30:34) mattock: btw.
(13:30:44) mattock: so the WINTUN + system fix
(13:30:49) mattock: what patch from plaisthos?
(13:30:52) plaisthos: cron2: you have beaches in Munich? *duck*
(13:31:04) plaisthos: something NCP client fix something
(13:31:28) mattock: lol I'll try to find it
(13:31:38) mattock: "Fix client's poor man NCP fallback     "?
(13:31:48) plaisthos: sounds right
(13:31:49) mattock: ok
(13:34:02) mattock: lev: care to CC me if you get a response from / send =
email to rozmansi?
(13:34:11) mattock: I can bother him with my own worries
(13:35:44) lev__: mattock: yes
(13:35:52) mattock: thanks!

--------------7912570505A87D8C903A21AA--

--xCEGQ3vr16bYxpeK8V02xhV2H3la9NU4p--

--ArWF3diVUPhMQCRGQ7P2UOL1yxVzC5BDp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEbQT48bAXMRH0mXleKVhNn0CGRXgFAl89AjIACgkQKVhNn0CG
RXgBmQgAi31fQgBy97iRTPGnHrCuspbMp0HR+XV7+8ORQwm+9+Dh9BnorBKjoCDy
hS7oJ5KThDd50UumgU7A19I2KpbU6VYwrWZXW3QL8uCUMbJdxO1dTLucLySfJMRF
dYu6GVbxvucY5WxNHKMgYcO51Qbuh8beiQcFY2QKAKZDz7r72PQwAr37MH/19eau
85wrnI4VJ5Y4x2eM5+HQWCaSxL9bISrocp/k8Y0+FpomKo2tF5nWNvTHIjaPRWrg
ZwhBDUOXAqWIIQtCZNE7VkBBTKj7SdxTg8OW0lPyX8TthZamu+sPsWprKeo7vNM+
czWrnk3M3W8JbliCQZHVz/tNaEFRxA==
=KXFH
-----END PGP SIGNATURE-----

--ArWF3diVUPhMQCRGQ7P2UOL1yxVzC5BDp--

