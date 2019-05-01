From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
References: <796722c6-e08b-6de4-67aa-6f2ecc21623e@...515...>
Message-ID: <03f9948e-b856-87b1-4b21-610f981a289d@...515...>
Date: Wed, 1 May 2019 13:00:20 +0300
MIME-Version: 1.0
In-Reply-To: <796722c6-e08b-6de4-67aa-6f2ecc21623e@...515...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="WX9geKHufbBkQUhNkiTQRlwjrgNy42Mxu"
Subject: [Openvpn-devel] Summary of the community meeting (1st May 2019)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--WX9geKHufbBkQUhNkiTQRlwjrgNy42Mxu
Content-Type: multipart/mixed; boundary="Tpb5dMZFuR57Yl09dtn241ZtfgG5ClsYC";
 protected-headers="v1"
From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
To: openvpn-devel@lists.sourceforge.net
Message-ID: <03f9948e-b856-87b1-4b21-610f981a289d@...515...>
Subject: Summary of the community meeting (1st May 2019)
References: <796722c6-e08b-6de4-67aa-6f2ecc21623e@...515...>
In-Reply-To: <796722c6-e08b-6de4-67aa-6f2ecc21623e@...515...>

--Tpb5dMZFuR57Yl09dtn241ZtfgG5ClsYC
Content-Type: multipart/mixed;
 boundary="------------999879C0CCD4AFFB3DC97C5D"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------999879C0CCD4AFFB3DC97C5D
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable

Hi,

Here's the summary of the IRC meeting.

---

COMMUNITY MEETING

Place: #openvpn-meeting on irc.freenode.net
Date: Wednesday 1st May 2019
Time: 11:30 CEST (9:30 UTC)

Planned meeting topics for this meeting were here:

<https://community.openvpn.net/openvpn/wiki/Topics-2019-05-01>

Your local meeting time is easy to check from services such as

<http://www.timeanddate.com/worldclock>

SUMMARY

cron2, erict, janjust and mattock participated in this meeting.

--

Discussed tap-windows6 HLK testing. Mattock started work on the HLK
testing setup again. Based on discussion with zx2c4 and rozmansi we can
probably get away with two signature sets - cross-signed and WHQL.
Pulling that off apparently requires three different HLK clients:

- Windows Server 2019 (64-bit),
- Windows Server 2019 core (64-bit)
- Windows 10 desktop (32-bit)

Covering all these with a single signature simplifies the installer part
quite a bit. Which of these HLK client can or can't be virtual is a
mystery. The wintun driver did not require any physical HLK clients, but
tap-windows6 test scope is much wider, so nobody knows the answer.

The older Windows platforms are happy with cross-signed drivers.

--

Noted that there were no updates on OpenVPN 2.5. Also noted that
reviewing patches in Patchwork was not possible as most of the devs were
not present in this meeting.

--

Noted that the OpenVPN 2.5 mini-hackathon is on the upcoming Friday
(starts in the CEST morning).

--

Full chatlog attached.


--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock


--------------999879C0CCD4AFFB3DC97C5D
Content-Type: text/plain; charset=UTF-8;
 name="openvpn_irc_meeting_chatlog_2019-05-01.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="openvpn_irc_meeting_chatlog_2019-05-01.txt"

(12:27:52) mattock: hi all!
(12:27:58) cron2_: mattockman!
(12:28:08) cron2_: so, how's your picknick?
(12:28:27) mattock: not that far yet, so I can be fairly present while do=
ing preparations
(12:28:50) mattock: we don't have any particular agendat today: https://c=
ommunity.openvpn.net/openvpn/wiki/Topics-2019-05-01
(12:28:52) vpnHelper: Title: Topics-2019-05-01 =E2=80=93 OpenVPN Communit=
y (at community.openvpn.net)
(12:29:17) mattock: chipitsine wanted to discuss enabling cirrus-ci at so=
me point
(12:29:30) mattock: I'm not opposed if it is about flipping a switch in G=
itHub and getting a bit more testing that way
(12:29:39) cron2_: I think we're waiting for a reason why we'd want that.=
=2E.
(12:29:58) mattock: tap-windows6 vise I started building the HLK testing =
setup
(12:30:31) mattock: also, based on discussion with zx2c4 and rozmansi we =
can probably get away with two signature sets - cross-signed and whql
(12:31:04) erict [b4966b98@...2315.../web/freenode/ip.180.150.107.152] =C3=A8=
 entrato nella stanza.
(12:31:22) mattock: pulling that off apparently requires three different =
HLK clients: one Windows Server 2019 (64-bit), one Windows Server 2019 co=
re (64-bit), one Windows 10 desktop (32-bit)
(12:31:32) mattock: so the installer part would be simplified quite a bit=

