Message-ID: <b00bd799-21b6-ebb3-3a70-5898cc20206a@...1227...>
Date: Fri, 24 Jun 2022 12:52:23 +0200
MIME-Version: 1.0
Content-Language: en-GB
References: <20220621161649.2872985-1-arne@...1227...>
 <20220621161649.2872985-5-arne@...1227...> <YrWTg6ZnqgtkezEP@...1296...>
From: Arne Schwabe <arne@...1227...>
In-Reply-To: <YrWTg6ZnqgtkezEP@...1296...>
Subject: Re: [Openvpn-devel] [PATCH 5/6] Change default MTU in server mode
 to 1420 and push it to client
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
To: Gert Doering <gert@...1296...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Am 24.06.22 um 12:35 schrieb Gert Doering:
> Hi,
> 
> On Tue, Jun 21, 2022 at 06:16:48PM +0200, Arne Schwabe wrote:
>> This changes the default MTU of the tun-mtu to 1420 to avoid MTU related
>> issues that are even more prominent when DCO server or clients are involved.
> 
> I'm not convinced that this change "by default" is a desirable change.
> 
> Being able to do that (pushable MTU) is good, but changing the default is
> fairly fundamental, and it will break use cases that rely on 1500 inner
> MTU (and outside fragmentation).
> 
> Originally, it was said that "with DCO, outside fragmentation is not
> possible", but if I remember right, this turned out to be incorrect,
> and implementations handle outside fragmentation just fine.  So there
> seems to be no hard pressing need to change the default (I am willing
> to be corrected if I misremember something).
> 
> Not saying that outside fragmentation is *desirable*, so for TCP,
> "mssfix 1492 mtu" will (already) ensure we have no fragmentation
> issues - whatever tun-mtu we have.

I understand that this is quite fundamental change but I think 
alternative of always using a wrong MTU and hoping that mssfix and 
outside fragmentation are going to save the day what we currently do, is 
lying to ourselves.

I still think this is a reasonable change. Yes, it might break in some 
very obscure setups but for those setups, people can still set the MTU 
back to 1500. Tap still uses the 1500 default anyway.

Arne

