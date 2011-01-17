Message-ID: <4D34B683.2050105@...1194...>
Date: Mon, 17 Jan 2011 13:37:07 -0800
From: Roman Vasilyev <roman@...1194...>
MIME-Version: 1.0
References: <4D34A90F.7080008@...1194...>
	<20110117212323.GG12114@...1296...>
In-Reply-To: <20110117212323.GG12114@...1296...>
Subject: Re: [Openvpn-devel] openvpn FreeBSD kqueue
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
To: Gert Doering <gert@...1296...>
Cc: Openvpn-devel@lists.sourceforge.net

after vpn deployment on FreeBSD without kqueue support, I want to add 
code for kqueue
and will send here patches and profiling results.
On 01/17/2011 01:23 PM, Gert Doering wrote:
> Hi,
>
> On Mon, Jan 17, 2011 at 12:39:43PM -0800, Roman Vasilyev wrote:
>    
>> I want to try FreeBSD with OpenVPN on high load, checked event.c ???
>> found that it can work only with epoll, just want to ask is it possible
>> to use kqueue in openvpn?
>> If not, what people thinking if I'll add this support there?
>>      
> We'd need to see some profiling that shows that the change is making
> a noticeable performance (or load) difference.  This sort of system
> dependent code can be a burden for a project, because it is hard to
> maintain if you don't develop on FreeBSD - but if it's a significant
> gain, it could be worth the effort.
>
> (Speaking my personal opinion here, not for all the developers)
>
> gert
>
>    


