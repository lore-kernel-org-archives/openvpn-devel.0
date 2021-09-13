Date: Mon, 13 Sep 2021 14:37:06 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <YT9F8nPtG1Xh2adu@...1296...>
References: <20210904095629.6273-1-a@...2181...>
 <20210904095629.6273-8-a@...2181...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="O/DZmLNgsodcXZxc"
Content-Disposition: inline
In-Reply-To: <20210904095629.6273-8-a@...2181...>
Subject: Re: [Openvpn-devel] [PATCH 7/7] add message about changing default
 values
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Antonio Quartulli <a@...2181...>
Cc: openvpn-devel@lists.sourceforge.net

--O/DZmLNgsodcXZxc
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sat, Sep 04, 2021 at 11:56:29AM +0200, Antonio Quartulli wrote:
> Add warning at startup to notify users about the change.
[..]
> +    /* Give a general warning at the end of initialisation that defaults
> +     * have changed */
> +    msg(M_WARN, "Note that modernisation of defaults in OpenVPN 2.6 limi=
ts "
> +                "compatibility with old versions. See Changes.rst and "
> +                "--compat-mode in the manual for details.");
>  }

I have my doubts if this is a good way forward.

This warning will be printed on *every single startup* on OpenVPN now.

Is this useful?  Or will people just ignore it.  Like, "all of a sudden
my Tunnelblick shows some giberrish in red at me, but the VPN is working,=20
so let's just ignore all warnings now".

I can see that we want to tell users, but every single time, forever?

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--O/DZmLNgsodcXZxc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJhP0XyAAoJEB2Cnv7KVigS2mwMAI8L/l1a00addMfDH8OudlQI
58teZrPvxVL57iKVHhKrP0QIFMccKLU61kQ+vUvYze7JhazqyjYmInSpzJeXYk7P
jfOBfUT7CAGsF4myM352y38mAxYyjs7gsd0n/fn2koLOuHkIlkFJEqyTtbUulGdl
3JuACL0VssEILRliXS+j8M9LV4s2stPOGf7AkgHlb654U2sld5NJsBOidTVajetg
ClNe7FYCr3De0d22EkQm5HaZBh/MzJ2/D9Cfjb3nw/4CUYks1BUbVWuiJK0IitQj
ktgj0ZxiBXPHmE5SsKEQ7iI1mWdLD8Gknqc6SiUku1++DB1LwjdG7C+9tqV06/MM
Z29XkOSBvRpMEDgC0g56ZmPqBqO/fmIfvbmbK7aw3V9py6D44lGBG7w+YeikZ+X0
BK/HniPGKg28Z3cUb0jWrlOVX8ECD9+1GQqae7u/ovpos5AfmEk2ACNMGlccdXTp
aEOtYZwxU68ODsAJeEBEI/HMWIk2l1DtHQSEvWTCyw==
=RhV9
-----END PGP SIGNATURE-----

--O/DZmLNgsodcXZxc--

