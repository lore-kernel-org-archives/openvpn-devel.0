Date: Sat, 11 Jul 2020 12:44:48 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20200711104448.GH1431@...1296...>
References: <f664dcaf-7224-1b17-c953-584557f2ac56@...1147...>
 <CAKuzo_iFf2iuOLg4LpXrz42MG1GggvdrcWKJrcDT6j38tQjrUw@...278...>
 <20200624102804.GM1431@...1296...>
 <50ad64e7-b75c-e40b-5d5e-9e89e90db45d@...1147...>
 <20200630141103.GY1431@...1296...>
 <67f23584-07bd-7f0a-de1d-6ac285342e46@...1147...>
 <20200706161532.GH1431@...1296...>
 <e5be8b49-0689-eb96-b294-f5b50388a67b@...1147...>
 <20200708082428.GT1431@...1296...>
 <198ea3c8-a306-6a52-eaf6-e88aca10812b@...1147...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="EwT+ufSHFf9p3Wph"
Content-Disposition: inline
In-Reply-To: <198ea3c8-a306-6a52-eaf6-e88aca10812b@...1147...>
Subject: Re: [Openvpn-devel] [PATCH] [V4] Added support for DHCP option 119
 (dns search suffix,
 list) for Windows. As of Windows 10 1809 Windows finally supports this so it,
 makes sense to add support to OpenVPN as well.
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

--EwT+ufSHFf9p3Wph
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Jul 10, 2020 at 06:42:18PM +0200, Jan Just Keijser wrote:
> On 08/07/20 10:24, Gert Doering wrote:
> > Can I have a v4, please? :-)
> V4:

Okay, here we go...


Generally speaking, it works now :-)

In the "ipconfig /all" output, I can now see a long list of DNS suffixes.

Together with a DNS search list on the LAN *and* block-outside-dns, this
seems to have interesting effects on Win10 - namely, it tries all the
search domains it has (on all interfaces), but it will try the "LAN"
search domains only via the "LAN" nameservers - and these are blocked,
so there might be interesting side effects if both are used togehter -
*or* it might be a way to get Win10 DNS to behave better even without
block-outside-DNS (by configuring a search domain on the TAP side).


Codewise, a few remarks...


> @@ -1145,6 +1146,19 @@ parse_hash_fingerprint(const char *str, int nbytes=
, int msglevel, struct gc_aren
>  #ifndef ENABLE_SMALL
>=20=20
>  static void
> +show_dhcp_option_list(const char *name, const char * const*array, int le=
n)
> +{
> +    int i;
> +    for (i =3D 0; i < len; ++i)
> +    {
> +        msg(D_SHOW_PARMS, "  %s[%d] =3D %s",
> +            name,
> +            i,
> +            array[i] );
> +    }
> +}

This is not "forbidden" by the style guide, but I think a more compact
form would increase readability - the old openvpn style of having=20
individual function calls spread over 10+ lines because each parameter
is getting its own line is not really something we do anymore.  So:

> +        msg(D_SHOW_PARMS, "  %s[%d] =3D %s", name, i, array[i] );

... which is well below the 80 character limit and which I find more
readable, tbh.


> +/*
> + * RFC3397 states that multiple searchdomains are encoded as follows:
> + *  - at start the length of the entire option is given
> + *  - each subdomain is preceded by its length
> + *  - each searchdomain is separated by a NUL character
> + * e.g. if you want "openvpn.net" and "duckduckgo.com" then you end up w=
ith
> + *  0x13  0x7 openvpn 0x3 net 0x00 0x0A duckduckgo 0x3 com 0x00

While at it, 0x1D :-)

> + */
> +static void
> +write_dhcp_search_str(struct buffer *buf, const int type, const char * c=
onst *str_array,
> +                      int array_len, bool *error)
> +{
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

This line should not stay as it is - if you see it in the log, it's
mostly unclear "it's processing 'domain' - what for?", and M_INFO is
too high for unspecific info.

Most other DHCP activities do not log anything (unless error), so for
consistency I would just remove it.  But if we keep it, it needs to
be more clear, like

> +        msg(D_DHCP_OPT, "dhcp search domain '%s'", ptr);

or something like that.


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

Side note: this violate coding style - for(), as if(), mandates brackets.

> +            for (k=3D0; k < j; k++)=20
               {
	           tmp_buf[len++] =3D ptr[k];
               }

> +            ptr =3D dotptr + 1;
> +        }=20=20=20
> +
> +        /* Now do the remainder after the last dot */
> +        j =3D strlen(ptr);
> +        tmp_buf[len++] =3D j;
> +        for (k=3D0; k < j; k++) tmp_buf[len++] =3D ptr[k];

same here.

> +=20=20
> +        /* And close off with an extra NUL char */
> +        tmp_buf[len++] =3D 0;
> +    }


With these required brackets, the nested loops get long - and I do not
find them overly elegant anyway (one could do a memcpy(), which would
make more clear what is done, but it's still double-looping).

For this, I had the idea to code it as follows (mentioned yesterday, but
now actually written down) - single pass, no nested loops:

    /* Loop over all subdomains separated by a dot and replace the dot
       with the length of the subdomain */

    /* label_length_pos points to the byte to be replaced by the length=20
     * of the following domain label */
    int label_length_pos =3D len++;

    while(true)
    {
        if (*ptr =3D=3D '.' || *ptr =3D=3D '\0' )
	{
	    tmp_buf[label_length_pos] =3D (len-label_length_pos)-1;
	    label_length_pos =3D len;
	    if (*ptr =3D=3D '\0')
	    {
		break;
	    }
	}
	tmp_buf[len++] =3D *ptr++;
    }
    /* And close off with an extra NUL char */
    tmp_buf[len++] =3D '\0';


(I've actually tested this and it works :-) - wireshark and Win10 confirms
that the result is good - so if you want it, just use it for v5, if not,=20
leave it)

> +
> +    if (!buf_safe(buf, 2 + len))
> +    {
> +        *error =3D true;
> +        msg(M_WARN, "write_search_dhcp_str: buffer overflow building DHC=
P options");
> +        return;
> +    }
> +    if (len > 255)
> +    {
> +        *error =3D true;
> +        msg(M_WARN, "write_dhcp_search_str: search domain string must be=
 <=3D 255 bytes");
> +        return;
> +    }
> +
> +    buf_write_u8(buf, type);
> +    buf_write_u8(buf, len);
> +    for (i=3D0; i < len; i++) buf_write_u8(buf, tmp_buf[i]);
> +}


There's another set of brackets needed here... { buf_write_u8() }

But why use buf_write_u8() and another for() loop at all?

   buf_write(buf, tmp_buf, len);

should do the job just fine...


So - getting close.  Technological issues solved, now style issues
(which are much harder at times :-) ).

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--EwT+ufSHFf9p3Wph
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJfCZgeAAoJEB2Cnv7KVigSYJQL+gNTjwinjbHA8g0V8GakI3op
ptKnFDwJIts+8KSF4LszQ24ayEqx4e1jhYF1t4V8jWRBmRHxvwFmHUuLMWSeM4oP
8p2FZIsU3WmVuoHgTkh9EHkm6dlXK7jsLfiSe94hw7qo6a95tTN1kBGCQ7Sct2ct
db6WLSK44SX2TylV4n+vmAmcw+o+uhm1V9NYeS4Rg2B/UxmSt9V66o2LjCk+51v8
Dj94xMgTT5mWqToZQ5e61w9ud/zZjIWls/ueJxoGI9CtEaXuIXo//flZtsRyJENa
RS38YL6As03hGIvJkIEsgP68Zb0YtsXLZY5jvnlfp6BRajpnOAKPd1WMpVYGPgt4
zbX1nfsQR/KK0BWu6yV0aEIEf1f81avn/AF9QXohCNjsX4SAAp6hlH8q5GvyQKq7
w6gaRTBY7VJkBU+we6jl1ZbM1AYFCEvZif1kMvHd50unt03sm83AYyHW/dsA60ec
l1PzbL8IRz8NfhV2uz2GAemiZhxUWqgFi2DVPMTZAA==
=jv33
-----END PGP SIGNATURE-----

--EwT+ufSHFf9p3Wph--

