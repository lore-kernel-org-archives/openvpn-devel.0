References: <b775444a-aaf6-4e93-5f9c-338ec105eaee@...515...>
	<88a33ea9-ef60-0378-b39e-ffb5c945e4ae@...515...>
From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
Message-ID: <109a5348-75aa-e85d-425e-118db4eb4c84@...515...>
Date: Wed, 15 Mar 2017 21:39:43 +0200
MIME-Version: 1.0
In-Reply-To: <88a33ea9-ef60-0378-b39e-ffb5c945e4ae@...515...>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="wEjRv1t5HCq7Pqe1TjgtSkpcGaEMFLOMN"
Subject: [Openvpn-devel] Summary of today's (Wed,
	15th Mar 2017) community meeting
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--wEjRv1t5HCq7Pqe1TjgtSkpcGaEMFLOMN
Content-Type: multipart/mixed; boundary="------------EB16BD615831215A9C0DA6D0"

This is a multi-part message in MIME format.
--------------EB16BD615831215A9C0DA6D0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

Hi,

Here's the summary of today's IRC meeting.

---

COMMUNITY MEETING

Place: #openvpn-meeting on irc.freenode.net
Date: Wednesday 15th Mar 2017
Time: 20:00 CET (19:00 UTC)

Planned meeting topics for this meeting were here:

<https://community.openvpn.net/openvpn/wiki/Topics-2017-03-15>

The next meeting has not been scheduled yet.

Your local meeting time is easy to check from services such as

<http://www.timeanddate.com/worldclock>

SUMMARY

cron2, mattock and syzzer participated in this meeting.

--

Discussed the OpenVPN 2.4.1 release. Agreed to make the release the
upcoming Monday (20th March). The OpenSSL support patches will have to
be postponed to 2.4.2.

--

Discussed the VLAN patchset:

<https://github.com/OpenVPN/openvpn/pull/76>

Agreed that it is too big a chunk to tackle right now.

---

Full chatlog has been attached to this email.

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock


--------------EB16BD615831215A9C0DA6D0
Content-Type: text/plain; charset=UTF-8;
	name="openvpn_irc_meeting_chatlog_2017-03-15.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="openvpn_irc_meeting_chatlog_2017-03-15.txt"

(21:05:12) mattock: hello all
(21:05:17) syzzer: hi mattock=20
(21:05:26) cron2: ullo
(21:05:48) syzzer: what language is that? :p
(21:06:46) mattock: :)
(21:07:16) mattock: https://community.openvpn.net/openvpn/wiki/Topics-201=
7-03-15
(21:07:17) vpnHelper: Title: Topics-2017-03-15 =E2=80=93 OpenVPN Communit=
y (at community.openvpn.net)
(21:07:27) mattock: start from the top?
(21:07:29) mattock: 2.4.1
(21:07:40) cron2: right
(21:08:21) cron2: 3 weeks ago, we planned for a release "in about two wee=
ks", then mattock went hiding :)
(21:08:43) mattock: well you could say so, yes
(21:08:46) mattock: but not because of 2.4.1 :P
(21:08:54) cron2: I would say "we agree whether we want the --ns-cert-typ=
e deprecation patch in, and then release" - anything else missing?
(21:08:57) mattock: it was vacation to which I was forced to :D
(21:09:03) cron2: poor guy :)
(21:09:47) syzzer: yeah, it kind of depends on the --ns-cert-type
(21:10:14) cron2: syzzer: how's the "we make --remote-cert-tls work with =
funky CAs" patch coming along?
(21:10:26) syzzer: cron2: sort-of ready, but not well tested yet
(21:12:11) cron2: does it make sense to release 2.4.1 with just one of th=
em?  I know that my users will then try the other option, and fail...
(21:14:49) syzzer: so, what I think we should do wrt --ns-cert-type / --r=
emote-cert-tls is:
(21:14:49) syzzer: 1) Change --remote-cert-tls to require a specific EKU,=
 but only *some* KU in the certificate, and let the crypto library check =
KU on its own (which both mbed TLS and OpenSSL do, but only if the extens=
ion is present)
(21:14:49) syzzer: 2) Deprecate --ns-cert-type
(21:14:50) syzzer: 3) release 2.4.1
(21:14:50) syzzer: 3) in 2.4.2+, change --ns-cert-type to just to what --=
remote-cert-tls does
(21:15:27) syzzer: where the last 3 should of course be a 4
(21:15:45) cron2: I guessed so :-) - so with 1), my funky CA would work a=
gain?
(21:15:52) syzzer: indeed
(21:16:11) cron2: works for me... do you have an estimate how long 1) wil=
l take?
(21:16:23) syzzer: it basically makes --remote-cert-tls less picky (it is=
 now way more strict than it should be)
(21:16:44) syzzer: if we don't quarrel too much, I can get the patch out =
tonight
(21:17:35) cron2: sounds good :-) - mattock: any time that would be parti=
cularily convenient/inconvenient for you for a release?
(21:18:33) mattock: not in particular
(21:18:44) mattock: except weekends :)
(21:19:08) mattock: better do it on Monday, just in case
(21:19:17) mattock: rather than Friday
(21:19:47) cron2: shall we aim for "next monday", then?  And I'll go over=
 the bug list until then to see whether I've missed something important
