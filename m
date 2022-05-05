Message-ID: <cc034a5e-a699-f350-dff2-2f35978e88b3@...2181...>
Date: Thu, 5 May 2022 15:15:40 +0200
MIME-Version: 1.0
Content-Language: en-US
References: <20220422142953.3805364-13-arne@...1227...>
 <20220505130348.1183195-1-arne@...1227...>
From: Antonio Quartulli <a@...2181...>
In-Reply-To: <20220505130348.1183195-1-arne@...1227...>
Subject: Re: [Openvpn-devel] [PATCH v4] Implement HMAC based session id for
 tls-crypt v2
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
To: Arne Schwabe <arne@...1227...>, openvpn-devel@lists.sourceforge.net

Hi,

On 05/05/2022 15:03, Arne Schwabe wrote:
> Tls-crypt v2 is more complicated to implement a proper stateless
> handshake. To allow state handshake this commit does
> 
>   - introduce a new packet CONTROL_WKC_V1 that repeats the wrapped
>     client key.
>   - introduce a way to negotiate the support for this packet in the
>     three way handshake
> 
> Details about the protocol changes are in tls-crypt-v2.txt. Optional
> arguments to the tls-crypt-v2 option have been added to explicitly
> allow or disallow client that do not support the stateless handshake.
> 
> Signed-off-by: Arne Schwabe <arne@...1227...>

Acked-by: Antonio Quartulli <a@...2181...>


-- 
Antonio Quartulli

