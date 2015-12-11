Date: Fri, 11 Dec 2015 20:38:17 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20151211193817.GT24952@...1296...>
References: <AF48117BC12D429393E4D93EFBA7E72E@...2089...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4k8fn04TlfgxNKWT"
Content-Disposition: inline
In-Reply-To: <AF48117BC12D429393E4D93EFBA7E72E@...2089...>
Subject: Re: [Openvpn-devel] Opttion "client-nat" not recognised
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: debbie10t@...277...
Cc: openvpn-devel@lists.sourceforge.net

--4k8fn04TlfgxNKWT
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Dec 11, 2015 at 07:35:18PM -0000, debbie10t@...277... wrote:
> today, I was working with an old config which uses --client-nat
> I upgraded that particular client to git-master for testing and
> discovered that git-master currently does not support --client-nat
[..]
> Fri Dec 11 19:08:12 2015 us=3D645088 PUSH: Received control message:=20
> 'PUSH_REPLY,ifconfig-ipv6 2001:db8:0:123::101/64=20
> 2001:db8:0:123::86,route-gateway 10.234.64.86,topology=20
> subnet,explicit-exit-notify 3,ping 10,ping-restart 30,tun-ipv6,client-nat=
=20
> snat   10.1.101.0 255.255.255.0 10.201.101.0 255.255.255.0,client-nat dna=
t=20
> 10.201.101.0 255.255.255.0   10.1.101.0 255.255.255.0,setenv-safe=20
> client_dynamic 1,ifconfig 10.234.64.101 255.255.255.0,peer-id 0'

According to the (slightly confusing, admittedly) man page entry,=20
the way you are calling the option is not correct, and as such,=20
git master will refuse the lines.  "client-nat" has *four* arguments,
not *five*.

This is backed by the 2.3 and git master code...

2.3:

#ifdef ENABLE_CLIENT_NAT
  else if (streq (p[0], "client-nat") && p[1] && p[2] && p[3] && p[4])
    {
      VERIFY_PERMISSION (OPT_P_ROUTE);
      cnol_check_alloc (options);
      add_client_nat_to_option_list(options->client_nat, p[1], p[2], p[3], =
p[4],
 msglevel);
    }
#endif

(so, argument 5 is silently ignored)

git master:

  else if (streq (p[0], "client-nat") && p[1] && p[2] && p[3] && p[4] && !p=
[5])
    {
      VERIFY_PERMISSION (OPT_P_ROUTE);
      cnol_check_alloc (options);
      add_client_nat_to_option_list(options->client_nat, p[1], p[2], p[3], =
p[4], msglevel);
    }

"if a 5th argument is given, refuse this option".

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--4k8fn04TlfgxNKWT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVmsmKakuBuNlUUl1AQJj/gP+KpA76hFPqUsvnjZXOVA2erIUDpMgTgg/
6GnKiB9z9RHABP7V1bG3tZSehKdeFu46i5kBk3CUhL9rA5e9Au5xPP8g5i4Vknt7
E7YgNyWlbc3ybR7UExbOPSAisUxTxBb7ZB5NMe9xdi3qFxrVqZ8/e5CMWSqdAvlw
lBVQqQLmWPo=
=oc+o
-----END PGP SIGNATURE-----

--4k8fn04TlfgxNKWT--

