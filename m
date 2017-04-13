References: <e6f1b674-b382-0626-03c8-a20e0fbefc1b@...2080...>
	<1491996924-24576-1-git-send-email-steffan.karger@...1435...>
From: Steffan Karger <steffan.karger@...1435...>
Message-ID: <024c8d0b-b82d-4ea2-2445-9c57bf734c83@...1435...>
Date: Thu, 13 Apr 2017 14:39:17 +0200
MIME-Version: 1.0
In-Reply-To: <1491996924-24576-1-git-send-email-steffan.karger@...1435...>
Subject: Re: [Openvpn-devel] [PATCH v2] Add --tls-cert-profile option for
	mbedtls builds
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

On 12-04-17 13:35, Steffan Karger wrote:
>  Version 2.4.1
>  =============
> - - ``--remote-cert-ku`` now only requires the certificate to have at least the
> -   bits set of one of the values in the supplied list, instead of requiring an
> -   exact match to one of the values in the list.
> - - ``--remote-cert-tls`` now only requires that a keyUsage is present in the
> -   certificate, and leaves the verification of the value up to the crypto
> -   library, which has more information (i.e. the key exchange method in use)
> -   to verify that the keyUsage is correct.
> - - ``--ns-cert-type`` is deprecated.  Use ``--remote-cert-tls`` instead.
> -   The nsCertType x509 extension is very old, and barely used.
> -   ``--remote-cert-tls`` uses the far more common keyUsage and extendedKeyUsage
> -   extension instead.  Make sure your certificates carry these to be able to
> -   use ``--remote-cert-tls``.
> +- ``--remote-cert-ku`` now only requires the certificate to have at least the
> +  bits set of one of the values in the supplied list, instead of requiring an
> +  exact match to one of the values in the list.
> +- ``--remote-cert-tls`` now only requires that a keyUsage is present in the
> +  certificate, and leaves the verification of the value up to the crypto
> +  library, which has more information (i.e. the key exchange method in use)
> +  to verify that the keyUsage is correct.
> +- ``--ns-cert-type`` is deprecated.  Use ``--remote-cert-tls`` instead.
> +  The nsCertType x509 extension is very old, and barely used.
> +  ``--remote-cert-tls`` uses the far more common keyUsage and extendedKeyUsage
> +  extension instead.  Make sure your certificates carry these to be able to
> +  use ``--remote-cert-tls``.
> +- The new option ``--tls-cert-profile`` can be used to restrict the set of
> +  allowed crypto algorithms in TLS certificates in mbed TLS builds.  The
> +  'legacy' profile can be used to re-enable support for SHA1 and 1024-bit RSA
> +  keys.

Hrmpf, this should of course get a new section '2.4.2'...  Let me know
if you want a v3, or whether this can be fixed on-the-fly.  Apologies!

-Steffan

