Message-ID: <4BC81AED.8010206@...1338...>
Date: Fri, 16 Apr 2010 10:08:13 +0200
From: Fabian Knittel <fabian.knittel@...1338...>
MIME-Version: 1.0
References: <4BC78077.80301@...1114...>
In-Reply-To: <4BC78077.80301@...1114...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigC5D04C7DC314FBFB7AA40149"
Subject: Re: [Openvpn-devel] [PATCH] Harden create_temp_filename()
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigC5D04C7DC314FBFB7AA40149
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi David,

David Sommerseth schrieb:
> As promised in the meeting today, a patch for hardening
> create_temp_filename().

Great! :)

> I've added more checks to what create_temp_filename() returns where it
> is called in addition, to make it even safer.

> +  do {
>      uint8_t rndbytes[16];
>      const char *rndstr;
>=20=20
> +    attempts++;
> +    mutex_lock_static (L_CREATE_TEMP);
> +    ++counter;
> +    mutex_unlock_static (L_CREATE_TEMP);
> +
>      prng_bytes (rndbytes, sizeof (rndbytes));
>      rndstr =3D format_hex_ex (rndbytes, sizeof (rndbytes), 40, 0, NULL, =
gc);
>      buf_printf (&fname, PACKAGE "_%s_%s.tmp", prefix, rndstr);
> +
> +    retfname =3D gen_path (directory, BSTR (&fname), gc);
> +    if( !retfname ) {
> +      msg (M_FATAL, "Failed to create temporary filename and path");
> +      return NULL;
> +    }
> +  } while ( test_file (retfname) && (attempts < 6) );
> +
> +  if( attempts > 5 ) {
> +    msg (M_FATAL, "Failed to create temporary file after %i attempts", a=
ttempts);
> +    return NULL;
> +  }
> +
> +  /* Create the tempfile to avoid a race condition */
> +  fd =3D creat (retfname, S_IRUSR | S_IWUSR);
> +  if( fd =3D=3D -1 ) {

You'll probably want to add O_EXCL to creat()'s mode flags:

|        O_EXCL Ensure that this call creates the file: if this flag  is
 speci=E2=80=90
|               fied  in  conjunction with O_CREAT, and pathname already
exists,
|               then open() will fail.  The behavior of O_EXCL is
undefined  if
|               O_CREAT is not specified.

Otherwise, there would be a race-condition between test_file() and
creat() and someone could create a symlink under you feet.

And as the important "does it exist?" test thereby moves to creat(), I
would like to suggest that you move the creat() call into the loop. The
 exit condition would then be "successful creat()" or "max attempts".

Cheers
Fabian

PS: Is there some kind of code style guide for OpenVPN? I notice that
    you're using a different style than I expected to see...


--------------enigC5D04C7DC314FBFB7AA40149
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iEYEARECAAYFAkvIGvMACgkQARH1aMTipzOIBwCfX9dfAntr1bZxpsw7g8t5qnKc
FAwAnjQ2fF/ZWq/2ebjlyxYkrgMMUt31
=JQWy
-----END PGP SIGNATURE-----

--------------enigC5D04C7DC314FBFB7AA40149--

