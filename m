Date: Wed, 8 Jul 2020 10:24:28 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20200708082428.GT1431@...1296...>
References: <20200621111403.GP1431@...1296...>
 <CAKuzo_h2oTaNK7A3+3MJ6GSfApr9L9vXYFtzELH8SaaNzqFWuQ@...278...>
 <f664dcaf-7224-1b17-c953-584557f2ac56@...1147...>
 <CAKuzo_iFf2iuOLg4LpXrz42MG1GggvdrcWKJrcDT6j38tQjrUw@...278...>
 <20200624102804.GM1431@...1296...>
 <50ad64e7-b75c-e40b-5d5e-9e89e90db45d@...1147...>
 <20200630141103.GY1431@...1296...>
 <67f23584-07bd-7f0a-de1d-6ac285342e46@...1147...>
 <20200706161532.GH1431@...1296...>
 <e5be8b49-0689-eb96-b294-f5b50388a67b@...1147...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="bcyNnEp43zD4gI3N"
Content-Disposition: inline
In-Reply-To: <e5be8b49-0689-eb96-b294-f5b50388a67b@...1147...>
Subject: Re: [Openvpn-devel] [Openvpn-users] Multiple DNS search suffixes on
 Windows
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Jan Just Keijser <janjust@...1147...>
Cc: Gert Doering <gert@...1296...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--bcyNnEp43zD4gI3N
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Jul 07, 2020 at 06:14:25PM +0200, Jan Just Keijser wrote:
> > This one works(!), so generally, Win10 accepts this DHCP option - but
> > it seems to want "all domains in one".
> >
> > Can you send a v3?
> >
> not sure if all went well , but here's V3.

Unfortunately not, that one seems to be based on your V1 patch, so=20
we have "remove 'SEARCH', add 'DOMAIN-SEARCH'" hunks...

> diff --git a/src/openvpn/options.c b/src/openvpn/options.c
> index e59b22b..85f1d8a 100644
> --- a/src/openvpn/options.c
> +++ b/src/openvpn/options.c
> @@ -726,7 +726,7 @@ static const char usage_message[] =3D
>      "                    which allow multiple addresses,\n"
>      "                    --dhcp-option must be repeated.\n"
>      "                    DOMAIN name : Set DNS suffix\n"
> -    "                    SEARCH name : Set DNS domain search list\n"
> +    "                    DOMAIN-SEARCH entry : Add entry to DNS domain s=
earch list\n"

This is ok for me to have a look, but to actually merge I need something
that applies "as it is" on top of master...

> diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
> index eed9ae6..60a149c 100644
> --- a/src/openvpn/tun.c
> +++ b/src/openvpn/tun.c
> @@ -5567,46 +5567,70 @@ write_dhcp_str(struct buffer *buf, const int type=
, const char *str, bool *error)
>      buf_write(buf, str, len);
>  }
>=20=20
> +/*
> + * RFC3397 states that multiple searchdomains are encoded as follows:
> + *  - at start the length of the entire option is given
> + *  - each subdomain is preceded by its length
> + *  - each searchdomain is separated by a NUL character
> + * e.g. if you want "openvpn.net" and "duckduckgo.com" then you end up w=
ith
> + *  0x13  0x7 openvpn 0x3 net 0x00 0x0A duckduckgo 0x3 com 0x00
> + */

Richard commented on IRC that the "0x13" does not seem to be right here
- adding up all of it (1+7+1+3+1+1+10+1+3+1 =3D 29).  Can you double-check?

It's just a comment, but if that is wrong, it's not helpful in trying to
understand the code.

>  static void
> -write_dhcp_search_str(struct buffer *buf, const int type, const char *st=
r, bool *error)
> +write_dhcp_search_str(struct buffer *buf, const int type, const char * c=
onst *str_array,
> +                      int array_len, bool *error)
>  {
> -    const char  *ptr =3D str, *dotptr =3D str;
> -    int          i, j;
> +    char         tmp_buf[256];
> +    int          i;
> +    int          len =3D 0;
> +
> +    for (i=3D0; i < array_len; i++)
> +    {
> +        const char  *ptr =3D str_array[i], *dotptr =3D str_array[i];
> +        int          j, k;
> +
> +        msg(M_INFO, "Processing '%s'", ptr);
> +
> +        if (strlen(ptr) + len + 1 > sizeof(tmp_buf))
> +        {
> +            *error =3D true;
> +            msg(M_WARN, "write_dhcp_search_str: temp buffer overflow bui=
lding DHCP options");
> +            return;
> +        }
> +        /* Loop over all subdomains separated by a dot and replace the d=
ot
> +           with the length of the subdomain */
> +        while ((dotptr =3D strchr(ptr, '.')) !=3D NULL)
> +        {=20=20=20
> +            j =3D dotptr - ptr;
> +            tmp_buf[len++] =3D j;
> +            for (k=3D0; k < j; k++) tmp_buf[len++] =3D ptr[k];
> +            ptr =3D dotptr + 1;
> +        }=20=20=20
> +
> +        /* Now do the remainder after the last dot */
> +        j =3D strlen(ptr);
> +        tmp_buf[len++] =3D j;
> +        for (k=3D0; k < j; k++) tmp_buf[len++] =3D ptr[k];

This should work.  It might be possible to do this with slightly less
code with strsep()  (which will give you nicely null-terminated chunks,
including "the remainder", but will require a writeable copy of the string).

It's overflow safe, so "good enough".

The restriction to max. 10 search domains sounds reasonable to me - since
the total string is limited, and we do not implement multiple options
(*and* windows 10 is, by observation, ignoring more than one anyway) this
is "good enough for all reasonable deployments".


Can I have a v4, please? :-)

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--bcyNnEp43zD4gI3N
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJfBYK8AAoJEB2Cnv7KVigSTKsL/RhMfWJIIkp5jXnZIDL1/lQM
UWfUTIw1BDlR6hD0Lgp1MJjM9Zb//gy49RtGFUynDNx55r1aJH/T5x71kbfyXlkD
Q5bUMH+sFbeEoXCDWPfHG016JRyWxZD+DiwhrkLYedIImNHx+gn0z+5RYbE0uGRT
ACDn2eTCUeBrhQGC1Oa8EA52AEOUQP31adspS+VDs4b/VJg9smB5Yo3IUSStGasE
dPSzLBmsoFMCUZUhObQIsnTUufOZ1dNbCzOfB1XUud+KCfQpay11qhg7+LrY/M90
/Vd6ewIEZcuSg5iOt8Ikw/rkHxQIhJiQZG72hdnCHOU50XcdnSwx89kHTCjoJ0BY
QGdBLPYYwFOTrJGi5eN1sM4YPTyJaBN0BOwUOkTmfecI+4fUzCp37ujs5iCxndwI
fru3mMngNx/Q1PTgYY4+JkNDHd15wPJrFLINliNARYdVQ6TJt1aSrQi3dOLjrgy3
r/xcjBIXInlvJcpw1sZKFZlbR/jJTU5BUkXUtApVhA==
=tCd/
-----END PGP SIGNATURE-----

--bcyNnEp43zD4gI3N--

