Message-ID: <4C6BD3CB.5050009@...68...>
Date: Wed, 18 Aug 2010 14:36:27 +0200
From: Matthias Andree <matthias.andree@...68...>
MIME-Version: 1.0
References: <1282134451-21285-1-git-send-email-dazo@...384...>
In-Reply-To: <1282134451-21285-1-git-send-email-dazo@...384...>
Subject: Re: [Openvpn-devel] [PATCH] Test framework improvment - Do not FAIL
 if	t_client.rc is missing
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Am 18.08.2010 14:27, schrieb David Sommerseth:
> This is to avoid 'make check' fail if this extra test case is not
> configured.  The patch gives a PASS, but will notify the user that
> this test was skipped.

The right approach would be to "exit 77" instead of 0,
so that "make check" can report the SKIP properly.  Assuming that t_client.sh is
listed in TESTS in some Makefile.am, which I didn't check.

> 
> Signed-off-by: David Sommerseth <dazo@...384...>
> ---
>  t_client.sh.in |   20 ++++++++++----------
>  1 files changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/t_client.sh.in b/t_client.sh.in
> index 664b2fd..c920a4f 100755
> --- a/t_client.sh.in
> +++ b/t_client.sh.in
> @@ -12,6 +12,16 @@
>  # - for "ping6" checks: fping6 binary in $PATH
>  #
>  
> +if [ -r ./t_client.rc ] ; then
> +    . ./t_client.rc
> +elif [ -r "${srcdir}"/t_client.rc ] ; then
> +    . "${srcdir}"/t_client.rc
> +else
> +    echo "$0: cannot find 't_client.rc' in current directory or" >&2
> +    echo "$0: source dir ('${srcdir}').  SKIPPING TEST." >&2
> +    exit 0
> +fi
> +
>  if [ ! -x ./openvpn ]
>  then
>      echo "no (executable) openvpn binary in current directory. FAIL." >&2
> @@ -24,16 +34,6 @@ then
>      exit 1
>  fi
>  
> -if [ -r ./t_client.rc ] ; then
> -    . ./t_client.rc
> -elif [ -r "${srcdir}"/t_client.rc ] ; then
> -    . "${srcdir}"/t_client.rc
> -else
> -    echo "cannot find 't_client.rc' in current directory or" >&2
> -    echo "source dir ('${srcdir}').  FAIL." >&2
> -    exit 1
> -fi
> -
>  if [ -z "$CA_CERT" ] ; then
>      echo "CA_CERT not defined in 't_client.rc'. SKIP test." >&2
>      exit 0


-- 
Matthias Andree

