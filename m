From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
References: <4d714839-b586-8b1c-df66-6ceb20a59fe3@...515...>
Message-ID: <d7dc89b7-9d52-3024-c5a6-230724308a0b@...515...>
Date: Thu, 24 Oct 2019 22:13:16 +0300
MIME-Version: 1.0
In-Reply-To: <4d714839-b586-8b1c-df66-6ceb20a59fe3@...515...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="QZBgTiwDHknZR7ynIzj6nS4vcuQmrpOSv"
Subject: [Openvpn-devel] Summary of the community meeting (24th Oct 2019)
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
--QZBgTiwDHknZR7ynIzj6nS4vcuQmrpOSv
Content-Type: multipart/mixed; boundary="bHfJERL4OlB6RXJS7V0qijzvXG1SwJv0I";
 protected-headers="v1"
From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
To: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Message-ID: <d7dc89b7-9d52-3024-c5a6-230724308a0b@...515...>
Subject: Summary of the community meeting (24th Oct 2019)
References: <4d714839-b586-8b1c-df66-6ceb20a59fe3@...515...>
In-Reply-To: <4d714839-b586-8b1c-df66-6ceb20a59fe3@...515...>

--bHfJERL4OlB6RXJS7V0qijzvXG1SwJv0I
Content-Type: multipart/mixed;
 boundary="------------4D62A2FF47D32DACD1EBDFFD"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------4D62A2FF47D32DACD1EBDFFD
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable

Hi,

Here's the summary of the IRC meeting.

---

COMMUNITY MEETING

Place: #openvpn-meeting on irc.freenode.net
Date: Thursday 24th October 2019
Time: 20:00 CEST (18:00 UTC)

Planned meeting topics for this meeting were here:

<https://community.openvpn.net/openvpn/wiki/Topics-2019-10-24>

Your local meeting time is easy to check from services such as

<http://www.timeanddate.com/worldclock>

SUMMARY

cron2, gcoxmoz, mattock and ordex participated in this meeting.

---

Noted that mattock's plan of action now, after setting up new tapbuilder
and releasing tap-windows6 test installer, is:

1) Setup IRC bouncer
2) Setup Windows "buildslave" (partially done already)
3) Setup ARM64 laptop and link it to OpenVPN internal network (for
others to use for testing as well)

--

Cron2 still has hopes of getting some of his old buildslaves back. At
some point he'll just reinstall what remains and ditch the rest.

--

Talked about OpenVPN 2.5 release schedule. Given all the time required
after the code has stabilized (RC1) it seems that 2020 Q1 is realistic.
Q4 2019 probably is not.

--

Discussed "SOCKS proxy not working with UDP+IPv6" issue:

<https://community.openvpn.net/openvpn/ticket/1221>

Agreed that cron2's patch "mutate upd6 into udp4 if socks-proxy is set"
patch, which is on the mailing list, is a reasonable approach.

--

Discussed the OpenVPN 2.4.8 release. Agreed to aim for a "halloween
release" (31st October). As agreed previously a new tap-windows6
installer with the pending tap-windows6 PRs should go in. Mattock asked
Selva to test the tap-windows6 test installer as he had some concerns
about PR#84:

<https://build.openvpn.net/downloads/snapshots/tap-windows-9.24.2-I601.exe>
<https://github.com/OpenVPN/tap-windows6/pull/84>
<https://github.com/OpenVPN/tap-windows6/pull/86>

--

Full chatlog attached.


--------------4D62A2FF47D32DACD1EBDFFD
Content-Type: text/plain; charset=UTF-8;
 name="openvpn_irc_meeting_chatlog_2019-10-24.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="openvpn_irc_meeting_chatlog_2019-10-24.txt"

(20:57:59) cron2: I'll be with you in like 5-10 minutes... kids, bed, ...=

(21:00:47) mattock: hello!
(21:05:28) mattock: anyone else?
(21:07:15) cron2: yes :)
(21:10:27) mattock: ok :)
(21:10:44) mattock: so let's start
(21:11:02) mattock: digging up the agenda
(21:11:18) mattock: https://community.openvpn.net/openvpn/wiki/Topics-201=
9-10-24
(21:11:19) vpnHelper: Title: Topics-2019-10-24 =E2=80=93 OpenVPN Communit=
y (at community.openvpn.net)
(21:11:32) mattock: all this boring stuff
(21:11:50) cron2: yeah, somewhat hard to discuss things if nobody is here=
=2E..
(21:11:52) mattock: at my end I guess the IRC bouncer would be the natura=
l next step
(21:11:58) ***cron2 likes that
(21:12:07) mattock: the tapbuilder/signing comp is working perfectly and =
the test installer is out there
(21:12:15) cron2: saw the announcement, this is nice
(21:12:26) mattock: irc bouncer -> windows "buildslave" -> arm64 lappy
(21:14:58) cron2: yeah.  I'm still hoping to get my buildslaves back, but=
 will eventually move forward and reinstall what is still missing and dit=
ch the rest
(21:15:25) mattock: ok sounds good
(21:15:58) mattock: I'll try to squeeze the above into this week and next=
 (i.e. before hackathon)
(21:20:13) gcoxmoz: I'll ask, since it's agenda item 1 and things are qui=
et: https://community.openvpn.net/openvpn/wiki/StatusOfOpenvpn25 still cl=
aims 2019 for 2.5.  Is this still feeling true or are there revised time =
guesses ("Q2 2020"?) you'd feel confident rolling into the wiki?
(21:20:15) vpnHelper: Title: StatusOfOpenvpn25 =E2=80=93 OpenVPN Communit=
y (at community.openvpn.net)
(21:21:49) cron2: we do not know
(21:22:02) cron2: progress has been a bit better in the last few weeks
(21:22:23) cron2: maybe Q1 is realistic, end of 2019 might not
(21:22:45) cron2: quite a bit of work still to do, and the "we are done w=
ith the code, now testing begins" phase usually takes +2 months...
(21:23:56) gcoxmoz: Cool, Q1 is enough of a guess for me for now.  Thank =
you.
(21:24:16) mattock: anything else for today?
(21:27:53) cron2: #1221
(21:28:05) cron2: I'd like to discuss this with ordex and dazo, or plaist=
hos...
(21:28:20) cron2: we currently fail if ( --proto udp6 && --socks-server )=

(21:28:23) ordex: hmhm
(21:28:38) cron2: fixing this for good is quite a bit of work, so I sugge=
st to just force "udp4" in this case
(21:28:58) ordex: socks-server is a 2.5 thing only ?
(21:29:01) mattock: oh ordex appeared!
(21:29:07) mattock: welcome!
(21:29:07) cron2: another approach would be to just error out, but I find=
 this unfriendly if we can make it work with just a warning
(21:29:08) ordex: you invoked me !
(21:29:10) cron2: --socks-proxy
(21:29:14) ordex: cron2: ah ok
(21:29:43) ordex: cron2: does that tunnel UDP packets over the TCP link t=
o the proxy ?
(21:29:51) cron2: nah, never :)
(21:29:59) cron2: --proto udp* with socks always works like this:
(21:30:04) cron2: - we do a TCP connect to the SOCKS server
(21:30:11) cron2: - we ask for a UDP socket, with "proto IPv4"
(21:30:16) cron2: - the server opens a UDP socket for us
(21:30:22) ordex: oh
(21:30:31) cron2: - we send UDP packets to this socket on the SOCKS host,=
 and the SOCKS host relays
(21:30:36) ordex: I see
(21:30:41) ordex: okok
(21:30:42) cron2: - the packets carry 10 byte of extra header with the "f=
inal" IPv4 address
(21:31:02) cron2: the TCP connection is nicely IPv6 today (so --proto tcp=
6 --socks-proxy works)
(21:31:22) cron2: but all the signalling in the protocol is IPv4 only tod=
ay
(21:31:33) ordex: ok
(21:31:57) cron2: so what happens today: the socks server gives us an IPv=
4 host+port to send packets to, and we try to use that with an UDP6 socke=
t, which fails
(21:32:29) ordex: yeah
(21:35:02) cron2: ordex: so, what do you think?
(21:35:18) ordex: I guess the options are 2
(21:35:30) ordex: 1) we fix this, by properly supporting this case
(21:35:37) ordex: 2) we reject udp6 with socks-proxy
(21:35:46) ordex: the latter might be the short term solution, since it d=
oes not work in any case
(21:35:50) cron2: 3) we mutate upd6 into udp4 if socks-proxy is set :)
(21:36:01) ordex: mumble mumble
(21:36:16) cron2: so, for a short-term fix, we need to decide if 2) or 3)=
 is what we want
(21:36:32) ordex: 3 may also make sense, with a big warning in the log
(21:37:34) cron2: yeah :-) - a patch for 3) is on the list, and I was wai=
ting for the tomatoes...
(21:37:50) cron2: https://patchwork.openvpn.net/patch/869/
(21:37:51) vpnHelper: Title: [Openvpn-devel] Force combinationation of --=
socks-proxy and --proto UDP to use IPv4. - Patchwork (at patchwork.openvp=
n.net)
(21:38:06) ordex: ah
(21:38:10) ***ordex prepares oranges
(21:39:05) cron2: (I do have two different messages here - if a user expl=
icitly asked for "udp6", he'll get a WARNING, if "just udp", it's an INFO=
, because it might just do udp4 anyway)
(21:39:44) ordex: right
(21:40:05) ordex: looks good
(21:40:08) ordex: did you test it ? :D
(21:40:36) cron2: yes, since I now have a SOCKS proxy that actually does =
IPv6 perfectly well, I noticed (for the first time ever) that OpenVPN doe=
sn't do that
(21:41:04) cron2: I use "dante", which has IPv4 in all its example files,=
 only IPv4.  But if you google, you find "of course we do support IPv6, j=
