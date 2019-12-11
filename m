From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
References: <0118782c-d5eb-485d-eee6-73dfa7e6399b@...515...>
Message-ID: <c6cd6743-6a8c-6ad1-dda0-e0a15f4d38c3@...515...>
Date: Wed, 11 Dec 2019 13:32:48 +0200
MIME-Version: 1.0
In-Reply-To: <0118782c-d5eb-485d-eee6-73dfa7e6399b@...515...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="WGrgQ3c661s0kBzXEzssPr0SHei3u1mbv"
Subject: [Openvpn-devel] Summary of the community meeting (11th December
 2019)
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
--WGrgQ3c661s0kBzXEzssPr0SHei3u1mbv
Content-Type: multipart/mixed; boundary="von7WKaGoiJG44n8ugjhXQ7fs8T6jagzZ"

--von7WKaGoiJG44n8ugjhXQ7fs8T6jagzZ
Content-Type: multipart/mixed;
 boundary="------------BCE94CDE3B953FFBECA962BE"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------BCE94CDE3B953FFBECA962BE
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

Hi,

Here's the summary of the IRC meeting.

---

COMMUNITY MEETING

Place: #openvpn-meeting on irc.freenode.net
Date: Wed 11th December 2019
Time: 11:30 CET (10:30 UTC)

Planned meeting topics for this meeting were here:

<https://community.openvpn.net/openvpn/wiki/Topics-2019-12-11>

Your local meeting time is easy to check from services such as

<http://www.timeanddate.com/worldclock>

SUMMARY

dazo, lev, mattock and plaisthos participated in this meeting.

---

Discussed status of OpenVPN 2.5:

<https://community.openvpn.net/openvpn/wiki/StatusOfOpenvpn25>

Added the "agreed upon in Trento hackathon" code freeze date (January
31st 2020) to that page.

Noted that even though wintun-enabled installers are available on the
official download pages we have not really receive much feedback on
them. The wintun patches has been ACKed for the most part, but patch 4/7
will require special treatment. Mattock will ask rozmansi and selvanair
to join next Thursday's meeting (19:00 UTC):

<https://community.openvpn.net/openvpn/wiki/Topics-2019-12-19>

Their review would be very valuable as they know Windows quite well.

--

Full chatlog attached

--------------BCE94CDE3B953FFBECA962BE
Content-Type: text/plain; charset=UTF-8;
 name="openvpn_irc_meeting_chatlog_2019-12-11.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="openvpn_irc_meeting_chatlog_2019-12-11.txt"

(12:32:30) mattock: hello
(12:32:44) plaisthos: hello mattock1 and mattock2
(12:33:39) mattock: I will kill one of my duplicates
(12:33:48) mattock2 ha abbandonato la stanza (quit: Quit: IRC for Sailfis=
h 0.9).
(12:33:53) mattock: and there it goes
(12:34:46) mattock: who do we have here today?
(12:36:12) dazo: I'm here
(12:36:24) dazo: cron2 announced on -devel he couldn't make it
(12:37:45) dazo ha scelto come argomento: Next meeting 19/Dec/2019 at 20:=
00 CET.  Agenda at https://community.openvpn.net/openvpn/wiki/Topics-2019=
-12-19
(12:38:02) mattock: ok
(12:38:18) mattock: once the bouncer I'm working on now works I may notic=
e such messages :)
(12:38:22) mattock: so, topic
(12:38:23) mattock: s
(12:38:29) dazo: anyone heard from rozmanzi lately?
(12:38:51) mattock: https://community.openvpn.net/openvpn/wiki/Topics-201=
9-12-11
(12:38:52) vpnHelper: Title: Topics-2019-12-11 =E2=80=93 OpenVPN Communit=
y (at community.openvpn.net)
(12:38:53) mattock: I have not
(12:39:15) mattock: he is known to appear if his name is mentioned
(12:40:33) mattock: so, 2.5?
(12:41:36) mattock: https://community.openvpn.net/openvpn/wiki/StatusOfOp=
envpn25
(12:41:38) vpnHelper: Title: StatusOfOpenvpn25 =E2=80=93 OpenVPN Communit=
y (at community.openvpn.net)
(12:41:39) lev__: what is the code freeze date for 2.5 ?
(12:41:53) mattock: we don't have that afaik
(12:41:59) mattock: "Current tentative planning is "2.5 release on April =
1st, 2020". "
(12:42:05) mattock: that is 2.5.0
(12:42:21) mattock: we may want to set a freeze date to get things moving=

(12:42:38) dazo: We discussed it briefly in Trento, IIRC we wanted all co=
de to be applied by end of January
(12:42:50) ***lev__ looks for syzzer=20
(12:43:11) dazo: then have stabilization process (rolling beta releases) =
 until release time