(21:19:56) cron2: AFAIK all stuff from Selva got in
(21:19:59) mattock: fine by me
(21:20:23) syzzer: yeah, for me too
(21:20:43) cron2: (and we should send a reminder to the -devel list "if y=
ou are aware of anything bugfixy that should go in, remind gert!")
(21:20:55) cron2: so - openssl 1.1 support patches
(21:21:33) cron2: about half the stuff is in, 05 has started a discussion=
 syzzer/dazo which got stuck
(21:23:20) mattock: dazo will be more or less absent for the the next two=
 weeks (his own words)
(21:24:02) syzzer: yeah, this basically got stuck on the --ns-cert-type s=
tuff
(21:24:33) syzzer: and I got side tracked by our current --remote-cert-tl=
s implementation
(21:25:20) cron2: ok, so we just postpone until that is settled, and then=
 maybe we can discuss with more technical arguments about the (new) impac=
t...
(21:25:55) syzzer: indeed :)
(21:26:06) syzzer: I'll continue with other patches if possible
(21:26:21) ***cron2 stands ready to test & merge :)
(21:26:37) cron2: that concludes 2., I think...=20
(21:26:58) syzzer: yep, think so too
(21:27:04) mattock: so do we postpone 2.4.1, or postpone the OpenSSL 1.1 =
patches to 2.4.2?
(21:27:11) syzzer: the latter
(21:27:12) cron2: mattock: the latter
(21:27:13) mattock: ok
(21:27:46) cron2: the way they are coded and merged mean they can go on o=
ne by one, with no negative impact on 1.0 builds - and when they are all =
in, we magically are 1.1 compatible
(21:27:50) mattock: 2.4.2 might get some patches related to the security =
audit, then
(21:28:16) cron2: indeed, so maybe 2.4.2 will follow quickly after 2.4.1 =
- and openssl 1.1 will be in 2.4.3 - we'll see :-)
(21:28:21) mattock: yeah
(21:28:31) ***cron2 is VERY curious what they have found
(21:28:32) mattock: so then we only have the long-term topic of VLAN patc=
hset
(21:28:36) mattock: yeah, me too
(21:28:54) syzzer: uhuh
(21:29:13) cron2: I have nothing new to contribute to that :-( - no time =
to work on such a big chunk
(21:29:22) mattock: yeah, it's a hanful
(21:29:24) mattock: handful
(21:29:46) mattock: plus, as cron2 so nicely said once, "all features hav=
e their merits, and then it blows up"
(21:29:50) mattock: or something along those lines :P
(21:30:19) cron2: it has blown up years ago, and then James ran away scre=
aming :-)
(21:30:46) mattock: well put
(21:30:47) cron2: "wouldn't it be much nicer to have a small and compact =
openvpn client library with just the important options?" ;-)
(21:30:58) mattock: indeed
(21:31:09) mattock: until enough features are added, and then it's a garb=
age dump again
(21:31:19) cron2: it's not completely true, though... but we indeed inher=
ited quite a list of features :)
(21:31:50) mattock: well OpenVPN 2.x is extremely stable all things consi=
dered
(21:32:20) mattock: anyways, any other topics for today?
(21:32:30) mattock: or was this really a 27 minute meeting?
(21:32:47) cron2: true... no other topics from me (there's the --auth-noc=
ache patch, but all we can do today is "remind people that it needs revie=
w and testing!")
(21:33:05) syzzer: nothing from my side either
(21:33:09) mattock: ok, great!
(21:33:19) cron2: so, let's conclude the meeting and go work on the patch=
es :-)
(21:33:23) mattock: +1
(21:33:32) cron2: $wife is out anyway, kids are sleeping...
(21:33:52) mattock: good hacking!
(21:33:59) cron2: good night!
(21:34:15) mattock: and good night!
(21:34:27) syzzer: good night!

--------------EB16BD615831215A9C0DA6D0
Content-Type: application/pgp-keys;
 name="0x40864578.asc"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="0x40864578.asc"

-----BEGIN PGP PUBLIC KEY BLOCK-----
Version: GnuPG v2

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
XuwT7RpGDZ6jBfphYQ=3D=3D
=3DFKLE
-----END PGP PUBLIC KEY BLOCK-----

--------------EB16BD615831215A9C0DA6D0--

--wEjRv1t5HCq7Pqe1TjgtSkpcGaEMFLOMN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJYyZh/AAoJEClYTZ9AhkV4Z7IH/iA4PEjNbHogY7zb+1ZqZQrl
Gea+pmqDUisHsbk2hUkW1zhLgKEEm4Pu1fh/TaAzveicRXkFYN5Gxso/sIZxHJWu
sCzt/k9IbtN7Epp9Y1Igf8sBfeBH+0Gf6rh40T+ta2R+0al9G+1tuJUrtJOAq+P6
2nkWjAXdoT1mCQI3hahlWk45xDtPYFyndWs0lDSoNJK0k39x5Sj4a+Blc18oZ85Z
GQl8vAEmwKn962liuCp2AnGajJcf3mRsJcHpREDSLWjaiE/fBXxUa0GE9puKvfaj
6yIY0Q29wL7G5bVX/vj2pcnKMAOnuaxE2xaF+V73q05RdDzLWrNjMAfZ6JZTTck=
=/7zn
-----END PGP SIGNATURE-----

--wEjRv1t5HCq7Pqe1TjgtSkpcGaEMFLOMN--

