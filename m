References: <20210818213354.687736-1-arne@...1227...>
 <20210818213354.687736-2-arne@...1227...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <56b5db50-c235-2288-a3c8-773049ce21ca@...2181...>
Date: Tue, 7 Sep 2021 15:53:45 +0200
MIME-Version: 1.0
In-Reply-To: <20210818213354.687736-2-arne@...1227...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH 2/2] Include Chacha20-Poly1305 into
 default --data-ciphers when available
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
To: Arne Schwabe <arne@...1227...>, openvpn-devel@lists.sourceforge.net

Hi,

On 18/08/2021 23:33, Arne Schwabe wrote:
> Most TLS 1.3 libraries inlcude the Chacha20-Poly1305 based cipher suite
> beside the AES-GCM based ones int he list of default ciphers suites.
> Chacha20-Poly1305 is accepted as good alternative AEAD algorithm to the
> AES-GCM algorithm by crypto community.
> 
> Follow this and include Chacha20-Poly1305 by default in data-ciphers
> when available. This makes picking Chacha20-Poly1305 easier as it only
> requires to change server (by changing priority) or client side (removing
> AES-GCM from data-ciphers) to change to Chacha20-Poly1305.
> 
> Signed-off-by: Arne Schwabe <arne@...1227...>

Not sure why this is 2/2 as it seems unrelated to 1/2.
Indeed I applied and reviewed this patch alone.

It does what it says and imho it is pretty clean.

Tested with a client that connects against a server having default
ciphers. The client, if willing, can specify chacha20poly1305 only and
connect with it.

This is a sensible change which IMHO will make a lot of people happy.

Acked-by: Antonio Quartulli <antonio@...515...>



-- 
Antonio Quartulli

