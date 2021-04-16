References: <20210408140229.31824-1-arne@...1227...>
 <20210408140229.31824-2-arne@...1227...>
 <3f527df4-744a-9eb5-17fa-c86459f7f757@...2181...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <952bddc0-b405-3cee-2b6c-63e5b78c2ba6@...1227...>
Date: Fri, 16 Apr 2021 13:01:13 +0200
MIME-Version: 1.0
In-Reply-To: <3f527df4-744a-9eb5-17fa-c86459f7f757@...2181...>
Content-Language: en-GB
Subject: Re: [Openvpn-devel] [PATCH 1/3] Change
 options->data_channel_use_ekm to flags
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

Am 16.04.21 um 00:27 schrieb Antonio Quartulli:
> Hi Arne,
> 
> On 08/04/2021 16:02, Arne Schwabe wrote:
>> Instead maintaining two different representation of the data channel
>> options in struct options and struct tls_options, use the same
>> flags variable that tls_options uses.
>>
>> Signed-off-by: Arne Schwabe <arne@...1227...>
> 
> Thia patch looks good, but I Was wondering: why converting this flag to
> a bitmask? are you planning to add more bits to
> o->data_channel_crypto_flags?
> 
> Or is it just to simplify the conversion to crypto_flags?
> 

Kinda both. I have a patch that extends the IV to be xor'ed instead of
just counting upwards like TLS 1.3 is doing that but I currently keeping
that back as it might not be worth doing that.

Arne

