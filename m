Date: Fri, 10 Feb 2023 18:14:12 +0100
From: Frank Lichtenheld <frank@...2641...>
Message-ID: <Y+Z7ZPZv2QnFbiOV@...2685...>
References: <20230210142712.572303-1-arne@...1227...>
 <20230210142712.572303-7-arne@...1227...>
MIME-Version: 1.0
In-Reply-To: <20230210142712.572303-7-arne@...1227...>
Subject: Re: [Openvpn-devel] [PATCH 3/4] Revise the cipher negotiation about
 OpenVPN3 in the man page
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net

On Fri, Feb 10, 2023 at 03:27:10PM +0100, Arne Schwabe wrote:
> Newer OpenVPN 3 core versions now allow limited configuration of ciphers:
> 
>     // Allow usage of legacy (cipher) algorithm that are no longer considered safe
>     // This includes BF-CBC, single DES and RC2 private key encryption.
>     // With OpenSSL 3.0 this also instructs OpenSSL to load the legacy provider.
>     bool enableLegacyAlgorithms = false;
> 
>     // By default modern OpenVPN version (OpenVPN 2.6 and OpenVPN core 3.7) will only allow
>     // preferred algorithms (AES-GCM, Chacha20-Poly1305) that also work with the newer DCO
>     // implementations. If this is enabled, we fall back to allowing all algorithms (if these are
>     // supported by the crypto library)
>     bool enableNonPreferredDCAlgorithms = false;
> 
> Adjust the man page section accordingly but only really mention the AEAD ciphers
> to be always present and that they should be included in the data-ciphers option.
> 
> Signed-off-by: Arne Schwabe <arne@...1227...>
> ---
>  doc/man-sections/cipher-negotiation.rst | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/doc/man-sections/cipher-negotiation.rst b/doc/man-sections/cipher-negotiation.rst
> index b07176cd2..66afeb835 100644
> --- a/doc/man-sections/cipher-negotiation.rst
> +++ b/doc/man-sections/cipher-negotiation.rst
> @@ -42,8 +42,9 @@ options to avoid this behaviour.
>  OpenVPN 3 clients
>  -----------------
>  Clients based on the OpenVPN 3.x library (https://github.com/openvpn/openvpn3/)
> -do not have a configurable ``--ncp-ciphers`` or ``--data-ciphers`` option. Instead
> -these clients will announce support for all their supported AEAD ciphers
> +do not have a configurable ``--ncp-ciphers`` or ``--data-ciphers`` option. Newer
> +version by default will disable legacy AES-CBC, BF-CBC, and, DES-CBC ciphers.

"versions"
Remove comma in "and,"
Remove "will"

> +These clients will always announce support for all their supported AEAD ciphers
>  (`AES-256-GCM`, `AES-128-GCM` and in newer versions also `Chacha20-Poly1305`).
>  
>  To support OpenVPN 3.x based clients at least one of these ciphers needs to be


-- 
  Frank Lichtenheld

