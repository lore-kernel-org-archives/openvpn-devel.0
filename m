Message-ID: <20050406102031.42076.qmail@...367...>
From: Tomas Nouza <tnnx@...109...>
MIME-Version: 1.0
Subject: [Openvpn-devel] Lightweigh openvpn client for windows/linux?
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
Date: Wed Apr  6 03:21:11 2005
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

Hi,

I am using OpenVpn i client/server mode and I have to
say it's a great piece of software.

However, each client on lin/win has to be installed
(under root privileges), which brings the limitation.
The more insecure your connection is, the more a VPN
solution is needed. When you want to connect securely
from a library, school or other user-space only pc,
you can't do it using OpenVpn, because you are not
allowed to install any software.

So my question is, if there is a plan to develop a
lightweigh client, that would not need a TUN/TAP
interface. Now you can say it's not possible, but it
is, with some limitations:
The client would support only tunneling, and it would
listen on config/command-line specified tcp/udp ports
on localhost, encrypt each packet and send it.
Received and decrypted packets would of course appear
on the localhost (loopback) interface. The usage would
be similar to SSH port tunneling, while the openvpn
lightweight client would support OpenVPN servers, and
port ranges tunnelling.

Of couse that many options like 'ifconfig', 'push',
... would be ignored by the client, but I still see
wide area of usage for this client - secure FTP, VNC,
RemDektop, file sharing and more from public computers.


		
__________________________________ 
Do you Yahoo!? 
Yahoo! Personals - Better first dates. More second dates. 
http://personals.yahoo.com


