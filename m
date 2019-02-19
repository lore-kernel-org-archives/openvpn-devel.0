References: <1550368541-10402-1-git-send-email-selva.nair@...277...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <ad1a285d-fa22-54b0-01ac-9a066e752065@...2080...>
Date: Tue, 19 Feb 2019 18:39:31 +0100
MIME-Version: 1.0
In-Reply-To: <1550368541-10402-1-git-send-email-selva.nair@...277...>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="pFrSRVNQ7aWjZ2ym5d1JRcbDdDCytmWtb"
Subject: Re: [Openvpn-devel] [PATCH] Better error message when script fails
 due to script-security setting
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: selva.nair@...277..., openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--pFrSRVNQ7aWjZ2ym5d1JRcbDdDCytmWtb
Content-Type: multipart/mixed; boundary="2yWjKO91v5OXGezLslFWlmLfScsLgXaiX";
 protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
To: selva.nair@...277..., openvpn-devel@lists.sourceforge.net
Message-ID: <ad1a285d-fa22-54b0-01ac-9a066e752065@...2080...>
Subject: Re: [Openvpn-devel] [PATCH] Better error message when script fails
 due to script-security setting
References: <1550368541-10402-1-git-send-email-selva.nair@...277...>
In-Reply-To: <1550368541-10402-1-git-send-email-selva.nair@...277...>

--2yWjKO91v5OXGezLslFWlmLfScsLgXaiX
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On 17/02/2019 02:55, selva.nair@...277... wrote:
> From: Selva Nair <selva.nair@...277...>
>=20
> - Add a new return value (-2) for openvpn_execve() when external
> program execution is not allowed due to a low script-security
> setting.
>=20
> - Add a corresponding error message
>=20
> Errors and warnings in such cases will now display as
> "WARNING: failed running command (<cmd>) :" followed by
>=20
> "disallowed by script-security setting" on all platforms
>=20
> instead of the current
>=20
> "external program did not execute -- returned error code -1"
> on Windows and
> "external program fork failed" on other platforms.
>=20
> The error is FATAL for some scripts and that behaviour is unchanged.
>=20
> This helps the Windows GUI to detect when a connection failure
> results from a safer script-security setting enforced by the GUI,
> and show a relevant message.
>=20
> Signed-off-by: Selva Nair <selva.nair@...277...>
> ---
> This is being presented as a better alternative for patch 684.
> A separate patch may be needed for 2.4 -- will do if this is found
> acceptable.

Generally speaking, this looks much better and should avoid changing the
behaviour.  It just clarifies the error better.  Feature-ACK from me.


[...]
> diff --git a/src/openvpn/run_command.c b/src/openvpn/run_command.c
> index 2d75a3e..7df7576 100644
> --- a/src/openvpn/run_command.c
> +++ b/src/openvpn/run_command.c
> @@ -65,12 +65,23 @@ system_error_message(int stat, struct gc_arena *gc)
>      {
>          buf_printf(&out, "external program did not execute -- ");
>      }
> -    buf_printf(&out, "returned error code %d", stat);
> +    if (stat =3D=3D -2)
> +    {
> +        buf_printf(&out, "disallowed by script-security setting");
> +    }
> +    else
> +    {
> +        buf_printf(&out, "returned error code %d", stat);
> +    }

Perhaps we could swap out the -1 and -2 values with macro constants, for co=
de
clarity?  Also, perhaps it would look more structured if using a switch()
instead of if()/else if().

Otherwise, the code looks good.

Another interesting are which most likely quite seldom fails, but we actual=
ly
have yet another "undocumented" exit code ...  This is not this patch's fau=
lt,
but should probably be reviewed a bit more carefully.

In run_command.c:149-153:
--------------------------------------------------------------------
            pid =3D fork();
            if (pid =3D=3D (pid_t)0) /* child side */
            {
                execve(cmd, argv, envp);
                exit(127);
            }
--------------------------------------------------------------------

If execve() fails, the exit code is 127.  That would normally be caught by =
the
waitpid() later on and this exit code would be returned by openvpn_execve().

This should be improved in a separate patch though, but is not of high
urgency.  I don't expect most setups having a high execve() failure rate.  =
But
catching it and reporting this error path would be good.


--=20
kind regards,

David Sommerseth
OpenVPN Inc



--2yWjKO91v5OXGezLslFWlmLfScsLgXaiX--

--pFrSRVNQ7aWjZ2ym5d1JRcbDdDCytmWtb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCgAGBQJcbD9eAAoJEIbPlEyWcf3y6XIP/094tBPP5jDFQglPVbxKbtlB
oZp+VwwqNb/ysafvxsIfgmSfVzmZO6CNVprNmZtf7E4qZo/qqVNGHztaF5UchIuo
a8NIfITfPUWVYXNy+1rGbdjVLqRiQd7isdcmBGU3jNXR/IwLmdCiqaoTwc8XFqL9
8MqCOYKNd6HT3Dp9p/2s3uYQRBpva8AITnNaZdGgzEKWqduNPv6xcBvDJhFaCOEN
ZxTmeyx62Cz2yHHfxartizmKN5TlJcIIOoZyrrpd/rm4eeos5+pVJMUlnNlQ92Of
37pZIFoIVFDSSOP4TKpL0tmwcUvaCoQYX4Pad/IO7JjOQPTpv+y2vte8wU0Uq5g1
2JAnet5aSsXcDm2WhR8NnFhsa4UhD7Z2PlDzGc+Ec+EjOp73SW3gsOVThg0Q1khA
fGF/tyohZmdj42MNL8rzNl31w6ToW2ftIAtwABQeo+W1L/raoSX2RnGGL41rIblc
WR8SX0+UGQbAQOpvNp1bBxqaTQZ3HzdF1cSii6y/fZ1YOzHF0uCwH5rrEDlA+5jF
W/MOGc4y81EzptghzoNtzY9D6oaY8vC+YiC90PyVJT61qQBC1VR5w+XO5Cd/imwJ
DMfpURiCAdGY7R27vr45m9dLByBLhHZAWVbCTELBawekj3JuKtnKcqOTS6PBume+
dvbMtL36YEdxRkiIWaaD
=spMS
-----END PGP SIGNATURE-----

--pFrSRVNQ7aWjZ2ym5d1JRcbDdDCytmWtb--

