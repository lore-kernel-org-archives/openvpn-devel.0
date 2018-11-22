References: <11098166-9909-4011-83F9-C5BC3FEA769D@...260...>
 <20181122092047.GS962@...1296...>
 <DFA3F418-5C5E-46F6-A39B-9CF5D76F2EE9@...260...>
 <fe1c465a-b9d7-df65-b19c-19384c40b84b@...1227...>
From: Jan Just Keijser <janjust@...1147...>
Message-ID: <ba2b9986-f688-d20a-8a5d-32f30420df9c@...1147...>
Date: Thu, 22 Nov 2018 16:09:40 +0100
MIME-Version: 1.0
In-Reply-To: <fe1c465a-b9d7-df65-b19c-19384c40b84b@...1227...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] foreign_option_2 not set in 2.4
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
To: Arne Schwabe <arne@...1227...>, Cyril Scetbon <cyril.scetbon@...260...>, Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

Hi,

On 22/11/18 15:43, Arne Schwabe wrote:
> Am 22.11.18 um 14:46 schrieb Cyril Scetbon:
>> OpenVPN 2.4.6 x86_64-alpine-linux-musl [SSL (OpenSSL)] [LZO] [LZ4]
>> [EPOLL] [MH/PKTINFO] [AEAD] built on Jul  8 2018
>>
>> Output with —verb 4 https://pastebin.com/huQmnGaU
>>
> Read your log closer. This is not a bug in OpenVPN but rather a broken
> config what we accepted in 2.3:
>
> Thu Nov 22 13:34:56 2018 us=235164 PUSH: Received control message:
> 'PUSH_REPLY,route 10.0.0.0 255.0.0.0,route 192.168.174.0
> 255.255.255.0,route 193.252.149.32 255.255.255.224,route 193.252.121.96
> 255.255.255.224,dhcp-option DNS 10.201.67.120,dhcp-option DOMAIN
> cyril.net cyril2.net,route 10.252.12.150,topology net30,ping
> 5,ping-restart 30,ifconfig 10.252.12.158 10.252.12.157'
>
> Thu Nov 22 13:34:56 2018 us=235314 Options error: Unrecognized option or
> missing or extra parameter(s) in [PUSH-OPTIONS]:6: dhcp-option (2.4.6)
>
> OpenVPN gets 'dhcp-option DOMAIN cyril.net cyril2.net' via push and
> using two arguments after DOMAIN is wrong but OpenVPN 2.3 ignored the
> second argument while 2.4 gives you an error and ignores the whole option.
so what Arne is trying to say is:

with 2.4, do not use
   push "dhcp-option DOMAIN cyril.net cyril2net"
but use
   push 'dhcp-option "DOMAIN cyril.net cyril2net"'
instead.
Having said, that, pushing two DOMAINS does not make sense, AFAIK: Windows will only pick up one of them...

HTH,

JJK


