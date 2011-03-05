Message-ID: <4D720E38.2050602@...1030...>
Date: Sat, 05 Mar 2011 10:19:36 +0000
From: Mr Dash Four <mr.dash.four@...1030...>
MIME-Version: 1.0
References: <4D713CD3.3000606@...515...>	<AANLkTin4QkZ36mi7qHyB9R+i1FdQJi66mi6nhhvYMWmN@...278...>	<4D716245.6040500@...1114...>	<4D717DB0.3030107@...1030...>
	<AANLkTikYoeusGQ3yFcCN9QrrAPWknAngoqiv5iWRD+Y3@...278...>
In-Reply-To: <AANLkTikYoeusGQ3yFcCN9QrrAPWknAngoqiv5iWRD+Y3@...278...>
Subject: Re: [Openvpn-devel] OpenVPN 2.2-RC released
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Alon Bar-Lev <alon.barlev@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>


>> Speaking of which, I also proposed a (rather trivial) patch which enables
>> cross compilation of a number of OpenVPN plugins (that patch is attached
>> again) as in the 2.1.4 version that was not possible.
>>     
>
> I think you should leave the -O2 as default to CFLAGS.
>
> CFLAGS=-O2
>
> Can be overridden by:
>
> make CFLAGS="-O0"
>   
As evident from the patch I provided, I haven't put the O2 flags there - 
I only alter the hard-coded values in that makefile which prevents 
cross-compilation. Whether the O2 (or O0) flags should have been there 
in the first place is not for me to decide as I do not maintain these 
plugins - my patch only ensures that cross-compilation is made possible.

