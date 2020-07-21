References: <0b251f8c-9745-319b-db9e-58a661cd7e13@...2181...>
 <20200721154922.17144-1-arne@...1227...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <fe01ba17-5988-285d-5f2b-2e8a4ac96478@...2181...>
Date: Tue, 21 Jul 2020 17:53:58 +0200
MIME-Version: 1.0
In-Reply-To: <20200721154922.17144-1-arne@...1227...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH v6 4/9] Implement tls-groups option to
 specify eliptic curves/groups
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

On 21/07/2020 17:49, Arne Schwabe wrote:
> By default OpenSSL 1.1+ only allows signatures and ecdh/ecdhx from the
> default list of X25519:secp256r1:X448:secp521r1:secp384r1. In
> TLS1.3 key exchange is independent from the signature/key of the
> certificates, so allowing all groups per default is not a sensible
> choice anymore and instead a shorter list is reasonable.
> 
> However, when using certificates with exotic curves that are not on
> the group list, the signatures of these certificates will no longer
> be accepted.
> 
> The tls-groups  option allows to modify the group list to account
> for these corner cases.
> 
> Patch V2: Uses local gc_arena instead of malloc/free, reword commit
>           message. Fix other typos/clarify messages
> 
> Patch V3: Style fixes, adjust code to changes from mbed tls session
>           fix
> 
> Patch V5: Fix compilation with OpenSSL 1.0.2
> 
> Patch V6: Redo the 'while((token = strsep(&tmp_groups, ":"))' change
>           that accidently got lost.
> 
> Signed-off-by: Arne Schwabe <arne@...1227...>


Much better now.

Acked-by: Antonio Quartulli <a@...2181...>




-- 
Antonio Quartulli

