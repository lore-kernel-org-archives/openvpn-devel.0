Date: Tue, 24 Nov 2015 22:56:05 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20151124215605.GP24952@...1296...>
References: <1448040238-21813-1-git-send-email-heiko.hund@...1489...>
	<1448383504-20376-1-git-send-email-heiko.hund@...1489...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HE8xRhbuhm5Vuapo"
Content-Disposition: inline
In-Reply-To: <1448383504-20376-1-git-send-email-heiko.hund@...1489...>
Subject: Re: [Openvpn-devel] [PATCHv2] put virtual IPv6 addresses into env
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Heiko Hund <heiko.hund@...1489...>
Cc: openvpn-devel@lists.sourceforge.net

--HE8xRhbuhm5Vuapo
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Ho Hum,

On Tue, Nov 24, 2015 at 05:45:04PM +0100, Heiko Hund wrote:
> Add missing environment variables for IPv6 virtual addresses:
>=20
>   * ifconfig_pool_local_ipv6
>   * ifconfig_pool_remote_ipv6
>   * ifconfig_pool_ipv6_netbits
>=20
> Signed-off-by: Heiko Hund <heiko.hund@...1489...>
[..]

There's two problems with it, unfortunately... first problem is that your
exchange server ("Received:" header #1) seems to stubbornly mangle all=20
tabs into 8 spaces - so the context of the patch does not match the=20
context in tree, and the patch doesn't apply.  Since sophos *does* have
a real MTA (postfix) further down the line - could that one be used
directly...?

But this is just a secondary thing for this patch as the patch is small
(so I could fix this by hand) - more complicated is this one:


>  void
> +setenv_in6_addr (struct env_set *es,
> +                 const char *name_prefix,
> +                 const struct in6_addr *addr,
> +                 const unsigned int flags)
> +{
> +  if (!IN6_IS_ADDR_UNSPECIFIED (addr) || !(flags & SA_SET_IF_NONZERO))
> +    {
> +      struct openvpn_sockaddr si;
> +      CLEAR (si);
> +      si.addr.in6.sin6_family =3D AF_INET6;
> +      si.addr.in6.sin6_addr =3D *addr;
> +      setenv_sockaddr (es, name_prefix, &si, flags|SA_NO_IP_SUFFIX);

... what does "SA_NO_IP_SUFFIX" do?  I've searched release/2.2, 2.3 and
git master, and couldn't find any trace of it - so it's not something
we lost during socket.c rewrite, but seemingly something we never=20
received...

I assume it is related to this stuff...

          openvpn_snprintf (name_buf, sizeof (name_buf), "%s_ip", name_pref=
ix);
          openvpn_snprintf (name_buf, sizeof (name_buf), "%s_ip6", name_pre=
fix);

... tacking a _ip(6) suffix to the name_prefix (or specifically, "not").

Where else do you use that?  Is this something we'd want to have?

thanks,

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--HE8xRhbuhm5Vuapo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVlTc9KkuBuNlUUl1AQITZwP/ezqq+eTb7rfXo47zQn8EJzs5t88mxln8
+P84+IuJd+SxcRcREJcTD/tpUMPbNQZN+qKzEPKpGR8R7YrGSDeISRZXoLdtQh79
QZFdg+OTSxx+GAPTd9tH83fBghzMslrZ/bcQGxKBavEj4r1nZLGsDKAh5l/dTjQx
5++wsyRUa24=
=qjGG
-----END PGP SIGNATURE-----

--HE8xRhbuhm5Vuapo--

