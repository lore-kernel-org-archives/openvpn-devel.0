Date: Thu, 17 Jan 2019 17:18:19 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20190117161819.GG962@...1296...>
References: <20181010192337.6984-1-simon@...2293...>
 <20181016102627.18676-1-simon@...2293...>
 <20181016102627.18676-5-simon@...2293...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="nRdxYlb+wtBQb4U5"
Content-Disposition: inline
In-Reply-To: <20181016102627.18676-5-simon@...2293...>
Subject: Re: [Openvpn-devel] [PATCH 5/5] Detect TAP interfaces with
 root-enumerated hardware ID
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Simon Rozman <simon@...2293...>
Cc: openvpn-devel@lists.sourceforge.net

--nRdxYlb+wtBQb4U5
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Oct 16, 2018 at 12:26:27PM +0200, Simon Rozman wrote:
> This patch extends the TAP interface enumerating to detect the TAP
> interfaces registered using "root\tap0901" hardware ID. Before, only TAP
> interfaces with legacy "tap0901" HWID were detected by openvpn.exe.
>=20
> The openvpnmsica.dll and tapctl.exe install TAP interfaces using root-
> enumerated HWIDs, and were not detected by openvpn.exe.

I do not see a specific reason to *not* apply this patch, but I'm wondering
if you could shed some background light on the changed behaviour in
openvpnmsica.dll and tapctl.exe?

I'm not sure if we're going to care for someone who uses a 2.5 msi installer
to set up a TAP interface and then runs a 2.3 openvpn.exe on top of it and
wonders why it isn't finding the TAP driver - but the question might come
up, and I like having good answers... :-)

gert=20

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--nRdxYlb+wtBQb4U5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJcQKrKAAoJEB2Cnv7KVigSWdIMAIuXAZAh/YEZkUglPioCz8Ie
S9d1sonOOxQDZK1unnPhcplMkO+0it/s+Ckpg+9jBiUJKgSQESY93aA7MCcmzbTc
j3/VN4sDLWQ2eMNG9Oh6imcC8ZlubygtgHd6DaYkk3JjUC0xhDCSkV8zr1pXeUoG
xfGAs4a/KjupoqoeLR66BaccbVMFh89o64cxzv55PdybWL9sm/sonZgPFuRj/+vf
Hq9vE5FDkajLpRhbnfJOyOli+aK0wd/QQxy1u8nOaFvID4n5zfrEbeQzl2cCfdEa
+WTAXbJd0TiFnElTGwEE9pnpHlq7cbDl6HtvA/Kbo5+7fmCyPgZB+0WgUfE/97Lb
/B5zGBEtiwBrXggO573Mpe333/UNV+/yoqon0i9COinxyz+3XgsfjW95xTr04aro
KtLIEZxl4/nnvNaza2qtPVdk336nepheB57ECPmbYsbE/E85t90Hm7SDzNezBDy9
1XBHe+7Tq7FgE4dMK3MMs0YQL2K24J9CopC8xj5FbQ==
=xUEd
-----END PGP SIGNATURE-----

--nRdxYlb+wtBQb4U5--

