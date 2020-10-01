References: <CAAWBBYMu6mT+H3atWxx1Stqt63kvTj-MGpUiM_2uDnAjbqNb=w@...278...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <e06ae161-d228-5ff3-eb32-01fa1f5476e1@...1227...>
Date: Thu, 1 Oct 2020 13:39:59 +0200
MIME-Version: 1.0
In-Reply-To: <CAAWBBYMu6mT+H3atWxx1Stqt63kvTj-MGpUiM_2uDnAjbqNb=w@...278...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="sifAs0SdO3SqFLXeiTHLkgkXgAy4hwkVg"
Subject: Re: [Openvpn-devel] NAT client-ip
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Rafael Gava <gava100@...277...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--sifAs0SdO3SqFLXeiTHLkgkXgAy4hwkVg
Content-Type: multipart/mixed; boundary="nqQFsnofEjR0WtnbZm9LzIceNVtCpSSpg"

--nqQFsnofEjR0WtnbZm9LzIceNVtCpSSpg
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Am 14.09.20 um 03:23 schrieb Rafael Gava:
> Hello guys,
>=20
> A couple years ago I submitted this patch which allows the user to set
> the 'client-ip' as a convenient way to use the leased IP address
> received from OpenVPN server in NAT configuration. For example:
>=20
> client-nat snat client-ip 255.255.255.255 172.20.1.15
>=20
> , where 'client-ip' string is replaced with the leased IP address
> received from OpenVPN server.
>=20
> At that time, it was NACKED due to the fact that I was using both
> client-ip and localhost strings. So, it's changed now and I'd like to
> re-submit it again for appreciation.


The patch is not easy to apply since it seems to be copy&pasted inline
and not as attachment or via git-send-email and my git does not like it
at all and quits with 'Patch is empty.' Even after copying and pasting
the patch manually I get:

error: corrupt patch at line 21



> diff --git a/src/openvpn/clinat.c b/src/openvpn/clinat.c
> old mode 100644
> new mode 100755
> index b08fd54..865b0e2
> --- a/src/openvpn/clinat.c
> +++ b/src/openvpn/clinat.c
> @@ -128,12 +128,16 @@ add_client_nat_to_option_list(struct
> client_nat_option_list *dest,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0msg(msglevel, "client-nat: type must be=
 'snat' or 'dnat'");
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;
> =C2=A0 =C2=A0 =C2=A0}
> -
> - =C2=A0 =C2=A0e.network =3D getaddr(0, network, 0, &ok, NULL);
> - =C2=A0 =C2=A0if (!ok)
> + =C2=A0 =C2=A0if (network && !strcmp(network, "client-ip"))
> =C2=A0 =C2=A0 =C2=A0{
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0msg(msglevel, "client-nat: bad network: %s",=
 network);
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0return;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0e.network =3D 0xFFFFFFFF;

I am not happy about abusing 255.255.255.255 with any netmask as a
standin for localhost. Is there any need to have any other netmask than
/32 for client-ip? And if we are using a network for the IP I would
rather use a special IP from the 127/8 block with a define here. Or
maybe even add new flag like CN_SNAT_CLIENT_IP/CN_DNAT_CLIENT_IP that
get replaced with the real information later.


> + =C2=A0 =C2=A0} else {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0e.network =3D getaddr(0, network, 0, &ok, NU=
LL);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!ok)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0{
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0msg(msglevel, "client-nat: bad=
 network: %s", network);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> =C2=A0 =C2=A0 =C2=A0}
> =C2=A0 =C2=A0 =C2=A0e.netmask =3D getaddr(0, netmask, 0, &ok, NULL);
> =C2=A0 =C2=A0 =C2=A0if (!ok)
> @@ -276,3 +280,34 @@ client_nat_transform(const struct
> client_nat_option_list *list,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> =C2=A0 =C2=A0 =C2=A0}
> =C2=A0}
> +
> +/*
> +* Replaces the client-ip token with the IP received from OpenVPN Server
> +*/
> +bool
> +update_client_ip_nat(struct client_nat_option_list *dest, in_addr_t
> local_ip)
> +{
> + =C2=A0 =C2=A0int i;
> + =C2=A0 =C2=A0bool ret =3D false;
> +

Please use C99 inline declaration, i.e. move the int i into the for loop.


> + =C2=A0 =C2=A0if (!dest)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;
> +
> + =C2=A0 =C2=A0for (i=3D0; i <=3D dest->n; i++)
> + =C2=A0 =C2=A0{
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0struct client_nat_entry *nat_entry =3D &dest=
->entries[i];
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0if (nat_entry && nat_entry->network =3D=3D 0=
xFFFFFFFF)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0{
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct in_addr addr;
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0nat_entry->network =3D ntohl(l=
ocal_ip);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0addr.s_addr =3D nat_entry->net=
work;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0char *dot_ip =3D inet_ntoa(add=
r);
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0msg (M_INFO, "Updating NAT tab=
le client-ip to: %s", dot_ip);

Logging this always with M_INFO feel excessive.

Arne


--nqQFsnofEjR0WtnbZm9LzIceNVtCpSSpg--

--sifAs0SdO3SqFLXeiTHLkgkXgAy4hwkVg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE88wmPb+Azu8xbws3FRhsZwKxRFQFAl91wA8ACgkQFRhsZwKx
RFQE9g//Tz5dyjydqQKL8Sg3hJSAAXlwXQhDHYx6bxYCDkLnqdGW0ZQma/aYM1tv
G9rB1cDaHbNNVne77PYw6wXYMDXHi6N8X1WHrPsogZUk8nTANewKsGKjvXTa9J/c
0Ks7PNkLuB8IQToLs6kZwxQ85xPWn0NFHzAlRLJk9eY9LNxTz4V3fsa60YqbZbip
X81tIvwnIfX06PuBKu52NYEmzP0TvRzKmq0i5wnfJIPCGucxNiO9KWvfQXq6eln3
MAz1qc83xOXKqlqV3vXYW+IMt+Qa41JTBgIGnXz5kNF2SrFYzCjydaCaQSpYtrhL
1KZcKgyHjHEBW4X2hwQ+ZbJVPjA154mO8EMyvI+QeH8wfxDedTt1AOA1J2MEcEdV
A+zqsn/5VUK/TfakOSxERTv+MiVlB5wOtEz9AmFFoAi7ITyBkbCwiA+UR/30qbhB
nhyo1F6tWCTcvh4y8Hs6p1UQJ5Jk/g6/inO2GivOPkAgw0pVjPv8xBlfELBjM9pR
ztr998foYka9XXSmcCKO0iHo3ABQbItu+OQIi8WEquFafHmLDyKfobLEL5KpnZ0d
kVxTGZG9QgA+y94gvyUOCeXZ65MGk75W0PlpFi5vHo+hm5F5Z77FBwd/kZXOQ9Hw
VHG/KBL+6HNkDpo00G1mfVzWAOHJr/EfpVxTr+nSOZVXTah0Qmc=
=r2TZ
-----END PGP SIGNATURE-----

--sifAs0SdO3SqFLXeiTHLkgkXgAy4hwkVg--