(12:44:18) lev__: we've added wintun-enabled client to download page and =
made an announcement to -users and -devel, but haven't got much feedback
(12:44:54) dazo: lev__: is everything you wanted merged in regards to win=
tun?
(12:44:58) mattock: I'll mention the January deadline on the planning pag=
e
(12:45:31) lev__: dazo: of course not :)
(12:45:49) lev__: 3 out of 7 is merged
(12:46:18) mattock: we may get more lucky with wintun testing during the =
stabilization phase
(12:46:21) lev__: 4 is most intrusive one, current version is v5
(12:46:44) lev__: mattock1: but that requires it to be merged into master=

(12:46:44) mattock: while wintun installers are available on the download=
 page "normal users" would just get the topmost release that opens up dir=
ectly in their browsers
(12:46:49) plaisthos: client connect is waiting
(12:47:22) dazo: lev__: what are the risks of merging those patches to no=
n-wintun users?
(12:50:00) lev__: good question
(12:51:01) lev__: while default option is tap-windows6 and users _should =
not_ be affected unless they explicitly set --windows-driver wintun, I ha=
ve changed certain code paths
(12:52:21) lev__: I would say the goal of review is to make sure that ove=
rall code quality hasn't been made (much) worse
(12:54:29) lev__: but well, wintun bumps performance from 390 to 730 mbit=
/s, so I would say that is a huge step forward for Windows users
(12:55:43) dazo: I'm looking for a risk assessment, if we should consider=
 applying the lazy-ack policy on these patches ... but then we need to ha=
ve a better understanding of the risks associated with it
(12:58:01) lev__: the follow-up patches (5-7, or most of them) have been =
acked by Simon, they're mostly about interactive service
(13:01:35) dazo: I've updated the status page a swell with a few more cor=
rections etc
(13:01:56) mattock: so the follow-up stuff could be merged?
(13:02:53) dazo: well, patch 5-7 might depend on changes from 1-4 ;-)
(13:03:44) lev__: 5-6 are acked (just checked)
(13:04:47) lev__: I can ask Simon to have a look at 7/7 and ack it
(13:04:59) lev__: (this is small one)
(13:05:46) lev__: essentially we need 4/7, this is the "core" of that pat=
chset
(13:06:34) lev__: dazo: plaisthos feel free to review :)
(13:07:07) mattock: what kind of testing would give us confidence in 4/7?=

(13:07:17) mattock: can we do some targeted testing?
(13:07:19) dazo: lev__: I find it hard to have to come with a valuable re=
view on a platform I have no development experience on
(13:08:01) mattock: could we maybe coordinate a session with Selva and Si=
mon about 4/7? Or ask them to join next week's meeting?
(13:08:15) lev__: well, the code is not windows specific
(13:08:16) dazo: that would definitely be much better
(13:08:36) lev__: although used by windows
(13:08:43) mattock: I can ask Selvan and Simon if they could join next we=
ek, with the goal of reviewing 4/7
(13:08:48) mattock: Selva :)
(13:09:31) lev__: sure
(13:09:37) dazo: lev__: wintun requires windows to start with .... so it =
would require to understand that driver
(13:09:59) dazo: mattock1: that sounds like a good idea; their review wil=
l be much more valuable for all of us
(13:10:16) mattock: ok, I'll do that
(13:11:19) mattock: anything else on 2.5?
(13:14:00) mattock: I'm itching to test my IRC bouncer (not on it yet)
(13:23:48) mattock: I'm lazy-ACKing the statement that "this IRC meeting =
is over"
(13:23:52) mattock: writing the summary :)
(13:23:59) dazo: sounds fine

--------------BCE94CDE3B953FFBECA962BE--

--von7WKaGoiJG44n8ugjhXQ7fs8T6jagzZ--

--WGrgQ3c661s0kBzXEzssPr0SHei3u1mbv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEbQT48bAXMRH0mXleKVhNn0CGRXgFAl3w0+AACgkQKVhNn0CG
RXiwHQgAoMqIlWhBUNun0JWFRdU/kbwxVaWtDXLwavJrk6LF3vW8fjO0AAt5J43B
6Z60EU4l4Jt5H/oBj8lQXKljqPm16NEJWHTzS0QYtrSjaZPVzit2gghHNHhzuA9O
oxsXvE3ZLDgFr2mdoSN2BiFXGejBZfdoD0o4HF5ln448TFSGY9KL8AQ/iC87VvIb
ckSmDAao6Pb7y+Xx7VHWd7vWj4MzGmXhcQ4I2eQfMj2UiFVp0eSLPP3d9PpxNioW
efU7dbD6KGRo8oqjlfamDzrG6ox1HD7uYU1ULLWBihiVVhtz4x5j9jjGSHET12+M
esnG4GhQ1RSY7/0HA6mSimf1507/GQ==
=YqJ+
-----END PGP SIGNATURE-----

--WGrgQ3c661s0kBzXEzssPr0SHei3u1mbv--

