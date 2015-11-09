Date: Mon, 9 Nov 2015 15:55:55 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20151109145555.GE24952@...1296...>
References: <1447079709-17806-1-git-send-email-lstipakov@...277...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oYAXToTM8kn9Ra/9"
Content-Disposition: inline
In-Reply-To: <1447079709-17806-1-git-send-email-lstipakov@...277...>
Subject: Re: [Openvpn-devel] [PATCH v2] Use adapter index instead of name
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Lev Stipakov <lstipakov@...277...>
Cc: Olli Mannisto <olmannisto@...277...>, openvpn-devel@lists.sourceforge.net

--oYAXToTM8kn9Ra/9
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Nov 09, 2015 at 04:35:09PM +0200, Lev Stipakov wrote:
> v2:
>  * Remove netsh call which uses adapter name. After thoughtful testing
> turns out that "adapter name" code branch is never used.

Not there yet :-) - but thanks for picking this up.

As I said for v1, if we change this for the "set address" part of the
code, because "it will sometimes not work otherwise", we should also
change it for the "set route" code - consistent usage of netsh, easier
to understand when reading the log, etc.

It should actually be not very hard - we should be able to set "tt->actual"
to read "interface=3Dnnn", and then it should work automagically without ev=
en=20
touching route.c at all

> -	/* example: netsh interface ipv6 set address MyTap 2001:608:8003::d sto=
re=3Dactive */
> +	/* example: netsh interface ipv6 set address 42 2001:608:8003::d store=
=3Dactive */

What does surprise me, though, is that it works for you with just specifying
the interface index, without "IF" or "interface=3D" before it.

When setting IPv6 routes for non-tun/tap gateways (route.c, line 1770,=20
in git master) I use "interface=3D<ifindex>" and that is what the online
help told me to use.

      struct buffer out =3D alloc_buf_gc (64, &gc);
      buf_printf (&out, "interface=3D%d", r6->adapter_index );
      device =3D buf_bptr(&out);
...
  argv_printf (&argv, "%s%sc interface ipv6 add route %s/%d %s",
               get_win_sys_path(),
               NETSH_PATH_SUFFIX,
               network,
               r6->netbits,
               device);

is the syntax different for "set address"?

(IPv4 code uses "IF <index>"... hrmph)

gert


--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--oYAXToTM8kn9Ra/9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVkCz+qkuBuNlUUl1AQIUeAP/eGJzDk9vLHHFPkk81YCd0sEQc7z776Lf
Ppw0tj3wS9TRC8+aa1Rtf8iUxGcpgTJTCszTsPUfBPYBmEGJJ1NjmhMsl7Oi6oC1
PbMRMsLv+35xfos6SwHnITZGG6nOcxZGtHlW+tC1Gt5emrFTu0GmuISpXEKmdOXZ
xE7+v+6x4zk=
=hIAo
-----END PGP SIGNATURE-----

--oYAXToTM8kn9Ra/9--

