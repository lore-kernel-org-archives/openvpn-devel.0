From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
References: <f9786676-a7ad-8b0d-708a-ff724d27376c@...515...>
Message-ID: <6a1c2a84-0a0b-4a56-5ca1-1ceb78efbca6@...515...>
Date: Thu, 26 Mar 2020 22:10:50 +0200
MIME-Version: 1.0
In-Reply-To: <f9786676-a7ad-8b0d-708a-ff724d27376c@...515...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="9qzm2B5IHiUlHhWfwqnbn3lmBpwO26Yjo"
Subject: [Openvpn-devel] Summary of the community meeting (26th March 2020)
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
--9qzm2B5IHiUlHhWfwqnbn3lmBpwO26Yjo
Content-Type: multipart/mixed; boundary="z5WQIm8pUQwqBBcs9diPwS8xKPjVCQzRo"

--z5WQIm8pUQwqBBcs9diPwS8xKPjVCQzRo
Content-Type: multipart/mixed;
 boundary="------------7E4A39C7AECE3A0D10242BCE"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------7E4A39C7AECE3A0D10242BCE
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

Hi,

Here's the summary of the IRC meeting.

---

COMMUNITY MEETING

Place: #openvpn-meeting on irc.freenode.net
Date: Thu 26th March 2020
Time: 20:00 CET (19:00 UTC)

Planned meeting topics for this meeting were here:

<https://community.openvpn.net/openvpn/wiki/Topics-2020-03-26>

Your local meeting time is easy to check from services such as

<http://www.timeanddate.com/worldclock>

SUMMARY

cron2, dazo, lev and mattock participated in this meeting.

---

Discussed OpenVPN 2.5 status.

There is now a status section for MSI-related work:

<https://community.openvpn.net/openvpn/wiki/StatusOfOpenvpn25#Missingpieces=
fromMSI>

All openvpn patches except for 11/12 have been merged which is very good
progress. Work on openvpn-build (MSI packaging) and tap-windows6 (MSM)
can really start once all of the openvpn work is in:

<https://github.com/OpenVPN/openvpn-build/pull/141>
<https://github.com/OpenVPN/tap-windows6/pull/106>

--

Noted that the "client-connect: split multi_connection_established into
separate functions" patch has a merge conflict in multi.c that somebody
needs to look at:

<https://patchwork.openvpn.net/patch/612/>

--

Noted that while --auth-token and --auth-gen-token are one of the nicest
new features in 2.5, they do not work right if combined with
--explicit-exit-notify on the server. This has to be fixed. Gory details
are available in the full chatlog.

--

Noted that the combination of a username-only --auth-user-pass and
--management-query-passwords does not work. Dazo will take a stab at
fixing the actual problem. There is already a
GET_USER_PASS_PASSWORD_ONLY flag which just needs to be processed
correctly when the management interface is in action.

An attempt to document the limitation plus related discussion is here:

<https://patchwork.openvpn.net/patch/1040/>

Further discussion of the issue is available here:

<https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg12835.=
html>

--

Noted that removal of --disable-server needs review:

<https://patchwork.openvpn.net/patch/1019/>

---

Full chatlog attached

--------------7E4A39C7AECE3A0D10242BCE
Content-Type: text/plain; charset=UTF-8;
 name="openvpn_irc_meeting_chatlog_2020-03-26.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="openvpn_irc_meeting_chatlog_2020-03-26.txt"

(20:57:36) mattock: drum roll
(20:58:26) lev__: guten aben
(20:59:34) cron2: meow
(20:59:35) dazo: Hey!
(21:00:26) mattock: hi!
(21:01:52) dazo: mattock: can you put on your "checklist" after meetings =
to update /topic?  we always forget to update it ....
(21:02:10) mattock: if somebody tells me how to do that
(21:02:14) mattock: I've never done it
(21:02:59) dazo: In (he)xchat it is just to modify the topic in the topic=
 field and hit [enter]
(21:03:12) dazo: otherwise there is the /topic command
(21:03:34) mattock: ok, I'll check that out
(21:03:57) mattock: https://community.openvpn.net/openvpn/wiki/Topics-202=
0-03-26
(21:04:17) mattock: https://patchwork.openvpn.net/patch/1045/ seems to be=
 accepted already
