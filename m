References: <20190613134834.5709-1-arne@...1227...>
From: tincanteksup <tincanteksup@...277...>
Message-ID: <c5bb8904-6f66-345d-c6bb-eb0bbbdc2156@...277...>
Date: Wed, 26 Jun 2019 15:46:14 +0100
MIME-Version: 1.0
In-Reply-To: <20190613134834.5709-1-arne@...1227...>
Content-Language: en-GB
Subject: Re: [Openvpn-devel] [PATCH v4 2/7] Implement --genkey type keyfile
 syntax and migrate tls-crypt-v2
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Unimportant non escaped dashes openvpn.8 & one typo

On 13/06/2019 14:48, Arne Schwabe wrote:
> This unifies our key generation and also migrates the generation
> of the tls-crypt-v2 keys. Since tls-crypt-v2 is not included in any
> released version, we remove the the old syntax without compatibility.
> 
> PATCH V4: Introduce warning/error when using --secret with --genkey
>            Update non code usages to use new --genkey syntax
> ---
>   INSTALL                                |  2 +-
>   doc/openvpn.8                          | 81 ++++++++++++++------------
>   sample/sample-config-files/server.conf |  2 +-
>   sample/sample-keys/gen-sample-keys.sh  |  2 +-
>   sample/sample-windows/sample.ovpn      |  2 +-
>   src/openvpn/crypto.c                   |  2 +-
>   src/openvpn/init.c                     | 71 ++++++++++++++--------
>   src/openvpn/options.c                  | 67 +++++++++++++--------
>   src/openvpn/options.h                  | 11 +++-
>   tests/t_lpback.sh                      |  8 +--
>   10 files changed, 151 insertions(+), 97 deletions(-)
> 


> diff --git a/doc/openvpn.8 b/doc/openvpn.8
> index ce440447..25195fd4 100644
> --- a/doc/openvpn.8
> +++ b/doc/openvpn.8
> @@ -5242,7 +5242,7 @@ Use client\-specific tls\-crypt keys.
>   For clients,
>   .B keyfile
>   is a client\-specific tls\-crypt key.  Such a key can be generated using the
> -.B \-\-tls\-crypt\-v2\-genkey
> +.B \-\-genkey tls\-crypt\-v2\-client
>   option.
>   
>   For servers,
> @@ -5250,7 +5250,7 @@ For servers,
>   is used to unwrap client\-specific keys supplied by the client during connection
>   setup.  This key must be the same as the key used to generate the
>   client\-specific key (see
> -.B \-\-tls\-crypt\-v2\-genkey\fR).
> +.B \-\-genkey tls\-crypt\-v2\-client\fR).
>   
>   On servers, this option can be used together with the
>   .B \-\-tls\-auth
> @@ -5260,36 +5260,6 @@ option.  In that case, the server will detect whether the client is using
>   client\-specific keys, and automatically select the right mode.
>   .\"*********************************************************
>   .TP
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
> -representing the current time in UTC, encoded in network order, as metadata for
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
>   .B \-\-tls\-crypt\-v2\-verify cmd
>   
>   Run command
> @@ -5741,13 +5711,18 @@ Show all available elliptic curves to use with the
>   .B \-\-ecdh\-curve
>   option.
>   .\"*********************************************************
> -.SS Generate a random key:
> -Used only for non\-TLS static key encryption mode.
> +.SS Generating key material:
>   .\"*********************************************************
>   .TP
> -.B \-\-genkey file
> +.B \-\-genkey keytype keyfile
>   (Standalone)
> -Generate a random key to be used as a shared secret, for use with the
> +Generate a key to be used of the type keytype. if keyfile is left out or empty
> +the key will be output on stdout. See the following sections for the different keytypes.
> +
> +.\"*********************************************************
> +.TP
> +.B \-\-genkey secret|tls-crypt|tls-auth keyfile

^^

> +Generate a shared secret, for use with the
>   .B \-\-secret
>   ,
>   .B \-\-tls-auth
> @@ -5755,6 +5730,8 @@ or
>   .B \-\-tls-crypt
>   options.  Stores the key in
>   .B file\fR.
> +All three variants (secret, tls-crypt, and tls-auth) generate the same type of

^^

> +key. The aliases are added for convience.

typo: convience -> convenience

>   
>   If using this for
>   .B \-\-secret
> @@ -5762,6 +5739,36 @@ If using this for
>   such as
>   .BR scp (1)\fR.
>   .\"*********************************************************
> +.TP
> +.B \-\-genkey tls\-crypt\-v2-server keyfile

^^

> +
> +Generate a \-\-tls\-crypt\-v2 server key and store the key in
> +.B keyfile\fR.
> +
> +.TP
> +.B \-\-genkey tls\-crypt\-v2-client keyfile [metadata]

^^

> +
> +Generate a \-\-tls\-crypt\-v2 client key, and store the key in > +.B keyfile\fR.
> +
> +If supplied, include the supplied
> +.B metadata
> +in the wrapped client key.  This metadata must be supplied in base64\-encoded
> +form.  The metadata must be at most 735 bytes long (980 bytes in base64).
> +
> +If no metadata is supplied, OpenVPN will use a 64\-bit unix timestamp
> +representing the current time in UTC, encoded in network order, as metadata for
> +the generated key.
> +
> +A tls\-crypt\-v2 client key is wrapped using a server key.  To generate a
> +client key, the user must therefore supply the server key using the
> +.B \-\-tls\-crypt\-v2
> +option.
> +
> +Servers can use
> +.B \-\-tls\-crypt\-v2\-verify
> +to specify a metadata verification command.
> +.\"*********************************************************
>   .SS TUN/TAP persistent tunnel config mode:
>   Available with Linux 2.4.7+.  These options comprise a standalone mode
>   of OpenVPN which can be used to create and delete persistent tunnels.
> @@ -7185,7 +7192,7 @@ First build a static key on bob.
>   .IP
>   .B openvpn \-\-genkey \-\-secret key
>   .LP
> -This command will build a random key file called
> +This command will build a key file called
>   .B key
>   (in ascii format).
>   Now copy

