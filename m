From: Ralf =?iso-8859-1?q?L=FCbben?= <ralfluebben@...68...>
Date: Sun, 21 Jun 2009 19:56:53 +0200
MIME-Version: 1.0
Message-Id: <200906211956.54243.ralfluebben@...68...>
Subject: [Openvpn-devel] Character remapping in common name when using
	username-as-common-name
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
To: openvpn-devel@lists.sourceforge.net

Hi,

I wrote a plugin for radius support, which creates client config files when the 
event OPENVPN_PLUGIN_AUTH_USER_PASS_VERIFY occurs.

If the OpenVPN option "username-as-common-name" is used during 
OPENVPN_PLUGIN_AUTH_USER_PASS_VERIFY event the common-name is still the one 
from the certificate and after successful authentication it becomes the 
username, with the difference that special characters are remapped.

If I use the raw username inside the plugin, OpenVPN doesn't find the client 
config file later, when it contains special characters.

My question is now, if it is possible to set the common-name which is pushed 
to the plugin already to the remapped common-name, when plugins are called for 
the first time.

Or is the better solution to do the remapping also in the plugin?

Thanks a lot.

Regards
Ralf


