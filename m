References: <20170815215451.21662-1-davids@...515...>
From: Steffan Karger <steffan@...1856...>
Message-ID: <5209cd28-1e57-6de0-c6ec-2bc0e24c6f2a@...1856...>
Date: Wed, 16 Aug 2017 23:43:13 +0200
MIME-Version: 1.0
In-Reply-To: <20170815215451.21662-1-davids@...515...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH] Highlight deprecated features
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Hi,

On 15-08-17 23:54, David Sommerseth wrote:
> We have quite a list of deprecated options currently.  Ensure this
> is highlighted both in documentation and code.
> 
> This patch builds on the wiki page [1] enlisting all deprecated features
> and their status.  There are also some options not listed here, as
> there exists patches in release/2.4 which awaits an update for git master.
> 
> Signed-off-by: David Sommerseth <davids@...515...>
> ---
>  Changes.rst           | 15 ++++++++++
>  doc/openvpn.8         | 78 ++++++++++++++++++++++++++++++++++-----------------
>  src/openvpn/options.c | 16 ++++++-----
>  3 files changed, 77 insertions(+), 32 deletions(-)
> 
> diff --git a/Changes.rst b/Changes.rst
> index 4358f78b..74d038a0 100644
> --- a/Changes.rst
> +++ b/Changes.rst
> @@ -161,6 +161,9 @@ Asynchronous push reply
>  
>  Deprecated features
>  -------------------
> +For an up-to-date list of all deprecated options, see this wiki page:
> +https://community.openvpn.net/openvpn/wiki/DeprecatedOptions
> +
>  - ``--key-method 1`` is deprecated in 2.4 and will be removed in 2.5.  Migrate
>    away from ``--key-method 1`` as soon as possible.  The recommended approach
>    is to remove the ``--key-method`` option from the configuration files, OpenVPN
> @@ -181,6 +184,18 @@ Deprecated features
>  - ``--keysize`` is deprecated and will be removed in v2.6 together
>    with the support of ciphers with cipher block size less than 128 bits.
>  
> +- ``--comp-lzo`` is deprecated in OpenVPN 2.4.  Use ``--compress`` instead.
> +
> +- ``--ifconfig-pool-linear`` has been deprecated since OpenVPN 2.1 and will be
> +  removed in v2.5.  Use ``--topology p2p`` instead.
> +
> +- ``--client-cert-not-required`` is deprecated in OpenVPN 2.4 and will be removed
> +  in v2.5.  Use ``--verify-client-cert none`` for a functional equivalent.
> +
> +- ``--ns-cert-type`` is deprecated in OpenVPN 2.3.18 and v2.4.  It will be removed
> +  in v2.5.  Use the far better ``--remote-cert-tls`` option which replaces this
> +  feature.
> +
>  
>  User-visible Changes
>  --------------------
> diff --git a/doc/openvpn.8 b/doc/openvpn.8
> index 056ae145..5da29300 100644
> --- a/doc/openvpn.8
> +++ b/doc/openvpn.8
> @@ -769,7 +769,8 @@ Only use
>  when none of the connecting clients are Windows systems.  This mode
>  is functionally equivalent to the
>  .B \-\-ifconfig\-pool\-linear
> -directive which is available in OpenVPN 2.0 and is now deprecated.
> +directive which is available in OpenVPN 2.0, is deprecated and will be
> +removed in OpenVPN 2.5
>  
>  .B subnet \-\-
>  Use a subnet rather than a point-to-point topology by
> @@ -2485,15 +2486,17 @@ setting to be pushed later.
>  .\"*********************************************************
>  .TP
>  .B \-\-comp\-lzo [mode]
> +.B DEPRECATED
> +This option will be removed in a future OpenVPN release.  Use the
> +newer
> +.B \-\-compress
> +instead.
> +
>  Use LZO compression -- may add up to 1 byte per
>  packet for incompressible data.
>  .B mode
>  may be "yes", "no", or "adaptive" (default).
>  
> -This option is deprecated in favor of the newer
> -.B --compress
> -option.
> -
>  In a server mode setup, it is possible to selectively turn
>  compression on or off for individual clients.
>  
> @@ -3106,9 +3109,13 @@ a common name and IP address.  They do not guarantee that the given common
>  name will always receive the given IP address.  If you want guaranteed
>  assignment, use
>  .B \-\-ifconfig\-push
> +
>  .\"*********************************************************
>  .TP
>  .B \-\-ifconfig\-pool\-linear
> +.B DEPRECATED
> +This option will be removed in OpenVPN 2.5
> +
>  Modifies the
>  .B \-\-ifconfig\-pool
>  directive to
> @@ -3671,15 +3678,16 @@ to empty strings ("").  The authentication module/script MUST have logic
>  to detect this condition and respond accordingly.
>  .\"*********************************************************
>  .TP
> -.B \-\-client\-cert\-not\-required (DEPRECATED)
> +.B \-\-client\-cert\-not\-required
> +.B DEPRECATED
> +This option will be removed in OpenVPN 2.5
> +
>  Don't require client certificate, client will authenticate
>  using username/password only.  Be aware that using this directive
>  is less secure than requiring certificates from all clients.
>  
> -
>  .B Please note:
> -This option is now deprecated and will be removed in OpenVPN v2.5.
> -It is replaced by
> +This is replaced by
>  .B \-\-verify\-client\-cert
>  which allows for more flexibility. The option
>  .B \-\-verify\-client\-cert none
> @@ -3744,7 +3752,10 @@ the authenticated username as the common name,
>  rather than the common name from the client cert.
>  .\"*********************************************************
>  .TP
> -.B \-\-compat\-names [no\-remapping] (DEPRECATED)
> +.B \-\-compat\-names [no\-remapping]
> +.B DEPRECATED
> +This option will be removed in OpenVPN 2.5
> +
>  Until OpenVPN v2.3 the format of the X.509 Subject fields was formatted
>  like this:
>  .IP
> @@ -3792,7 +3803,10 @@ to make the transition to the new formatting less intrusive.  It will be
>  removed in OpenVPN v2.5.  So please update your scripts/plug-ins where necessary.
>  .\"*********************************************************
>  .TP
> -.B \-\-no\-name\-remapping (DEPRECATED)
> +.B \-\-no\-name\-remapping
> +.B DEPRECATED
> +This option will be removed in OpenVPN 2.5
> +
>  The
>  .B \-\-no\-name\-remapping
>  option is an alias for
> @@ -4150,13 +4164,29 @@ For more information on HMAC see
>  .B \-\-cipher alg
>  Encrypt data channel packets with cipher algorithm
>  .B alg.
> +
>  The default is
>  .B BF-CBC,
> -an abbreviation for Blowfish in Cipher Block Chaining mode.
> +an abbreviation for Blowfish in Cipher Block Chaining mode.  When cipher
> +negotiation (NCP) is allowed, OpenVPN 2.4 and newer on both client and server
> +side will automatically upgrade to
> +.B AES-256-GCM.
> +See
> +.B \-\-ncp\-ciphers
> +and
> +.B \-\-ncp\-disable
> +for more details on NCP.
>  
> -Using BF-CBC is no longer recommended, because of it's 64-bit block size.  This
> +Using
> +.B BF-CBC
> +is no longer recommended, because of its 64-bit block size.  This
>  small block size allows attacks based on collisions, as demonstrated by SWEET32.
> -See https://community.openvpn.net/openvpn/wiki/SWEET32 for details.
> +See https://community.openvpn.net/openvpn/wiki/SWEET32 for details.  Due to
> +this, support for
> +.B BF-CBC, DES, CAST5, IDEA
> +and
> +.B RC2
> +ciphers will be removed in OpenVPN 2.6.
>  
>  To see other ciphers that are available with OpenVPN, use the
>  .B \-\-show\-ciphers
> @@ -4166,14 +4196,6 @@ Set
>  .B alg=none
>  to disable encryption.
>  
> -As of OpenVPN 2.4, cipher negotiation (NCP) can override the cipher specified by
> -.B \-\-cipher\fR.
> -See
> -.B \-\-ncp\-ciphers
> -and
> -.B \-\-ncp\-disable
> -for more on NCP.
> -
>  .\"*********************************************************
>  .TP
>  .B \-\-ncp\-ciphers cipher_list
> @@ -4260,6 +4282,9 @@ supported by OpenSSL.
>  .\"*********************************************************
>  .TP
>  .B \-\-no\-replay
> +.B DEPRECATED
> +This option will be removed in OpenVPN 2.5.
> +
>  (Advanced) Disable OpenVPN's protection against replay attacks.
>  Don't use this option unless you are prepared to make
>  a tradeoff of greater efficiency in exchange for less
> @@ -4423,7 +4448,6 @@ This option only makes sense when replay protection is enabled
>  .\"*********************************************************
>  .TP
>  .B \-\-no\-iv
> -
>  .B DEPRECATED
>  This option will be removed in OpenVPN 2.5.
>  
> @@ -4823,6 +4847,9 @@ Certificate Store GUI.
>  .\"*********************************************************
>  .TP
>  .B \-\-key\-method m
> +.B DEPRECATED
> +This option will be removed in OpenVPN 2.5
> +
>  Use data channel key negotiation method
>  .B m.
>  The key method must match on both sides of the connection.
> @@ -5379,8 +5406,9 @@ as X509_<depth>_<attribute>=<value>.  Multiple
>  options can be defined to track multiple attributes.
>  .\"*********************************************************
>  .TP
> -.B \-\-ns\-cert\-type client|server (DEPRECATED)
> -This option is deprecated.  Use the more modern equivalent
> +.B \-\-ns\-cert\-type client|server
> +.B DEPRECATED
> +This option will be removed in OpenVPN 2.5.  Use the more modern equivalent
>  .B \-\-remote\-cert\-tls
>  instead.  This option will be removed in OpenVPN 2.5.
>  
> diff --git a/src/openvpn/options.c b/src/openvpn/options.c
> index ef7009c1..860bc859 100644
> --- a/src/openvpn/options.c
> +++ b/src/openvpn/options.c
> @@ -415,8 +415,9 @@ static const char usage_message[] =
>      "                  client instance.\n"
>      "--ifconfig-pool start-IP end-IP [netmask] : Set aside a pool of subnets\n"
>      "                  to be dynamically allocated to connecting clients.\n"
> -    "--ifconfig-pool-linear : Use individual addresses rather than /30 subnets\n"
> -    "                  in tun mode.  Not compatible with Windows clients.\n"
> +    "--ifconfig-pool-linear : (DEPRECATED) Use individual addresses rather \n"
> +    "                  than /30 subnets\n in tun mode.  Not compatible with\n"
> +    "                  Windows clients.\n"
>      "--ifconfig-pool-persist file [seconds] : Persist/unpersist ifconfig-pool\n"
>      "                  data to file, at seconds intervals (default=600).\n"
>      "                  If seconds=0, file will be treated as read-only.\n"
> @@ -434,7 +435,7 @@ static const char usage_message[] =
>      "                  Only valid in a client-specific config file.\n"
>      "--disable       : Client is disabled.\n"
>      "                  Only valid in a client-specific config file.\n"
> -    "--client-cert-not-required : Don't require client certificate, client\n"
> +    "--client-cert-not-required : (DEPRECATED) Don't require client certificate, client\n"
>      "                  will authenticate using username/password.\n"
>      "--verify-client-cert [none|optional|require] : perform no, optional or\n"
>      "                  mandatory client certificate verification.\n"
> @@ -455,7 +456,7 @@ static const char usage_message[] =
>      "                  with those of the server will be disconnected.\n"
>      "--auth-user-pass-optional : Allow connections by clients that don't\n"
>      "                  specify a username/password.\n"
> -    "--no-name-remapping : Allow Common Name and X509 Subject to include\n"
> +    "--no-name-remapping : (DEPRECATED) Allow Common Name and X509 Subject to include\n"
>      "                      any printable character.\n"
>      "--client-to-client : Internally route client-to-client traffic.\n"
>      "--duplicate-cn  : Allow multiple clients with the same common name to\n"
> @@ -539,13 +540,13 @@ static const char usage_message[] =
>      "--prng alg [nsl] : For PRNG, use digest algorithm alg, and\n"
>      "                   nonce_secret_len=nsl.  Set alg=none to disable PRNG.\n"
>  #ifdef HAVE_EVP_CIPHER_CTX_SET_KEY_LENGTH
> -    "--keysize n     : Size of cipher key in bits (optional).\n"
> +    "--keysize n     : (DEPRECATED) Size of cipher key in bits (optional).\n"
>      "                  If unspecified, defaults to cipher-specific default.\n"
>  #endif
>  #ifndef ENABLE_CRYPTO_MBEDTLS
>      "--engine [name] : Enable OpenSSL hardware crypto engine functionality.\n"
>  #endif
> -    "--no-replay     : Disable replay protection.\n"
> +    "--no-replay     : (DEPRECATED) Disable replay protection.\n"
>      "--mute-replay-warnings : Silence the output of replay warnings to log file.\n"
>      "--replay-window n [t]  : Use a replay protection sliding window of size n\n"
>      "                         and a time window of t seconds.\n"
> @@ -563,7 +564,7 @@ static const char usage_message[] =
>      "(These options are meaningful only for TLS-mode)\n"
>      "--tls-server    : Enable TLS and assume server role during TLS handshake.\n"
>      "--tls-client    : Enable TLS and assume client role during TLS handshake.\n"
> -    "--key-method m  : Data channel key exchange method.  m should be a method\n"
> +    "--key-method m  : (DEPRECATED) Data channel key exchange method.  m should be a method\n"
>      "                  number, such as 1 (default), 2, etc.\n"
>      "--ca file       : Certificate authority file in .pem format containing\n"
>      "                  root certificate.\n"
> @@ -6570,6 +6571,7 @@ add_option(struct options *options,
>      {
>          VERIFY_PERMISSION(OPT_P_GENERAL);
>          options->topology = TOP_P2P;
> +        msg(M_WARN, "DEPRECATED OPTION: --ifconfig-pool-linear, use --topology p2p instead");
>      }
>      else if (streq(p[0], "ifconfig-ipv6-pool") && p[1] && !p[2])
>      {
> 

Better documentation and more consistency, nice!  ACK.

(Given that you add that reference to the commit message ;-) )

-Steffan

