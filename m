References: <20210406162518.4075-1-arne@...1227...>
 <20210406162518.4075-5-arne@...1227...>
 <59fa6949-300a-d13d-efb8-e3ba128ce6c2@...2181...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <a718243e-a26b-316c-cb13-a97a17d7de22@...1227...>
Date: Wed, 7 Apr 2021 00:51:41 +0200
MIME-Version: 1.0
In-Reply-To: <59fa6949-300a-d13d-efb8-e3ba128ce6c2@...2181...>
Content-Language: en-GB
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
To: Antonio Quartulli <a@...2181...>, openvpn-devel@lists.sourceforge.net


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
>\

Just running uncrustify on the file will just add that one comment

-#endif
+#endif /* if OPENSSL_VERSION_NUMBER < 0x10100000L &&
!defined(ENABLE_CRYPTO_WOLFSSL) */

So if that can be done at commit time that would avoid a V2 but I can
also send a V2 with only that change if that is preferred.

Arne

