References: <20200711093655.23686-1-arne@...1227...>
 <20200711093655.23686-13-arne@...1227...>
 <20200713154047.GF1431@...1296...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <ce539842-b9d1-5cb1-eb56-f4a85533bbac@...1227...>
Date: Mon, 13 Jul 2020 18:08:04 +0200
MIME-Version: 1.0
In-Reply-To: <20200713154047.GF1431@...1296...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="rBfS74NT3sHMHgHSziHi3t8WIZjUbuXor"
Subject: Re: [Openvpn-devel] [PATCH v5 13/14] client-connect: Implement
 deferred connect support for plugin API v2
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
--rBfS74NT3sHMHgHSziHi3t8WIZjUbuXor
Content-Type: multipart/mixed; boundary="oaGE7vZAwkK9FOsBUmvVvZLPfO7KWYnvy"

--oaGE7vZAwkK9FOsBUmvVvZLPfO7KWYnvy
Content-Language: en-GB
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

Am 13.07.20 um 17:40 schrieb Gert Doering:
> Hi,
>=20
> On Sat, Jul 11, 2020 at 11:36:54AM +0200, Arne Schwabe wrote:
>> The V2 API is simpler than the V1 API since there is no passing of
>> data via files. This also means that with the current API the V2 API
>> cannot support async notify via files. Adding a file just for async
>> notify seems very hacky and when needed we should implement a better
>> option when async is needed for the plugin V2 API.
>=20
> I'm not sure I understand a word of this.
>=20
> If we want async cc, we should do it in the V2 API - and since v2 plugin
> async auth works just fine (with file), I wonder why it is hard for=20
> async cc?  Because we cannot pass back the returned config data?

Not async cc. That works fine. But async notification via file notify
does not work without a file being involved.

v1 API returns config and status via files.

v2 returns status as return value (OPENVPN_PLUGIN_FUNC_SUCCESS,
OPENVPN_PLUGIN_FUNC_DEFERRED...) and the config file via memory in
plugin_return. So no file involved and no way to use inotify


Arne


--oaGE7vZAwkK9FOsBUmvVvZLPfO7KWYnvy--

--rBfS74NT3sHMHgHSziHi3t8WIZjUbuXor
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE88wmPb+Azu8xbws3FRhsZwKxRFQFAl8MhuQACgkQFRhsZwKx
RFTYdhAAlrJ/LCNRuvCSTC4r9nwCWXTmUJXFfSfiVa6TCD5bOv5KWbBBcsiyHy17
lrRUCU9zsc8hhMOCIHF27x6PzJnDN2hQq3kUr5Xfj9rgwUZ0bRL4AVxcTe3UTgFh
n0jt9B9pYtCARGpUnycV0J08M+tYElz1ZALnD3kCXyP/OatewcfNWUqMpfcqy4Wd
0kkXOskJmDNKaM1AeLxZSk22mycUhztF2+qMJHcrmzW0s6vPjNfgH2mxQd3PZb8/
ff/e188wcJrKWqTG8eLp2FRxyDoUBRXujLtZJdkCOWOyCYra268TdQcH/2CIKMDN
88x5MzY3giy3w1ikO/XEcMKTRZwqxHnjcXxMpkxw9xylZC/fgn4wvvS/+c8oWcMh
DKR6JPb0v6Y9EvPyYiZcB0BMzLuJw0M6BtoXrBASyT9MJcWTwpoBexPOqtyRhnaJ
dvxjcCb2MlZakijM57nSVYNp9rrcS1/VnrPjEn+FPIVovZm83ZBuMXMd77YsDBm2
OAm8LhBuJ9OKZlpMBnnxK9Wal/nxH6ADuv1OAm1Ev6HGZYSij1rq5Vk6mc04yiHp
xC2fowNATmAWXT/YfhPkTlV8iyHlcrLNcOD0cDo+cBYEwyp4fDeC2tcnpYS6wSzh
YxfAh94J8T9Zs9izRsJOlr3pd50BvAtOyOo0eC85zUXgT1PWCXQ=
=54+w
-----END PGP SIGNATURE-----

--rBfS74NT3sHMHgHSziHi3t8WIZjUbuXor--

