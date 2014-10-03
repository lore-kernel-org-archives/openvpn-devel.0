Message-ID: <542EC2B3.6070201@...1114...>
Date: Fri, 03 Oct 2014 17:37:23 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <1412344661-26600-1-git-send-email-openvpn.list@...1114...>
	<CAJ0EP410UgueO4xYY_QohFgA=TLyEghp3ByFVw0pkDDnG1iPEg@...278...>
In-Reply-To: <CAJ0EP410UgueO4xYY_QohFgA=TLyEghp3ByFVw0pkDDnG1iPEg@...278...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="N8uckj00hu4lkEUr785esJ4FHJHhlr73K"
Subject: Re: [Openvpn-devel] [PATCH] systemd: Use systemd functions to
 consider systemd availability
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Mike Gilbert <floppym@...594...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--N8uckj00hu4lkEUr785esJ4FHJHhlr73K
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On 03/10/14 16:47, Mike Gilbert wrote:
>> +AC_ARG_VAR([SYSTEMD_LIBS], [linker flags for systemd])
>> +if test "$enable_systemd" =3D "yes" ; then
>> +    AC_CHECKING([for systemd Library and Header files])
>> +    havesystemdlib=3D1
>> +
>> +    # if SYSTEMD_LIBS is set, we assume it will work, otherwise test
>> +    saved_LIBS=3D"${CFLAGS}"
>> +    LIBS=3D"${LIBS} ${SYSTEMD_LIBS}"
>> +    if test -z "${SYSTEMD_LIBS}"; then
>> +       AC_CHECK_LIB(systemd-daemon, sd_booted,
>> +           [ SYSTEMD_LIBS=3D"-lsystemd-daemon" ],
>> +           [
>> +               AC_MSG_ERROR([systemd-daemon library not found.])
>> +               havesystemdlib=3D0
>> +           ])
>> +    fi
>=20
> Checking for libsystemd-daemon this way will fail with newer releases
> of systemd (>=3D 209), where all systemd libs have been consolidated
> into a single "libsystemd".

Whoops!  Didn't know that.

> Also, why not use PKG_CHECK_MODULES here?

Good catch!  Actually, it was a copy-paste of a section earlier in the
file I knew worked.  But I agree, using PKG_CHECK_MODULES is more
appropriate.

/me goes to prepare a v2 patch

--=20
kind regards,

David Sommerseth


--N8uckj00hu4lkEUr785esJ4FHJHhlr73K
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlQuwrYACgkQDC186MBRfrqZbQCfck87ziH1giR36w/hu92s39qG
eV8AnAxspUP3NSpikbgmOJuI6KvNgvLr
=W2VQ
-----END PGP SIGNATURE-----

--N8uckj00hu4lkEUr785esJ4FHJHhlr73K--

