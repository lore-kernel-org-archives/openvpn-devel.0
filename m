Date: Fri, 13 Nov 2015 08:56:49 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20151113075649.GM24952@...1296...>
References: <20151111081604.GU24952@...1296...>
	<1447242487-30243-1-git-send-email-lstipakov@...277...>
	<20151111194006.GB24952@...1296...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Wn0J+vu9+NMIXK57"
Content-Disposition: inline
In-Reply-To: <20151111194006.GB24952@...1296...>
Subject: Re: [Openvpn-devel] [PATCH v3] Use adapter index instead of name
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

--Wn0J+vu9+NMIXK57
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, Nov 11, 2015 at 08:40:06PM +0100, Gert Doering wrote:
> ... but wouldn't
>=20
>   	argv_printf (&argv,
> 		    "%s%sc interface ipv6 set address interface=3D%lu %s store=3Dactive=
",
>   		     get_win_sys_path(),
>   		     NETSH_PATH_SUFFIX,
> 		     get_adapter_index_flexible(actual),
> 		     ifconfig_ipv6_local);
>=20
> (without storing into a temp variable) work "just fine"?

Turns out this does not work, as argv_printf() does not implement a=20
generic printf() parser, but splits up the string at whitespace boundaries
and then handles each element explicitly - and '%-parsing' is only done
for known cases, and then the % part has to stand on its own, with=20
some special exceptions...

          else if (!strcmp (term, "%s/%d"))
...
          else if (!strcmp (term, "%s%sc"))
...

given that, I think the v3 patch is as good as it's going to get without
extending argv_printf() - IOW, ACK, and I'll merge later.  Thanks.

(I'll add a comment to the commit message to explain why a temporary
string has to be used, in case I forget and start wondering a year from
now...)

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--Wn0J+vu9+NMIXK57
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVkWXwKkuBuNlUUl1AQL1VgQAoNGkQSVfTyrJ5eZxeLAkRuENJc7FudCH
IlodHrdWWAuQf68dr1oQIvIbi+Ix8HtOSPoPApRTAxLzxXE3z+hR+SrXxCZ8qU1j
klgRGY1beyKd4l9IieOkd8l0vDeD8hpBlZc4QOPv9w5ofKrJMa5lQCAIKl/rxNeB
xaX+y142rRY=
=n89H
-----END PGP SIGNATURE-----

--Wn0J+vu9+NMIXK57--

