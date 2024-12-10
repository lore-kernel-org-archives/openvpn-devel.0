Date: Tue, 10 Dec 2024 10:33:15 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <Z1gK22dVjc5kzKg4@...1296...>
References: <gerrit.1731290343000.I74216d776d3e0a8dc987ec7b1671c8e8dcccdbd6@...2715...>
 <20241209210956.13536-1-gert@...1296...>
 <c21582dc-4dff-443a-978e-da89b1fd057e@...2181...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="vyKhFsN7RNnX5a8g"
Content-Disposition: inline
In-Reply-To: <c21582dc-4dff-443a-978e-da89b1fd057e@...2181...>
Subject: Re: [Openvpn-devel] [PATCH v8] Use XOR instead of concatenation for
 calculation of IV from implicit IV
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Antonio Quartulli <a@...2181...>
Cc: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net

--vyKhFsN7RNnX5a8g
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Dec 10, 2024 at 10:30:09AM +0100, Antonio Quartulli wrote:
> My ACK got lost when v8 was created:
>=20
> Acked-by: Antonio Quartulli <antonio@...2726...>

Thanks.  Will record this on merge.  Tests are running right now...

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--vyKhFsN7RNnX5a8g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJnWArbAAoJEB2Cnv7KVigSDwIL/3+QX5F1QxJa6QYErGXwjcYI
X2kCu6KwUcv/+RFWu+OW9bo9fx+j+XvV6GMYkqKK2S5KJR58t5hPy7pvOS3QJnkW
yrFEry37aa1agVUZpJ6juzlUCWPor31uziGW49rvUMYFZF77kp7TWJOHAxZ3zIo0
IW44i95n2kDJpr6+Fql9P+Z7F0WXx9xHsOD0HKFXbTQLnN12qufsKZkt/qHBsj0B
0b4be8OHtekdv5Vpp2y4rJiIY7RxZjcLpAzdJEYZ2EJcXineLC2OKGBtjWkPSMNn
eAdddG086wyCzk2cQ6VpeeptUSfb341AU/1lf18wvITnpSF1zkdgJqmAtz3qrgce
FPCXXj3O1jo40lOEDaTTbOL7yKeXkoJs2uB43Lfngjj358UIB2HnUN0WMX0m6GkB
apq/0WRQ0lH/tA2RHD7IDDgoqtQbslqY+TH1uEPzi5DC4DPVCije07tEqt5BUO48
ifXDPfFzk0SoqDGZraUQWo1HZ9iY6L+E4158HFjrlA==
=tEQI
-----END PGP SIGNATURE-----

--vyKhFsN7RNnX5a8g--

