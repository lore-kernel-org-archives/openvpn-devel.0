Message-ID: <1e6368e805011315343512955f@...278...>
From: Leonard Isham <leonard.isham@...277...>
Reply-To: Leonard Isham <leonard.isham@...277...>
Subject: Re: [Openvpn-devel] Openvpn future: probably certificate problems...
In-Reply-To: <41E67DB4.6090504@...255...>
Mime-Version: 1.0
References: <41E67DB4.6090504@...255...>
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
Date: Thu Jan 13 15:35:13 2005
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: Didier Conchaudron <didier@...255...>
Cc: James Yonan <jim@...41...>, Mathias Sundman <mathias@...209...>, openvpn-devel@lists.sourceforge.net, peter@...292...

On Thu, 13 Jan 2005 14:55:00 +0100, Didier Conchaudron
<didier@...255...> wrote:
> Hi all,
> 
> I'm still working on a renewed openvpn service wrapper( which's heading
> to allow a non-admin user to start/stop pre-defined tunnels via a tcp
> socket) and I see some big troubles in a near future.
> 
> The *great* actual cryptoapi patch allow a user to access local machine
> and local user certs. It's quite good right now because most of the
> openvpn users are using it with admin rights or non-interactive
> processing( like autostart at windows boot).
> 
> I'm worrying about those features when our aim will be to do let
> non-admin users start their tunnel and authenticate themselves on the
> openvpn server with their own certificate. In the actual openvpn it's
> not possible, because the SYSTEM account can only access to his own
> certs and the local machine certs, but not "Foo Bar User" certs.
> 
> We can ask ourselves few questions:
> 
> - is it possible to make SYSTEM access user certs?
> - if not, how can we make openvpn access to those users data?
> 
> A friend of mine said an answer could be to let the GUI(or a user only
> component) manage the access to such user-related data, and let openvpn
> deal with this component in order to use the certs.
> 
> Of course, this problem is only windows-related.
> 
> What do you think of this problem?
> 

Defense in depth.

The user should not have the ability to logon to a machine with
OpenVPN installed if they are not allowed to use OpenVPN, or that user
should not have access to run the GUI (maybe the OpenVPN Service
should not even be running).

The certificate is authenticating the computer.

-- 
Leonard Isham, CISSP
Ostendo non ostento.

