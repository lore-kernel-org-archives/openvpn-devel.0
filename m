Message-ID: <41E78806.1020700@...255...>
From: Didier Conchaudron <didier@...255...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] Openvpn future: probably certificate problems...
References: <41E67DB4.6090504@...255...> <1e6368e805011315343512955f@...278...>
In-Reply-To: <1e6368e805011315343512955f@...278...>
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
Date: Fri Jan 14 00:53:22 2005
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: Leonard Isham <leonard.isham@...277...>
Cc: James Yonan <jim@...41...>, Mathias Sundman <mathias@...209...>, openvpn-devel@lists.sourceforge.net, peter@...292...

Leonard Isham wrote:
> On Thu, 13 Jan 2005 14:55:00 +0100, Didier Conchaudron
> <didier@...255...> wrote:
> 
>>Hi all,
>>
>>I'm still working on a renewed openvpn service wrapper( which's heading
>>to allow a non-admin user to start/stop pre-defined tunnels via a tcp
>>socket) and I see some big troubles in a near future.
>>
>>The *great* actual cryptoapi patch allow a user to access local machine
>>and local user certs. It's quite good right now because most of the
>>openvpn users are using it with admin rights or non-interactive
>>processing( like autostart at windows boot).
>>
>>I'm worrying about those features when our aim will be to do let
>>non-admin users start their tunnel and authenticate themselves on the
>>openvpn server with their own certificate. In the actual openvpn it's
>>not possible, because the SYSTEM account can only access to his own
>>certs and the local machine certs, but not "Foo Bar User" certs.
>>
>>We can ask ourselves few questions:
>>
>>- is it possible to make SYSTEM access user certs?
>>- if not, how can we make openvpn access to those users data?
>>
>>A friend of mine said an answer could be to let the GUI(or a user only
>>component) manage the access to such user-related data, and let openvpn
>>deal with this component in order to use the certs.
>>
>>Of course, this problem is only windows-related.
>>
>>What do you think of this problem?
>>
> 
> 
> Defense in depth.
> 
> The user should not have the ability to logon to a machine with
> OpenVPN installed if they are not allowed to use OpenVPN, or that user
> should not have access to run the GUI (maybe the OpenVPN Service
> should not even be running).

These are not the questions. The ability to access to openvpn is not a 
matter of openvpn, just one of the computer admin. And even if a user 
have openvpn installed, a good conf must need a USER certificate or a 
user/pass to allow him to connect to the vpn server. So it's not a 
matter of openvpn too, but one of the openvpn admin.

> The certificate is authenticating the computer.

It's the actual openvpn features. But much openvpn addicts would be very 
pleased to make openvpn works like other commercial vpn, with USER 
certificate.

Btw, MSDN cryptoapi docs don't talk about a way to get userspace certs 
from a SYSTEM rights. I think a way to solve this issue would be to make 
  openvpn deals with a userspace component which one could get the 
certificate and supply desired data to openvpn at tunnel startup. This 
userspace component could be openvpn-gui or another program. I really 
don't know if this kind of solution is technicaly possible. Only true 
openvpn hackers could ;-)

Didier


