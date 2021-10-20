References: <20211019183127.614175-1-arne@...1227...>
 <20211019183127.614175-4-arne@...1227...>
From: Max Fillinger <maximilian.fillinger@...2507...>
Message-ID: <a8e16056-5e9d-11e8-c517-129d4cfd122c@...2507...>
Date: Wed, 20 Oct 2021 19:36:26 +0200
MIME-Version: 1.0
In-Reply-To: <20211019183127.614175-4-arne@...1227...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH v3 03/21] [OSSL 3.0] Implement DES ECB
 encrypt via EVP_CIPHER api
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
> +    if (!EVP_EncryptInit_ex(ctx, EVP_bf_ecb(), NULL, key, 0))

EVP_bf_ecb() is the Blowfish cipher, not DES.

