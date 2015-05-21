Message-ID: <555E55B4.5080804@...1147...>
Date: Fri, 22 May 2015 00:01:24 +0200
From: Jan Just Keijser <janjust@...1147...>
MIME-Version: 1.0
References: <555BF270.3090706@...1147...> <20150521181409.GY382@...1296...>
	<555E21F7.4030002@...1147...> <20150521183108.GZ382@...1296...>
In-Reply-To: <20150521183108.GZ382@...1296...>
Subject: Re: [Openvpn-devel] patch for bug #93: up-restart env vars
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
To: Gert Doering <gert@...1296...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Hi,

On 21/05/15 20:31, Gert Doering wrote:
> On Thu, May 21, 2015 at 08:20:39PM +0200, Jan Just Keijser wrote:
>> On 21/05/15 20:14, Gert Doering wrote:
>>> On Wed, May 20, 2015 at 04:33:20AM +0200, Jan Just Keijser wrote:
>>>> here's my patch for bug #93: missing ifconfig_* env vars after
>>>> up-restart. Tested with both IPv4, IPv6, topology subnet and topology
>>>> net30
>>> Reading through #93, I'm wondering - what about the other environment
>>> variables mentioned, like "route_gateway" etc.?
>>>
>>> In other words, your patch looks like it will nicely fix the missing
>>> ifconfig_* variables (by ensuring that what close_instance() destroyed
>>> is re-initialized even if not calling init_tun() - and cleaning up that
>>> one a bit while at it :-) ), but I wonder if more needs to be done?
>> I did look into that - a 'restart' occurs only if 'persist-tun' is used
>> and in that case  the routes are not re-added . If you look at the flow
>> of code of 'do_open_tun' in init.c you'll see that all routing stuff is
>> *not* re-run, hence those environment variables are not present anymore
>> - but then again, the routes are still there, as the system routing
>> tables were not affected because the tun device was never closed in the
>> first place.
> OK, so these get lost, but are set elsewhere, and would need an extra
> patch...
>
>> My guestimation was that there are no other *important* env vars that
>> get lost during a soft restart.
> Well, what's important to some is not to others (I could care less about
> "ifconfig_local", as tun.c does that for me :-) )...  this ticket is all
> about consistency, *or* documenting that --up-restart will not see the
> environment variables that --up has "because you do not need them"...
>
> I'm not sure what the best path forward is, TBH...
>

--up-restart *is* different from --up in several ways:

- runs as the user+group that is specified in the config file
- the 'tun' device is persistent so it's not "fresh"
- routes are not reset during a "persistent" restart, so are still present

I agree that I am not sure that the best path forward is, but I think 
the route of "make sure everything looks the same as in --up script" is 
not the right way.  The 'do_open_tun' flow of code could also be 
improved, by the way, but I did not want to do that for this bug report.

cheers,

JJK


