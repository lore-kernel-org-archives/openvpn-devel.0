Message-Id: <6B68DFBC-517B-4031-8E84-A29922AE9C58@...1348...>
From: Toby Thain <toby@...1348...>
Mime-Version: 1.0 (Apple Message framework v936)
Date: Mon, 26 Apr 2010 09:47:08 +1000
Subject: [Openvpn-devel] [ANN] OS X packages - OpenVPN 2.1.1
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
To: openvpn-users@lists.sourceforge.net
Cc: openvpn-devel@lists.sourceforge.net

Hi,

I have put together a generic packaging script for OS X (pkg/dmg), and  
created basic binary Installer packages for PowerPC and Intel. It's  
meant only for distributing the generic binary distribution, analogous  
to any other UNIX binary package. A small addition is a script which  
installs an OS X launchd service, net.openvpn.

The binary package can be combined with a separate per-client key pkg  
that installs configuration and keys and starts the launchd service  
(scripts also available for this, in key-package directory).

This may help people with simple deployments that include OS X  
clients. I have not linked to built packages, on the theory that  
there's little reason you should trust my builds. (If you have the  
Apple Developer Tools, and archives for openvpn and lzo, then creating  
the binary packages and disk image yourself, for whatever architecture  
you run, is as simple as 'make dmg'. Package build, install and run  
have been tested on 32-bit PowerPC and Intel.)

cc'd devel list in case there is any interest in adopting the  
packaging script(s), perhaps as contrib?

http://telegraphics.com.au/svn/openvpn-package/trunk/

--Toby


