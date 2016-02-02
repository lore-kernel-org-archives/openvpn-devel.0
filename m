From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
Message-ID: <56B0ECA6.3000902@...515...>
Date: Tue, 2 Feb 2016 19:51:34 +0200
MIME-Version: 1.0
Subject: [Openvpn-devel] Test installers with the Interactive service /
 Vista-compatible block-outside-dns
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
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Hi,

Here are test installers based on latest Git code plus the Interactive=20
service patch, which allows non-admin users to launch OpenVPN connections:

<http://build.openvpn.net/downloads/temp/openvpn-install-2.3_iservice-I601-=
i686.exe>
<http://build.openvpn.net/downloads/temp/openvpn-install-2.3_iservice-I601-=
x86_64.exe>

A second pair of installers contain a patch which makes the new=20
--block-outside-dns work with Windows Vista:

<http://build.openvpn.net/downloads/temp/openvpn-install-2.3_blockoutsidedn=
s-I601-i686.exe>
<http://build.openvpn.net/downloads/temp/openvpn-install-2.3_blockoutsidedn=
s-I601-x86_64.exe>

If you test these, please let us know about your experience with them=20
(worked/did not work/had issues).

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock

