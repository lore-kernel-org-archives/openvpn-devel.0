Message-ID: <4FAB80BA.9070500@...1147...>
Date: Thu, 10 May 2012 10:47:54 +0200
From: Jan Just Keijser <janjust@...1147...>
MIME-Version: 1.0
References: <1336639383.83791.YahooMailNeo@...1721...>
In-Reply-To: <1336639383.83791.YahooMailNeo@...1721...>
Subject: Re: [Openvpn-devel] openvpn question
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: Raj Kumar <raj_kumar_sh@...109...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Hi Raj,

Raj Kumar wrote:
>
> Hi all,
>
> I am new to openvpn. I am using openvpn on my  linux machine.
>
> I have a basic question about openvpn. 
>
> How openvpn process the incoming packets ?
>
> Is it processing incoming packets one by one, means receive one packet 
> from the kernel, decrypt it and send it back to the kernel then next 
> packet ?
> or
> whenever a packet comes, openvpn receives  and queues it while doing 
> decryption of already received packet ?
>
>  
openvpn processes the incoming packets one by one , both from the VPN 
side (the encrypted packets) , and the packets coming in via the tun/tap 
interface. This is one of the main reasons why openvpn speeds top off at 
around ~ 300 Mbps.

HTH,

JJK


