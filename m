References: <20200528225920.6983-1-James.Bottomley@...2316...>
 <20200528225920.6983-3-James.Bottomley@...2316...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <9db81c43-f73e-723f-5013-1841f6a03d64@...1227...>
Date: Fri, 5 Jun 2020 13:41:00 +0200
MIME-Version: 1.0
In-Reply-To: <20200528225920.6983-3-James.Bottomley@...2316...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="KKM3masLWrK8Iv8k64b2Ctpo4qvik2NKx"
Subject: Re: [Openvpn-devel] [PATCH v6 2/3] crypto_openssl: add
 initialization to pick up local configuration
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: James Bottomley <James.Bottomley@...2316...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--KKM3masLWrK8Iv8k64b2Ctpo4qvik2NKx
Content-Type: multipart/mixed; boundary="9RYFjD5HZaWaOWgtaRCsCmpsOdQBdOvho"

--9RYFjD5HZaWaOWgtaRCsCmpsOdQBdOvho
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Am 29.05.20 um 00:59 schrieb James Bottomley:
> The test programme for the new openssl engine code requires overriding
                   ^^^
Unrelated to this commit but I wondered about this spelling and it seems
that the British programme spelling usually is a TV programme while
program is used in computer context. AE just uses program for both.

> the system default configuration file to point to the location of the
> test engine.  Add an initialization stanza that makes this behaviour
> universal, so now anyone running openvpn configured with openssl can
> specify their own configuration file with the OPENSSL_CONF environment
> variable.

Acked-By: Arne Schwabe <arne@...1227...>

I also tested that with a configuration file with an invalid statement
this does not abort OpenVPN (the bug we had a few weeks ago)

Arne


--9RYFjD5HZaWaOWgtaRCsCmpsOdQBdOvho--

--KKM3masLWrK8Iv8k64b2Ctpo4qvik2NKx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE88wmPb+Azu8xbws3FRhsZwKxRFQFAl7aL0wACgkQFRhsZwKx
RFRizg/+KWDbOxmqgSkJREBWHNZMzxyj6OjNixbm38FJYqArksOymVZDV1WpmSJT
rWJjYyq+Q9qVXbb76KR77Z2sdbqr7rn3FdlaGCdR33n2rRvxZw/K2bV5kfnjrrhR
s4szQMK5LESkhC7o4L7iGLxtWHckTz6HMQ92IjdhmWCr7tA4GJihFoNzss6KlV5S
UNcMnlVbu8f7shKxYiTxB16clTjg9zSMDn0brJyfnwHkTEIAHj9H+A4RtRBUUkFH
dWBXOcVt1gSHxg+5vWX15X+sj5Fr6C2V/5k7PpFNRzcRflJNPjpHLjVWWWhX/tgA
W1GTRxURspQ6PTOonhB2FxL+tbnGpbIgmVt6EM+p3vS/C1It8D9gWDYjgYWeLApB
pMpvUNKgE1PKlJVA75pVGq6GyRyd4vP0jlFbaimfJb6nPiDfwhAPfrt1xo18jHOa
YwUc9TfwwvJ6x2RGC3EKf0wzgETORk8YzMzNgHH+jE0ieCR+u4kd4EnIDUWGAsWl
JVtdkFMqpM8RDcyalbse1hqt8FiFD1dlAHhrG2eRb1VZAHuH3x93YrZt/Wmanl1Y
f3TNkoYyXwN+IweSku77eJ2jk6+HVe6jVf9Ep812PW4pY5vIv5K5YAJRo761JhlY
N+0KpGTcymnhu9V3BTlFBgHphkc0WkQc/5iQbou61Fon0k4nCe8=
=LWgP
-----END PGP SIGNATURE-----

--KKM3masLWrK8Iv8k64b2Ctpo4qvik2NKx--

