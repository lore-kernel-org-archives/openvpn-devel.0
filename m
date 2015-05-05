Message-ID: <5548E7AC.4060009@...1227...>
Date: Tue, 05 May 2015 17:54:20 +0200
From: Arne Schwabe <arne@...1227...>
MIME-Version: 1.0
References: <1430840857-6123-1-git-send-email-steffan@...1856...>
In-Reply-To: <1430840857-6123-1-git-send-email-steffan@...1856...>
Subject: Re: [Openvpn-devel] [PATCH] Improve --tls-cipher and --show-tls man
 page description
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
To: Steffan Karger <steffan@...1856...>, openvpn-devel@lists.sourceforge.net



Am 05.05.15 um 17:47 schrieb Steffan Karger:
> As reported in trac tickets #304, #358 and #359 (and possibly more), the
> usage and interpretation of --tls-cipher (and --show-tls) is tricky.  This
> patch extends the man page to explain those a bit better and point out
> that --tls-cipher is an expert feature (i.e. easy to get wrong).  Also add
> a notice to the --show-tls output, referring to the man page explanation.
>
> Signed-off-by: Steffan Karger <steffan@...1856...>
> ---
>  doc/openvpn.8              | 40 ++++++++++++++++++++++++++++------------
>  src/openvpn/ssl_common.h   |  5 +++++
>  src/openvpn/ssl_openssl.c  |  2 +-
>  src/openvpn/ssl_polarssl.c |  2 +-
>  4 files changed, 35 insertions(+), 14 deletions(-)
>
> diff --git a/doc/openvpn.8 b/doc/openvpn.8
> index b09f7d7..d2f47b3 100644
> --- a/doc/openvpn.8
> +++ b/doc/openvpn.8
> @@ -4524,18 +4524,29 @@ separately negotiated over the existing secure TLS channel.  Here,
>  determines the derivation of the tunnel session keys.
>  .\"*********************************************************
>  .TP
> -.B \-\-tls-cipher l
> +.B \-\-tls\-cipher l
>  A list
>  .B l
>  of allowable TLS ciphers delimited by a colon (":").
> -If you require a high level of security,
> -you may want to set this parameter manually, to prevent a
> -version rollback attack where a man-in-the-middle attacker tries
> -to force two peers to negotiate to the lowest level
> -of security they both support.
> +
> +This setting can be used to ensure that certain cipher suites are used (or
> +not used) for the TLS connection.  OpenVPN uses TLS to secure the control
> +channel, over which the keys that are used to protect the actual VPN traffic
> +are exchanged.
> +
> +The supplied list of ciphers is (after potential OpenSSL/IANA name translation)
> +simply supplied to the crypto library.  Please see the OpenSSL and/or PolarSSL
> +documentation for details on the cipher list interpretation.
> +
>  Use
> -.B \-\-show-tls
> -to see a list of supported TLS ciphers.
> +.B \-\-show\-tls
> +to see a list of TLS ciphers supported by your crypto library.
> +
> +Warning!
> +.B \-\-tls\-cipher
> +is an expert feature, which - if used correcly - can improve the security of
> +your VPN connection.  But it is also easy to unwittingly use it to carefully
> +align a gun with your foot, or just break your connection.  Use with care!
>  
>  The default for --tls-cipher is to use PolarSSL's default cipher list
>  when using PolarSSL or "DEFAULT:!EXP:!PSK:!SRP:!kRSA" when using OpenSSL.
> @@ -5091,11 +5102,16 @@ Show all message digest algorithms to use with the
>  option.
>  .\"*********************************************************
>  .TP
> -.B \-\-show-tls
> +.B \-\-show\-tls
>  (Standalone)
> -Show all TLS ciphers (TLS used only as a control channel).  The TLS
> -ciphers will be sorted from highest preference (most secure) to
> -lowest.
> +Show all TLS ciphers supported by the crypto library.  OpenVPN uses TLS to
> +secure the control channel, over which the keys that are used to protect the
> +actual VPN traffic are exchanged.  The TLS ciphers will be sorted from highest
> +preference (most secure) to lowest.
> +
> +Be aware that whether a cipher suite in this list can actually work depends on
> +the specific setup of both peers (e.g. both peers must support the cipher, and
> +an ECDSA cipher suite will not work if you are using an RSA certificate, etc.).
>  .\"*********************************************************
>  .TP
>  .B \-\-show-engines
> diff --git a/src/openvpn/ssl_common.h b/src/openvpn/ssl_common.h
> index 6222bd6..bb1c1c2 100644
> --- a/src/openvpn/ssl_common.h
> +++ b/src/openvpn/ssl_common.h
> @@ -511,4 +511,9 @@ struct tls_multi
>  };
>  
>  
> +#define SHOW_TLS_CIPHER_LIST_WARNING \
> +  "Be aware that that whether a cipher suite in this list can actually work\n" \
> +  "depends on the specific setup of both peers. See the man page entries of\n" \
> +  "--tls-cipher and --show-tls for more details.\n\n"
> +
>  #endif /* SSL_COMMON_H_ */
> diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
> index d9abc6e..df9fa87 100644
> --- a/src/openvpn/ssl_openssl.c
> +++ b/src/openvpn/ssl_openssl.c
> @@ -1395,7 +1395,7 @@ show_available_tls_ciphers (const char *cipher_list)
>        }
>  
>      }
> -  printf ("\n");
> +  printf ("\n" SHOW_TLS_CIPHER_LIST_WARNING);
>  
>    SSL_free (ssl);
>    SSL_CTX_free (tls_ctx.ctx);
> diff --git a/src/openvpn/ssl_polarssl.c b/src/openvpn/ssl_polarssl.c
> index 158088f..3fc811e 100644
> --- a/src/openvpn/ssl_polarssl.c
> +++ b/src/openvpn/ssl_polarssl.c
> @@ -1094,7 +1094,7 @@ show_available_tls_ciphers (const char *cipher_list)
>        printf ("%s\n", ssl_get_ciphersuite_name(*ciphers));
>        ciphers++;
>      }
> -  printf ("\n");
> +  printf ("\n" SHOW_TLS_CIPHER_LIST_WARNING);
>  
>    tls_ctx_free(&tls_ctx);
>  }


