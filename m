Message-ID: <555F1566.6030303@...1147...>
Date: Fri, 22 May 2015 13:39:18 +0200
From: Jan Just Keijser <janjust@...1147...>
MIME-Version: 1.0
References: <555BF270.3090706@...1147...> <20150521181409.GY382@...1296...>
	<555E21F7.4030002@...1147...> <20150521183108.GZ382@...1296...>
	<555E55B4.5080804@...1147...> <20150522074348.GA382@...1296...>
In-Reply-To: <20150522074348.GA382@...1296...>
Subject: Re: [Openvpn-devel] patch for bug #93: up-restart env vars
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
To: Gert Doering <gert@...1296...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Gert Doering wrote:
> Hi,
>
> On Fri, May 22, 2015 at 12:01:24AM +0200, Jan Just Keijser wrote:
>   
>>> I'm not sure what the best path forward is, TBH...
>>>       
>> --up-restart *is* different from --up in several ways:
>>
>> - runs as the user+group that is specified in the config file
>> - the 'tun' device is persistent so it's not "fresh"
>> - routes are not reset during a "persistent" restart, so are still present
>>     
>
>   - IP addresses are not reset (as the tun device is pesistent)
>
> so indeed, lots of differences here.
>
> What about this:
>
>  - take your patch as it is (because it's not very intrusive, provides
>    variables people are asking for, and cleans up tun.c a bit :-) )
>  - add a patch to openvpn.8 that explains the differences in --up-restart
>    (so people will know that the lack of route env vars is not a bug)
>   

agreed, but do we patch openvpn.8 before or after the documentation 
split ;) ?

JJK

