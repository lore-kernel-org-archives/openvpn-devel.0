References: <20170628191538.9135-1-davids@...515...>
From: Steffan Karger <steffan.karger@...1435...>
Message-ID: <83d0ae64-8ccb-e602-e416-8dc64836a6d0@...1435...>
Date: Thu, 29 Jun 2017 10:25:58 +0200
MIME-Version: 1.0
In-Reply-To: <20170628191538.9135-1-davids@...515...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH] doc: The CRL processing is not a
 deprecated feature
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

On 28-06-17 21:15, David Sommerseth wrote:
> The note related to the CRL processing was somehow put into
> the deprecated section.  This is quite confusing.
> 
> Since this is a fairly important change, and there have been
> a noticable amount of supports questions related to OpenVPN
> not starting due to CRL errors, I put this into the
> "New features" section labelled as an improvement.  Otherwise
> I fear this would drown in the list of "User-visible Changes"
> later on.
> 
> Signed-off-by: David Sommerseth <davids@...515...>
> ---
>  Changes.rst | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/Changes.rst b/Changes.rst
> index 9db0a451..0b2b04dd 100644
> --- a/Changes.rst
> +++ b/Changes.rst
> @@ -44,6 +44,13 @@ ECDH key exchange
>      The TLS control channel now supports for elliptic curve diffie-hellmann
>      key exchange (ECDH).
>  
> +Improved Certificate Revocation List (CRL) processing
> +    CRLs are now handled by the crypto library (OpenSSL or mbed TLS), instead
> +    of inside OpenVPN itself.  The crypto library implementations are more
> +    strict than the OpenVPN implementation was.  This might reject peer
> +    certificates that would previously be accepted.  If this occurs, OpenVPN
> +    will log the crypto library's error description.
> +
>  Dualstack round-robin DNS client connect
>      Instead of only using the first address of each ``--remote`` OpenVPN
>      will now try all addresses (IPv6 and IPv4) of a ``--remote`` entry.
> @@ -160,12 +167,6 @@ Deprecated features
>    will then use ``--key-method 2`` by default.  Note that this requires changing
>    the option in both the client and server side configs.
>  
> -- CRLs are now handled by the crypto library (OpenSSL or mbed TLS), instead of
> -  inside OpenVPN itself.  The crypto library implementations are more strict
> -  than the OpenVPN implementation was.  This might reject peer certificates
> -  that would previously be accepted.  If this occurs, OpenVPN will log the
> -  crypto library's error description.
> -
>  - ``--tls-remote`` is removed in 2.4, as indicated in the 2.3 man-pages.  Similar
>    functionality is provided via ``--verify-x509-name``, which does the same job in
>    a better way.
> 

ACK

-Steffan

