References: <20210428081054.29081-1-a@...2181...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <4c53c755-225e-8561-e1f0-adec8c1d5c76@...1227...>
Date: Wed, 28 Apr 2021 12:29:07 +0200
MIME-Version: 1.0
In-Reply-To: <20210428081054.29081-1-a@...2181...>
Content-Language: en-GB
Subject: Re: [Openvpn-devel] [PATCH] crypto: respect ECB argument type from
 prototype
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
Cc: Antonio Quartulli <antonio@...515...>

Am 28.04.21 um 10:10 schrieb Antonio Quartulli:
> From: Antonio Quartulli <antonio@...515...>
> 
> Crypto backends are implementing the cipher_des_encrypt_ecb()
> function without fully respecting the type of the argumentis as described
> in the function prototype.
> 
> All ECB arguments (key, input block and output block) are expected to
> be 8 bytes long, for this reason the prototype specifies the arguments
> as 3 arrays of 8 bytes in size.
> 
> Convert the implementations to also explicitly mention the size of the
> array they expect to receive in input.
>

Acked-By: Arne Schwabe <arne@...1227...>

In case someone wonders. We use *single* DES in ECB mode for NTLM. And
this was found by GCC 11.

Arne

