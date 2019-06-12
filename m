From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
References: <e55f098a-1ba1-02d7-5f50-b12e4eec054a@...515...>
Message-ID: <5a62f76f-0560-89f5-b398-00c349ae6c7b@...515...>
Date: Wed, 12 Jun 2019 13:16:23 +0300
MIME-Version: 1.0
In-Reply-To: <e55f098a-1ba1-02d7-5f50-b12e4eec054a@...515...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="QoOJ4jWpYJwzhD3klEor4aLxlpnSiNfCS"
Subject: [Openvpn-devel] Summary of the community meeting (12th June 2019)
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
--QoOJ4jWpYJwzhD3klEor4aLxlpnSiNfCS
Content-Type: multipart/mixed; boundary="6NbyNzXkxmUj80bMuqR5Iq4NEPIBoWSEw";
 protected-headers="v1"
From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
To: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Message-ID: <5a62f76f-0560-89f5-b398-00c349ae6c7b@...515...>
Subject: Summary of the community meeting (12th June 2019)
References: <e55f098a-1ba1-02d7-5f50-b12e4eec054a@...515...>
In-Reply-To: <e55f098a-1ba1-02d7-5f50-b12e4eec054a@...515...>

--6NbyNzXkxmUj80bMuqR5Iq4NEPIBoWSEw
Content-Type: multipart/mixed;
 boundary="------------633CE9C94EB072993CA26FF0"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------633CE9C94EB072993CA26FF0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable

Hi,

Here's the summary of the IRC meeting.

---

COMMUNITY MEETING

Place: #openvpn-meeting on irc.freenode.net
Date: Wednesday 12th June 2019
Time: 11:30 CEST (9:30 UTC)

Planned meeting topics for this meeting were here:

<https://community.openvpn.net/openvpn/wiki/Topics-2019-06-12>

Your local meeting time is easy to check from services such as

<http://www.timeanddate.com/worldclock>

SUMMARY

dazo, lev, mattock, ordex and syzzer participated in this meeting.

---

Mattock gave an update on tap-windows6 HLK testing. The physical HLK
environment is working well. There a couple of odd-duck test failures
(=3Dreason unknown/not looked into yet) as well as a few known issues
(=3Dsolution known). Some of the tests that have failed are not even
mandatory (e.g. "Static tools logo test"). A server 2019 Core HLK client
is needed to pass the "Operating in Server Core" test.

---

Mattock relayed an update from OSTIF.  The Operator Foundation should be
able to complete the obfs4, shadowsocks, and meek1 plugins (for OpenVPN)
by the end of October.

--

Talked about OpenVPN 2.x, and testing in particular. User/pass auth
testing has started to become quite complex. In that area more automated
testing would be good. Also, testing (things through) the management
interface would be a nice addition.

--

Full chatlog attached.

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock

--------------633CE9C94EB072993CA26FF0
Content-Type: text/plain; charset=UTF-8;
 name="openvpn_irc_meeting_chatlog_2019-06-12.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="openvpn_irc_meeting_chatlog_2019-06-12.txt"

(12:35:24) mattock: hi!
(12:35:44) lev__: hi
(12:37:51) ordex: hi mattock1=20
(12:37:51) ordex: :)
(12:38:17) dazo ha scelto come argomento: Next meeting 20/June/2019 at 20=
:00 CEST.  Agenda at https://community.openvpn.net/openvpn/wiki/Topics-20=
19-06-12
(12:38:45) dazo: hopefully at least 1 of 2 of the information parts will =
be valid next week :-P
(12:39:48) mattock: hi guys!
(12:39:58) mattock: let's check the agenda
(12:40:10) dazo: #1 tap-windows6 update :)
(12:40:17) mattock: https://community.openvpn.net/openvpn/wiki/Topics-201=
9-06-12
(12:40:19) vpnHelper: Title: Topics-2019-06-12 =E2=80=93 OpenVPN Communit=
y (at community.openvpn.net)
(12:40:37) mattock: so, I've slowly worked through most of the tests
(12:40:57) mattock: there are a couple of odd ducks (=3Dunknown issues) w=
hich I need to look into
(12:41:18) mattock: plus those tests which are known to fail without some=
 special setup
(12:41:46) mattock: plus "Operate in Server Core" requires a Server 2019 =
Core installation
(12:41:51) mattock: =3DHLK client
(12:42:18) mattock: then I also need to verify which of the tests are act=
ually mandatory (e.g. static tools logo test is failing, but it is not ma=
ndatory)
(12:43:32) mattock: so, looking good, and I _hope_ the remaining failures=
 can be resolved this week
