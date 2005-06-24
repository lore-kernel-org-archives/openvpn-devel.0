From: Ralf =?UTF-8?B?TMO8YmJlbg==?= <ralfluebben@...68...>
Message-ID: <d9gch6$408$1@...165...>
References: <200504291033.00667.ralfluebben@...68...>
Mime-Version: 1.0
Subject: [Openvpn-devel] Re: Radius support (Authentification, Authorization and Accounting)
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
Date: Fri Jun 24 00:35:04 2005
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

Hello,

the radius plugin in is working.
I have still some questions about the OpenVpn behaviour.

After one hour there is a rekeying/reauthentication of the user? Is that
right. The problem is that before an user can be authenticated from the
plugin the user needs a disconnect from OpenVpn for this user. At the
moment the reauthentenication fails and the OpenVpn disconnects the user
after the keepalive interval. Ather this the user can connect again.

Have I the possibility to get the information if the authentication is a new
or a reauthentication from the enviroment variable?

Maybe if I already have the user in my internal list and the user comes in
with the same username, password and remote_ip he is authenticated without
asking the radius server.
The other possibility is too delete the user from the list and add the user
again to the list.

What are about the counters in the status file? Are they set to 0 at the
rekeying/reauthentication? So I have to send the stop ticket to the radius
server and I have to send again a start ticket.

What are the maximum length of strings in the enviroment that I can get from
the OpenVpn process? Maybe 128 characters for the username and password.

Ralf Lübben


Ralf Lübben wrote:

> Hello,
> 
> I am interesting in build radius support for OpenVpn.
> At the moment I'am thinking about what is the best way.
> 
> 1. Authentification and Authroization:
> I think this already works with the plugin pam_radius_auth.so, is that
> right?
> 
> But I am interested in more features,
> like to get the ip-address and the routes from the RADIUS-Server.
> Can this be done with a plugin? Maybe by creating the configurationfiles
> at the start of the connection?
> Or could this be integrated in the Source Code? I think this would be the
> best solution.
> I hope the fea
> 2. Accounting:
> I need to count the traffic  of a VPN-connection, one the side every
> traffic which goes from a client to the server (tun0-interface) and one
> the other side every traffic which goes through the VPN, maybe from one
> client to another client.
> So when I use the counter of the tun-interface, I lose the traffic which
> goes from one client to another. If I count the traffic of the
> eth-interface I get other traffic, which has nothing to do with the vpn.
> 
> Maybe someone has some experiences with this topic and give some hints
> which is the best way? To do all things in a modul or to do all changes in
> the source code. and where I have to look in the source code to integrate
> this feature.
> 
> I hope there is a gerneal interest in this feature.
> 
> For every help I am very grateful.
> 
> Ralf Lübben



