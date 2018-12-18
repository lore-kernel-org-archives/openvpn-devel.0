References: <20181218140945.GU962@...1296...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <8d921fbc-7baa-62c7-5689-ccfc9bf16240@...2181...>
Date: Wed, 19 Dec 2018 09:09:30 +1000
MIME-Version: 1.0
In-Reply-To: <20181218140945.GU962@...1296...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="Ynd08K8Ybpr8uTNNs3DpWMa0IVasAxRLw"
Subject: Re: [Openvpn-devel] RfD: printing of port numbers on v6 addresses
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
--Ynd08K8Ybpr8uTNNs3DpWMa0IVasAxRLw
Content-Type: multipart/mixed; boundary="9TaZjD5K9UXBMpbnylBTi7wExnLw9s1S2";
 protected-headers="v1"
From: Antonio Quartulli <a@...2181...>
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net
Message-ID: <8d921fbc-7baa-62c7-5689-ccfc9bf16240@...2181...>
Subject: Re: [Openvpn-devel] RfD: printing of port numbers on v6 addresses
References: <20181218140945.GU962@...1296...>
In-Reply-To: <20181218140945.GU962@...1296...>

--9TaZjD5K9UXBMpbnylBTi7wExnLw9s1S2
Content-Language: en-US
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

Hi,

On 19/12/2018 00:09, Gert Doering wrote:
> Hi,
>=20
> somewhen before 2.4 we lost "printing of port numbers on v6 addresses"
> - we used to dumbly print v6addr:port, leading to
>=20
>   2001:db8::123:1194
>=20
> which is less than clear on "is this a v6 address plus port 1194" or=20
> "just a longer v6 address".  Now we just print 2001:db8::123 in things
> like the log line prefix, with no port indication.
>=20
> "The Internet" says there are two widely used conventions:
>=20
> - One is "the URI format as per rfc3986", which would make this
>=20
>      [2001:db8::123]:1194
>=20
>   which is "IPv6 literal addresses are always enclosed in square brackets=
",
>   and if the port is printed, it's tacked on with ":port".
>=20
> - the other one is "what tcpdump and others do", tacking the port onto
>   the v6 address with ".", so this would become:
>=20
>      2001:db8::123.1194
>=20
>   also unambiguous (even in the v4-compatible 2001:db8::1.2.3.4.1194=20
>   form), though possibly confusing.  This is what RFC5952 has to offer
>   (plus "2001:db8::1 port 80" and "2001:db8::1p80" and "#80") - see
>   https://tools.ietf.org/html/rfc5952#section-6
>=20
>=20
> I find most of these forms ugly, but I want to "repair" this issue - not=
=20
> the least because our management interface has "kill client by IP+Port",
> which is currently broken because we do not print the port number at
> all... (it might still be broken due to the way it works internally,
> but that's a new can of worms).
>=20
> See also https://community.openvpn.net/openvpn/ticket/664 for more
> background.
>=20
>=20
> Opinions?


I personally prefer the rfc3986 notation because it is more widespread
and, therefore, easier to understand/recognize.

The tcpdump notation has the advantage of working with both v4 and v6,
but it's not really standard, so less ideal imho.

After all somebody has already agreed on a notation, so there is no need
to re-invent the wheel on our side.


Regards,


--=20
Antonio Quartulli


--9TaZjD5K9UXBMpbnylBTi7wExnLw9s1S2--

--Ynd08K8Ybpr8uTNNs3DpWMa0IVasAxRLw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE3o8ejP0lUW4GTX3J9FVsWUWDDm0FAlwZfioACgkQ9FVsWUWD
Dm2Z/hAAuL7iLwX24RnZYLEOJD7D6fFr+HZUMCnMlIPo+jNMXQYRe3Xu4H0bAz5b
oy1mJ8oj3TKUOZ3WiHq3ocO0YHYdYX4fD915cfNw034ag3JrBOMVXjmaOx0NUVuz
v3uiONR1M4iak7KQ8qK1MbO0yx+cBcFLxkVtGkslG/ujBOkYcEwbLCh1K2o77P4w
0h+1hYKpKUIhVXGps2f8F02VaSSMoUWCBxKgymOTL8TdZwxhPCDIhyG9ffj3qryX
+1WKY+cqp1P/sy5IZseKpLTWtEnQSpO0FGtLkKuNGl6hw8m7vUzutbG5noAEu+O2
q2D2B7UEDiPsYp5jy/+6XI9WiSFdE7V7xOnQjZU20HzdCFST8MmN0Tgt0JBMVYKN
et8R7rrCCObKX7d9PLlhDU2RFyX2aDJ1o+J22zRfVrr3WdiskOFMVLVx+WILhf5V
KXSfzkxDaV+IsrzL4cfA9pgwnFL9rtCxoWRzTDxlMAPC/d2UnhzzKR2I2TXpORT/
xBS9GyxQHEnj1/9ZL/gC7K6OxJFvCzb3tBGvwQK0kJS2jgzAW/KYIp8LSC2QUuUx
P4NJqokERPlTzsZklUTF2O1f+RDcm72iqaNon7t+FyTpCFsoRGZzkZM0Tz/BwkD3
oP0HAzKwhOy5Q64jsuIBNR823oH11T5NnuHcVJF9VTWRAtVRXpU=
=Vd+b
-----END PGP SIGNATURE-----

--Ynd08K8Ybpr8uTNNs3DpWMa0IVasAxRLw--

