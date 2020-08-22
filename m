References: <28a15eaf-16e5-0756-82c7-29035ec15382@...1918...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <684df390-6ac8-4715-1e78-b9aadb96cc23@...1227...>
Date: Sat, 22 Aug 2020 11:07:05 +0200
MIME-Version: 1.0
In-Reply-To: <28a15eaf-16e5-0756-82c7-29035ec15382@...1918...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="CH0YPsTx3Si7mAE6kdEF7QZLJAeWuTRY2"
Subject: Re: [Openvpn-devel] AUTH_PENDING from client-pending-auth query
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Eric Thorpe <eric@...1918...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--CH0YPsTx3Si7mAE6kdEF7QZLJAeWuTRY2
Content-Type: multipart/mixed; boundary="CXJYQFHeTOthaCeGDKF8QwBiHMt9TITw7"

--CXJYQFHeTOthaCeGDKF8QwBiHMt9TITw7
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Am 21.08.20 um 02:56 schrieb Eric Thorpe:
> Hi All,
>=20
> Arne might be best to answer this but wasn't sure. I've been testing out
> the client-pending-auth/cr-response stuff recently and had a question.
> Currently, the first thing that happens from the client-pending-auth
> management command is the client is sent an AUTH_PENDING control channel
> notification, however this isn't handled, all the client receives is a
> log message about an unknown push notification. Is there a plan for this
> AUTH_PENDING message to do something in the future, is it for
> compatibility for something else or is it simply extraneous and can be
> removed?

OpenVPN 2.x currently ignores AUTH_PENDING but the OpenVPN 3.x library
needs it to enter that state.

Arne


--CXJYQFHeTOthaCeGDKF8QwBiHMt9TITw7--

--CH0YPsTx3Si7mAE6kdEF7QZLJAeWuTRY2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE88wmPb+Azu8xbws3FRhsZwKxRFQFAl9A4DoACgkQFRhsZwKx
RFRGvA//UY5iq8WeQxOnbFxg6Ih8eLfGIyplpUMo2bcrnWGdQYDzaN1PzlzgHee8
Nw0hRiOdCio4uqiZG6X9lRbhjaJX5rDBRAxyAjm6mbLwaxtI7pz/aZAhINYBMyc6
mJJHluz3pCLxY2GMZqejzaXDRusWSNzrcw9hbCbbEzdrVi773iooRgV+MKfxVbHZ
ak+USg0ejkLCVOeydk/qKbvONkEgO9tG3gJXgL00eI3orXo0XRR9tkBfrDV2sVb2
A6qrKZKJjZlmnJyjGIGTm2mCbZikh0q6F/Hdz8ZsykgRHe1IyYADj78v/j8qp2w3
st6mJMZ6oNZWaBWaJbIktc2Z48LiggmhuYOxMNhAGP8N1f8xktOlFZPErI9LBrxC
6faOIYoGqbnVcjzne3IBfvlfjnhVjIk5CVpAg0XcJifoUxgj0G+SK37K1xn6d4wR
jBfnfbGykgMLvEzX+qGhqTBJu1w5XxeNo3BO2PURZLgrxefAmcysnBEtgGVCjeDp
qFAJ1AwS1MOAU2A3qy/qxwsvEtb/Zd+dDAKYgELJr3fGqC40yHZbUKR5GQ1OkB+5
emYP7XwEP4RcGP8Ls6zT7LShp6DUAc8sz64dQuw09adYUCfFUR2GcQQK+UJRUxQ1
ZMzpS5YJAUUm/8NvChnzhaLWSpjtsaGbkxV5E65AQ0+shewNltI=
=yUKE
-----END PGP SIGNATURE-----

--CH0YPsTx3Si7mAE6kdEF7QZLJAeWuTRY2--

