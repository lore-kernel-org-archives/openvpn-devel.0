References: <20160208213929.GA20623@...2120...>
	<20160209092821.GH24952@...1296...>
	<20160209101533.GJ3102@...2121...>
	<20160209104625.GL24952@...1296...>
	<20160209105839.GP3102@...2121...>
	<20160209115825.GP24952@...1296...>
	<20160209124533.GQ3102@...2121...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <56BA8AD9.7060309@...2080...>
Date: Wed, 10 Feb 2016 01:56:57 +0100
MIME-Version: 1.0
In-Reply-To: <20160209124533.GQ3102@...2121...>
Subject: Re: [Openvpn-devel] route / route-ipv6 can not be used in ccd
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
To: Samuel Thibault <samuel.thibault@...1817...>, Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net

On 09/02/16 13:45, Samuel Thibault wrote:
> Gert Doering, on Tue 09 Feb 2016 12:58:26 +0100, wrote:
>> On Tue, Feb 09, 2016 at 11:58:39AM +0100, Samuel Thibault wrote:
>>> I have tried putting
>>>
>>> iroute-ipv6 2a01:474:5:1100::/56
>>>
>>> in the ccd, but from the learn-address script the environment does not
>>> contain this route.
>>
>>        --learn-address cmd
>>               Run  command cmd to validate client virtual addresses or routes.
>> ...
>>               Three arguments will be appended to any arguments in cmd as fol-
>>               lows:
> 
> D'oh.
> 
> Busy people talking to busy people :) I didn't even take the time to
> check that, sorry.
> 
> I indeed see the learn-address script called with
> 
> add 2a01:474:5:1100::/56 samuel.thibault.test
> 
> And seen it called with 
> 
> delete 2a01:474:5:1100::/56 samuel.thibault.test
> 
> 2 minutes after the client disconnected, which would probably be fine
> enough for our use case.
> 

If you use --proto udp, then it can take up to --ping-reset $SEC to trigger
(IIRC).  You can use explicit-exit-notify to avoid this behaviour.  With this
option set, the client will tell the server "I'm disconnecting now", which
will trigger the --learn-address script instantly.

This option is not useful in TCP mode, as explicit disconnect is part of the
TCP protocol.


-- 
kind regards,

David Sommerseth

