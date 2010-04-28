Message-ID: <4BD83FC0.5090607@...515...>
Date: Wed, 28 Apr 2010 17:01:36 +0300
From: =?ISO-8859-15?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
MIME-Version: 1.0
Subject: [Openvpn-devel] Any volunteer Windows devs to change OpenVPN
 proxying code to use "new" InternetQueryOption API?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Hi all,

A while back a user noticed that OpenVPN still uses old IE4 API to
detect proxy settings (e.g. in proxy.c and ieproxy.c). This apparently
causes problems with IE's proxy detection on some Windows installations.
A "new" InternetQueryOption API was introduced in IE5,  so this part of
OpenVPN would benefit from an upgrade anyways. Would somebody be
interested in taking up this task? We seem to have a shortage of Windows
devs, so any help would be most welcome!

For more information about this issue can be found from here:

* http://thread.gmane.org/gmane.network.openvpn.devel/3446
* http://support.microsoft.com/kb/226473

If I've misunderstood the problem, please send clarifications - proxy
usage in OpenVPN is still pretty vague to me :)

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock


