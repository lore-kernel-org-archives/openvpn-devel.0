References: <20200711093655.23686-1-arne@...1227...>
 <20200711093655.23686-14-arne@...1227...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <51d2684f-0fd1-8cde-bb7d-0240914af6dd@...2080...>
Date: Thu, 16 Jul 2020 23:04:09 +0200
MIME-Version: 1.0
In-Reply-To: <20200711093655.23686-14-arne@...1227...>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="Bo3eB0k6qp2rVZ0jfDM7m2E2BHrg8e05o"
Subject: Re: [Openvpn-devel] [PATCH v5 14/14] client-connect: Add
 documentation for the deferred client connect feature
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Bo3eB0k6qp2rVZ0jfDM7m2E2BHrg8e05o
Content-Type: multipart/mixed; boundary="ZNwLiF6xxc3TdIsZjkXfLimlN15mEsNvr";
 protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
To: Arne Schwabe <arne@...1227...>, openvpn-devel@lists.sourceforge.net
Message-ID: <51d2684f-0fd1-8cde-bb7d-0240914af6dd@...2080...>
Subject: Re: [Openvpn-devel] [PATCH v5 14/14] client-connect: Add
 documentation for the deferred client connect feature
References: <20200711093655.23686-1-arne@...1227...>
 <20200711093655.23686-14-arne@...1227...>
In-Reply-To: <20200711093655.23686-14-arne@...1227...>

--ZNwLiF6xxc3TdIsZjkXfLimlN15mEsNvr
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable


So I'm looking into migrating this text over to the new .rst format ... and=
 I
have a question ...

On 11/07/2020 11:36, Arne Schwabe wrote:
> diff --git a/doc/openvpn.8 b/doc/openvpn.8
> index 03ae5ac5..7a0080bf 100644
> --- a/doc/openvpn.8
> +++ b/doc/openvpn.8
> @@ -3422,6 +3422,13 @@ is significant.  If
>  .B script
>  returns a non\-zero error status, it will cause the client
>  to be disconnected.
> +
> +If a
> +.B \-\-client\-connect cmd
> +wants to defer the generating of the configuration the script, should
> +use the client_connect_deferred_file and client_connect_config_file
> +environment variables and write status accordingly into these files
> +(See the environment section below for more details).
>  .\"*********************************************************
>  .TP
>  .B \-\-client\-disconnect cmd
> @@ -3505,12 +3512,18 @@ This directory will be used by in the following c=
ases:
>=20=20
>  *
>  .B \-\-client\-connect
> -scripts to dynamically generate client\-specific
> -configuration files.
> +scripts and
> +.B OPENVPN_PLUGIN_CLIENT_CONNECT
> +plugin hook
> +to dynamically generate client\-specific configuration files
> +and return success/failure via client_connect_deferred_file
> +when using deferred client connect method
>=20=20
>  *
>  .B OPENVPN_PLUGIN_AUTH_USER_PASS_VERIFY
> -plugin hook to return success/failure via auth_control_file
> +and
> +
> +plugin hook to return success/failure via auth_control_file/
>  when using deferred auth method

This part is oddly rendered, and it seems it lacks something ...

      * OPENVPN_PLUGIN_AUTH_USER_PASS_VERIFY and

        plugin  hook  to  return  success/failure via
auth_control_file/client_connect_deferred_file
        when using deferred auth method


Is this what you intended to say?

      * OPENVPN_PLUGIN_AUTH_USER_PASS_VERIFY plugin hook and
        --client-connect scripts to return success/failure via
        auth_control_file/client_connect_deferred_file when using
        deferred auth method

--=20
kind regards,

David Sommerseth
OpenVPN Inc



--ZNwLiF6xxc3TdIsZjkXfLimlN15mEsNvr--

--Bo3eB0k6qp2rVZ0jfDM7m2E2BHrg8e05o
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCgAGBQJfEMDKAAoJEIbPlEyWcf3ykXMP/A8dy89jDLhqbXVDEPfZKQWX
rEjlpMi7387FVPE2hvl34GvzMQu86ZzECDd6oYsTulnqGjuHzvRch4mvJvE1rXk+
ge8UYhQhcWu1+0pnEfhcWqzhJiau+INkTQwaV7FrA+pIFa98f8/+xLpAGahTfC6T
+mrpgq9+jBhQpdFw0A1Lp3dllO1uDMzIw4tVqTevVPDNKYw9vLxb/DPmqiad0ICh
hRqTdAdkQuWn+eGJzjol1qgZ7tqipt9nxkuM+kqSAfj46BArgfUjmijg+70uptLX
wtJRpytsoA8w7Gg1oD9Xi9x/Dt2vfl5I+njh2w2og1rGjAHQVy1xUp6BDrAl+QyC
DgSAAKYB73ygKHuU1yGFGdA8wgVsdWSQV0Xb9/Ndt3EysfHfh0Bq0TMbEoeFjdlo
O42ntCLO1XGAxC9meM4ZmnlSEiUypXs2zGJUnCPVdt1zimtuzBHiIv0hTqgMR087
LzNPaQVEYGxJ7R5ClbWiFWwqPDp42DX8LuSH6UpnMyTsT+322mllI2ZP2vO5l607
ZKRhkpdZKuVhIrJSdErV55hHyPMtg80iEPkwd4PkT+bMxTMGc6hReTFGgZUXw8O0
+cuX2norY4wFUpTNC7WyXQqsyQVmIIHWB0dmABTSdPYjxiJrKRPzW8Gk2qWXWDXE
N/IN7KFiTdYkctNTPJ0M
=TDPT
-----END PGP SIGNATURE-----

--Bo3eB0k6qp2rVZ0jfDM7m2E2BHrg8e05o--

