References: <20200923111242.GH976@...1296...>
 <20200923125839.7519-1-jan.seeger@...2574...>
 <20200923125839.7519-2-jan.seeger@...2574...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <df6b7ab7-0679-78da-7f3c-48ea672c8e73@...2080...>
Date: Wed, 23 Sep 2020 19:18:17 +0200
MIME-Version: 1.0
In-Reply-To: <20200923125839.7519-2-jan.seeger@...2574...>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="pBqyX48kDct1GE7fNJE4bKBe6uf3IhlCR"
Subject: Re: [Openvpn-devel] [PATCH] Added environment variable for IPv6
 route metric.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Jan Seeger <jan.seeger@...2574...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--pBqyX48kDct1GE7fNJE4bKBe6uf3IhlCR
Content-Type: multipart/mixed; boundary="XBsbq5Aj9o6gyWYbh7pPwFOUxOQnDXzcD";
 protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
To: Jan Seeger <jan.seeger@...2574...>, openvpn-devel@lists.sourceforge.net
Message-ID: <df6b7ab7-0679-78da-7f3c-48ea672c8e73@...2080...>
Subject: Re: [Openvpn-devel] [PATCH] Added environment variable for IPv6 route
 metric.
References: <20200923111242.GH976@...1296...>
 <20200923125839.7519-1-jan.seeger@...2574...>
 <20200923125839.7519-2-jan.seeger@...2574...>
In-Reply-To: <20200923125839.7519-2-jan.seeger@...2574...>

--XBsbq5Aj9o6gyWYbh7pPwFOUxOQnDXzcD
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On 23/09/2020 14:58, Jan Seeger wrote:
> --- a/doc/man-sections/script-options.rst
> +++ b/doc/man-sections/script-options.rst
> @@ -709,10 +709,10 @@ instances.
>      A set of variables which define each IPv6 route to be added, and are
>      set prior to **--up** script execution.
>=20=20
> -    ``parm`` will be one of :code:`network` or :code:`gateway`
> +    ``parm`` will be one of :code:`network`, :code:`gateway`
>      (:code:`netmask` is contained as :code:`/nnn` in the
>      ``route_ipv6_network_{n}``, unlike IPv4 where it is passed in a
> -    separate environment variable).
> +    separate environment variable) or :code:`metric`.

I would suggest to rewrite this slightly, to make it clearer.  The () sente=
nce
should be incorporated as a normal sentence.

So the (text/plain) result will be something like:

  param will be one of network, code or metric.  The netmask is contained
  as /nnn in the route_ipv6_network_{n}, unlike IPv4 where it is passed in
  a separate environment variable.

Or maybe even (why do we highlight IPv4 differences so much?):

  param will be one of network, code or metric.  The netmask is
  not provided and is preserved as /nnn in the IPv6 range in
  route_ipv6_network_{n}.

(These examples needs the proper :code:`value` and ``value`` highlighting,
removed here for clarity)


--=20
kind regards,

David Sommerseth
OpenVPN Inc



--XBsbq5Aj9o6gyWYbh7pPwFOUxOQnDXzcD--

--pBqyX48kDct1GE7fNJE4bKBe6uf3IhlCR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCgAGBQJfa4NZAAoJEIbPlEyWcf3yxikQALpb5qju8VQ6fQWTGt2AFafA
umDE8AQZo/0ip4jmHVfcDDIdExDwMIU/mA3Fz1yT5LGokQjDgd9BkE/+MRPMxHf4
psazMqSrOIkKK4XTHK6yaqiLZTXd8rHQK4HeJDG3ISbRtgBc8yxUnuBpQNI5RUjV
Fxsa3iQ/hdVLU4rgH/l0tyM5NnLHTLMWnI1Gd3hxCFfnvPYo6AmWtDf6Ddi0T7bf
JFW1aHldZvOKxBtjJvQe/Biyh15n3N5cfg6diGhct49hnJz6HoRB4mE4lgVg2xKD
BBvIfeUryHJ11o3ywC8yauxMCu/oR/AJw0RilPHINKgPZXi+PYcM86pTc8PHKOP0
8+/SCTDRWDkgaim5Nz7VFlWNlimBn9SuCIgTRQYqKRvSEVIWSQsv96SB7bacPh8m
Nyxy81M9jErKA2YuoN5sH6tFiV8I2cMOYwRjtIaCjJurB26Yd/HRzDEbggQij71X
N2h8R/JQuQDHZ2bnbbNlhi8Knd8IdHxKO7fB7URbGoOlhVuT5UzW0wRjHUTURWAP
pYxqMYN4iC4CpIDSc5WGgxrAXCA1HxU6Q/u1vzFNxytEKU24o39pSYo4lVl4WmVZ
tm6ZSEr9Uawb1ZqFamDsg9msA2zsOINpPIrb4ds+/d3yv05NH89whOgqD+kge2mQ
Fax6Om92gjsaHRPIqDVY
=DGuJ
-----END PGP SIGNATURE-----

--pBqyX48kDct1GE7fNJE4bKBe6uf3IhlCR--

