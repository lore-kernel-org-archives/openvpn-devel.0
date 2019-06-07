References: <20190510121114.30468-1-arne@...1227...>
 <20190510121114.30468-3-arne@...1227...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <a23bf109-eb28-1f56-ed4a-039a3ab43d45@...2080...>
Date: Fri, 7 Jun 2019 22:46:08 +0200
MIME-Version: 1.0
In-Reply-To: <20190510121114.30468-3-arne@...1227...>
Content-Language: en-GB
Subject: Re: [Openvpn-devel] [PATCH v3 2/7] Implement --genkey type keyfile
 syntax and migrate tls-crypt-v2
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
To: Arne Schwabe <arne@...1227...>, openvpn-devel@lists.sourceforge.net

On 10/05/2019 14:11, Arne Schwabe wrote:
> This unifies our key generation and also migrates the generation
> of the tls-crypt-v2 keys. Since tls-crypt-v2 is not included in any
> released version, we remove the the old syntax without compatibility.
> ---
>  doc/openvpn.8         | 79 +++++++++++++++++++++++--------------------
>  src/openvpn/init.c    | 61 ++++++++++++++++++++-------------
>  src/openvpn/options.c | 67 ++++++++++++++++++++++--------------
>  src/openvpn/options.h | 11 ++++--
>  4 files changed, 131 insertions(+), 87 deletions(-)
> 
> diff --git a/doc/openvpn.8 b/doc/openvpn.8
> index ce440447..90a6be91 100644
> --- a/doc/openvpn.8
> +++ b/doc/openvpn.8
> @@ -5242,7 +5242,7 @@ Use client\-specific tls\-crypt keys.
>  For clients,
>  .B keyfile
>  is a client\-specific tls\-crypt key.  Such a key can be generated using the
> -.B \-\-tls\-crypt\-v2\-genkey
> +.B \-\-genkey tls\-crypt\-v2\-client
>  option.
>  
>  For servers,
> @@ -5250,7 +5250,7 @@ For servers,
>  is used to unwrap client\-specific keys supplied by the client during connection
>  setup.  This key must be the same as the key used to generate the
>  client\-specific key (see
> -.B \-\-tls\-crypt\-v2\-genkey\fR).
> +.B \-\-genkey tls\-crypt\-v2\-client\fR).
>  
>  On servers, this option can be used together with the
>  .B \-\-tls\-auth
> @@ -5260,36 +5260,6 @@ option.  In that case, the server will detect whether the client is using
>  client\-specific keys, and automatically select the right mode.
>  .\"*********************************************************
>  .TP
> -.B \-\-tls\-crypt\-v2\-genkey client|server keyfile [metadata]
> -
> -If the first parameter equals "server", generate a \-\-tls\-crypt\-v2 server
> -key and store the key in
> -.B keyfile\fR.
> -
> -
> -If the first parameter equals "client", generate a \-\-tls\-crypt\-v2 client
> -key, and store the key in
> -.B keyfile\fR.
> -
> -If supplied, include the supplied
> -.B metadata
> -in the wrapped client key.  This metadata must be supplied in base64\-encoded
> -form.  The metadata must be at most 735 bytes long (980 bytes in base64).
> -
> -If no metadata is supplied, OpenVPN will use a 64\-bit unix timestamp
> -representing the current time in UTC, Rencoded in network order, as metadata for
> -the generated key.
> -
> -A tls\-crypt\-v2 client key is wrapped using a server key.  To generate a
> -client key, the user must therefore supply the server key using the
> -.B \-\-tls\-crypt\-v2
> -option.
> -
> -Servers can use
> -.B \-\-tls\-crypt\-v2\-verify
> -to specify a metadata verification command.
> -.\"*********************************************************
> -.TP
>  .B \-\-tls\-crypt\-v2\-verify cmd
>  
>  Run command
> @@ -5741,13 +5711,18 @@ Show all available elliptic curves to use with the
>  .B \-\-ecdh\-curve
>  option.
>  .\"*********************************************************
> -.SS Generate a random key:
> -Used only for non\-TLS static key encryption mode.
> +.SS Generating random key material:

"Random key material" sounds a bit odd.  Is it important for most end-users
that we emphasize "random"?  Isn't enough saying: "Generating key material"?

>  .\"*********************************************************
>  .TP
> -.B \-\-genkey file
> +.B \-\-genkey keytype keyfile
>  (Standalone)
> -Generate a random key to be used as a shared secret, for use with the
> +Generate a random key to be used of the type keytype. if keyfile is left out or empty
> +the key will be output on stdout. See the following sections for the different keytypes.

Same as the comment above.

There is also some odd and unexpected behaviour, some which I already touched
in my initial review overview mail.

 $ openvpn --genkey
 [new static key is sent to stdout, this is fine]

 $ openvpn --genkey --secret test.key
 [new static key saved to test.key, this is fine]

 $ openvpn --genkey secret
 [new static key is sent to stdout, this is fine]

 $ openvpn --genkey secret --secret test.key
 [new static key is saved to test.key, this is fine]

 $ openvpn --genkey auth-token
 [new static key is sent to stdout, this is fine]

 $ openvpn --genkey auth-token --secret test.key
 [new static key is sent to stdout - huh!?]

 $ openvpn --genkey tls-crypt --secret test.key
 [new static key is saved to test.key, this is fine]

 $ openvpn --genkey tls-crypt-v2-server --secret test.key
 [new static key is sent to stdout - huh!?]

This behaviour change with/without --secret where it sometimes writes file to
stdout, sometimes to file is confusing.  *I* know why, but users not diving
into the code does not.

I also know filename can be given as an argument to --genkey.  So I propose
that we either ditch --secret with --genkey all together.  OpenVPN 2.5 is a
new major release, we can allow such a change; it will not break existing
configuration files.  By not allowing --secret to be used with --genkey, we
avoid this ambiguity.

We could consider to support --secret properly with --genkey, but that will
make the '--genkey tls-crypt-v2-client KEYFILE [METADATA]' trickier and less
consistent.  If --secret is present, should that remove the need for KEYFILE,
should KEYFILE overrule --secret or should KEYFILE be ignored?  This makes it
much less consistent.

Another challenge: Currently we cannot generate tls-crypt-v2-client keys to
stdout with METADATA.

Should we rather do what other *nix programs often do, use '-' as and
indication for "write to stdout"?  Or have a specific keyword (like 'stdout:')?


> diff --git a/src/openvpn/init.c b/src/openvpn/init.c
> index 3c449678..9260067f 100644
> --- a/src/openvpn/init.c
> +++ b/src/openvpn/init.c
> @@ -1053,18 +1053,33 @@ bool
>  do_genkey(const struct options *options)
>  {
>      /* should we disable paging? */
> -    if (options->mlock && (options->genkey || options->tls_crypt_v2_genkey_file))
> +    if (options->mlock && (options->genkey))
>      {
>          platform_mlockall(true);
>      }
> -    if (options->genkey)
> +    if (options->genkey && options->genkey_type == GENKEY_SECRET)
>      {
>          int nbits_written;
>  
> -        notnull(options->shared_secret_file,
> -                "shared secret output file (--secret)");
> +        if (options->shared_secret_file && options->genkey_filename)
> +        {
> +            msg(M_USAGE, "You must provide a filename to either --genkey or --secret, not both");
> +        }

By removing support for --genkey with --secret, this check need to moved
outside this if() scope and check whether --secret and --genkey are both present.

Otherwise, this patch looks reasonable.


-- 
kind regards,

David Sommerseth
OpenVPN Inc


