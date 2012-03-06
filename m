Message-ID: <4F55E057.4060603@...1114...>
Date: Tue, 06 Mar 2012 11:00:55 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <1330546342-17794-1-git-send-email-alon.barlev@...277...>
	<1330546342-17794-3-git-send-email-alon.barlev@...277...>
	<4F55DE83.4090801@...515...>
In-Reply-To: <4F55DE83.4090801@...515...>
Subject: Re: [Openvpn-devel] [PATCH 02/52] package: rpm: strip should be
 handled by package management
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
To: =?ISO-8859-1?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
Cc: Alon Bar-Lev <alon.barlev@...277...>, "Openvpn-devel@lists.sourceforge.net" <Openvpn-devel@lists.sourceforge.net>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 06/03/12 10:53, Samuli Sepp=E4nen wrote:
>=20
>> Signed-off-by: Alon Bar-Lev <alon.barlev@...277...> ---=20
>> openvpn.spec.in |    1 - 1 files changed, 0 insertions(+), 1
>> deletions(-)
>>=20
>> diff --git a/openvpn.spec.in b/openvpn.spec.in index
>> c5178e9..c42e7c6 100644 --- a/openvpn.spec.in +++ b/openvpn.spec.in=20
>> @@ -101,7 +101,6 @@ and portability to most major OS platforms.=20
>> %build %configure --disable-dependency-tracking
>> %{?with_password_save:--enable-password-save}
>> %{?without_lzo:--disable-lzo}
>> %{?with_kerberos:--with-ssl-headers=3D/usr/kerberos/include} %__make=20
>> -%__strip %{name}
>>=20
>> # Build down-root plugin pushd plugin/down-root
>=20
> Let's see if I understood this correctly... the binary is stripped=20
> anyways when the package is installed? On a CentOS 6 box I have this
> in "rpm --showrc" output[1]:
>=20
> -14: __os_install_post %{_rpmconfigdir}/brp-compress=20
> %{_rpmconfigdir}/brp-strip %{_rpmconfigdir}/brp-strip-static-archive=20
> %{_rpmconfigdir}/brp-strip-comment-note
>=20
> If so, I give this one an ACK.

That's correct, according to what I remember from the Fedora packaging
guidelines.  The .spec file should not strip packages explicit.  The
rpmbuild process will take care of that, which will also create the
debuginfo files during that process.  If explicit stripping the binaries
in the .spec file, there won't be any debuginfo files either.

The Fedora packaging rules also applies to EPEL, which then (kind of)
hits RHEL, CentOS and ScientificLinux as well.


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk9V4FUACgkQDC186MBRfrogGwCdFnC9pPmXYjEFfFF0Yyon78kG
6aEAn207GtSWS437XpN9mDoCGtXNm3iI
=3DgJ2V
-----END PGP SIGNATURE-----

