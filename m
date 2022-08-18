Date: Thu, 18 Aug 2022 10:06:19 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <Yv3y+x9CHVa+5fyS@...1296...>
References: <20220813204224.22576-1-a@...2181...>
 <20220813204224.22576-2-a@...2181...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="k7EFfQoLy2R+D5CY"
Content-Disposition: inline
In-Reply-To: <20220813204224.22576-2-a@...2181...>
Subject: Re: [Openvpn-devel] [PATCH v101 2/7] dco-win: check for
 incompatible options
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Antonio Quartulli <a@...2181...>
Cc: openvpn-devel@lists.sourceforge.net, Lev Stipakov <lev@...515...>

--k7EFfQoLy2R+D5CY
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sat, Aug 13, 2022 at 10:42:19PM +0200, Antonio Quartulli wrote:
> At the moment dco-win doesn't support --persist-tun and --server,
> so check for these options at startup time.

This needs rebasing anyway (due to the startup change), but while at it...

> +
> +    if (options->windows_driver =3D=3D WINDOWS_DRIVER_DCO)
> +    {
> +        dco_check_option_conflict(M_USAGE, options);
> +    }

... this should read "if (dco_enabled(options))", no?  Patch 3/7 changes
dco_enabled() to do exactly this "if (driver =3D=3D WINDOWS_DRIVER_DCO)" and
it would make *this* function more clear.

OTOH, the first thing dco_check_options_conflict() does is "check
if DCO is enabled at all", so why check it in the caller again?


Staring at this for a while, I do wonder why we do the "linux DCO"
options check in options_postprocess_mutate(), and the "Win32 DCO"
options check in options_postprocess_verify_ce() (while it does not
look at the actual ->ce entries, and really *really* does not belong).

Can we please clean this up, and have one joint call for all DCO
platforms?  I see no good reason for having two calls to the same
function, doing the same thing, in two different call chains for
different OSes.


Now there is a material difference, if the Win32 invocation finds
a dco-incompatible option, it will exit M_USAGE, while Linux will just
disable DCO - if this is what we want, we should still keep the stuff
closer together, like

    /* check if any option should force disabling DCO */
#if defined(TARGET_LINUX) || defined(TARGET_FREEBSD)
    o->tuntap_options.disable_dco =3D !dco_check_option_conflict(D_DCO, o)
                                    || !dco_check_startup_option_conflict(D=
_DCO,
 o);
#else if _WIN32
    /* we can not currently fallback to non-DCO on Windows, so exit M_USAGE
     * if an option conflict is discovered */
    dco_check_option_conflict(M_USAGE, o);
    dco_check_startup_option_conflict(M_USAGE, o);
#endif


gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--k7EFfQoLy2R+D5CY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJi/fL7AAoJEB2Cnv7KVigS5ykMAI1PjB9ZKXFTvehHjqR3LEEL
WDKobgIv34CbHFrRI3tc8Lhdkb0dT/5bvBT6hNCVMEQC63/i6nHCi2Rgc8UrNmzw
pWJu1HeMcYPZhLVu5ySO+PkAU+kmYRSH9a2nk+AuzQC5lz6ysOjUHsHVxlnwoqzU
gbHBwfxECB7smvEj3uSuNrM2qOGpeZUHhqY3PxfGhEJzXpUgFF3sj4WnZ+NNobWQ
K/HLfwDDTu3mNfBmOv0atP3XqE7KEOz4goHsA91hiNAbX3eFJa8iu1NAfO84NEiM
kBb81ZBu7QGMa43SMwn2rFH6cpDQ7QBRcul6O4txvyYk0d+DxQ7GTJw1qCDix909
nBDurcmdHMXks6UNAF9kW81ApilClWMMkckn0fqKCMhfQkSwkD02R6nY9Cv9wNJ3
oDq8do3UGjhY6+Z3uFP+XooM3Ot2u3WS0579QLuzuZgKTrrf8SAbhr2O9jOny383
fW3x+EzcMSXmEiZSJwzI0dWGesjnrzFLGkbGxfIuIg==
=Kns7
-----END PGP SIGNATURE-----

--k7EFfQoLy2R+D5CY--

