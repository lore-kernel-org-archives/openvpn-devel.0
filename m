From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
Message-ID: <3572b3e5-8830-3418-87d7-725d611bb04a@...515...>
Date: Tue, 11 Oct 2016 13:36:02 +0300
MIME-Version: 1.0
Subject: [Openvpn-devel] Help testing OpenVPN 2.4-alpha1 preview installers?
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

Hi all,

We're really close to OpenVPN 2.4-alpha1 release now. In yesterday's IRC=20
meeting[1] we deemed that "late this week" might be doable.

However, we'd need to help with testing these preview installers:

<http://build.openvpn.net/downloads/temp/openvpn-install-2.3_git-do-ifconfi=
g-after-tun-v2-I601-i686.exe>
<http://build.openvpn.net/downloads/temp/openvpn-install-2.3_git-do-ifconfi=
g-after-tun-v2-I601-x86_64.exe>

Note that the installers contain a much improved OpenVPN-GUI that=20
behaves differently under the hood from the one bundled in OpenVPN 2.3.x:

<https://github.com/OpenVPN/openvpn-gui>

The installer also contains a new, much improved Windows system service=20
called openvpnserv2:

<https://github.com/OpenVPN/openvpnserv2>

Based on earlier tests openvpnserv2 should be able to handle=20
suspend/resume gracefully. It should also automatically restart a=20
connection that dies for whatever reason.

So far the installers linked to above have passed some basic tests:

<https://community.openvpn.net/openvpn/wiki/OpenVPN24WindowsTests>

If you can, please test the installers in your environment and let us=20
know how it went: we'd like to minimize the chance of breaking existing=20
setups before we make the official 2.4-alpha1 release.

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock


[1]=20
<https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg12657.=
html>

