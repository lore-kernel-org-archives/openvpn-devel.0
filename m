Message-ID: <415AA77E.1030207@...255...>
From: Didier Conchaudron <didier@...255...>
MIME-Version: 1.0
Subject: [Openvpn-devel] PATCH WIN32: wrapper tcp patch
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
Date: Wed Sep 29 05:24:35 2004
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Hi list,

Few weeks ago I've announced on users list that I will publish a patch 
aiming at adding a tcp server in the wrapper. That's now done.

I'm not familiar with patch making with diff and my modifications only 
apply on the service-win32 directory in the openvpn source code.

What have been added precisely?

- a client apps (whitout any admin credentials) can talk with a tcp 
server launched in the actual openvpnserv.exe windows service.
- on localhost only
- without any auth. from the client.
- it's for now possible to start/stop a tunnel via a gui/console app.
- the actual functions of automatic launch of tunnels is still ok but 
you have to add the config filename of the tunnel that must be run at 
startup into a new file named service.cfg (placed into the openvpn 
config files dir). It's necessary because in the original service, all 
.ovpn files were ran at startup. So now you can start a tunnel1.ovpn at 
startup and allow a user to start another tunnel2.ovpn when he want 
using a GUI/console app.

What have change in the original code?

- rewrite of some functions in order to use them more accuratly in the 
tcp server
- the makefile have been change a little too.
- add of tcpser.c and tcpser.h

Where do I get it?

You can get 2 tarballs for now:

- one including the patched wrapper which just have to replace 
completely the actual code.
- one with the client code I use to test the tcp server. This code 
probably only helps GUI developpers

http://conchaudron.free.fr/contrib/openvpn/tcp_client_openvpn.tgz
http://conchaudron.free.fr/contrib/openvpn/tcp_server_openvpn.tgz

Mathias Sundman will work on the client code in order to add this 
feature on his GUI.

Thanks to the list for his ideas (in an old thread;-) on this kind of 
features.
Thanks to Mathias for his help in my first real contribution to opensource.

Didier

