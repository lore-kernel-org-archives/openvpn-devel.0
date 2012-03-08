Message-ID: <4F58B9A5.2040603@...515...>
Date: Thu, 08 Mar 2012 15:52:37 +0200
From: =?ISO-8859-1?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
MIME-Version: 1.0
References: <1330546342-17794-1-git-send-email-alon.barlev@...277...>
	<1330546342-17794-52-git-send-email-alon.barlev@...277...>
In-Reply-To: <1330546342-17794-52-git-send-email-alon.barlev@...277...>
Subject: Re: [Openvpn-devel] [PATCH 51/52] build: distribute samples in
	windows
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
To: Alon Bar-Lev <alon.barlev@...277...>
Cc: "Openvpn-devel@lists.sourceforge.net" <Openvpn-devel@lists.sourceforge.net>

So, this essentially makes sure client.conf and server.conf are included
in Windows (installers) as client.ovpn and server.ovpn?

If so, ACK.

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock




> Signed-off-by: Alon Bar-Lev <alon.barlev@...277...>
> ---
>  configure.ac       |    3 +++
>  sample/Makefile.am |   14 ++++++++++++++
>  2 files changed, 17 insertions(+), 0 deletions(-)
>
> diff --git a/configure.ac b/configure.ac
> index 0f2a62e..2b095a3 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -903,6 +903,9 @@ AC_SUBST([OPTIONAL_PKCS11_HELPER_LIBS])
>=20=20
>  AM_CONDITIONAL([WIN32], [test "${WIN32}" =3D "yes"])
>=20=20
> +sampledir=3D"\$(docdir)/sample"
> +AC_SUBST([sampledir])
> +
>  AC_CONFIG_FILES([
>  	version.sh
>  	Makefile
> diff --git a/sample/Makefile.am b/sample/Makefile.am
> index 5df8d9c..8e35bfc 100644
> --- a/sample/Makefile.am
> +++ b/sample/Makefile.am
> @@ -17,3 +17,17 @@ EXTRA_DIST =3D \
>  	sample-windows \
>  	sample-keys \
>  	sample-scripts
> +
> +if WIN32
> +sample_DATA =3D \
> +	client.ovpn \
> +	server.ovpn \
> +	sample-windows/sample.ovpn
> +
> +client.ovpn: sample-config-files/client.conf
> +	-rm -f client.ovpn
> +	cp "$(srcdir)/sample-config-files/client.conf" client.ovpn
> +server.ovpn: sample-config-files/server.conf
> +	-rm -f server.ovpn
> +	cp "$(srcdir)/sample-config-files/server.conf" server.ovpn
> +endif



