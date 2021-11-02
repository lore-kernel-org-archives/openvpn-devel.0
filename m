References: <20211019183127.614175-1-arne@...1227...>
 <20211029111109.2003101-1-arne@...1227...>
From: Max Fillinger <maximilian.fillinger@...2507...>
Message-ID: <4c466dab-b562-fa87-381a-dd65db35c59c@...2507...>
Date: Tue, 2 Nov 2021 17:12:16 +0100
MIME-Version: 1.0
In-Reply-To: <20211029111109.2003101-1-arne@...1227...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH v4] [OSSL 3.0] Implement DES ECB encrypt
 via EVP_CIPHER api
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



On 29/10/2021 13:11, Arne Schwabe wrote:
> Even though DES is super outdated and also NTLM is super outdated,
> eliminating the warnings for OpenSSL 3.0 is still a step in the right
> direction and using the correct APIs. We cheat a bit by using 3DES instead
> of DES to avoid needing legacy provider for DES encryption for now.
> 
> Patch v4: add unit test, use 3DES to avoid legacy provider for now
> 
> Signed-off-by: Arne Schwabe <arne@...1227...>

Acked-by: Max Fillinger <maximilian.fillinger@...2507...>

Looks good to me, and the unit tests succeed with OpenSSL 1.1.1 and 3.

Small nitpick that can be fixed at compile time:

> +    if (!EVP_EncryptInit_ex(ctx, EVP_des_ede3_ecb(), NULL, key3, 0))

The last argument for this function is "const unsigned char *iv", so 
this should be NULL instead of 0. (Passing NULL here is correct because 
ECB mode doesn't need an initialization vector.)

