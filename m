Message-ID: <41E7BAEE.8060802@...255...>
From: Didier Conchaudron <didier@...255...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] Openvpn future: probably certificate problems...
References: <41E67DB4.6090504@...255...>	 <1e6368e805011315343512955f@...278...>	 <41E78806.1020700@...255...> <1e6368e80501140259b1a9a8e@...278...>
In-Reply-To: <1e6368e80501140259b1a9a8e@...278...>
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Fri Jan 14 04:30:32 2005
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: Leonard Isham <leonard.isham@...277...>
Cc: James Yonan <jim@...41...>, Mathias Sundman <mathias@...209...>, openvpn-devel@lists.sourceforge.net, peter@...292...

Leonard Isham wrote:

[snip]

>>Btw, MSDN cryptoapi docs don't talk about a way to get userspace certs
>>from a SYSTEM rights. I think a way to solve this issue would be to make
>>  openvpn deals with a userspace component which one could get the
>>certificate and supply desired data to openvpn at tunnel startup. This
>>userspace component could be openvpn-gui or another program. I really
>>don't know if this kind of solution is technicaly possible. Only true
>>openvpn hackers could ;-)
>>
> 
> 
> All good points. I must add a couple of my own. 
> 
> 1) OpenVPN is cross platform.

Yes, those certificates problems are only windows-related. Linux and 
*BSD don't have such problems to make user certs available to root.

> 2) Apparently a MS design implementation. Could possible be rectified
> by having the service use the user login instead of system.

First, the certificate way of things like MS have coded it is not bad 
because it's quite usefull to disable user certificate access for 
admin/system. The MS problem comes from the missing of a su/sudo system 
in order to allow a user to temporary access other account data/rights.

Your suggestion about moving the service into userspace is not the 
solution because we need a system-space service in order to set up the 
tunnels(which require admin/system rights) instead of users, because 
they're not allowed to.

Finally, on win32 and in a company context, a system-space service is 
necessary to achieve tunnel set up, a user-space program is necessary in 
order to get the user certs and to let him choose when he want to set up 
the tunnel.

> 3) At this stage I think changes of this magnitude, as you suggest,
> would most likely be post 2.0.  James an the other brains behind this
> would know better.

The new service wrapper was soon considered as a post 2.0 feature. 
Perhaps more.
The big problem is that we actually have a single binary which is able 
to do everything, a great gui which allow end-users to interact easily.
And what we are talking about is a global system, actually usefull for 
few of us, which will need 2 or 3 components in system/user space for 
just one platform. But this small case is what will bring openvpn on top 
of proprietary vpn challengers.

Is our community ready to get to a such level? Do we want to? In a 
personnal point of view, I think openvpn is a great piece of code and it 
deserve to be famous and widely used.

Didier

