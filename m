From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
References: <6a623f26-a30c-eb91-204b-8f938cad2994@...515...>
Message-ID: <2ae69b1e-3ff4-e147-9e70-b28952f5b0d5@...515...>
Date: Wed, 29 Apr 2020 15:51:20 +0300
MIME-Version: 1.0
In-Reply-To: <6a623f26-a30c-eb91-204b-8f938cad2994@...515...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="y4QhokR0wLmwPKmAbZ2jLJrW0DQ80gYsy"
Subject: [Openvpn-devel] Summary of the community meeting (29th April 2020)
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
--y4QhokR0wLmwPKmAbZ2jLJrW0DQ80gYsy
Content-Type: multipart/mixed; boundary="spMcUpGRpRXoxuqA6GMuPszzYW9Sb6O5t"

--spMcUpGRpRXoxuqA6GMuPszzYW9Sb6O5t
Content-Type: multipart/mixed;
 boundary="------------CA55B37022247DD0956ED0DF"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------CA55B37022247DD0956ED0DF
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

Hi,

Here's the summary of the IRC meeting.

---

COMMUNITY MEETING

Place: #openvpn-meeting on irc.freenode.net
Date: Wed 29th April 2020
Time: 11:30 CEST (09:30 UTC)

Planned meeting topics for this meeting were here:

<https://community.openvpn.net/openvpn/wiki/Topics-2020-04-29>

Your local meeting time is easy to check from services such as

<http://www.timeanddate.com/worldclock>

SUMMARY

cron2, lev, mattock, ordex and plaisthos participated in this meeting.

---

Talked about broken IPv6 connectivity to community.openvpn.net. This is
caused by Cloudflare, where IPv6 is turned off, apparently for the whole
openvpn.net domain. It apparently can't be selectively turned on for
just community.openvpn.net.

Mattock and plaisthos will try to convince the ops team to turn on IPv6
across the board, or otherwise resolve this issue.

--

Noted that right now it is still possible to amend the coding style for
the future. Nobody had any strong opinions on it.

--

Ordex sent the "ipv6-only" patch to OpenVPN Inc's QA team for testing.
This will pave the way for approval. Ordex will check the end of this
week to see what progress QA has made.

--

Mattock will try to reach the person who is responsible for corporate
(e.g. OpenVPN Connect) MSI packaging and recruit him/her to help with
OpenVPN 2.5 MSI installers.

--

Talked about the remaining 2.5 patches:

- client-connect (requires review)
- auth-token breakage when server is restarted and explicit-exit-notify
is set

--

Full chatlog attached


--------------CA55B37022247DD0956ED0DF
Content-Type: text/plain; charset=UTF-8;
 name="openvpn_irc_meeting_chatlog_2020-04-29.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="openvpn_irc_meeting_chatlog_2020-04-29.txt"

(12:31:32) ***plaisthos is here
(12:31:36) cron2: barely made it
(12:32:39) mattock: hi!
(12:33:33) lev__: hello
(12:34:00) cron2: good
(12:34:52) mattock: seems like we have a fair number of participants toda=
y
(12:36:28) mattock: ok let's start
(12:37:04) mattock: https://community.openvpn.net/openvpn/wiki/Topics-202=
0-04-29
(12:37:18) mattock: I can give an update on the IPv6 situation on communi=
ty.openvpn.net
(12:37:24) mattock: before we even start
(12:37:42) mattock: so, as I assumed, it is cloudflare that's breaking IP=
v6 there
(12:38:12) cron2: why, and what can we do about it?
(12:38:28) mattock: basically IPv6 is turned off at the cloudflare end si=
te-wide (*.openvpn.net I presume) and turning it on for community.openvpn=
=2Enet was not trivially possible=20
(12:39:05) cron2: why is turned off for *.openvpn.net?
(12:39:12) mattock: it may be possible, but if not, then there are two op=
tions:
(12:39:12) mattock: - take community.openvpn.net off off cloudflare (DoS =
becomes way more likely)
(12:39:12) mattock: - enable IPv6 site-wide
(12:39:16) mattock: I have no clue
(12:39:17) cron2: and why can it not be turned on for community?
(12:39:40) mattock: usually overrides are done with "page rules" and ther=
e did not seem to be an option for enabling IPv6 selectively
(12:39:55) mattock: but I did not look myself and I won't dare touch stuf=
f there because everything could break if I did
(12:40:22) mattock: I will put pressure on raidz who is responsible for t=
his to get this resolved somehow
(12:41:14) mattock: anyways, that all about it
(12:41:37) cron2: just break stuff, again and again, so they get aware of=
 the consequences of not having IPv6! :-)