(21:04:18) vpnHelper: Title: [Openvpn-devel,v3] travis-ci: add arm64, s39=
0x builds. - Patchwork (at patchwork.openvpn.net)
(21:04:46) mattock: shall we move on to missing pieces in 2.5?
(21:05:21) dazo: Good idea
(21:05:43) mattock: I have the MSI/MSM status tracking in here now: https=
://community.openvpn.net/openvpn/wiki/StatusOfOpenvpn25#Missingpiecesfrom=
MSI
(21:05:50) cron2: I am mostly waiting to an 11/12 v2 from rozmansi, and a=
 patch set from plaisthos...
(21:05:52) mattock: it seems that most of the openvpn patches are in
(21:05:58) mattock: not so earlier this week
(21:06:02) mattock: \o/
(21:06:05) cron2: lev has acked 01-10 + 12v2
(21:06:08) lev__: well, client connect isn't
(21:06:23) cron2: for MSM, most is in, for client-connect, waiting for th=
e patch set
(21:06:48) mattock: once openvpn has all the pieces I think we can move t=
o openvpn-build (MSI packaging) and tap-windows6 (MSM)
(21:08:52) mattock: the MSI PR in openvpn-build (https://github.com/OpenV=
PN/openvpn-build/pull/141) seems to have new commits to add the MSM stuff=

(21:08:56) vpnHelper: Title: Windows MSI Packaging by rozmansi =C2=B7 Pul=
l Request #141 =C2=B7 OpenVPN/openvpn-build =C2=B7 GitHub (at github.com)=

(21:09:07) mattock: so I guess I just have to start experimenting with it=
 once 11/12 is in
(21:09:24) cron2: yes :)
(21:09:57) mattock: besides this MSI stuff: anything else in 2.5 that nee=
ds coordination?
(21:10:20) cron2: there's patches from plaisthos related to auth-gen-toke=
n
(21:10:27) cron2: which want a review :)
(21:11:31) dazo: It is still on my todo list ... I will try once again to=
 dig it up once again ... I'm so sorry for these things falling through t=
he cracks so often
(21:12:16) lev__: client-connect doesn't apply on latest master
(21:12:38) dazo: lev__: did you have a look on how complicated the confli=
ct is?
(21:12:51) dazo: (using patch -p1 instead of git apply/am)
(21:13:15) lev__: no, I didn't
(21:13:24) lev__: something in multi.c
(21:18:02) dazo: lev__: do you have the patchwork link for it?  We should=
 link to it on our status page
(21:18:56) cron2: https://patchwork.openvpn.net/project/openvpn2/list/?se=
ries=3D413
(21:18:57) vpnHelper: Title: OpenVPN 2 - Patchwork (at patchwork.openvpn.=
net)
(21:19:01) dazo: thx!
(21:19:03) cron2: :-P
(21:19:07) cron2: argh
(21:19:09) lev__: https://patchwork.openvpn.net/patch/612/
(21:19:11) vpnHelper: Title: [Openvpn-devel,v4,01/13] client-connect: Spl=
it multi_connection_established into separate functions - Patchwork (at p=
atchwork.openvpn.net)
(21:19:27) ***cron2 has spent too much time staring at things related to =
--auth-token, auth_user_pass, up->... today
(21:19:48) cron2: and subtle interactions between auth-nocache, encrypted=
 profiles, and magic OCC strings
(21:24:00) cron2: auth-token handling in git master is still very fragile=
 on the client side
(21:24:11) cron2: so I think this should go to the "must fix" list for 2.=
5
(21:24:44) cron2: in combination with explicit-exit-notify and/or auth-no=
cache, the most interesting things happen
(21:24:49) dazo: I see plaisthos posted a 3 more patches ... so those nee=
ds to get in on top of the current patch set as well?
(21:25:15) cron2: plaisthos' patches are "server side mishandling things"=
 (so the expiry time of tokes is not honoured after a server restart)
(21:25:17) dazo: explicit-exit-notify sounds like server not clearing the=
 session in time
(21:25:20) cron2: plus documentation
(21:25:44) cron2: nah, when the server is restarted *and* explicit-exit-n=
otify is sent, the client purges auth_user_pass, resetting up->defined, a=
nd will then never accept a new token again
(21:26:03) cron2: incoming tokens end up being ignored, so it resends the=
 last token it has, and that one expires after 2*renec-sec
(21:26:30) cron2: if you send RESTART,[P] it won't purge, unless you have=
 auth-nocache, in which case it *will*
(21:26:39) dazo: ahh, server side sending explicit-exit-notify ... okay, =
that's a different can of worms indeed .... I don't think that has ever b=
een extensively tested, though
(21:26:47) cron2: (and there is no way to make the server send RESTART,[P=
] anyway)
(21:27:09) cron2: I love that option, because then you can have the clien=
ts reconnect right away on server restart, instead of having to wait for =
a timeout
(21:27:33) dazo: Yeah, it sounds useful ... unless you have too many clie=
nts reconnecting at the same time
(21:28:04) cron2: but the interactions with --auth-token and --auth-nocac=
he are "non-intuitive"
(21:28:25) cron2: yeah, if you have 1000s of clients, you may want to pus=
h them to the next server (explicit-exit-notify 2)
(21:28:40) dazo: yeah, I remember fighting with that before plaisthos sta=
rted his quest to improve things
(21:29:11) cron2: which will purge the token, but things are still broken=
 because it will not use your password but the last token for authenticat=
ion...
(21:29:29) dazo: that's clearly wrong
(21:29:56) dazo: but with auth-nocache, the client should also ask for a =
new authentication interaction with the user
(21:30:22) dazo: (because it shouldn't have cached any credentials after =
the first successful auth)
(21:30:57) cron2: the flow of things is subtle and very magic... some bit=
s get reset that shouldn't, others do not get reset that should...
(21:32:27) dazo: yeah ... lets get plaisthos patches in first, and lets s=
ee where that leads us next
(21:32:35) cron2: indeed :)
(21:33:22) dazo: This evening (night?) I need to investigate an important=
 AS issue ... and if that's done, I will allocate tomorrow for those patc=
hes again
(21:34:29) mattock: can somebody summarize this in one line? :D
(21:35:02) cron2: --auth-token and --auth-gen-token are one of the nicest=
 new features in 2.5, but they do not work right if combined with --expli=
cit-exit-notify on the server
(21:35:20) dazo: ^^^ that :)
(21:35:20) mattock: thank you :)
(21:36:07) mattock: anything else?
(21:36:26) dazo: Not for this particular issue :-P
(21:37:16) cron2: you two (mattock, dazo) need to agree on https://patchw=
ork.openvpn.net/patch/1040/
(21:37:17) vpnHelper: Title: [Openvpn-devel] Document some limitations of=
 --auth-user-pass - Patchwork (at patchwork.openvpn.net)
(21:39:56) dazo: There are multiple issues here ... documentation and ugl=
y behaviour in some cases.  I believe it works correctly on all platforms=
 but Windows
(21:40:28) mattock: I opened another can of worms it seems
(21:40:47) cron2: sure, you mentioned "openvpn", "documentation" and "win=
dows" in a single e-mail :)
(21:41:02) mattock: :)
(21:41:14) dazo: Windows (for some reason, if I undestood Selva correctly=
) have not really supported --auth-user-pass files as it does on other pl=
atforms
(21:41:22) dazo: :-D
(21:41:40) mattock: windows does support them, but just not this particul=
ar use-case
(21:41:47) mattock: :P
(21:42:04) dazo: the "only username" in the file case?
(21:42:07) cron2: yes
(21:42:14) dazo: Right, then we're on the same page :)
(21:42:36) cron2: I assume that other platforms have the same issue if th=
e management interface is used
(21:43:15) cron2: because that seems to be the underlying issue - "user i=
s known, password query" seems to be something that got hacked in later w=
ithout taking care of management... plaisthos should be able to answer th=
at, but he fled
(21:43:21) dazo: Hmmm ... good question, I presumed not ... but I see the=
re is potential for breakage there too
(21:43:52) cron2: now, since the "inline auth-user-pass with only user" p=
atch was never merged (I think?) this is less relevant on IOS and Android=
=2E.. :)
(21:44:46) dazo: I don't recall merging inline auth-user-pass .... I'm no=
t sure I really like that feature
(21:45:52) cron2: I think we got agreement on it, but it was nerver rebas=
ed, and andj never refreshed it... something like that
(21:46:02) ***cron2 likes it better than lumping around external files
(21:47:12) dazo: I think this is a case for the management interface ... =
but accept the argument it's awful to write a script doing tcp sockets is=
 ugly and easily fragile :)
(21:48:12) dazo: (this way the creds could be stored more securely than i=
n a file .... but lets not walk down that path now)
(21:48:19) cron2: and not exactly helping the use case of "inline auth-us=
er-pass" (having a config with all you need in a single place, which can =
be used for unattended communication)
(21:48:52) cron2: you still need to store the creds somewhere...  like ou=
r community VPN - this is not "super high secure", but it needs to come b=
ack on buildslave reboots, without manual intervention
(21:49:08) dazo: For unattended communication, the server side could just=
 ignore username/password for specific cert CNs
(21:49:27) cron2: tell that to mattock :-) - he's using the same cert for=
 all, and individual LDAP users
(21:49:50) mattock: yes, that is what I do, and I do it proudly
(21:50:06) dazo: *this* is actually an AS feature :-)
(21:50:56) mattock: can we agree on "fix" or "modify my proposed document=
ation"?
(21:51:03) mattock: I believe we have decided on "document" already
(21:51:08) mattock: in Trento probably
(21:51:33) cron2: document, unless fixing on the management interface is =
easy
(21:51:47) mattock: will somebody check if fixing the management is easy?=

(21:52:11) mattock: and if not, go with my documentation patch (I believe=
 it is accurate)
(21:52:32) dazo: there is a flag GET_USER_PASS_PASSWORD_ONLY ... which "j=
ust" needs to be processed correctly when the management interface is in =
action
(21:53:02) mattock: I think we have a volunteer here :D
(21:53:36) dazo: well, I've been down this path a few times earlier ... I=
 can surely poke at it again, after the auth-token stuff
(21:53:56) cron2: hehe, I was about to say that "you've been there, and w=
e had long and heated discussions" :)
(21:54:17) dazo: make my blood boil and see what will happen :-P
(21:54:31) mattock: :P
(21:54:58) dazo: [digression] btw ... I did also send a patch to the ML r=
emoving client-only mode in ./configure=20
(21:55:16) cron2: yes, it's in patchwork, and nobody has complained so fa=
r :)
(21:55:35) dazo: https://patchwork.openvpn.net/patch/1019/=20
(21:55:37) vpnHelper: Title: [Openvpn-devel] build: Remove --disable-serv=
er from ./configure - Patchwork (at patchwork.openvpn.net)
(21:56:13) dazo: good, it has not gone completely into /dev/null yet :-P
(21:58:14) mattock: two minutes left
(22:00:14) dazo: seems nobody had much more to say :)
(22:00:23) ***cron2 is tired
(22:00:35) cron2: too much family, and too much openvpn inards today
(22:01:03) ***dazo started his working day 1 hour ago .... too much famil=
y :-P
(22:01:05) mattock: let's call this a day
(22:01:14) cron2: good night :-)
(22:01:20) mattock: I started mine at around 6:30 AM=20
(22:01:24) mattock: so I'm a bit tired
(22:01:29) mattock: good night! :)
(22:01:43) cron2: yeah, I started at 7 am, because kids do not get up bef=
ore 8, so I have *one full hour* of undisturbed work
(22:02:26) mattock: the situation is grave indeed
(22:02:35) dazo: cron2: https://twitter.com/KathrineHarstad/status/124175=
9062909427713?s=3D20
(22:03:03) mattock: :)

--------------7E4A39C7AECE3A0D10242BCE--

--z5WQIm8pUQwqBBcs9diPwS8xKPjVCQzRo--

--9qzm2B5IHiUlHhWfwqnbn3lmBpwO26Yjo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEbQT48bAXMRH0mXleKVhNn0CGRXgFAl59DEoACgkQKVhNn0CG
RXg4IAgAseUvKlFspC5Y8ERqv2QOUCoSUcqu6QF4Kr+rr0kyROM21e4+O5OoELvt
1Q0CgSxBAsn5D3msK4lECdpUQAIz7A626IEc1W7wXeMpCFM3MQyqQ1ELgUvtlXSu
zWBVcys4rJRBtw29wa2dyGtAbizMamxvQrJLs0wj/9HEdxPZWeMCMXDAb3+akzzJ
SQgr47pkxhtaA5SxYn9EyXvs7h6g7yRTG6a7VKCZh6iHeNt7+UQ5oPrukCvoihHB
9Mkmcg4wVcQmz9NGtoSFeqvv+01psaaJ+vP99B2SnWad42hQry5emnGZzv7JL843
t0H4HXuA+YBB7Bn6DX3ArJ6e1mrHCw==
=mFNh
-----END PGP SIGNATURE-----

--9qzm2B5IHiUlHhWfwqnbn3lmBpwO26Yjo--

