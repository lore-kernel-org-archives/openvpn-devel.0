Message-ID: <1e6368e80501140259b1a9a8e@...278...>
From: Leonard Isham <leonard.isham@...277...>
Reply-To: Leonard Isham <leonard.isham@...277...>
Subject: Re: [Openvpn-devel] Openvpn future: probably certificate problems...
In-Reply-To: <41E78806.1020700@...255...>
Mime-Version: 1.0
References: <41E67DB4.6090504@...255...>
	 <1e6368e805011315343512955f@...278...>
	 <41E78806.1020700@...255...>
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
Date: Fri Jan 14 03:00:27 2005
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: Didier Conchaudron <didier@...255...>
Cc: James Yonan <jim@...41...>, Mathias Sundman <mathias@...209...>, openvpn-devel@lists.sourceforge.net, peter@...292...

[snip]
> > The user should not have the ability to logon to a machine with
> > OpenVPN installed if they are not allowed to use OpenVPN, or that user
> > should not have access to run the GUI (maybe the OpenVPN Service
> > should not even be running).
> 
> These are not the questions. The ability to access to openvpn is not a
> matter of openvpn, just one of the computer admin. And even if a user
> have openvpn installed, a good conf must need a USER certificate or a
> user/pass to allow him to connect to the vpn server. So it's not a
> matter of openvpn too, but one of the openvpn admin.
> 
> > The certificate is authenticating the computer.
> 
> It's the actual openvpn features. But much openvpn addicts would be very
> pleased to make openvpn works like other commercial vpn, with USER
> certificate.
> 
> Btw, MSDN cryptoapi docs don't talk about a way to get userspace certs
> from a SYSTEM rights. I think a way to solve this issue would be to make
>   openvpn deals with a userspace component which one could get the
> certificate and supply desired data to openvpn at tunnel startup. This
> userspace component could be openvpn-gui or another program. I really
> don't know if this kind of solution is technicaly possible. Only true
> openvpn hackers could ;-)
> 

All good points. I must add a couple of my own. 

1) OpenVPN is cross platform.
2) Apparently a MS design implementation. Could possible be rectified
my having the service use the user login instead of system.
3) At this stage I think changes of this magnitude, as you suggest,
would most likely be post 2.0.  James an the other brains behind this
would know better.

-- 
Leonard Isham, CISSP
Ostendo non ostento.