(12:41:52) cron2: 11:41 -!- There is no such nick raidz
(12:41:59) cron2: mmmh, smart man, hiding from me
(12:42:04) mattock: yes I guess so :P
(12:42:44) mattock: I think disabling IPv6 must be some "security" thing,=
 though I don't see the point myself
(12:43:25) plaisthos: Yeah not supporting IPv6 in 2020 is really stupid
(12:43:47) cron2: if it's cloudflared, having IPv6 enabled on the outside=
 is totally decoupled from IPv6 "between couldflare and the origin server=
s", so there is no security argument whatsoever
(12:43:47) mattock: plaisthos: maybe you can also help convince the ops t=
eam to agree on that
(12:44:00) plaisthos: mattock: sure
(12:44:30) mattock: I will bring this up again in tomorrow's meeting on a=
 more "enable IPv6 across the board" level
(12:44:32) cron2: not having IPv6 inside is sort of "typical enterprise I=
T thinking" (this is new stuff, we do not know new stuff, we never want n=
ew stuff).  Seems OpenVPN has become quite a big success :-)
(12:44:47) cron2: plaisthos, mattock: thanks!
(12:45:22) mattock: np!
(12:45:26) mattock: shall we move on?
(12:45:42) cron2: yes
(12:45:54) mattock: any topics besides "2.5"?
(12:46:11) ordex: ops
(12:46:24) mattock: oops or ops? :)
(12:46:34) ordex: both
(12:46:36) cron2: I had planned on discussing uncrustify style for tests/=
unit_tests/ today, but events overtook it
(12:46:49) cron2: syzzer decided "we want a uniform coding style!" and so=
 we did
(12:46:59) ordex: agreed
(12:47:03) ordex: better have it uniform
(12:47:13) ordex: having two styles in the same project can easily become=
 .. annoying
(12:47:49) cron2: right (just for completeness: my argument was "test cod=
e is different shape anyway, so we *could* agree on a more compact style"=
) - but I am perfectly fine with this
(12:48:06) plaisthos: yeah if we discuss it, I woudl advocate to drop the=
 80 char limit but then again it is not that important