ust write ::/0 if you want to permit v6"
(21:41:22) cron2: which is sort of "roll eye, why don't you put that into=
 your examples" :)
(21:41:44) cron2: I did use "ssh -D 3333" for "tcp6 socks" previously, bu=
t that does not do UDP
(21:42:00) ordex: :D
(21:42:04) ordex: right
(21:42:08) ordex: I use dante as well sometimes
(21:42:09) ordex: okok
(21:48:55) mattock: hmm, so
(21:49:35) mattock: agreement that "patch of 3) is on the list" is good e=
nough?
(21:49:59) cron2: not sure if I just nerdsniped ordex by providing just e=
nough interesting bits about SOCKS...
(21:50:30) ordex: :D
(21:50:33) ordex: I am fine with 3
(21:50:38) ordex: I was looking at the patch actually
(21:50:42) cron2: cool :-)
(21:50:43) ordex: seems easy to review
(21:56:09) mattock: ok, summary ready
(21:56:14) mattock: anything to discuss
(21:56:25) mattock: ?
(21:56:30) mattock: one topic
(21:56:38) mattock: so, I guess we could have a meeting next week
(21:56:43) mattock: actually
(21:56:44) cron2: yes
(21:56:53) cron2: we could do a halloween 2.4 release
(21:57:07) mattock: next week easily, but the week after next is already =
"almost-hackathon" Thursday
(21:57:21) cron2: we can skip that one
(21:57:23) mattock: yep
(21:57:34) mattock: we wanted to get tap-windows6 in, right?
(21:57:40) cron2: yes
(21:57:45) mattock: perhaps we need to do some pushing at selva :)
(21:58:19) mattock: if we aim for a halloweed release, that is
(21:58:58) mattock: one of the tap-windows6 PRs was waiting for his appro=
val which hanged on practical testing I believe
(21:59:36) cron2: yes
(21:59:38) mattock: anyways, do we aim for a 2.4 "halloween edition"?
(21:59:44) mattock: i.e. make it a goal
(21:59:49) cron2: I find the thought entertaining, so why not :-)
(21:59:56) mattock: well, there are worse reasons
(22:00:05) mattock: we need to make it a really scary release
(22:00:06) cron2: maybe remind people again to actually test your install=
er...
(22:00:11) mattock: break everyone's VPNs
(22:00:17) mattock: yup
(22:00:21) mattock: I will poke in the PRs
(22:00:23) cron2: I can do that :)
(22:00:34) mattock: ok that's even better
(22:00:42) mattock: which one lol? :)
(22:00:47) mattock: poke or break, or both?
(22:00:51) cron2: "break everyone's VPNs"
(22:00:59) mattock: ah
(22:01:01) mattock: that should be easy
(22:01:05) mattock: side-channel a patch in
(22:01:15) mattock: maybe only break IPv4 and nobody might not notice?
(22:01:53) cron2: just print out "OpenVPN Halloween Release... core dumpe=
d!" at startup, sleep(10) and then go on normally...
(22:03:21) mattock: +1
(22:03:25) mattock: ok, so I will poke at selva
(22:03:34) mattock: will aim at halloween release
(22:03:36) mattock: anything else?
(22:05:04) cron2: not from me today :)
(22:07:48) mattock: ok, let's conclude this meeting then
(22:07:56) mattock: I'll send the summary in a few mins
(22:08:26) cron2: good night :)
(22:11:12) mattock: good night!

--------------4D62A2FF47D32DACD1EBDFFD--

--bHfJERL4OlB6RXJS7V0qijzvXG1SwJv0I--

--QZBgTiwDHknZR7ynIzj6nS4vcuQmrpOSv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEbQT48bAXMRH0mXleKVhNn0CGRXgFAl2x980ACgkQKVhNn0CG
RXilawgApvXI+Ns3s+5Dj+xUQptxywwamhLh/bdArdDxd2Dy2VtKUR0wc0PhNiVP
9akpG/mzjcD5zFgOkzH6xiX3eJcblxzFuG4Zk9g73Be6OGo/ySSgAJf+6vOpzURZ
0YGRkPffTMZtfpPaCHL9cIpr5Y8Fxub4Qg7Qn9jqOieasCYYxBEI6Gn5G+wOTt3o
pMA9bKifK5gUfipiFtnLRxQcS6wl/sjHYLRv6aOJJQ2Nh/bhfm6xJZCgujYyuRwB
nG+SsxEALgo/GkRmvzzMTbPcLv7b7HUNu/37UohgP1/3woqefDkB2KIuByPn/m4+
OHfcqEQ9L9P9diZILJPy/s8uHreEbg==
=uu7v
-----END PGP SIGNATURE-----

--QZBgTiwDHknZR7ynIzj6nS4vcuQmrpOSv--

