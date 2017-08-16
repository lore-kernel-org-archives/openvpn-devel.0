References: <20170815205301.14542-1-davids@...515...>
From: Steffan Karger <steffan@...1856...>
Message-ID: <2906d8f6-95d4-0142-918d-f59c3b74798e@...1856...>
Date: Wed, 16 Aug 2017 23:35:40 +0200
MIME-Version: 1.0
In-Reply-To: <20170815205301.14542-1-davids@...515...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH] Use consistent version references
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

On 15-08-17 22:53, David Sommerseth wrote:
> A simple clean-up where the version references have been unified
> all those places I could find now.  The versioning scheme used is:
> 
>     * OpenVPN 2.x
>     * v2.x
> 
> We want to avoid:
>     * 2.x  (2.4 can be just an ordindary decimal number,
>             OID reference, a version number or anything else)
>     * OpenVPN v2.x (OpenVPN indicates we're talking about a version)
> 
> In addition, several places where it made sense I tried to ensure
> the first version reference uses "OpenVPN 2.x" and the following
> references in the same section/paragraph uses "v2.x", to set the
> context for the version reference.
> 
> In Changes.rst modified paragraphs exceeding 80 chars lines where
> reformatted as well.
> 
> Signed-off-by: David Sommerseth <davids@...515...>
> ---
>  Changes.rst                            | 52 ++++++++++++++++++----------------
>  doc/openvpn.8                          | 34 +++++++++++-----------
>  sample/sample-config-files/client.conf |  2 +-
>  sample/sample-config-files/server.conf |  4 +--
>  src/openvpn/options.c                  |  8 +++---
>  5 files changed, 51 insertions(+), 49 deletions(-)
> 
> diff --git a/Changes.rst b/Changes.rst
> index 4358f78b..0999a835 100644
> --- a/Changes.rst
> +++ b/Changes.rst
> @@ -161,25 +161,26 @@ Asynchronous push reply
>  
>  Deprecated features
>  -------------------
> -- ``--key-method 1`` is deprecated in 2.4 and will be removed in 2.5.  Migrate
> -  away from ``--key-method 1`` as soon as possible.  The recommended approach
> -  is to remove the ``--key-method`` option from the configuration files, OpenVPN
> -  will then use ``--key-method 2`` by default.  Note that this requires changing
> -  the option in both the client and server side configs.
> +- ``--key-method 1`` is deprecated in OpenVPN 2.4 and will be removed in v2.5.
> +  Migrate away from ``--key-method 1`` as soon as possible.  The recommended
> +  approach is to remove the ``--key-method`` option from the configuration
> +  files, OpenVPN will then use ``--key-method 2`` by default.  Note that this
> +  requires changing the option in both the client and server side configs.
>  
> -- ``--tls-remote`` is removed in 2.4, as indicated in the 2.3 man-pages.  Similar
> -  functionality is provided via ``--verify-x509-name``, which does the same job in
> -  a better way.
> +- ``--tls-remote`` is removed in OpenVPN 2.4, as indicated in the v2.3
> +  man-pages.  Similar functionality is provided via ``--verify-x509-name``,
> +  which does the same job in a better way.
>  
> -- ``--compat-names`` and ``--no-name-remapping`` were deprecated in 2.3 and will
> -  be removed in 2.5.  All scripts and plug-ins depending on the old non-standard
> -  X.509 subject formatting must be updated to the standardized formatting.  See
> -  the man page for more information.
> +- ``--compat-names`` and ``--no-name-remapping`` were deprecated in OpenVPN 2.3
> +  and will be removed in v2.5.  All scripts and plug-ins depending on the old
> +  non-standard X.509 subject formatting must be updated to the standardized
> +  formatting.  See the man page for more information.
>  
> -- ``--no-iv`` is deprecated in 2.4 and will be removed in 2.5.
> +- ``--no-iv`` is deprecated in OpenVPN 2.4 and will be removed in v2.5.
>  
> -- ``--keysize`` is deprecated and will be removed in v2.6 together
> -  with the support of ciphers with cipher block size less than 128 bits.
> +- ``--keysize`` is deprecated in OpenVPN 2.4 and will be removed in v2.6
> +  together with the support of ciphers with cipher block size less than
> +  128-bits.
>  
>  
>  User-visible Changes
> @@ -302,7 +303,7 @@ Maintainer-visible changes
>    files instead of older ones, to provide a unified behaviour across systemd
>    based Linux distributions.
>  
> -- With OpenVPN v2.4, the project has moved over to depend on and actively use
> +- With OpenVPN 2.4, the project has moved over to depend on and actively use
>    the official C99 standard (-std=c99).  This may fail on some older compiler/libc
>    header combinations.  In most of these situations it is recommended to
>    use -std=gnu99 in CFLAGS.  This is known to be needed when doing
> @@ -324,7 +325,7 @@ New features
>  Security
>  --------
>  - CVE-2017-7522: Fix ``--x509-track`` post-authentication remote DoS
> -  A client could crash a 2.4+ mbedtls server, if that server uses the
> +  A client could crash a v2.4+ mbedtls server, if that server uses the
>    ``--x509-track`` option and the client has a correct, signed and unrevoked
>    certificate that contains an embedded NUL in the certificate subject.
>    Discovered and reported to the OpenVPN security team by Guido Vranken.
> @@ -381,7 +382,7 @@ User-visible Changes
>  Bugfixes
>  --------
>  - Fix fingerprint calculation in mbed TLS builds.  This means that mbed TLS users
> -  of OpenVPN 2.4.0, 2.4.1 and 2.4.2 that rely on the values of the
> +  of OpenVPN 2.4.0, v2.4.1 and v2.4.2 that rely on the values of the
>    ``tls_digest_*`` env vars, or that use ``--verify-hash`` will have to change
>    the fingerprint values they check against.  The security impact of the
>    incorrect calculation is very minimal; the last few bytes (max 4, typically
> @@ -410,17 +411,18 @@ Version 2.4.2
>  
>  Bugfixes
>  --------
> -- Fix memory leak introduced in 2.4.1: if ``--remote-cert-tls`` is used, we leaked
> -  some memory on each TLS (re)negotiation.
> +- Fix memory leak introduced in OpenVPN 2.4.1: if ``--remote-cert-tls`` is
> +  used, we leaked some memory on each TLS (re)negotiation.
>  
>  
>  Security
>  --------
> -- Fix a pre-authentication denial-of-service attack on both clients and servers.
> -  By sending a too-large control packet, OpenVPN 2.4.0 or 2.4.1 can be forced
> -  to hit an ASSERT() and stop the process.  If ``--tls-auth`` or ``--tls-crypt``
> -  is used, only attackers that have the ``--tls-auth`` or ``--tls-crypt`` key
> -  can mount an attack. (OSTIF/Quarkslab audit finding 5.1, CVE-2017-7478)
> +- Fix a pre-authentication denial-of-service attack on both clients and
> +  servers.  By sending a too-large control packet, OpenVPN 2.4.0 or v2.4.1 can
> +  be forced to hit an ASSERT() and stop the process.  If ``--tls-auth`` or
> +  ``--tls-crypt`` is used, only attackers that have the ``--tls-auth`` or
> +  ``--tls-crypt`` key can mount an attack.
> +  (OSTIF/Quarkslab audit finding 5.1, CVE-2017-7478)
>  
>  - Fix an authenticated remote DoS vulnerability that could be triggered by
>    causing a packet id roll over.  An attack is rather inefficient; a peer
> diff --git a/doc/openvpn.8 b/doc/openvpn.8
> index 056ae145..2d22fb57 100644
> --- a/doc/openvpn.8
> +++ b/doc/openvpn.8
> @@ -1994,7 +1994,7 @@ could be either
>  .B execve
>  or 
>  .B system. 
> -As of OpenVPN v2.3, this flag is no longer accepted.  In most *nix environments the execve()
> +As of OpenVPN 2.3, this flag is no longer accepted.  In most *nix environments the execve()
>  approach has been used without any issues.
>  
>  Some directives such as \-\-up allow options to be passed to the external
> @@ -2006,7 +2006,7 @@ To run scripts in Windows in earlier OpenVPN
>  versions you needed to either add a full path to the script interpreter which can parse the
>  script or use the
>  .B system
> -flag to run these scripts.  As of OpenVPN v2.3 it is now a strict requirement to have
> +flag to run these scripts.  As of OpenVPN 2.3 it is now a strict requirement to have
>  full path to the script interpreter when running non-executables files.
>  This is not needed for executable files, such as .exe, .com, .bat or .cmd files.  For
>  example, if you have a Visual Basic script, you must use this syntax now:
> @@ -2201,7 +2201,7 @@ passwords, or key pass phrases anymore.  This has certain consequences,
>  namely that using a password-protected private key will fail unless the
>  .B \-\-askpass
>  option is used to tell OpenVPN to ask for the pass phrase (this
> -requirement is new in 2.3.7, and is a consequence of calling daemon()
> +requirement is new in v2.3.7, and is a consequence of calling daemon()
>  before initializing the crypto layer).
>  
>  Further, using
> @@ -2474,7 +2474,7 @@ The
>  parameter may be "lzo", "lz4", or empty.  LZO and LZ4
>  are different compression algorithms, with LZ4 generally
>  offering the best performance with least CPU usage.
> -For backwards compatibility with OpenVPN versions before 2.4, use "lzo"
> +For backwards compatibility with OpenVPN versions before v2.4, use "lzo"
>  (which is identical to the older option "\-\-comp\-lzo yes").
>  
>  If the
> @@ -3678,7 +3678,7 @@ is less secure than requiring certificates from all clients.
>  
>  
>  .B Please note:
> -This option is now deprecated and will be removed in OpenVPN v2.5.
> +This option is now deprecated and will be removed in OpenVPN 2.5.
>  It is replaced by
>  .B \-\-verify\-client\-cert
>  which allows for more flexibility. The option
> @@ -3745,7 +3745,7 @@ rather than the common name from the client cert.
>  .\"*********************************************************
>  .TP
>  .B \-\-compat\-names [no\-remapping] (DEPRECATED)
> -Until OpenVPN v2.3 the format of the X.509 Subject fields was formatted
> +Until OpenVPN 2.3 the format of the X.509 Subject fields was formatted
>  like this:
>  .IP
>  .B
> @@ -3763,13 +3763,13 @@ option, this old formatting and remapping will be re-enabled again.  This is
>  purely implemented for compatibility reasons when using older plug-ins or
>  scripts which does not handle the new formatting or UTF-8 characters.
>  .IP
> -In OpenVPN v2.3 the formatting of these fields changed into a more
> +In OpenVPN 2.3 the formatting of these fields changed into a more
>  standardised format.  It now looks like:
>  .IP
>  .B
>  C=US, L=Somewhere, CN=John Doe, emailAddress=john@...1113...
>  .IP
> -The new default format in OpenVPN v2.3 also does not do the character remapping
> +The new default format in OpenVPN 2.3 also does not do the character remapping
>  which happened earlier.  This new format enables proper support for UTF\-8
>  characters in the usernames, X.509 Subject fields and Common Name variables and
>  it complies to the RFC 2253, UTF\-8 String Representation of Distinguished
> @@ -3789,7 +3789,7 @@ carriage-return. no-remapping is only available on the server side.
>  .B Please note:
>  This option is immediately deprecated.  It is only implemented
>  to make the transition to the new formatting less intrusive.  It will be
> -removed in OpenVPN v2.5.  So please update your scripts/plug-ins where necessary.
> +removed in OpenVPN 2.5.  So please update your scripts/plug-ins where necessary.
>  .\"*********************************************************
>  .TP
>  .B \-\-no\-name\-remapping (DEPRECATED)
> @@ -3802,7 +3802,7 @@ It ensures compatibility with server configurations using the
>  option.
>  
>  .B Please note:
> -This option is now deprecated.  It will be removed in OpenVPN v2.5.
> +This option is now deprecated.  It will be removed in OpenVPN 2.5.
>  So please make sure you support the new X.509 name formatting
>  described with the
>  .B \-\-compat\-names
> @@ -4204,8 +4204,8 @@ will inherit the cipher of the peer if that cipher is different from the local
>  .B \-\-cipher
>  setting, but the peer cipher is one of the ciphers specified in
>  .B \-\-ncp\-ciphers\fR.
> -E.g. a non-NCP client (<=2.3, or with \-\-ncp\-disabled set) connecting to a
> -NCP server (2.4+) with "\-\-cipher BF-CBC" and "\-\-ncp-ciphers
> +E.g. a non-NCP client (<=v2.3, or with \-\-ncp\-disabled set) connecting to a
> +NCP server (v2.4+) with "\-\-cipher BF-CBC" and "\-\-ncp-ciphers
>  AES-256-GCM:AES-256-CBC" set can either specify "\-\-cipher BF-CBC" or
>  "\-\-cipher AES-256-CBC" and both will work.
>  
> @@ -5010,8 +5010,8 @@ response.
>  (required) is a file in OpenVPN static key format which can be generated by
>  .B \-\-genkey
>  
> -Older versions (up to 2.3) supported a freeform passphrase file.
> -This is no longer supported in newer versions (2.4+).
> +Older versions (up to OpenVPN 2.3) supported a freeform passphrase file.
> +This is no longer supported in newer versions (v2.4+).
>  
>  See the
>  .B \-\-secret
> @@ -5568,7 +5568,7 @@ Write key to
>  .B file.
>  .\"*********************************************************
>  .SS TUN/TAP persistent tunnel config mode:
> -Available with linux 2.4.7+.  These options comprise a standalone mode
> +Available with Linux 2.4.7+.  These options comprise a standalone mode
>  of OpenVPN which can be used to create and delete persistent tunnels.
>  .\"*********************************************************
>  .TP
> @@ -5895,7 +5895,7 @@ flag.
>  .TP
>  .B \-\-dhcp\-release
>  Ask Windows to release the TAP adapter lease on shutdown.
> -This option has no effect now, as it is enabled by default starting with version 2.4.1.
> +This option has no effect now, as it is enabled by default starting with OpenVPN 2.4.1.
>  .\"*********************************************************
>  .TP
>  .B \-\-register\-dns
> @@ -6178,7 +6178,7 @@ isprint() function to return true.
>  
>  .B \-\-client\-config\-dir filename as derived from common name or username:
>  Alphanumeric, underbar ('_'), dash ('-'), and dot ('.') except for "." or 
> -".." as standalone strings.  As of 2.0.1-rc6, the at ('@') character has
> +".." as standalone strings.  As of v2.0.1-rc6, the at ('@') character has
>  been added as well for compatibility with the common name character class.
>  
>  .B Environmental variable names:
> diff --git a/sample/sample-config-files/client.conf b/sample/sample-config-files/client.conf
> index f5c69e34..5fd4a948 100644
> --- a/sample/sample-config-files/client.conf
> +++ b/sample/sample-config-files/client.conf
> @@ -110,7 +110,7 @@ tls-auth ta.key 1
>  # Select a cryptographic cipher.
>  # If the cipher option is used on the server
>  # then you must also specify it here.
> -# Note that 2.4 client/server will automatically
> +# Note that v2.4 client/server will automatically
>  # negotiate AES-256-GCM in TLS mode.
>  # See also the ncp-cipher option in the manpage
>  cipher AES-256-CBC
> diff --git a/sample/sample-config-files/server.conf b/sample/sample-config-files/server.conf
> index aa7d5b39..1dd477bd 100644
> --- a/sample/sample-config-files/server.conf
> +++ b/sample/sample-config-files/server.conf
> @@ -246,13 +246,13 @@ tls-auth ta.key 0 # This file is secret
>  # Select a cryptographic cipher.
>  # This config item must be copied to
>  # the client config file as well.
> -# Note that 2.4 client/server will automatically
> +# Note that v2.4 client/server will automatically
>  # negotiate AES-256-GCM in TLS mode.
>  # See also the ncp-cipher option in the manpage
>  cipher AES-256-CBC
>  
>  # Enable compression on the VPN link and push the
> -# option to the client (2.4+ only, for earlier
> +# option to the client (v2.4+ only, for earlier
>  # versions see below)
>  ;compress lz4-v2
>  ;push "compress lz4-v2"
> diff --git a/src/openvpn/options.c b/src/openvpn/options.c
> index ef7009c1..5346fcdc 100644
> --- a/src/openvpn/options.c
> +++ b/src/openvpn/options.c
> @@ -6186,7 +6186,7 @@ add_option(struct options *options,
>      else if (streq(p[0], "max-routes") && !p[2])
>      {
>          msg(M_WARN, "DEPRECATED OPTION: --max-routes option ignored."
> -            "The number of routes is unlimited as of version 2.4. "
> +            "The number of routes is unlimited as of OpenVPN 2.4. "
>              "This option will be removed in a future version, "
>              "please remove it from your configuration.");
>      }
> @@ -7016,7 +7016,7 @@ add_option(struct options *options,
>          VERIFY_PERMISSION(OPT_P_GENERAL);
>          if (streq(p[1], "env"))
>          {
> -            msg(M_INFO, "NOTE: --win-sys env is default from OpenVPN v2.3.	 "
> +            msg(M_INFO, "NOTE: --win-sys env is default from OpenVPN 2.3.	 "
>                  "This entry will now be ignored.  "
>                  "Please remove this entry from your configuration file.");
>          }
> @@ -7862,7 +7862,7 @@ add_option(struct options *options,
>              msg(msglevel, "you cannot use --compat-names with --verify-x509-name");
>              goto err;
>          }
> -        msg(M_WARN, "DEPRECATED OPTION: --compat-names, please update your configuration. This will be removed in OpenVPN v2.5.");
> +        msg(M_WARN, "DEPRECATED OPTION: --compat-names, please update your configuration. This will be removed in OpenVPN 2.5.");
>          compat_flag(COMPAT_FLAG_SET | COMPAT_NAMES);
>  #if P2MP_SERVER
>          if (p[1] && streq(p[1], "no-remapping"))
> @@ -7878,7 +7878,7 @@ add_option(struct options *options,
>              msg(msglevel, "you cannot use --no-name-remapping with --verify-x509-name");
>              goto err;
>          }
> -        msg(M_WARN, "DEPRECATED OPTION: --no-name-remapping, please update your configuration. This will be removed in OpenVPN v2.5.");
> +        msg(M_WARN, "DEPRECATED OPTION: --no-name-remapping, please update your configuration. This will be removed in OpenVPN 2.5.");
>          compat_flag(COMPAT_FLAG_SET | COMPAT_NAMES);
>          compat_flag(COMPAT_FLAG_SET | COMPAT_NO_NAME_REMAPPING);
>  #endif
> 

Makes our communication more consistent, which is good.  ACK.

-Steffan

