Message-Id: <AEF3CC4F-E0C2-4F8F-BBCB-921BA3F97FC5@...1348...>
From: Toby Thain <toby@...1348...>
In-Reply-To: <1271861373.1490.4@...1207...>
Mime-Version: 1.0 (Apple Message framework v936)
Date: Thu, 22 Apr 2010 08:35:53 +1000
References: <4BCF0259.8070902@...1347...>
	<CA8D46C6-BAA6-4BEA-901B-34E1B5B20D97@...1348...>
	<1271861373.1490.4@...1207...>
Subject: Re: [Openvpn-devel] Slight modification to the contrib client.up
	script: DNS in server order
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
To: "Karl O. Pinc" <kop@...1206...>
Cc: openvpn-devel@lists.sourceforge.net


On 22-Apr-10, at 12:49 AM, Karl O. Pinc wrote:

> On 04/21/2010 09:13:35 AM, Toby Thain wrote:
>>
>> On 21-Apr-10, at 11:49 PM, Richard Monk wrote:
>>
>>> I had an issue come up where the clients were getting DNS entries
>> in
>>
>>> the
>>> reverse order the server sends them when using the client.up
>> contrib
>>> script.  Since the DNS servers on our system are in order from
>>> closest->farthest network wise from the VPN server, having them
>>> backwards caused some performance issues.
>>
>> Have you considered a local caching DNS with forwarding?
>
> I don't see how this will solve the problem.
> What if the closest _is_ a local caching DNS with forwarding
> to the next farthest out?  You still want all the DNS servers
> available in case one is down for some reason.

I got the impression his problem was *latency*, not availability;  
changing the order of name servers cannot help with the latter. A  
local caching DNS may have considerably less latency than the closest  
forwarder...

--Toby

>
>
> Karl <kop@...1206...>
> Free Software:  "You don't pay back, you pay forward."
>                 -- Robert A. Heinlein
>
>
> ------------------------------------------------------------------------------
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel


