From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
References: <9d879a78-47c9-5be5-5798-98e07bc25c89@...515...>
Message-ID: <f46bc668-e2aa-8bed-3d2d-49b8848a07d4@...515...>
Date: Wed, 13 May 2020 14:14:21 +0300
MIME-Version: 1.0
In-Reply-To: <9d879a78-47c9-5be5-5798-98e07bc25c89@...515...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="GWrs7qR8sSu65ROI37cuMmIdyWYCzNUpK"
Subject: [Openvpn-devel] Summary of community meeting (13th May 2020)
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
--GWrs7qR8sSu65ROI37cuMmIdyWYCzNUpK
Content-Type: multipart/mixed; boundary="0bbg3spBEpBYJEx2nXlhNBRTQazoV0m9U"

--0bbg3spBEpBYJEx2nXlhNBRTQazoV0m9U
Content-Type: multipart/mixed;
 boundary="------------5D41563C37740DBCD69D2354"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------5D41563C37740DBCD69D2354
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

Hi,

Here's the summary of the IRC meeting.

---

COMMUNITY MEETING

Place: #openvpn-meeting on irc.freenode.net
Date: Wed 13th May 2020
Time: 11:30 CEST (9:30 UTC)

Planned meeting topics for this meeting were here:

<https://community.openvpn.net/openvpn/wiki/Topics-2020-05-13>

Your local meeting time is easy to check from services such as

<http://www.timeanddate.com/worldclock>

SUMMARY

dazo, krzee, lev, mattock, ordex and plaisthos participated in this meeting.

---

Talked about MSI/MSM for OpenVPN and tap-windows6. Mattock is now
fighting his way through the MSI/MSM jungle.

---

Talked about improving the buildbot configuration. Agreed that it makes
sense to:

1) Upgrade buildbot to a more modern version (better webui etc)
2) Migrate lots of semi-manual testing that is currently internal to
OpenVPN Inc. to buildbot
3) Start building openvpn3 on buildbot
4) Testing latest server code through buildbot

After the meeting cron2 reminded us that he has t_server testing
framework already - it is just running outside of buildbot.

Krzee and mattock will work together on these buildbot improvements.

---

Discussed OpenVPN 2.5 patches. This week dazo will review plaisthos'
three patches and start the epic "man page struggle".

--

Full chatlog attached


--------------5D41563C37740DBCD69D2354
Content-Type: text/plain; charset=UTF-8;
 name="openvpn_irc_meeting_chatlog_2020-05-13.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="openvpn_irc_meeting_chatlog_2020-05-13.txt"

(12:28:46) mattock: hello!
(12:28:56) dazo: hey!
(12:30:12) mattock: cron2 said he could not make it
(12:30:26) mattock: it would be nice if rozmansi was here by accident :)
(12:30:42) mattock: I'm working on tap-windows6 MSM and unsurprisingly th=
ere have been a number of issues I've had to resolve
(12:30:48) krzee [be50baf1@...1423.../corp/krzee] =C3=A8 entrato nella stanz=
a.
(12:30:53) mattock: probably related to the build environment, but proble=
ms nevertheless
(12:31:59) ordex: u=C3=A9
(12:32:25) lev__: hello
(12:33:29) plaisthos: hello
(12:34:03) krzee: heyhey
(12:35:21) mattock: hi all
(12:35:23) mattock: so
(12:35:38) mattock: I pretty much reported what I've been up to :)
(12:35:48) mattock: any topics besides openvpn 2.5?
(12:36:16) dazo: plaisthos: what's the status now on the auth-token patch=
es?
(12:36:35) dazo: Lets have a look here: https://community.openvpn.net/ope=
nvpn/wiki/StatusOfOpenvpn25
(12:36:37) vpnHelper: Title: StatusOfOpenvpn25 =E2=80=93 OpenVPN Communit=
y (at community.openvpn.net)
(12:37:15) dazo: I'm planning to start playing with the man page challeng=
e this week
(12:37:32) mattock: \o/
(12:37:39) plaisthos: dazo: err chek patchwork
(12:37:44) mattock: sounds like e-sports
(12:38:51) krzee: id like to understand a little more about our unit test=
s (using buildbot as i understand), specifically because i think ovpn3 sh=
ould be added to it when possible and i think that maybe corp and communi=
ty could use the same tests so that efforts are not duplicated
(12:41:19) mattock: +1
(12:42:17) mattock: basically we'd just add openvpn3 build dependencies t=
o a subset of our buildslaves and add a few builders to build openvpn3
(12:42:55) dazo: plaisthos: ahh, found it ... alright, 3 patches missing =
formal acks ... I'll try to complete that this week then
(12:44:57) dazo: mattock: Hmmm ... can we also please upgrade our buildbo=
t to something more up-to-date?  So that it is simpler to get an overview=
 what is being run/tested, split out build errors from test errors, etc
(12:46:23) mattock: yes that is the plan
(12:46:30) mattock: after MSI stuff
(12:46:50) dazo: good!  Then I'll keep quite for a bit more :-P
(12:46:51) plaisthos: like jenkins?
(12:46:55) dazo: *quiet
(12:47:06) plaisthos: or newer buildbot?
(12:47:10) mattock: no jenkinses
(12:47:14) mattock: update buildbot
(12:47:16) mattock: :)
(12:47:20) krzee: how many tests are already implemented in buildbot?
(12:47:22) dazo: plaisthos: hehe ....
(12:47:35) dazo: krzee: Only `make check`
(12:47:36) mattock: not sure as those are created programmatically
(12:47:47) plaisthos: no was a serious question. People might have more e=
xperience with jenkin
(12:48:12) mattock: yes, and it is still a piece of crap especially from =
management perspective
(12:48:37) ordex: :D
(12:48:51) krzee: dazo, i dont understand the answer
(12:49:44) ordex: tests are defined in t_client
(12:49:44) dazo: krzee: buildbot runs 'make check' ... so what is being r=
un is defined in tests/Makefile.am via the TESTS variable
(12:50:04) ordex: the buildbot just runs make check (which executes the u=
nit tests and the various t_* scripts)
(12:50:07) dazo: t_client.sh is one of the defined tests in TESTS
(12:50:31) ordex: right
(12:51:07) mattock: krzee and I also talked about extending t_client to i=
nclude server-side tests (i.e. connect clients to a server instance built=
 from HEAD)
(12:51:28) mattock: at the moment our servers are static (version <n> of =
openvpn)
(12:51:36) dazo: https://github.com/OpenVPN/openvpn/blob/master/tests/Mak=
efile.am#L17  .... oh and beware of SUBDIRS too ... so this is also evalu=
ated, recursively
(12:51:38) vpnHelper: Title: openvpn/Makefile.am at master =C2=B7 OpenVPN=
/openvpn =C2=B7 GitHub (at github.com)
(12:51:40) ordex: yeah, that would be a great improvement
(12:52:26) dazo: I would suggest implementing a t_server.sh test for that=
 ... to avoid complicating t_client.sh further
(12:52:49) mattock: kind of reverse of t_client.sh?
(12:52:57) mattock: as in: static clients, latest server?
(12:53:24) krzee: as well as latest client
(12:53:30) dazo: kinda ... but it could drive also client connections too=
, but t_client.sh is well defined in what it tests and how it works
(12:53:32) mattock: yeah I was about to add that
(12:53:36) ordex: maybe a coordinated effort of t_server andf t_client ? =
:D to run combined tests
(12:54:35) mattock: something like that, but I'm not sure how it would lo=
ok like
(12:54:37) dazo: yeah, t_server.sh cloud use t_client to drive the client=
 side ... but t_client.sh should try to strive to focus on testing the cl=
ient side code - it can be extended to handle other configs than t_client=
=2Erc
(12:54:55) dazo: gee .... cloud -> could
(12:55:26) mattock: basically one buildslave could just build the latest =
server and make it available before t_client kicks in
(12:55:44) dazo: yeah
(12:56:01) mattock: the only challenge is enforcing the order afaics, but=
 I'm sure that can be done
(12:56:58) krzee: i cant add much to the conversation yet because ill nee=
d to catch up to how tests work :)
(12:57:01) mattock: anyhow, buildbot upgrade is the first step - our vers=
ion _is_ old
(12:57:09) dazo: The test code is not set in stone ... fortunately ;-) ..=
=2E. I'm just advocating keeping t_client.sh to be focused on client conf=
igs
(12:57:29) mattock: krzee: once I have MSI/MSM in a reasonable shape (=3D=
able to make release packages) I can help you with it
(12:57:39) mattock: dazo: +1
(12:57:44) mattock: it works well now
(12:57:47) krzee: mattock, maybe after MSI stuff we can pivot our meeting=
s to that
(12:57:55) mattock: krzee: +1
(12:58:00) krzee: nice
(12:58:17) krzee: i still need to write this up to get approval from abov=
e
(12:58:30) krzee: but if we put our personal meetings into this, screw it=
 we doing it
(12:58:32) krzee: lol
(12:58:44) mattock: be a cowboy like the rest of us :D
(12:58:55) mattock: "lone ranger who does his own thing"
(12:59:03) krzee: dude im in, this is the only logical way
(12:59:37) mattock: I mean, everyone will benefit from this (company and =
community)
(12:59:41) krzee: the idea of manually testing everything in openvpn, whi=
ch has more potential configs that ANY other app i have used, is just sil=
ly
(12:59:58) mattock: that is what our QA does at the moment
(12:59:58) krzee: than*
(13:00:07) mattock: due to mostly historic reasons
(13:00:10) krzee: oh i know, i have become qa :D
(13:00:15) krzee: just ask ordex
(13:00:22) ordex: :D
(13:00:27) ordex: yeah
(13:00:50) mattock: anyhow, it seems we have a plan
(13:01:11) krzee: yep
(13:01:16) krzee: thanks
(13:01:26) mattock: mattock will fight his way through the MSI/MSM jungle=
 (MSM is still on the winning side) and then he and krzee will move onto =
automating more testing and making it available via buildbot to the commu=
nity developers as well
(13:01:55) mattock: dazo will check plaisthos' three patches this week, a=
s well as start the epic "man page struggle"
(13:02:12) mattock: anything else that needs discussion/coordination?
(13:02:15) krzee: best of luck with msi https://static2.stuff.co.nz/14018=
34912/639/10117639.jpg
(13:02:51) mattock: I have to clear the jungle first before I can even ge=
t to the MSI
(13:02:52) mattock: :)
(13:07:18) mattock: anything else or are we done?
(13:09:41) krzee: ...
(13:10:12) mattock: I think we're done
(13:10:35) krzee: i doubt ill make it to your morning meeting
(13:10:43) krzee: :D
(13:10:53) mattock: tomorrow?
(13:11:06) krzee: my tomorrow, your tonight
(13:11:07) mattock: (it's not today, so not all hope is lost)
(13:11:20) mattock: Thursday at 7:30 AM PST
(13:11:25) krzee: OHHH
(13:11:28) mattock: yep
(13:11:30) krzee: sweet im in
(13:11:40) krzee: wednesday was unlikely :D
(13:11:48) mattock: definitely, given what time is at your end
(13:34:32) krzee ha abbandonato la stanza (quit: Remote host closed the c=
onnection).
(13:37:18) cron2: wrt "automated server side tests" - that is *hard*, but=
 I have it outside buildbot
(13:37:29) cron2: (just to mention it again)
(13:40:28) cron2: ... and please do not start discussing and sort-of-deci=
ding stuff that is not on the agenda
(13:58:54) mattock: that is why we have summaries, so that people can als=
o complain after the fact
(13:59:04) mattock: summary which I am about to send :)
(13:59:45) cron2: yeah, but it's a waste of precious time if you discuss =
something where I might have answers already (and I'm sure I mentioned my=
 t_server setup like 100 times in the past)
(14:01:47) mattock: I can waste 10 minutes discussing it, but yes, we nee=
d to take your t_server setup into account before actually implementing i=
t
(14:02:06) mattock: implementing anything of sorts

--------------5D41563C37740DBCD69D2354--

--0bbg3spBEpBYJEx2nXlhNBRTQazoV0m9U--

--GWrs7qR8sSu65ROI37cuMmIdyWYCzNUpK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEbQT48bAXMRH0mXleKVhNn0CGRXgFAl671o0ACgkQKVhNn0CG
RXgwxgf8C3gZyEAzHhNwavz8iPmRHFZVioIle4FVe4r+L5M8m0dP82SPF4bxAJr8
FbhqpPDpWoUzYHpxaafGoH43Lnv+7G13C6q0UAqViv8+xJPTHOZhGL/p0MPLPUY2
qdfaz623KfSm9g3o9zInKnLJUaBtoWJrCtqtCrmdHUOgzc9WxIC7115sYFAS1xSL
0InWwnNd/Yk9IlEBGDdDL+sRp/ep0NMj6xEwiPH2Z64dvKbNDMe6X3rtW154q5v7
WEjJMnsznkgPHhTpX1tFtTUC4FG8EK94xftVj2q+Orlngxwf3coDl0VxQUMcIjml
Ez9DfsyDMz8xofzo17Vj04QXNtPH2Q==
=tlZe
-----END PGP SIGNATURE-----

--GWrs7qR8sSu65ROI37cuMmIdyWYCzNUpK--

