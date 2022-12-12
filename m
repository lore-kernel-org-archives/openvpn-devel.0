Date: Mon, 12 Dec 2022 13:32:47 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <Y5cfb1hc16JfcEX3@...1296...>
References: <20221126162648.150678-1-maximilian.fillinger@...2507...>
 <20221126162648.150678-2-maximilian.fillinger@...2507...>
 <Y5cYjSu0D5P4QMIZ@...1296...>
 <1e23d42e6ba74b27978d94f9012a0029@...2507...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="u9HhEkPoIeMSOEKP"
Content-Disposition: inline
In-Reply-To: <1e23d42e6ba74b27978d94f9012a0029@...2507...>
Subject: Re: [Openvpn-devel] [PATCH 2/2] Fix message for too long
 tls-crypt-v2 metadata
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Maximilian Fillinger <maximilian.fillinger@...2507...>
Cc: Gert Doering <gert@...1296...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--u9HhEkPoIeMSOEKP
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Dec 12, 2022 at 12:24:10PM +0000, Maximilian Fillinger wrote:
> Right now, openvpn just checks that we have at most 980 base64 characters
> and then tries to decode them into a 733 byte buffer. But 980 characters
> of base64 can encode up to 735 bytes. In that case, openvpn gives a fatal
> error about being unable to decode the base64 which I find misleading.
>=20
> My patch always allocates a large enough buffer to decode the base64 and
> checks that the decoded length is <=3D 733. An alternative would be to ch=
eck
> the base64 length, decode to a 735 bytes buffer, then check the decoded
> length. I thought it's cleaner to have one length check, but I don't have
> a strong opinion about this.

Thanks (to you and Arne, your mails arrived here about the same time) -=20
I was indeed confused about pre-decode / post-decode buffer size, and
padding.

Will proceed with merging as soon as I have the EEN patch out of the way.

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--u9HhEkPoIeMSOEKP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJjlx9vAAoJEB2Cnv7KVigSXS4L/1DEqsiG9jugvnSECFW+q0w4
MiwzvFPT5uns1TIasVNv7/aZkQiRfRVzESMA1vmNlJf01vROitVm6o1iTnismMLU
EaHiXii0bkJXL5DnBb5PXNzDj4tSCyMdKZvEegUAwMIayN8D4qlUDxITgYfBxr0d
r9X5tU97J8pmFHrJZ8BqmuU9G9uRiRpoDpuEsUC5inD/U1Cr504sAHpibz1Mqwbs
0lCypgvfR/yBne0wQlkAytv7bq325prUhOokpj/zoDwO930GNmyief+R3j0DBtOw
v8Do9jzHp1fwzRUi6HDnmBTyAGiikWlqvyjob4jbpMNToCy01f2ftdIzSASy0xbd
I4DqeaKYHjSrHZbOg2X/dBdsgb/p6vqSvAHb7MCYKpGcvbOoll4jDy8U0DCeDDxp
eZ0qLYr5sBAL9ohI1atrLMbDEVTCdA+noNfeauN2QwQKoZM3XP528Pv6uRjyL3v7
idGHq7TUzggaIBy6OLdtauBX+wk3PsOMS8nqq/y6uw==
=8bP8
-----END PGP SIGNATURE-----

--u9HhEkPoIeMSOEKP--

