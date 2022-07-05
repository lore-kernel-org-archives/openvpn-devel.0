Message-ID: <04f18d8f-0db0-cac5-d5fe-21ec424fdb32@...2181...>
Date: Tue, 5 Jul 2022 16:09:17 +0200
MIME-Version: 1.0
Content-Language: en-US
References: <20220624083809.23487-1-a@...2181...>
 <20220624083809.23487-16-a@...2181...> <5328690.mmUj8nBKDy@...2664...>
From: Antonio Quartulli <a@...2181...>
In-Reply-To: <5328690.mmUj8nBKDy@...2664...>
Subject: Re: [Openvpn-devel] [PATCH 15/25] dco: add documentation for
 ovpn-dco-linux
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
To: Heiko Hund <heiko@...2662...>, openvpn-devel@lists.sourceforge.net

Hi,

On 05/07/2022 14:31, Heiko Hund wrote:
> On Freitag, 24. Juni 2022 10:37:59 CEST Antonio Quartulli wrote:
>> +    application. Note that DCO will use DATA_V2 packets
>> in P2P mode, therefore,
>> +    this implies that peers must be running 2.6.0+
>> in order to have P2P-NCP
>> +    which brings DATA_V2 packet support.
> [...]
>> +- OpenVPN 2.4.0 is the minimum peer version.
> 
> Now I'm not sure what the minimum version is. Maybe clarify.

I think you removed the context which should clarify this.

2.6.0 is required for P2P-NCP
2.4.0 is required for standard client/server mode

Cheers,

> 
> 
> 
> 
> 
> 
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
> 

-- 
Antonio Quartulli

