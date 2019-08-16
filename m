References: <20190815155319.28249-1-gert@...1296...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <24031142-ddef-6e78-45dc-e6363f8a1723@...2080...>
Date: Fri, 16 Aug 2019 13:49:27 +0200
MIME-Version: 1.0
In-Reply-To: <20190815155319.28249-1-gert@...1296...>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="L2gERprsjhiQHfoldU9UpadKG4BHbrXm8"
Subject: Re: [Openvpn-devel] [PATCH] Increase listen() backlog queue to 32
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--L2gERprsjhiQHfoldU9UpadKG4BHbrXm8
Content-Type: multipart/mixed; boundary="TPdvM78BHy7XrqL3zPllxxX4VyiIEG3Vm";
 protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
To: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net
Message-ID: <24031142-ddef-6e78-45dc-e6363f8a1723@...2080...>
Subject: Re: [Openvpn-devel] [PATCH] Increase listen() backlog queue to 32
References: <20190815155319.28249-1-gert@...1296...>
In-Reply-To: <20190815155319.28249-1-gert@...1296...>

--TPdvM78BHy7XrqL3zPllxxX4VyiIEG3Vm
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On 15/08/2019 17:53, Gert Doering wrote:
> For reasons historically unknown, OpenVPN sets the listen() backlog
> queue to "1", which signals the kernel "while there is one TCP connect
> waiting for OpenVPN to handle it, refuse all others" - which, on
> restarting a busy TCP server, will create connection issues.
>=20
> The exact "best" value of the backlog queue is subject of discussion,
> but for a server that is not extremely busy with many connections
> coming in in parallel, there is no real difference between "10" or "500",
> as long as it's "more than 1".
>=20
> Found and debugged by "mjo" in Trac.
>=20
> Trac: #1208
>=20
> Signed-off-by: Gert Doering <gert@...1296...>

Acked-By: David Sommerseth <davids@...515...>

I agree with Antonio, and we should make it somewhat easier to modify.  I'm
not sure if there's value in having it as a runtime option, like
--socket-backlog (or something like that), or as a value you can pass to
./configure at compile time.


--=20
kind regards,

David Sommerseth
OpenVPN Inc



--TPdvM78BHy7XrqL3zPllxxX4VyiIEG3Vm--

--L2gERprsjhiQHfoldU9UpadKG4BHbrXm8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCgAGBQJdVphHAAoJEIbPlEyWcf3yC2IP/0FTobqqTbWz2aK3lhvSSVJ8
7sU6TY3MrwPxWpiP7N1lGbj/g8Trohw6MqwyEz8/U25+AgE7D/xC7BTZpnEKy1ag
aGEksDmalNbqXDol9LjHZVF5ReJ6X9VyWRoCedpXQMFFsXRxzM8Wnw6LbD0GB4De
o+6F9SCraHAhjdLBZ462Es+8ajLJKYSLhxeyndCi1evM5O4Y3nuO1AdImFse/wQ/
mpp//RRj/OXfT4mPAHDzXkmgpzHDGcsYumvTNBUihSmPGuxNfgtwae5E1OLyFvyJ
oCURrMa+EI9ptBYIGcTY1VLH/h/k+5qM8EpiMH8S7aeRkux0SdXl1NzeR5++m3pv
3J0VFFw3kqHfzzOTlGWvudREVdhyIz5i9OtmGAAXaYBkRIDsOfJYNs5Vrw/zsQuV
uphAmLWwEFcF82L+5jqjzWInmNG0Ge+XS/ow6BIBCMCWns5mlsBCVUQwg6ddA2Q2
NfLiMkOsIrF2xonQ/1N46R3gYurJHPpjS9aPhbWZyYCkf/Om8A1h9t818YTGzRO8
fFdwKkOSCWSgzIy3rjP1K2UuNdkxYUbBy557w7HxAwaSwLj/Hx7C1ssiY9WLwnP1
ug19YzapLo9lnGR12mgaFFuw4m8rENKWWT0Fe9oSeM7nR1xft4hrqvEhevqV9vzp
+TcqKXqjKTSeSiNqgw/l
=vLPA
-----END PGP SIGNATURE-----

--L2gERprsjhiQHfoldU9UpadKG4BHbrXm8--

