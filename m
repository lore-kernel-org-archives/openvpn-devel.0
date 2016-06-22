MIME-Version: 1.0
In-Reply-To: <CAFHpkQGFnPgNGXnasM5Tcwbx1yMdYuRes3+cvpNnb=Gq+=obpQ@...278...>
References: <CAFHpkQHX-m9-Ub0WxgpyDx5uWcjyFf=aRN-cUTYt=fJ7dEXc0w@...278...>
	<CAA1AbxK5OUWtYhszHVpD7nXFu1Yh-PQgraZNDE0XtLcs_2_5dA@...278...>
	<CAFHpkQGFnPgNGXnasM5Tcwbx1yMdYuRes3+cvpNnb=Gq+=obpQ@...278...>
From: Steffan Karger <steffan@...1856...>
Date: Wed, 22 Jun 2016 22:41:48 +0200
Message-ID: <CAA1AbxJfdDMHV9PF1Qzpa1FhNBvwKfW-tnnM3w2AO0qh6x9moA@...278...>
Subject: Re: [Openvpn-devel] what is the best way of skipping tests when
 openvpn configured --disable-crypto ?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

On Wed, Jun 22, 2016 at 9:23 PM, =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=
=BF=D0=B8=D1=86=D0=B8=D0=BD <chipitsine@...277...> wrote:
> like that ?
>
> diff --git a/configure.ac b/configure.ac
> index d733023..dc95123 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -1192,6 +1192,7 @@ AM_CONDITIONAL([WIN32], [test "${WIN32}" =3D "yes"])
>  AM_CONDITIONAL([GIT_CHECKOUT], [test "${GIT_CHECKOUT}" =3D "yes"])
>  AM_CONDITIONAL([ENABLE_PLUGIN_AUTH_PAM], [test "${enable_plugin_auth_pam=
}"
> =3D "yes"])
>  AM_CONDITIONAL([ENABLE_PLUGIN_DOWN_ROOT], [test
> "${enable_plugin_down_root}" =3D "yes"])
> +AM_CONDITIONAL([ENABLE_CRYPTO], [test "${enable_crypto}" =3D "yes"])
>
>  plugindir=3D"${with_plugindir}"
>  sampledir=3D"\$(docdir)/sample"
> diff --git a/tests/Makefile.am b/tests/Makefile.am
> index 2cba9e6..235cd13 100644
> --- a/tests/Makefile.am
> +++ b/tests/Makefile.am
> @@ -14,7 +14,10 @@ MAINTAINERCLEANFILES =3D \
>
>  SUBDIRS =3D unit_tests
>
> -test_scripts =3D t_client.sh t_lpback.sh t_cltsrv.sh
> +test_scripts =3D t_client.sh
> +if ENABLE_CRYPTO
> +test_scripts +=3D t_lpback.sh t_cltsrv.sh
> +endif
>
>  TESTS_ENVIRONMENT =3D top_srcdir=3D"$(top_srcdir)"
>  TESTS =3D $(test_scripts)

Ah, this is even cleaner than AC_SUBST.  But this matches what I had
in mind, yes.  (I didn't test, but I assume this simply doesn't run
these tests?)

-Steffan

