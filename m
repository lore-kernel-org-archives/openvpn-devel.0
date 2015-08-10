Date: Mon, 10 Aug 2015 20:47:27 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20150810184727.GT382@...1296...>
References: <55A786E3.7010805@...1147...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1S/G9tqlxK0HeYAd"
Content-Disposition: inline
In-Reply-To: <55A786E3.7010805@...1147...>
Subject: Re: [Openvpn-devel] [PATCH v3] Add TFTP and WPAD DHCP options
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Jan Just Keijser <janjust@...1147...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--1S/G9tqlxK0HeYAd
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hiya,

On Thu, Jul 16, 2015 at 12:26:43PM +0200, Jan Just Keijser wrote:
> here's rev3 of the patch; this time the Cisco DHCP options are fully unde=
rstood by Whireshark  ;)=20
>=20
> share and enjoy,

Well... we shared, David feature-ACKed it, and I tried to merge, but
I'm giving up - Jan Just, please use "git format-patch" to send patches,
because git cannot work with this...

> --- openvpn-2.3.7/src/openvpn/options.c 2015-06-02 10:01:24.000000000 +02=
00
> +++ /tmp/build-x86_64/openvpn-2.3.7/src/openvpn/options.c       2015-07-1=
6 12:14:20.762335566 +0200

... this is not mergeable, unless I change it all to "b/src/openvpn..."
with a relative 1-level path.


Also, there's code quality issues here...

> @@ -5354,6 +5358,8 @@
>         {
>           if (ip_or_dns_addr_safe (p[1], options->allow_pull_fqdn) || is_=
special_addr (p[1])) /* FQDN -- may be DNS name */
>             {
> +             struct tuntap_options *o =3D &options->tuntap_options;
> +
>               options->route_default_gateway =3D p[1];
>             }
>           else

This is totally unrelated, and no-op anyway?

> @@ -6153,6 +6159,14 @@
>         {
>           o->disable_nbt =3D 1;
>         }
> +         else if (streq (p[1], "TFTP") && p[2])
> +       {
> +         dhcp_option_address_parse ("TFTP", p[2], o->tftp, &o->tftp_len,=
 msglevel);
> +       }
> +         else if (streq (p[1], "WPAD") && p[2])
> +       {
> +         o->wpad_url =3D p[2];
> +       }
>        else
>         {
>           msg (msglevel, "--dhcp-option: unknown option type '%s' or miss=
ing parameter", p[1]);

This does not apply.  I assume your editor mangled space and tab - the
original code has tabs here...  (and this is still the valid coding
convention, 8 space =3D 1 tab)


> --- openvpn-2.3.7/src/openvpn/tun.h     2015-06-02 10:01:24.000000000 +02=
00
> +++ /tmp/build-x86_64/openvpn-2.3.7/src/openvpn/tun.h   2015-07-16 12:10:=
59.537519134 +0200
> @@ -78,7 +78,6 @@
>=20=20
>  #define N_DHCP_ADDR 4        /* Max # of addresses allowed for
>                                 DNS, WINS, etc. */
> -
>    /* DNS (6) */
>    in_addr_t dns[N_DHCP_ADDR];
>    int dns_len;
> @@ -98,6 +97,14 @@

No spurious white-space changes, please...

> @@ -4692,6 +4697,30 @@
>      buf_write_u8 (buf,  4);  /* length of the vendor specified field */
>      buf_write_u32 (buf, 0x002);
>    }
> +
> +  /* Set both the RFC2132 and Cisco DHCP options for a TFTP server */
> +  if (o->tftp_len > 0)
> +  {
> +       tftp_str =3D print_in_addr_t (o->tftp[0], 0, &gc);
> +       write_dhcp_str (buf, 66, tftp_str, &error);
> +  }
> +  write_dhcp_u32_array (buf, 150, (uint32_t*)o->tftp, o->tftp_len, &erro=
r);

Indenting conventions, please - while ugly, it should at least be=20
somewhat uniformly ugly (which the if(o->disable_nbt) block before that
isn't, unfortunately, but yours has even different formatting again,
with *5* extra spaces...)


> +  /* IE6 seems to requires an extra character at the end of the URL */
> +  if (o->wpad_url)
> +  {
> +#ifdef WIN32
> +    char str[256];
> +    strncpy( str, o->wpad_url, 255 );
> +    strcat( str, "\r" );
> +    write_dhcp_str (buf, 252, str, &error);

... and this is unsafe, as strncpy() doesn't 0-terminate, so strcat will
not have anything to append to.  Even if it has, strncpy() will have put
255 bytes without "0" into the buffer, so 255+"\n"+0 will overflow.

David suggested

  +    snprintf(str, sizeof(str), "%.254s\r", o->wpad_url);

which guarantees 0-terminate and no overflow.

> --- openvpn-2.3.7/doc/openvpn.8 2015-06-02 10:01:34.000000000 +0200
> +++ /tmp/build-x86_64/openvpn-2.3.7/doc/openvpn.8       2015-07-16 12:10:=
59.539519037 +0200
> @@ -5413,6 +5413,14 @@
>  to a non-windows client, the option will be saved in the client's
>  environment before the up script is called, under
>  the name "foreign_option_{n}".
> +
> +.B TFTP addr --
> +Set TFTP server address (Trivial File Transer Protocol).
> +This option sets both the RFC2132 DHCP option (66) and the Cisco option =
(150).
> +
> +.B WPAD url --
> +Set the WPAD url (Windows Proxy Auto Detection) for proxy autodetection.=
=20
> +The URL should be of the format "http://example.org/wpad.dat".
>  .\"*********************************************************

This part I like :-) actual documentation!

thanks,

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--1S/G9tqlxK0HeYAd
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVcjxv6kuBuNlUUl1AQLQuQQAhGL4kiJMS25A7NWdhzbzs1BSpDXYXh0p
gZaSupOO2NkGj8pcBJgyvj1H7KLSo/AEcDT9yJpWZDH2eREjCgzOv7wJn/4pbE7F
/4NwfM+3pMEk7tEPG8pjifTtAtPPBsQ+w0p81Q87fC7LTlL8eAm//uywrK0cxSjQ
U9sacW0+Hq8=
=GMqH
-----END PGP SIGNATURE-----

--1S/G9tqlxK0HeYAd--

