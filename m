From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
References: <20170907022827.10658-1-davids@...515...>
 <20170907172004.22534-1-davids@...515...>
 <c122b7ac9f1d63ac0ba060f7f7d3ceff.squirrel@...2257...>
Message-ID: <fbf169c9-8353-7a06-ed33-2689706a0e8b@...2080...>
Date: Fri, 22 Sep 2017 00:50:18 +0200
MIME-Version: 1.0
In-Reply-To: <c122b7ac9f1d63ac0ba060f7f7d3ceff.squirrel@...2257...>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="6Na7w8mkC52ArHhJCeIMlDCM3gjKKwXkk"
Subject: Re: [Openvpn-devel] [PATCH v2] lz4: Move towards a newer LZ4 API
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Simon Matter <simon.matter@...2249...>, David Sommerseth <davids@...515...>
Cc: openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--6Na7w8mkC52ArHhJCeIMlDCM3gjKKwXkk
Content-Type: multipart/mixed; boundary="o3PLASnoVN5FFr4ggX73OETDTW2DhdjQ5";
 protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
To: Simon Matter <simon.matter@...2249...>,
 David Sommerseth <davids@...515...>
Cc: openvpn-devel@lists.sourceforge.net
Message-ID: <fbf169c9-8353-7a06-ed33-2689706a0e8b@...2080...>
Subject: Re: [Openvpn-devel] [PATCH v2] lz4: Move towards a newer LZ4 API
References: <20170907022827.10658-1-davids@...515...>
 <20170907172004.22534-1-davids@...515...>
 <c122b7ac9f1d63ac0ba060f7f7d3ceff.squirrel@...2257...>
In-Reply-To: <c122b7ac9f1d63ac0ba060f7f7d3ceff.squirrel@...2257...>

--o3PLASnoVN5FFr4ggX73OETDTW2DhdjQ5
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On 07/09/17 22:40, Simon Matter wrote:
> Hi,
>=20
> While we are at it, I found it useful to see the used LZ4 version at
> runtime as it is done with LZO and other libraries.
>=20
> I've patched my rpms with the patch attached.

Thanks a lot!  I think this makes sense.  But I think we can do this
stuff as a separate patch, not part of this round of patches.  Lets
target this after we have sorted out the current LZ4 patches have been
applied.  Then it is much easier to test and validate this approach.


--=20
kind regards,

David Sommerseth
OpenVPN Technologies, Inc




--o3PLASnoVN5FFr4ggX73OETDTW2DhdjQ5--

--6Na7w8mkC52ArHhJCeIMlDCM3gjKKwXkk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCgAGBQJZxEIqAAoJEIbPlEyWcf3yvJYQALxE/7y1x40nitTnoCo2cJNK
0IgSRo383lkxrQTFalRgoS2O9RrdM1kly4FqezFz199TjGLzSN601G8wPYq1I92k
TFpPs1VJFSZxb+bPK/3ROlfCD7dEn64ZLPLpt1BTpuf8Z+5orQ9Th+F9oPdsRu0E
58cw5bhWbfvYPYrDZGjiKOsf65pIt7lDgguiO3J4ckTNEegTlQlov7VanPRlX4Xr
3jUNoLXC+HckStY3EOOD+Q4J5g3+TJ/g5JzJCDqnn0NfUWL/KgliFUY24f61raOa
GI0wxlXunls3WAJvrFbE3i3RxfJwd7Tps/RwSBv1UueMzRvZVfCPbURcEE26rMY0
hMwtss+4AOQ19K1hOMN0nfMj5FoBruhb6pCfcpCZTzksT8RljWFQ8Ft5chJEdUKO
xNiguodyCejXnLh6eymU/fv9Syvin14XoG4n/8nQIoMxMrQEK5BBeW/Da6ZwSMdP
4xSf4Xfuacbu4frhmCk/7jfTlaGX1sylAQCILXbtBJzaOoF/u/AL8xVU1uIsuqAj
aLleUOBfAEewgUe5MCTeRZvEevC47DvNsErntHS+aiBIbAvoLmswn4a6AnwfB2+D
QJYWjcSiHlDTC/CqWfIdFFea7Gjxm8YyXbKJanpqyXDXuHHtLSzlDfirDj9P308c
k9a57yKDdB1wDNcCz+cI
=yuU1
-----END PGP SIGNATURE-----

--6Na7w8mkC52ArHhJCeIMlDCM3gjKKwXkk--

