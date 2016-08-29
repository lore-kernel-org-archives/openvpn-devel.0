From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
Message-ID: <45b848f8-6d95-2a2d-9cd6-667655e24857@...515...>
Date: Mon, 29 Aug 2016 16:02:04 +0300
MIME-Version: 1.0
Subject: [Openvpn-devel] Fixing non-standard PKCS#11 serialization format
 using a patched pkcs11-helper?
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

Right now our Windows installers use the official pkcs11-helper release=20
from the OpenSC project. Unfortunately this means that output of=20
"--show-pkcs11-ids" and input of "--pkcs11-id" are non-standard, as=20
reported here:

<https://community.openvpn.net/openvpn/ticket/491>

In Fedora this problem has been fixed with a custom patch

<https://github.com/OpenSC/pkcs11-helper/pull/4>
<http://pkgs.fedoraproject.org/cgit/rpms/pkcs11-helper.git/>

Debian and Ubuntu have _not_ are not patching this issue:

<http://http.debian.net/debian/pool/main/p/pkcs11-helper/pkcs11-helper_1.11=
-5.debian.tar.xz>
<http://archive.ubuntu.com/ubuntu/pool/main/p/pkcs11-helper/pkcs11-helper_1=
.11-5.debian.tar.xz>

Do _we_ want to move to start using a patch pkcs11-helper version?

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock

