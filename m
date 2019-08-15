From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
References: <596f0202-4908-6657-373e-ce6b7346b8e5@...515...>
Message-ID: <4715c196-5c6a-e9b6-3dc7-4bb3ee83f800@...515...>
Date: Thu, 15 Aug 2019 21:56:45 +0300
MIME-Version: 1.0
In-Reply-To: <596f0202-4908-6657-373e-ce6b7346b8e5@...515...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="qmpEYp0JbRpoXXOZMVZVSWTDV0ZanA3iz"
Subject: [Openvpn-devel] Summary of the community meeting (15th August 2019)
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
--qmpEYp0JbRpoXXOZMVZVSWTDV0ZanA3iz
Content-Type: multipart/mixed; boundary="M1Gib0NtGcwroK2ADWhDjdLOCSpfRhbxv";
 protected-headers="v1"
From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
To: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Message-ID: <4715c196-5c6a-e9b6-3dc7-4bb3ee83f800@...515...>
Subject: Summary of the community meeting (15th August 2019)
References: <596f0202-4908-6657-373e-ce6b7346b8e5@...515...>
In-Reply-To: <596f0202-4908-6657-373e-ce6b7346b8e5@...515...>

--M1Gib0NtGcwroK2ADWhDjdLOCSpfRhbxv
Content-Type: multipart/mixed;
 boundary="------------248B3992D0D869970DCF8665"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------248B3992D0D869970DCF8665
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable

Hi,

Here's the summary of the IRC meeting.

---

COMMUNITY MEETING

Place: #openvpn-meeting on irc.freenode.net
Date: Thursday 15th August 2019
Time: 20:00 CEST (18:00 UTC)

Planned meeting topics for this meeting were here:

<https://community.openvpn.net/openvpn/wiki/Topics-2019-08-15>

Your local meeting time is easy to check from services such as

<http://www.timeanddate.com/worldclock>

SUMMARY

cron2, dazo, mattock and ordex participated in this meeting.

---

Briefly touched on HLK testing. Mattock did some testing with routing
tables and HLK last week, but they did not immediately solve the e2eperf
test problem.

--

Talked about the other Windows ARM64 laptop provided by Microsoft and
aimed at OpenVPN/tap-windows6 testing. Mattock started a private email
thread with the goal of determining who should have it.

--

Discussed tomorrow's mini-hackathon. Mattock will attempt to fix the
(Ubuntu) buildslave issue and bring back the Windows buildslave. If time
permits he'll work on HLK as well. Dazo will try to ACK some patches,
but ordex probably won't make it. Cron2 will work on stuff during the
evening.

--

Discussed the "TCP socket backlog set too low" issue:

<https://community.openvpn.net/openvpn/ticket/1208>

Agreed that increasing the backlog size makes sense. Cron2 had converted
that idea into a formal patch sent to the mailing list.

--

Full chatlog attached.

---


--------------248B3992D0D869970DCF8665
Content-Type: text/plain; charset=UTF-8;
 name="openvpn_irc_meeting_chatlog_2019-08-15.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="openvpn_irc_meeting_chatlog_2019-08-15.txt"

(20:57:09) cron2: seems we're getting close to the real start :)
(20:58:52) mattock: howdy
(21:01:00) cron2: yeeha
(21:01:53) mattock: who do we have here today?
(21:02:11) cron2: dazo was around 45 minutes ago...
(21:05:23) mattock: https://community.openvpn.net/openvpn/wiki/Topics-201=
9-08-15
(21:05:24) vpnHelper: Title: Topics-2019-08-15 =E2=80=93 OpenVPN Communit=
y (at community.openvpn.net)
(21:05:29) dazo: I'm here
(21:05:32) mattock: no particular topics besides the usual ones
(21:05:41) mattock: let's get #1 done quickly
(21:06:10) mattock: so, I did some testing with routing tables and HLK la=
st week, but they did not immediately solve the e2eperf test problem
(21:06:24) mattock: but I'm quite confident that we're on the right track=
, and will work on HLK tomorrow in our mini-hackaton
(21:07:02) cron2: I won't have time to actually get anything done during =
daytime tomorrow but will look at things tomorrow evening
(21:07:07) ***ordex is here
(21:07:09) mattock: oh, did I mention that I received the ARM64 Windows l=
aptops?
(21:07:15) cron2: like, at all the ACKs that come in tomorrow :-) *hint h=
int*
(21:07:33) cron2: mattock1: not here, but I've seen the mail.  nice :)
(21:07:56) mattock: I haven't actually tested openvpn on it yet
(21:09:50) mattock: ok guys so who of you can join tomorrow's mini-hackat=
hon?
(21:10:12) mattock: besides cron2 that is
(21:10:23) dazo: I'll try to do that
(21:10:49) cron2: dazo: nice.  A new round of token patches is waiting :)=

(21:11:07) ordex:  i am not sure I will be around - but if I see any high=
light pointing to me, I'll try to get back asap
(21:12:13) dazo: yeah, spotted those :)
(21:12:56) cron2: then there's the 2.4 libressl patch from m-a, which loo=
ks very sane (as in "no #ifdef LIBRESSL" but depending on availability of=
 the HAVE_TLS1_3 macros)
(21:13:00) mattock: one question regarding the ARM64 laptops: did we deci=
de who should get the other one?
(21:13:08) mattock: I mean, I really don't want or need two of them
(21:13:12) mattock: one is more than enough :)
(21:13:24) cron2: I forgot, but maybe my e-mails remember.
(21:13:32) mattock: it was you or rozmansi
(21:13:41) mattock: unless somebody has better ideas
(21:13:54) ordex: mattock1: ask lev__=20
(21:14:01) ordex: he may need one for some wintun development
(21:14:04) cron2: rozmansi
(21:14:20) ordex: unless it's already allocated :)
(21:14:22) mattock: ordex: yeah, that is one option is MS is fine with it=

(21:14:49) mattock: so basically whoever is doing release management for =
OpenVPN 2.x (=3Dme) needs one
(21:15:12) cron2: rozmansi is into wintun as well, so lev__ should be abl=
e to benefit
(21:15:17) mattock: yeah
(21:16:20) mattock: I can start an email thread between me, lev, rozmansi=
 and cron2
(21:16:38) mattock: to figure out who earns that slightly frankensteinian=
 laptop
(21:16:44) mattock: :P
(21:17:24) mattock: need to help carry stuff, will be back in a few mins
(21:20:09) ordex: slavery was not yet defeated in Finland?
(21:20:09) ordex: :P
(21:20:31) ordex: cron2: do you have time to look at the sitnl fixups the=
se days too ?
(21:20:45) cron2: just on my way to 1/6, you ruined the surprise :)
(21:20:51) ordex: :D
(21:26:45) mattock: back
(21:27:57) mattock: let me send that email now
(21:30:20) mattock: any particular topics we'd want to discuss today?
(21:30:41) ordex: _o_
(21:30:45) ordex: not me
(21:30:56) mattock: ok
(21:31:07) ***cron2 wants his windows buildbot back, and no errors from t=
he other buildslaves...
(21:31:18) mattock: oh yes that is another thing I need to look into tomo=
rrow
(21:31:22) cron2: thanks :)
(21:32:05) mattock: the Windows buildslave is probably not a huge effort =
(all was in a Git repo)
(21:32:17) mattock: so maybe I could even bring it back to life tomorrow,=
 but no promises
(21:32:28) cron2: that would certainly be nice :-)
(21:32:32) mattock: I'll take a stab at it, because HLK has a way of suck=
ing all the time I give it anyways
(21:32:33) mattock: :P
(21:32:50) cron2: ordex: if you have a bit of brains, you could look at T=
rac: #1208
(21:33:14) cron2: trivial patch, and I think it's the way to go, but not =
sure I'm overlooking something
(21:34:23) ordex: the one about listen() ?
(21:34:40) cron2: yep
(21:34:44) ordex: ah yeah seen it
(21:34:49) ordex: what you said makes sense
(21:35:00) ordex: I just wanted to read a bit of the manpage before bless=
ing it
(21:35:23) cron2: :)
(21:37:29) cron2: didn't know we have a gc_reset(), but that is certainly=
 useful :)
(21:39:15) cron2: (which does not currently do anything different than gc=
_free(), but the message is different - "I want to keep this gc around, b=
ut cleanup please")
(21:39:18) ordex: well it's basically an alias for gc_free
(21:39:19) ordex: :D
(21:39:24) cron2: yes :)
(21:39:30) ordex: but yeah
(21:39:58) cron2: +    char *addr_str =3D (char *)print_in_addr_t(*addr, =
0, &ctx->gc);
(21:40:06) cron2: why is there a (char*)...?
(21:41:08) cron2: I assume it's to get around a "const" warning, but it c=
ertainly looks weird - assign a char * to a char *, casting it to a (char=
 *)...
(21:52:31) mattock: anything else for today?
(21:52:48) cron2: nah, ordex has fallen asleep and I'm going down to the =
sofa now as well :)
(21:52:55) mattock: and I need to bike home
(21:53:00) mattock: so, tomorrow it is!
(21:53:02) cron2: will be in IRC tomorrow, but won't have focus
(21:53:02) ordex: whoops I wasn't reading
(21:53:06) cron2: haha
(21:53:10) ordex: :p
(21:53:15) ordex: ordex is the keyword !
(21:53:21) mattock: good to know!
(21:53:36) ordex: will check
(21:53:40) mattock: my keyword seems to be "Samuli Sepp=C3=A4nen" (pidgin=
 beeps if somebody writes that)
(21:53:44) cron2: so - that patch 3/6 has (char *) casts that look ugly t=
o me, and unless there's a convincing reason why we need them, maybe we d=
on't need them :-)
(21:53:47) cron2: anyway, see you tomorrow
(21:53:59) mattock: see you tomorrow!

--------------248B3992D0D869970DCF8665--

--M1Gib0NtGcwroK2ADWhDjdLOCSpfRhbxv--

--qmpEYp0JbRpoXXOZMVZVSWTDV0ZanA3iz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEbQT48bAXMRH0mXleKVhNn0CGRXgFAl1Vqu0ACgkQKVhNn0CG
RXgh7Qf/c3ZwoCBpHeWqWA10Q9lIQeSm/0qiUpSenNbZUUEdxM2bjq+L+xFlJT6w
LL8ffcsVhxvu4sar8udH+OOwu44z0iArVHuZly8UuZw+H6CW+WydZGEdDIB4pmLI
7EKNhtr3giH9rDfjNTfpjjVa9fdtlefgrGJB9EKdFIGpkHPRgwitxxzn4dLFKDsp
K/rf0qK76bmEh3qZqDyQ6tAnVUej4DRQjrxZZxQS6PebZ0fxE37ruDB/9ZQHgd0a
Q7/MTe3alHlAmLojvv9PpgRNMjDFniu00s41a5qP0ZgSxUcycrE4dCp5SnhAtq63
CCbGohvGT/wypsb3t3ClDYnqkvY6oQ==
=/Iwo
-----END PGP SIGNATURE-----

--qmpEYp0JbRpoXXOZMVZVSWTDV0ZanA3iz--

