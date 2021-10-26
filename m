References: <20211019183127.614175-1-arne@...1227...>
 <20211019183127.614175-14-arne@...1227...>
From: Max Fillinger <maximilian.fillinger@...2507...>
Message-ID: <d4b6d143-b3c2-f3d8-61ed-375a6e094ea0@...2507...>
Date: Tue, 26 Oct 2021 14:21:42 +0200
MIME-Version: 1.0
In-Reply-To: <20211019183127.614175-14-arne@...1227...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH v3 13/21] [OSSL 3.0] Remove dependency
 on BF-CBC existance from test_ncp
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
> The test_check_ncp_ciphers_list test assumed that BF-CBC is always
> available, which is no longer the case with OpenSSL 3.0. Rewrite the
> test to not rely on BF-CBC to be available.

Unit tests are working now. I've got some style nitpicks that I think 
can be fixed during commit:

>       bool have_chacha = cipher_kt_get("CHACHA20-POLY1305");
> +    bool have_blowfish= cipher_kt_get("BF-CBC");

Add space before =


> -    if (have_chacha)
> +    if(have_chacha)
> +    {
> +        assert_string_equal(mutate_ncp_cipher_list(aes_chacha, &gc), aes_chacha);
> +    }

Add space before (

Acked-by: Max Fillinger <maximilian.fillinger@...2507...>

