From: Antonio Quartulli <a@...2181...>
References: <20210406162518.4075-1-arne@...1227...>
 <20210406162518.4075-5-arne@...1227...>
 <59fa6949-300a-d13d-efb8-e3ba128ce6c2@...2181...>
Message-ID: <65d7fe52-a18b-a8e2-b4ab-26dfae8f6a1d@...2181...>
Date: Wed, 7 Apr 2021 16:28:03 +0200
MIME-Version: 1.0
In-Reply-To: <59fa6949-300a-d13d-efb8-e3ba128ce6c2@...2181...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH 5/5] Remove OpenSSL configure checks
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

On 06/04/2021 23:01, Antonio Quartulli wrote:
> 
> I like the new approach a lot.
> It definitely helps keeping track of "what compat code do we need? and
> for which version?"
> 
> Just one suggestion:
> I think it would still be useful to add a comment on the #endif line to
> explicitly say what if we are closing.
> 
> i.e:
> 
> #endif /* OPENSSL_VERSION_NUMBER < 0x10101000L &&
> !defined(ENABLE_CRYPTO_WOLFSSL) */
> 
> That helps your brain when the corresponding #if is far away or you have
> more than one nearby.
> 
> Other than that, it compiles on openssl-1.1.1, 1.1.0 and 1.0.2.
> Test on Linux and Windows (openssl-1.1.1 only in this case).

Since Gert has volunteered to fix this comment on the fly, I am fine
with this version of the patch.

Acked-by: Antonio Quartulli <antonio@...515...>


-- 
Antonio Quartulli

