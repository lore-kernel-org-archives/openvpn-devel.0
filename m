From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
Message-ID: <5683B1C6.7010800@...515...>
Date: Wed, 30 Dec 2015 12:28:22 +0200
MIME-Version: 1.0
Subject: [Openvpn-devel] Windows installers with OpenVPN-GUI that requests
 highest available privileges
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-15"; format=flowed
Content-Transfer-Encoding: quoted-printable
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>, "openvpn-users@lists.sourceforge.net" <openvpn-users@lists.sourceforge.net>

Hi,

I've produced two test installers based OpenVPN 2.3.9 plus an=20
OpenVPN-GUI which requests highest possible privileges of the user,=20
instead of launching as the invoking user:

<https://github.com/OpenVPN/openvpn-gui/pull/6>

The above patch should allow users with administrator privileges to=20
launch OpenVPN-GUI without having to "Run as administrator" separately.=20
It should also allow use of OpenVPN-GUI without having full admin rights=20
- it is enough to have whatever OpenVPN/OpenVPN-GUI needs to function=20
properly. A much more detailed description is available beyond the above=20
link.

The test installers are here:

<http://build.openvpn.net/downloads/temp/openvpn-install-2.3.9-I901-i686.ex=
e>
<http://build.openvpn.net/downloads/temp/openvpn-install-2.3.9-I901-x86_64.=
exe>

Let me know if the installers work correctly - or don't. I'd like to=20
merge this functionality into OpenVPN 2.3.10 which is due early next=20
week. If that deadline passes, I will release new Windows installers=20
with this patch a bit later.

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock

