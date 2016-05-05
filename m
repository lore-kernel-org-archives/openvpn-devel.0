MIME-Version: 1.0
In-Reply-To: <20160505115050.GA81579@...1296...>
References: <1462126986-2686-1-git-send-email-steffan@...1856...>
	<20160505115050.GA81579@...1296...>
From: Steffan Karger <steffan@...1856...>
Date: Thu, 5 May 2016 14:18:43 +0200
Message-ID: <CAA1AbxLzLH-YfBRGjNk3RrZk6WBJ2_=bf__CwXxruFE9t0wz_A@...278...>
Subject: Re: [Openvpn-devel] [PATCH] configure.ac: link to all mbed TLS libs
 during library detection
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

On Thu, May 5, 2016 at 1:50 PM, Gert Doering <gert@...1296...> wrote:
> --- a/configure.ac
> +++ b/configure.ac
> @@ -844,11 +844,11 @@ elif test "${with_crypto_library}" = "mbedtls"; then
>
>         if test -z "${MBEDTLS_CFLAGS}" -a -z "${MBEDTLS_LIBS}"; then
>                 # if the user did not explicitly specify flags, try to autodetect
> -               LIBS="${LIBS} -lmbedtls -lmbedcrypto -lmbedx509"
> +               LIBS="${LIBS} -lmbedtls -lmbedx509 -lmbedcrypto"
>                 AC_CHECK_LIB(
>                         [mbedtls],
>                         [mbedtls_ssl_init],
> -                       [MBEDTLS_LIBS="-lmbedtls -lmbedcrypto -lmbedx509"],
> +                       [MBEDTLS_LIBS="-lmbedtls -lmbedx509 -lmbedcrypto"],
>                         [AC_MSG_ERROR([Could not find mbed TLS.])],
>                         [${PKCS11_HELPER_LIBS}]
>                 )

Yes, makes sense. ACK.

-Steffan

