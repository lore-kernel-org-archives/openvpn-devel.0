Date: Fri, 28 Oct 2022 08:46:41 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <Y1t60WGhceo8M6/I@...1296...>
References: <20221027160619.11894-1-selva.nair@...277...>
 <202210271902.29RJ2qTm038532@...2054...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="KDnNieg2zdFcoVP7"
Content-Disposition: inline
In-Reply-To: <202210271902.29RJ2qTm038532@...2054...>
Subject: Re: [Openvpn-devel] [PATCH applied] Re: Do not copy auth_token
 username to itself
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva Nair <selva.nair@...277...>
Cc: openvpn-devel@lists.sourceforge.net

--KDnNieg2zdFcoVP7
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

... and here we go:

On Thu, Oct 27, 2022 at 09:02:52PM +0200, Gert Doering wrote:
> Your patch has been applied to the master branch, for now - it needs
> to go to 2.5 as well, but we're right in the middle of a 2.5.8=20
> release, and I need to check with Samuli & Frank if anything has been
> done already that would cause havoc if I change the (preliminary)
> v2.5.8 tag...
>=20
> commit dbf142ffe597b21aa09a47677ea2061b74a9354e
  commit cd50cf021bcfb797b6dacbe853e4c08b21a8e89d (release/2.5)

briefly tested in a setup with username+password and token, things
still work :-) - v2.5.8 has been updated, so this is in.

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--KDnNieg2zdFcoVP7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJjW3rRAAoJEB2Cnv7KVigSLl8MAIcL0IwJo8wCxeek7+32sfqf
IgV85xgn/nftSqkJBoe+9uxGVZkeRBW3AumdVSwma52o44c2X2SG8LmUaLoGhzqs
bwWM2kgd8BHzXghUZQG8czu+EtL0XdDcgWItuZGb2XqNnYIHTMzYTkDV8zL+/hdC
y2/JVvdTIqm22FrUW9qqiMAv6QYpfjb1ZUi0qdk+R2oPAmSqSnCAEyH3gIC5c6IR
7L2XMEasukS7fcxbxqczT/dhj/JvLr5LjZjqopiSPtiXdAjUTFeYl7OK6CVZfAUo
SB1XfHzYm7eg+Z+05EcLFIX/rlwzQ//9hGTU94SdWOcsE5I/GP7XnBHNCXQgWIDQ
A6ISXj9SB6kY5Ppuoo5diTNzGEZBuqkafRxG74LOwgpm30vcmLJ53ipg90fTXh32
hHHkhSxXInqzqIZwGekeEDDRhbJvXWE1xae7HOJO9x4w2elXyJ+Id+dd/AlnfARX
6hgYcXMk89sVkv6dfZjBPK4bDjosVS7CqMZ3sDyHTQ==
=P0T1
-----END PGP SIGNATURE-----

--KDnNieg2zdFcoVP7--

