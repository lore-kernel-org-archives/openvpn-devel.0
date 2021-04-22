References: <20210421123415.1942917-1-arne@...1227...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <8fc2c5c5-5f20-2ba0-99b8-1e64fb449bc5@...2181...>
Date: Thu, 22 Apr 2021 17:48:33 +0200
MIME-Version: 1.0
In-Reply-To: <20210421123415.1942917-1-arne@...1227...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH v2] Allow all GCM ciphers
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

Hi,

On 21/04/2021 14:34, Arne Schwabe wrote:
> OpenSSL also allows ARIA-GCM and that works well with our implementation
> While the handpicked list was needed for earlier OpenSSL versions (and
> is still needed for Chacha20-Poly1305), the API nowadays with OpenSSL
> 1.0.2 and 1.1.x works as expected.
> 
> Patch V2: Remove special cases for AES-GCM ciphers.
> 
> Signed-off-by: Arne Schwabe <arne@...1227...>

Testing AES-GCM on various OpenSSL versions just works as usual.
ARIA-GCM works as expected on 1.1.0 and 1.1.1 (1.0.2 does not seem to
support it).

CHACHA20-POLY1305 is also confirmed to still be working on OpenSSL 1.1.0
and 1.1.1.

LibreSSL compiles and works as expected (basic tests performed).

wolfSSL compiles but does not work anymore. I presume it does not
properly implement EVP_CIPHER_mode() as it returns 0 for AES-256-GCM.

IMHO this is one of those cases where we should merge this patch and
then wait for wolfSSL to fix the library.

So this patch gets my ACK, but I am not sure how we want to proceed.

Acked-by: Antonio Quartulli <antonio@...515...>




-- 
Antonio Quartulli

