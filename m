References: <20200812140120.21287-1-arne@...1227...>
 <20200812140120.21287-3-arne@...1227...>
From: tincanteksup <tincanteksup@...277...>
Message-ID: <84527759-b8a3-d4a2-bb54-a3df9d83f1c7@...277...>
Date: Wed, 12 Aug 2020 16:07:45 +0100
MIME-Version: 1.0
In-Reply-To: <20200812140120.21287-3-arne@...1227...>
Content-Language: en-GB
Subject: Re: [Openvpn-devel] [PATCH v2 3/3] Implement generating data
 channel keys via EKM/RFC 5705
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

typos/grammar

On 12/08/2020 15:01, Arne Schwabe wrote:
> OpenVPN currently uses its own (based on TLS 1.0) key derivation
> mechansim to generate the 256 bytes key data in key2 struct that

mechansim -> mechanism


> are then used used to generate encryption/hmac/iv vectors. While
> this mechanism is still secure, it is not state of the art.
> 
> Instead of modernisating our own approach, this commit implements

modernisating - > modernising


> key derivation using the Keying Material Exporters API introduced
> by RFC 5705.
> 
> We also use an opportunistic approach of negotiating the use of
> EKM (exported key material) through an IV_PROTO flag and prefer
> EKM to our own PRF if both client and server support it. The
> use of EKM is pushed to the client as part of NCP as
> key-derivation tls-ekm.
> 
> We still exchange the random data (112 bytes from client to server
> and 64 byte from server to client) that for the OpenVPN PRF but

client) that for - unnecessary 'that'

> do not use it. Removing that exchange would break the handshake
> and make a key-method 3 or similar necessary.
> 
> Side note: this commit breaks the (not yet merged) WolfSSL support as it
> claims to support EKM in the OpenSSL compat API but always returns an error
> if you try to use it.
> 
> Signed-off-by: Arne Schwabe <arne@...1227...>
> 
> Patch V2: rebase/change to V2 of EKM refactoring
> ---
>   Changes.rst                      | 11 +++++++
>   doc/doxygen/doc_key_generation.h | 15 ++++++++--
>   src/openvpn/crypto.h             |  4 +++
>   src/openvpn/init.c               |  1 +
>   src/openvpn/multi.c              |  4 +++
>   src/openvpn/options.c            | 14 +++++++++
>   src/openvpn/options.h            |  3 ++
>   src/openvpn/push.c               |  5 +++-
>   src/openvpn/ssl.c                | 50 ++++++++++++++++++++++++++++++--
>   src/openvpn/ssl.h                |  2 ++
>   src/openvpn/ssl_backend.h        |  2 ++
>   src/openvpn/ssl_mbedtls.c        |  7 ++---
>   12 files changed, 107 insertions(+), 11 deletions(-)
> 
> diff --git a/Changes.rst b/Changes.rst
> index bacc98cd..2c28a399 100644
> --- a/Changes.rst
> +++ b/Changes.rst
> @@ -1,3 +1,14 @@
> +Overview of changes in 2.6
> +==========================
> +
> +
> +New features
> +------------
> +Keying Material Exporters (RFC 5705) based key generation
> +    As part of the cipher negotiation OpenVPN will automatically prefer
> +    the RFC5705 based key material generation to the current custom
> +    OpenVPN PRF. This feature requires OpenSSL or mbed TLS 2.18+.
> +
>   Overview of changes in 2.5
>   ==========================
>   
> diff --git a/doc/doxygen/doc_key_generation.h b/doc/doxygen/doc_key_generation.h
> index 4bb9c708..bbd6c0c5 100644
> --- a/doc/doxygen/doc_key_generation.h
> +++ b/doc/doxygen/doc_key_generation.h
> @@ -58,6 +58,12 @@
>    *
>    * @subsection key_generation_method_2 Key method 2
>    *
> + * There are two methods for generating key data when using key method 2
> + * the first is OpenVPN's traditional approach that exchanges random
> + * data and uses a PRF and the other is using the RFC5705 keying material
> + * exporter to generate the key material. For both methods the random
> + * data is exchange but only used in the traditional method.
> + *
>    * -# The client generates random material in the following amounts:
>    *    - Pre-master secret: 48 bytes
>    *    - Client's PRF seed for master secret: 32 bytes
> @@ -73,8 +79,13 @@
>    *    server's random material.
>    *
>    * %Key method 2 %key expansion is performed by the \c
> - * generate_key_expansion() function.  Please refer to its source code for
> - * details of the %key expansion process.
> + * generate_key_expansion_oepnvpn_prf() function.  Please refer to its source
> + * code for details of the %key expansion process.
> + *
> + * When the client sends the IV_PROTO_TLS_KEY_EXPORT and the server replies
> + * with `key-derivation tls-ekm` RFC5705 key material exporter with the label
> + * EXPORTER-OpenVPN-datakeys is used for the key data.

Grammar: split the sentence by a 'then'.

 > + * When the client sends the IV_PROTO_TLS_KEY_EXPORT and the server 
replies
 > + * with `key-derivation tls-ekm` then RFC5705 key material exporter 
with the label
 > + * EXPORTER-OpenVPN-datakeys is used for the key data.