(12:31:44) mattock: our HLK setup is not up-to-par with this yet, but we =
can make it so
(12:31:53) mattock: which of these can or can't be virtual is a mystery
(12:32:27) mattock: wintun driver did not require any physical HLK client=
s, but tap-windows6 test scope is much wider, so nobody probably has the =
answer
(12:32:38) mattock: that's all about tap-windows6 from my end
(12:32:55) cron2_: thanks :-) - good to hear you're making progress behin=
d the scenes
(12:34:12) mattock: janjust: btw. I don't seem to have your mailing addre=
ss for the T-shirt (in case you're here)
(12:34:25) janjust: mattock1, I will send it in private
(12:36:21) mattock: ecrist as well btw :)
(12:36:32) mattock: ok, next topic?
(12:37:15) janjust: just a quick question:  I had an off-list discussion =
with dazo & syzzer about the command line option --genkey
(12:37:26) janjust: I proposed to write a patch for it - would that be in=
 time for 2.5?
(12:37:39) cron2_: the sooner the better
(12:37:48) janjust: I'll get on it
(12:37:56) cron2_: there are a number of patches waiting for a decision a=
nd code for that...
(12:38:13) cron2_: (the auth-token-patchset from plaisthos is one of them=
)
(12:38:27) erict: Hey all, just wanted to pop in and see if anyones had a=
 chance to have a look at the "Send auth fail to client on reneg failure"=
 and arne's auth-token patchset
(12:39:01) cron2_: erict: that's all pending and waiting for some final w=
ord on the --genkey bits
(12:39:15) erict: no worries, cheers
(12:39:28) cron2_: dazo and plaisthos (arne) had long discussions on that=
, and i'm not sure they settled... but both are not here today
(12:40:17) mattock: ecrist: PM me your mailing address to receive your T-=
shirt :)
(12:40:29) mattock: oh wrong person I guess, misread :)
(12:40:38) mattock: erict is probably too far from ecrist to be a typo? :=
P
(12:41:00) cron2_: since ecrist never makes it to a meeting, I think so :=
-)
(12:41:08) erict: oh was that aimed at me?
(12:41:23) cron2_: erict: only if you happen to be ecrist :)
(12:41:40) erict: I do not :)
(12:41:49) janjust: I misread his name too  :)
(12:43:21) cron2_: human reading error correction is fairly amazing
(12:43:26) mattock: indeed
(12:46:58) mattock: ok next topic?
(12:47:18) cron2_: this is going to be a short meeting :)
(12:47:36) mattock: short meeting is always a good meeting :)
(12:47:46) ***cron2_ has no update on 2.5, and none of the usual suspects=
 are here to discuss patchwork...
(12:48:02) cron2_: but I stick to my plan for "this friday is reserved fo=
r OpenVPN work", so maybe it works out
(12:48:18) mattock: yes we must not forget
(12:48:22) mattock: I have it in my calendar
(12:48:40) mattock: I'll probably work on HLK though, but I will be avail=
able if anyone needs someone
(12:48:42) cron2_: cool
(12:49:43) mattock: end of meeting then!
(12:49:56) cron2_: yep :-) - see you on Friday!
(12:50:02) mattock: you too! bye all!
(12:50:08) cron2_: *wave*
(12:50:25) janjust: that was quick ;)

--------------999879C0CCD4AFFB3DC97C5D--

--Tpb5dMZFuR57Yl09dtn241ZtfgG5ClsYC--

--WX9geKHufbBkQUhNkiTQRlwjrgNy42Mxu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEbQT48bAXMRH0mXleKVhNn0CGRXgFAlzJbjQACgkQKVhNn0CG
RXj43Af8Cxzq9iCGFmZ4gOvmm/le4PqIC6B4/i38qVlm2I4TMGufNH4KM3RB0CsM
kxlgpj4LsAhib51zzeIdOJwr+bpFVza8PM8JRMWNK+7OYjpWpB0uyEVwyfHD7blU
SIC49NfqOyarVA9WEEuyxpe6qxovzVaxMdpY5Dti2LixmZHJbZSVCWLb5A1ulBYW
tXN/qCk4wuNMJlBFkOoc0GR1jZnjaRS7jXi9xMgVDXN4FADme1QeiKS2i0xGnTAU
7T6JiqsbMxf3nmn3D640SBfmtIQLF8UKknxlDWVDrHFTcQ8q11uX14RafWsAF8iH
hrh0GH7llHA3X5dyZr0yOcTW8l7eQg==
=8Viy
-----END PGP SIGNATURE-----

--WX9geKHufbBkQUhNkiTQRlwjrgNy42Mxu--

