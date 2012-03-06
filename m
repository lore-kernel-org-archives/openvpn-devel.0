Message-ID: <4F55DE83.4090801@...515...>
Date: Tue, 06 Mar 2012 11:53:07 +0200
From: =?ISO-8859-1?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
MIME-Version: 1.0
References: <1330546342-17794-1-git-send-email-alon.barlev@...277...>
	<1330546342-17794-3-git-send-email-alon.barlev@...277...>
In-Reply-To: <1330546342-17794-3-git-send-email-alon.barlev@...277...>
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
To: Alon Bar-Lev <alon.barlev@...277...>
Cc: "Openvpn-devel@lists.sourceforge.net" <Openvpn-devel@lists.sourceforge.net>


> Signed-off-by: Alon Bar-Lev <alon.barlev@...277...>
> ---
>  openvpn.spec.in |    1 -
>  1 files changed, 0 insertions(+), 1 deletions(-)
>
> diff --git a/openvpn.spec.in b/openvpn.spec.in
> index c5178e9..c42e7c6 100644
> --- a/openvpn.spec.in
> +++ b/openvpn.spec.in
> @@ -101,7 +101,6 @@ and portability to most major OS platforms.
>  %build
>  %configure --disable-dependency-tracking %{?with_password_save:--enable-=
password-save} %{?without_lzo:--disable-lzo} %{?with_kerberos:--with-ssl-he=
aders=3D/usr/kerberos/include}
>  %__make
> -%__strip %{name}
>=20=20
>  # Build down-root plugin
>  pushd plugin/down-root

Let's see if I understood this correctly... the binary is stripped
anyways when the package is installed? On a CentOS 6 box I have this in
"rpm --showrc" output[1]:

-14: __os_install_post=20
    %{_rpmconfigdir}/brp-compress
    %{_rpmconfigdir}/brp-strip
    %{_rpmconfigdir}/brp-strip-static-archive
    %{_rpmconfigdir}/brp-strip-comment-note

If so, I give this one an ACK.

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock


[1] See
<http://groups.google.com/group/linux.redhat.rpm/browse_thread/thread/4cacf=
a2591cad1c9>


