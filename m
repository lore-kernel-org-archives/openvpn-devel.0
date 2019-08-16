References: <20190815155319.28249-1-gert@...1296...>
 <24031142-ddef-6e78-45dc-e6363f8a1723@...2080...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <4ef40555-1c91-2062-f9d0-d486737ef407@...2181...>
Date: Fri, 16 Aug 2019 17:13:10 +0200
MIME-Version: 1.0
In-Reply-To: <24031142-ddef-6e78-45dc-e6363f8a1723@...2080...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="CK7jPKEub2WmLN9g68F5FB4d4BOwe9DDO"
Subject: Re: [Openvpn-devel] [PATCH] Increase listen() backlog queue to 32
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: David Sommerseth <openvpn@...2080...>, Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--CK7jPKEub2WmLN9g68F5FB4d4BOwe9DDO
Content-Type: multipart/mixed; boundary="USIQK1gvhD9aMP2l6Xot1zEn6tqGHnCT0";
 protected-headers="v1"
From: Antonio Quartulli <a@...2181...>
To: David Sommerseth <openvpn@...2080...>,
 Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net
Message-ID: <4ef40555-1c91-2062-f9d0-d486737ef407@...2181...>
Subject: Re: [Openvpn-devel] [PATCH] Increase listen() backlog queue to 32
References: <20190815155319.28249-1-gert@...1296...>
 <24031142-ddef-6e78-45dc-e6363f8a1723@...2080...>
In-Reply-To: <24031142-ddef-6e78-45dc-e6363f8a1723@...2080...>

--USIQK1gvhD9aMP2l6Xot1zEn6tqGHnCT0
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On 16/08/2019 13:49, David Sommerseth wrote:
> On 15/08/2019 17:53, Gert Doering wrote:
>> For reasons historically unknown, OpenVPN sets the listen() backlog
>> queue to "1", which signals the kernel "while there is one TCP connect
>> waiting for OpenVPN to handle it, refuse all others" - which, on
>> restarting a busy TCP server, will create connection issues.
>>
>> The exact "best" value of the backlog queue is subject of discussion,
>> but for a server that is not extremely busy with many connections
>> coming in in parallel, there is no real difference between "10" or "500",
>> as long as it's "more than 1".
>>
>> Found and debugged by "mjo" in Trac.
>>
>> Trac: #1208
>>
>> Signed-off-by: Gert Doering <gert@...1296...>
>=20
> Acked-By: David Sommerseth <davids@...515...>
>=20
> I agree with Antonio, and we should make it somewhat easier to modify.

I disagree with you on this point :D This is not something we expect
people to play with. This is only a value that a developer with
networking knowledge is expected to find and tweak. Hence my suggestion
to make it a define in some header main header file.

>  I'm
> not sure if there's value in having it as a runtime option, like
> --socket-backlog (or something like that), or as a value you can pass to
> ./configure at compile time.
>=20

Like above: yet another config option that the average joe can mess up
and come up with unknown problems nobody will understand? nonono ;)

Cheers,

>=20
>=20
>=20
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>=20

--=20
Antonio Quartulli


--USIQK1gvhD9aMP2l6Xot1zEn6tqGHnCT0--

--CK7jPKEub2WmLN9g68F5FB4d4BOwe9DDO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE3o8ejP0lUW4GTX3J9FVsWUWDDm0FAl1WyAYACgkQ9FVsWUWD
Dm1jnBAAoX9vXYMU3GWNrjDkoL16tlBYJPAd2yiQkEgfZFh+/DsQa7aZUO3+FID5
BZd60SkjLNouz3Xcag32EP0P/VsoOHPyEDPm697kGSTwrVFy9Oj70iFBrjf9j/gT
zMSC48Xq7uMCYFsdODn96X7yqDnl8LCpzF7pg98RWFv1s9xZUpYN1OqsZUytQ/80
DIk/6N01h7bGNLEDX1NEoQygt9Ecnsm3ceX42H95NR8kv4PE2qwItPDvc4beUy0R
lPMSxfJxiuhLCf1Oq7jNurRIzSSqZcbC8bG7DL1Scl6XxHXhQMcZQM7p/aFJMY/f
Xn2j4mQkEn7ZrsU3kV9lETaBNDuFin3rkytd1h+CaQwJYGWvpU1RZO2iBv9DUNmm
Q35KcduIfwfbQpUqjK7oXBk589+j7r0dW3j4D7FsbowDRPGuWyG2uEWvv9o3Hwj0
g6bGwhhqVzTbcZ68Hax26uSlBr2gufFHGsa7no0kwGiubxktLbgETLl2CCmEJmA4
b0u6Oc0A2gGT0JBd/MSMKMVy2wsFU1zHEkRsdcNbrry4h8I+Etg9cDQccuIFNizj
0FtTdM15pibsE0HELSiMcp1T37YI99zYScPUvw6EykloFdy5tboCc5rH/hfMM1oF
dI1ozq3/s1RAUSBJKWz/pLfKtnsibw1dm0qPhLPkQ33etaVv3/o=
=JCVN
-----END PGP SIGNATURE-----

--CK7jPKEub2WmLN9g68F5FB4d4BOwe9DDO--

