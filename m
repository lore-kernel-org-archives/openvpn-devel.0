From: Arne Schwabe <arne@...1227...>
References: <20211019183127.614175-1-arne@...1227...>
 <20211019183127.614175-11-arne@...1227...>
 <CAKuzo_ikOZgK1oJ_-p9Y46MQ__6u2SD4ctJp-CotW3fEfufz-g@...278...>
 <cafcb35e-0595-8d48-43eb-9515832dabdb@...1227...>
Message-ID: <d9f9d48c-c9e6-5516-0e0e-95c96dcf14a2@...1227...>
Date: Mon, 1 Nov 2021 23:18:22 +0100
MIME-Version: 1.0
In-Reply-To: <cafcb35e-0595-8d48-43eb-9515832dabdb@...1227...>
Content-Language: en-GB
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Selva Nair <selva.nair@...277...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>


>>
>> One option is to continue using get_cipherbyname() but add a helper call
>> for OpenSSL 3.0 to check algorithm availability. Say,
>> EVP_CIPHER_available() that fetches, checks the result and frees --- 
>> to be used on top of the existing code.
> 
> That is an option but will break as soon as we have the first cipher
> that is no longer defined with EVP_ORIG_GLOBAL compatibility definition.
> I need to check how much work it is to teach OpenVPN to free the cipher
> and md.

I looked at this and I think the best option is to change API to use
strings rather than EVP_CIPHER in the "public" API of the ssl library
implementation. That will simplify the code rather than to complicate it.

Arne

