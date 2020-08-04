References: <20200729113835.2415-1-arne@...1227...>
 <20200804202010.GV75094@...1296...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <b8c90764-96e4-6e6d-2060-ee3d84cb446d@...1227...>
Date: Wed, 5 Aug 2020 00:20:54 +0200
MIME-Version: 1.0
In-Reply-To: <20200804202010.GV75094@...1296...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="TmM5vJUpsQEwJ7lspnjLFy7utJLdiAZUu"
Subject: Re: [Openvpn-devel] [PATCH v2] Rework NCP compability logic and
 drop BF-CBC support by default
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--TmM5vJUpsQEwJ7lspnjLFy7utJLdiAZUu
Content-Type: multipart/mixed; boundary="liH7ktXw9eVoQKtD95Wlv1BszRILCyTPJ"

--liH7ktXw9eVoQKtD95Wlv1BszRILCyTPJ
Content-Language: en-GB
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable


>=20
> I'm not exactly sure what the code *does*, TBH, but de-fusing the check
> into
>=20
>     if (remote_cipher =3D=3D NULL=20
>         || (peer_info && strstr(peer_info, "IV_CIPHERS=3D") ))
>=20
> makes it no longer crash (and also pass the unit test).


Yes that is the right fix. My test client client had a push-peer-info in
it so I didn't catch this. :(


>=20
> This patch also breaks connections from "default 2.3" clients, though in =
a=20
> different way:
>=20
> Aug  4 21:56:25 gentoo tun-udp-p2mp-112-mask[25184]: cron2-freebsd-tc-amd=
64-23/194.97.140.21:48168 PUSH: No common cipher between server and client.=
 Server data-ciphers: 'AES-256-GCM:AES-128-GCM', client supports cipher 'BF=
-CBC'
> ug  4 21:56:27 gentoo tun-udp-p2mp-112-mask[25184]: cron2-freebsd-tc-amd6=
4-23/194.97.140.21:48168 SENT CONTROL [cron2-freebsd-tc-amd64-23]: 'AUTH_FA=
ILED,Data channel cipher negotiation failed (no shared cipher)' (status=3D1)
>=20
> this is a server that has *no* "--cipher" in its config, and a client
> that has nothing either and no NCP - so it advertises "OCC cipher bf-cbc",
> which is no longer accepted on the server.
>=20
> Is that intentional?

Yes. That is intentional. If you do not have any cipher option in the
config, there is nowadays a very high change that you allow BF-CBC by
"accident". I encountered this first-hand ("I do want to put as few
option in a config as possible").

Since 2.4 only warns about SWEET32/BF-CBC being if you actually
negotiate it (i.e. talking to a 2.3 client/server), many of these
probably were not even aware that they allowed BF-CBC.

If you really want BF-CBC with the new patch you need to either add it
to data-ciphers or explicitly set --cipher BF-CBC (that adds it to
data-cipher and data-ciphers-fallback).

When I am back from vacation, I can send a patch with better wording to
Changes.rst:

Removal of BF-CBC support in default configuratio:
- By default OpenVPN 2.5 will only accept AES-256-GCM and AES-128-GCM as
data ciphers. OpenVPN 2.4 allows AES-256-GCM,AES-128-GCM and BF-CBC when
no --cipher and --ncp-ption were present. Accepting BF-CBC can be
enabled by adding

    data-ciphers AES-256-GCM:AES-128-GCM:BF-CBC

for very old peers also

    data-ciphers-fallback BF-CBC

to offer backwards compatiblity with older config an *explicit*

    cipher BF-CBC

in the configuration will be automatically translated in the two
commands above. We strongly recommend to switching away from BF-CBC to a
more secure cipher.

Arne



--liH7ktXw9eVoQKtD95Wlv1BszRILCyTPJ--

--TmM5vJUpsQEwJ7lspnjLFy7utJLdiAZUu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE88wmPb+Azu8xbws3FRhsZwKxRFQFAl8p30YACgkQFRhsZwKx
RFTA2xAApDuRXFsOrJpKtjfumv37E696IN2d3IOpN82mXmTYGiLnJL0EmuaJBSjn
R+jQgZjHJFU28uGTq1aczG2MKtHYkuONgDNN97UE+AaTjJaDm2WbfGhOMVw7n8Pr
gi64l59pT5bSNb8xqvtA3HRAa8ONWH88626ntdVePHWcLvRRVmy/pZ24D0Jhhqn0
eOTVQsGTo0XKkp34QVoVyejSJqmh24zHmGlMU+//LDQ1mU3I24B3AY/rQM+Mhi1U
go/RXyhdBOZo+H8S2os33SXM4DMANI7Zn8ZPVCLZrjCQjEXuFm82CCo1DA2OzFQ2
BvggoEqAay67OBWf+9ZFFrGSh/aiTGF/0nFvwPi0HMn3MRSBkUDa/hpvfDuz8SbK
FUOxrT2BEUUyCEaZnb5jZT2rpLbCyqOD4RkSBRbDyHYtCkJ1aryb8lLISszV8GmE
TalSaoUe/Jvl66oLlGJjJSlJ+8i1HRaCWb0+sSf6nPGV+EG+cQd55gxSLjxbRXE8
iwdROy8NaBG51JTzqDOuCzjh/OD5whPcTMoyIGMpDYlN2urpwQxCsZyJZawO25+K
vExGah9b1pWNnt3sQUkrsrcrOlHtsXVZOmuSz47wZkVjh2XmwudxVS8fsPeDZefs
g5h8ZbzcYqEzpVxX2x5AoyyOZLjWjbla613W76rCgco8+1KfIJk=
=s+yX
-----END PGP SIGNATURE-----

--TmM5vJUpsQEwJ7lspnjLFy7utJLdiAZUu--