(12:44:30) mattock: the physical HLK test environment seems to work well
(12:44:46) mattock: that's all there is about tap-windows6 at my end
(12:46:02) mattock: I have an update from OSTIF btw
(12:46:20) mattock: maybe that would work as topic #2
(12:46:43) syzzer: at least decent progress on the tap-windows side, that=
's nice :)
(12:46:55) syzzer: what's with OSTIF?
(12:47:03) mattock: syzzer: yeah, though it is not done until it is done =
:)
(12:47:17) mattock: first of all, the wanted to thank ordex for his work
(12:47:29) dazo: syzzer: https://ostif.org/
(12:47:32) vpnHelper: Title: OSTIF.org Open Source Technology Improvement=
 Fund (at ostif.org)
(12:47:47) mattock: "obfs4, shadowsocks, and meek1 plugins should be comp=
leted by the end of October"
(12:47:56) dazo: nice!
(12:48:11) ordex: mattock1: what for exactly ?
(12:48:32) mattock: OpenVPN I assume
(12:48:46) ordex: ah "they"
(12:49:12) mattock: so operator foundation is working on this stuff
(12:49:16) ordex: ah ok
(12:49:26) ordex: tthen yeah, it's related to the jigsaw project
(12:49:41) ordex: that I am trying to get merged
(12:49:48) mattock: yeah
(12:50:13) mattock: so things seem to be moving forward there, which is g=
ood
(12:50:13) ordex: okok
(12:50:30) mattock: so, speaking of progress
(12:50:41) mattock: anything we should/can discuss regarding openvpn 2.5?=

(12:51:09) syzzer: not from my side
(12:53:09) ordex: I briefly discussed with dazo how to change the makefil=
e to fix the t_net.sh issue we have now in master
(12:53:21) ordex: so I should fix that soon after I try it locally
(12:53:47) mattock: ok good!
(12:53:49) dazo: I'll be available to help out there anytime
(12:54:09) ordex: ok!
(12:54:36) ordex: cron2 also merged most of the sitnl patches, and he com=
mented on something, so I will try to wrap those changes in a new patch a=
fter I fix the Makefile
(12:55:31) dazo: I'm hoping to get a chance to complete the review of the=
 auth-token-hmac patches as well in coming days
(12:56:37) dazo: I've tested them fairly thoroughly and it works as expec=
ted.  But will need to run a few extra tests using auth-plugins (only tes=
ted with --auth-user-pass-verify so far)
(12:57:55) dazo: But user/pass auth testing is growing in complexity, as =
we have quite a few ways how to do that now ... and I still haven't reall=
y thought about how to test the same features using the management interf=
ace
(13:01:06) mattock: how do we test that now?
(13:01:13) mattock: "stare with eye" only?
(13:02:13) dazo: I have some test scripts ... and for the new features pl=
aisthos introduces, I need to write a simple auth-plugin .... management =
interface is mostly untested from community side, but it is used by the A=
ccess Server
(13:02:43) mattock: plus openvpn-gui etc
(13:03:07) dazo: yeah, but not for server side user authentication
(13:03:39) mattock: yeah
(13:04:09) mattock: do we have any tests in openvpn 2 for testing the man=
agement interface?
(13:04:27) mattock: or "testing things by using the management interface"=

(13:04:42) dazo: I've done sporadic tests using the management interface =
manually
(13:04:54) dazo: but nothing consistent or automated
(13:05:10) ordex: I don't think we have any script testing that
(13:05:46) mattock: would be "nice to have"
(13:05:56) dazo: yeah
(13:07:11) mattock: anything else on 2.5/testing?
(13:08:51) ordex: not on my side
(13:09:01) mattock: any other topics?
(13:12:40) ordex: maybe not ? :D
(13:13:22) mattock: sounds good :)
(13:13:48) syzzer: well, lunch time then :)
(13:13:52) dazo: :)
(13:14:01) mattock: enjoy, I already ate :)
(13:14:11) mattock: thursday next week then

--------------633CE9C94EB072993CA26FF0--

--6NbyNzXkxmUj80bMuqR5Iq4NEPIBoWSEw--

--QoOJ4jWpYJwzhD3klEor4aLxlpnSiNfCS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEbQT48bAXMRH0mXleKVhNn0CGRXgFAl0A0PgACgkQKVhNn0CG
RXh2NAgApH0YZIP2qwycaQIoXU1eCtCYBEkJw0LrkrsZBw8DWy8QZaLUCMCbqgoE
rqnkEuAHt3vFULx6Wj8s1LWWeeIx0ggJ7R8ra4ljO3uiafG6zPYHEwQD0ImdxEBJ
SjkO7b+DOBQCzHQLzQOmg2abQRKTYcSk8BH8BXUCtc8PwutZd9FI1j8e1UKWqb13
ecTE1LKK00FiL4NAQcSNgWjmBsSDTpP7pTlh+n0PlrtKk0BsVooDe8R72MS057RV
4pbA+vBYurs8TS0tvSFTYZS6JHQ1pqZMuky3ysowLfzg6pf0kutcOK3shEPYku3C
ZtNkvxzuSkl4MNWcc6pnnDRfHJLK0g==
=Lu2n
-----END PGP SIGNATURE-----

--QoOJ4jWpYJwzhD3klEor4aLxlpnSiNfCS--