(12:48:25) ordex: I have quite strong feeling about that liit though :D
(12:48:29) ordex: *limit
(12:48:56) ***cron2 is not writing any code these days, just managering t=
hings :-(
(12:48:57) plaisthos: ordex: strong feeling to drop it, right? *ducks*
(12:49:07) ***ordex ducks around too
(12:49:14) ordex: not really :p but it seems we are not discussing it any=
way
(12:49:34) ordex: next ?
(12:49:40) cron2: well, 2.5
(12:49:45) ordex: for 2.5: we have the ipv6-onlt patchset which was resur=
rected
(12:50:00) cron2: I suck at doing things (news at 11), so haven't looked =
at the ipv6-only stuff
(12:50:19) ordex: I created an internal corp ticket for our QA to take ca=
re of performing some tests - tests that have been first discussed a bit =
with cron2=20
(12:50:32) ordex: hehe
(12:50:33) ordex: ok
(12:50:42) ordex: I think having hte results of the tests will already be=
 a step forward
(12:51:00) ordex: will check with QA by the end of this week to see whet =
they managed to achieve
(12:51:25) mattock: good, I like seeing corporate resources actually bein=
g used for community things
(12:51:43) ordex: \o/
(12:51:53) ordex: nothing else from my side
(12:52:10) mattock: I think there is some poor developer in the company t=
hat has to maintain MSI installers
(12:52:20) mattock: I should really try to recruit him to help with 2.5 M=
SI stuff
(12:52:26) mattock: unless that poor soul is lev :D
(12:52:35) cron2: oh, good
(12:53:38) mattock: anything else?
(12:56:08) cron2: client-connect?
(13:00:44) mattock: any takers?
(13:04:55) mattock: I'm starting to suspect my IRC client has died
(13:04:59) cron2: no
(13:05:02) mattock: oh
(13:05:17) cron2: this group starts to be very talkative as soon as "2.5"=
 is mentioned...
(13:05:28) mattock: indeed
(13:05:40) mattock: everyone fled away
(13:05:47) plaisthos: I am doing my best :/
(13:05:55) cron2: to flee?
(13:06:13) plaisthos: Nah, for the client-connect, that requires review
(13:06:20) plaisthos: and the other patches from me too
(13:06:36) plaisthos: I am nore what else I can currently do with 2.5 rel=
ease
(13:06:37) cron2: I have auth-token on my plate
(13:07:20) cron2: plaisthos: the thing with "if you restart the server, w=
ith exit-notification to the peers, auth-token breaks"
(13:07:29) cron2: explicit-exit-notify
(13:09:35) plaisthos: cron2: ah forgot about that
(13:12:11) cron2: plaisthos: who (was) volunteered to review the client-c=
onnect stuff?  ordex, dazo?
(13:16:10) mattock: maybe we have to dig that info up from meeting summar=
ies
(13:17:46) mattock: I'll check the latest summaries quickly
(13:19:20) mattock: I'll check if I can figure out the volunteer from her=
e: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg19=
624.html
(13:19:22) vpnHelper: Title: [Openvpn-devel] Summary of the community mee=
ting (26th March 2020) (at www.mail-archive.com)
(13:21:15) mattock: no volunteers there afaics:
(13:21:15) mattock: (21:32:27) dazo: yeah ... lets get plaisthos patches =
in first, and lets see  where that leads us next
(13:21:15) mattock: (21:32:35) cron2: indeed :)
(13:21:28) mattock: maybe nobody volunteered to do the job?
(13:21:58) cron2: originally, ordex was volunteered (since there is payme=
nt on the table)... but he got corp'ed away
(13:24:12) mattock: ordex?
(13:24:20) mattock: we have 6 minutes to spare
(13:30:21) mattock: ok, I need to take $child out as $wife has a meeting =
and $child is making too much noise :)
(13:30:30) mattock: I will send the summary after
(13:30:32) cron2: meeting is game over anyway
(13:31:25) mattock: yeah
(13:31:26) mattock: agreed

--------------CA55B37022247DD0956ED0DF--

--spMcUpGRpRXoxuqA6GMuPszzYW9Sb6O5t--

--y4QhokR0wLmwPKmAbZ2jLJrW0DQ80gYsy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEbQT48bAXMRH0mXleKVhNn0CGRXgFAl6peEgACgkQKVhNn0CG
RXhaGgf+O0ntA+fuBgn1HaACHgCPHpKYb7EWSELOxXRwh2kzv2BJs3mTVO2Oga7c
P7d2CMC0KubupoFenJ0akOGleFACPiBV5K+0CcFdO/K7uWKCkIU+e0Z0oekhIIqU
/McTN1dl6N/HiZ+GIknk1xQfOm/HczNkpddE1t4SlNc5HUbtdcPLEekBHDU+RdhS
Yd8tSSTHB724idgl1YimtUk7BGWzni+pIvZC70BQCfeY083bBlE4FMBJGuzmNwA7
IxfNixAchParY2qSXNrGbkHMvgue3Da+bIT1gretAezagf3JdrdoTaKh74ZajT6z
S4RH9NZopj2QoPqHIQQwAHgWjncl2g==
=zpHi
-----END PGP SIGNATURE-----

--y4QhokR0wLmwPKmAbZ2jLJrW0DQ80gYsy--

