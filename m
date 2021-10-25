References: <20211019183127.614175-1-arne@...1227...>
 <20211019183127.614175-11-arne@...1227...>
From: Max Fillinger <maximilian.fillinger@...2507...>
Message-ID: <108c949a-f5e9-d8c4-d468-ca888813cd8e@...2507...>
Date: Mon, 25 Oct 2021 17:55:10 +0200
MIME-Version: 1.0
In-Reply-To: <20211019183127.614175-11-arne@...1227...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH v3 10/21] [OSSL 3.0] Replace
 EVP_get_cipherbyname with EVP_CIPHER_fetch
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

On 19/10/2021 20:31, Arne Schwabe wrote:
> In OpenSSL 3.0 EVP_get_cipherbyname return a non NULL algorithm
> even if the algorithm is not avaialble with the currently available
> provider. Luckily EVP_get_cipherbyname can be used here as drop
> in replacement and returns only non NULL if the algorithm is actually
> currently supported.
> 
> Signed-off-by: Arne Schwabe <arne@...1227...>

Acked-by: Max Fillinger <maximilian.fillinger@...2507...>

Looks good to me!

Some small errors in the commit message:

"return a non Null algorithm": Should be "may return", I think.

second "EVP_get_cipherbyname" should be "EVP_CIPHER_fetch".

