From: Arne Schwabe <arne@...1227...>
References: <20200825073643.15920-2-arne@...1227...>
 <20200907162221.20928-1-arne@...1227...>
Message-ID: <d1c25496-eedf-d199-8716-e101291d6ed6@...1227...>
Date: Fri, 30 Oct 2020 10:55:04 +0100
MIME-Version: 1.0
In-Reply-To: <20200907162221.20928-1-arne@...1227...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="eTHwSBQ8I2Gs4rquNom70G59uLDtaVVGu"
Subject: Re: [Openvpn-devel] [PATCH 3/5] Allow running a default
 configuration with TLS libraries without BF-CBC
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
--eTHwSBQ8I2Gs4rquNom70G59uLDtaVVGu
Content-Type: multipart/mixed; boundary="RfXUziUN3XbJtwdx55lhuR18f5BqRoEgO"

--RfXUziUN3XbJtwdx55lhuR18f5BqRoEgO
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Am 07.09.20 um 18:22 schrieb Arne Schwabe:
> Modern TLS libraries might drop Blowfish by default or distributions

OpenSSL 3.0 will be one of these that only provides Blowfish if you load
the legacy provider (not included by default)


--RfXUziUN3XbJtwdx55lhuR18f5BqRoEgO--

--eTHwSBQ8I2Gs4rquNom70G59uLDtaVVGu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE88wmPb+Azu8xbws3FRhsZwKxRFQFAl+b4vgACgkQFRhsZwKx
RFQ2KBAAppE2xfODDp2UQDUh4MBRiNnavuCMQjHxFhHZhy8R08Dps9eRr8kvUMns
tCOqaDS22R9r0NZFrEwdDIPaBERuiQaWjfutkL5HcYSwolo2D42xIpR5AH0mIzrL
KvmR8beqJlHd8Ej03C3lTQSYJjZH3OEsxyPGrKb6fFvfM5y5NaAtfFIJJWFbJvYV
q2AeGwJoWLu8Rb6hDGHUEul2OtSurnaBrzuHDTgd09xFmBoxrZVSrKh1sy3C/4IR
QEB1tE5m5bGYWqcy2YXE3m2JFXhJSrs/1zHVDmQ7J1CAjTVllwIF+2FO5HdkktLm
VUj95EbtGOqljBMiik/wx0BOwADfjt0XF8SUWDCMnwZa/nJ0os+Mb7b7S/AUz0Nc
0Q2XM7DvsId+NDJWl7oKzB8aSbfNALGdWesLbZnEj3tWFwhZ1wC8weYHnkjdCN1J
J/ZR6ZAe6nA15dhBeyx5+u95Ogz0hx3NPIU4ov2JkbNBjPeVFy5679HbZ35PeLQx
20BlyzqjOPm/eLYMUE3+POEoXS65m+wGRbYh46SguWVCzq19rt54kjoPnHBHLWH/
8scCX5l6vluGfyPrjwUH6hMALKbD6rVwhpfW0WsQvJ00dtq4Zg5UeclvHvg9aPlj
gEilOxd45LN2NDDzW5uJ/Nos5RGhD5kAsrgBmZmLZ4jisQCOfDQ=
=zXY1
-----END PGP SIGNATURE-----

--eTHwSBQ8I2Gs4rquNom70G59uLDtaVVGu--

