Message-ID: <2444b8c5-cb6b-8746-9fe0-a3c72b2e7866@...1227...>
Date: Tue, 15 Feb 2022 13:39:23 +0100
MIME-Version: 1.0
Content-Language: en-GB
References: <20220215123157.10615-1-a@...2181...>
From: Arne Schwabe <arne@...1227...>
In-Reply-To: <20220215123157.10615-1-a@...2181...>
Subject: Re: [Openvpn-devel] [PATCH v2] auth_token/tls_crypt: fix usage of
 md_valid()
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Antonio Quartulli <a@...2181...>, openvpn-devel@lists.sourceforge.net

Am 15.02.22 um 13:31 schrieb Antonio Quartulli:
> With b39725cf ("Remove md_kt_t and change crypto API to use const char*")
> the logic for validating ciphers and md algorithms has been changed.
> 
> We should now *always* use md_valid() when validating a digest alg.
> 
> At the same time, add '!' (negation) when validating the digest algorithm
> in the tls-crypt code, in order to restore the proper logic.
> 
> Cc: Arne Schwabe <arne@...1227...>
> Fixes: b39725cf ("Remove md_kt_t and change crypto API to use const char*")
> Reported-by: Richard T Bonhomme <tincantech@...2282...>
> Signed-off-by: Antonio Quartulli <a@...2181...>

Acked-By: Arne Schwabe <arne@...1227...>

