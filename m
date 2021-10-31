References: <20211030185756.1831-1-selva.nair@...277...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <e4f38ae4-2232-4142-5918-60a343ba2618@...1227...>
Date: Sun, 31 Oct 2021 10:48:21 +0100
MIME-Version: 1.0
In-Reply-To: <20211030185756.1831-1-selva.nair@...277...>
Content-Language: en-GB
Subject: Re: [Openvpn-devel] [PATCH] Avoid memory leak in hmac_ctx_new
 (OpenSSL 3.0 only)
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
To: selva.nair@...277..., openvpn-devel@lists.sourceforge.net

Am 30.10.21 um 20:57 schrieb selva.nair@...277...:
> From: Selva Nair <selva.nair@...277...>
> 
> In OpenSSL 3.0, fetched algorithms must be freed
> (down referenced). In this case, though EVP_MAC_CTX_new()
> keeps a reference to 'hmac', it up-refs it. So we have to free
> it here before return.
> 
> (Tested using an enable-asan build).
> 

Acked-By: Arne Schwabe <arne@...1227...>

Thanks. I overlooked freeing of fetched algorithms. I probably need to
look at the fetch patch again too :/

Arne

