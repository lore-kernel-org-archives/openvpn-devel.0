References: <1462306478-21059-1-git-send-email-steffan@...1856...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <572B25B1.3040801@...1227...>
Date: Thu, 5 May 2016 12:51:29 +0200
MIME-Version: 1.0
In-Reply-To: <1462306478-21059-1-git-send-email-steffan@...1856...>
Subject: Re: [Openvpn-devel] [PATCH] mbedtls: improve error reporting in tls
 verify callback
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

Am 03.05.16 um 22:14 schrieb Steffan Karger:
> Instead of just printing the contents of the flags variable, try to
> convert it to a human-readable error string and print that instead.
> 
> This will for example print "The certificate is signed with an
> unacceptable key (eg bad curve, RSA too short).", instead of
> "flags=10000".
> 
> Signed-off-by: Steffan Karger <steffan@...1856...>
> ---
>  Changes.rst                      |  5 ++++-
>  src/openvpn/ssl_verify_mbedtls.c | 20 +++++++++++++++++---
>  2 files changed, 21 insertions(+), 4 deletions(-)
> 
> diff --git a/Changes.rst b/Changes.rst
> index 5034b15..dc9131b 100644
> --- a/Changes.rst
> +++ b/Changes.rst
> @@ -91,10 +91,13 @@ User-visible Changes
>    * Non-ephemeral key exchange using static (EC)DH keys
>    * DSS private keys
>  
> -- PolarSSL builds: changed the tls_digest_N values exported to the script
> +- mbed TLS builds: changed the tls_digest_N values exported to the script
>    environment to be equal to the ones exported by OpenSSL builds, namely
>    the certificate fingerprint (was the hash of the 'to be signed' data).
>  
> +- mbed TLS builds: minimum RSA key size is now 2048 bits.  Shorter keys will
> +  not be accepted, both local and from the peer.
> +

ACK. ANd thanks for maintaining Changes.rst

Arne


