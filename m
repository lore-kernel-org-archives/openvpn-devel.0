Message-ID: <5437B156.1020408@...1114...>
Date: Fri, 10 Oct 2014 12:13:42 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <20141009214049.GB4106@...1818...>
In-Reply-To: <20141009214049.GB4106@...1818...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="nS4fpEtb59P6pEURHBsrIclLML96OrEdu"
Subject: Re: [Openvpn-devel] [PATCH] Fix temporary file leak
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Samuel Thibault <samuel.thibault@...1817...>
Cc: openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--nS4fpEtb59P6pEURHBsrIclLML96OrEdu
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

On 09/10/14 23:40, Samuel Thibault wrote:
> Hello,
>=20
> Our openvpn server got out of free inodes in /tmp, making it quite
> completely nonworking.  This is due to some codepath in multi.c which
> does not remove its temporary file (when a plugin callback returns an
> error, or a client-connect script returns an error).  Please see the
> attached patch which fixes this.
>=20
> Samuel
>=20
>=20
> patch
>=20
>=20
> diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
> index 5910154..d0ed147 100644
> --- a/src/openvpn/multi.c
> +++ b/src/openvpn/multi.c
> @@ -1699,6 +1705,9 @@ multi_connection_established (struct multi_context =
*m, struct multi_instance *mi
>  	    {
>  	      msg (M_WARN, "WARNING: client-connect plugin call failed");
>  	      cc_succeeded =3D false;
> +	      if (!platform_unlink (dc_file))
> +		msg (D_MULTI_ERRORS, "MULTI: problem deleting temporary file: %s",
> +		     dc_file);
>  	    }
>  	  else
>  	    {
> @@ -1757,7 +1766,12 @@ multi_connection_established (struct multi_context=
 *m, struct multi_instance *mi
>  	      ++cc_succeeded_count;
>  	    }
>  	  else
> -	    cc_succeeded =3D false;
> +	    {
> +	      cc_succeeded =3D false;
> +	      if (!platform_unlink (dc_file))
> +		msg (D_MULTI_ERRORS, "MULTI: problem deleting temporary file: %s",
> +		     dc_file);
> +	    }
>          script_failed:
>  	  argv_reset (&argv);
>  	}
>=20

Good catch!  But I'm not convinced about this approach, from a code
quality perspective.  Now we have the unlinking of these temp files two
places.  In multi_client_connect_post() if the plug-in(s) didn't fail,
or in multi_connection_established() if the plug-in failed.

I think it would be better to move the unlink() code from
multi_client_connect_post() into multi_connection_established(), where
these temp files are created.  This makes the code clearer and easier to
understand.  And you can have a label and goto statement in the error
section, similar to what's already done (look for script_depr_failed:
and script_failed:).


--=20
kind regards,

David Sommerseth



--nS4fpEtb59P6pEURHBsrIclLML96OrEdu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlQ3sVgACgkQDC186MBRfroBAQCcDnao6YewAc3QkzxwNoHHn+xu
SVIAoJrcsIoXdkoW6gZ+26GhohsCST24
=uCQE
-----END PGP SIGNATURE-----

--nS4fpEtb59P6pEURHBsrIclLML96OrEdu--

