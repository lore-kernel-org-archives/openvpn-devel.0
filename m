Date: Sat, 15 Nov 2025 11:09:41 +0100
From: Sabrina Dubroca <sd@...2891...>
Message-ID: <aRhRZfy_9liL1HGG@...2915...>
References: <20251114104029.239065-1-ralf@...2726...>
MIME-Version: 1.0
In-Reply-To: <20251114104029.239065-1-ralf@...2726...>
Subject: Re: [Openvpn-devel] [PATCH ovpn v3] ovpn: consolidate crypto
 allocations in one chunk
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
Content-Disposition: inline
To: Ralf Lici <ralf@...2726...>
Cc: openvpn-devel@lists.sourceforge.net, Antonio Quartulli <antonio@...515...>

2025-11-14, 11:40:29 +0100, Ralf Lici wrote:
> Currently ovpn uses three separate dynamically allocated structures to
> set up cryptographic operations for both encryption and decryption. This
> adds overhead to performance-critical paths and contribute to memory
> fragmentation.
> 
> This commit consolidates those allocations into a single temporary blob,
> similar to what esp_alloc_tmp() does.
> 
> The resulting performance gain is +7.7% and +4.3% for UDP when using AES
> and ChaChaPoly respectively, and +4.3% for TCP.
> 
> Signed-off-by: Ralf Lici <ralf@...2726...>
> Signed-off-by: Antonio Quartulli <antonio@...515...>
> ---
> Changes since v2:
> - Replaced manual multiplication with array_size() helper
> - Made ovpn_aead_crypto_tmp_size() less generic by asserting that IV
>   size equals OVPN_NONCE_SIZE
> 
> Changes since v1:
> - Fixed typo in commit message
> - Adjusted ovpn_aead_crypto_tmp_size comment to follow kdoc style
> - Stored allocated blob in the skb control block immediately after
>   allocation to prevent leakage on failure
> - Removed 'inline' from function declarations in crypto_aead.c
> 
>  drivers/net/ovpn/crypto_aead.c | 160 +++++++++++++++++++++++++--------
>  drivers/net/ovpn/io.c          |   8 +-
>  drivers/net/ovpn/skb.h         |  13 ++-
>  3 files changed, 135 insertions(+), 46 deletions(-)

Reviewed-by: Sabrina Dubroca <sd@...2891...>

Thanks Ralf.

-- 
Sabrina

