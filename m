Message-ID: <4BC1C486.6090808@...515...>
Date: Sun, 11 Apr 2010 15:45:58 +0300
From: =?ISO-8859-15?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
MIME-Version: 1.0
Subject: [Openvpn-devel] Community site Trac open for public
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

The community site Trac instance is now open for the public:

https://community.openvpn.net/openvpn

A few key developers already have accounts and I'll create new ones on
request. There's not really any content there yet and it does not make
sense to move any of the old content to Trac until the user self-service
registration is available. The git integration (see "Browse source")
seems painfully slow and it eats 40-50% of the CPU when it's loading a
directory listing or a file. This is a known performance problem with
the Trac git-plugin code, so we may have to replace it with something else.

Let me know if you encounter any obvious problems with the site and I'll
fix them. After that we can start installing Trac plugins one by one and
see if the thing stays in one piece ;). Potentially useful Trac plugins
were discussed earlier in a community meeting (28th  Jan 2010):

http://www.secure-computing.net/wiki/index.php/OpenVPN/IRC_meetings

All the best,

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock


