From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
Message-ID: <56936C78.3020505@...515...>
Date: Mon, 11 Jan 2016 10:48:56 +0200
MIME-Version: 1.0
Subject: [Openvpn-devel] Disabling auth_pam plugin by default in
	openvpn-build?
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

There is a pull request in GitHub to openvpn-build, which disables=20
auth_pam plugin by default:

<https://github.com/OpenVPN/openvpn-build/pull/10/files>

For Windows this makes sense, as PAM is not present. However,=20
openvpn-build can also be used to cross-compile for the ARM=20
architecture, in which case PAM might be useful.

Does the pull request makes sense, or should we just fix this with=20
better documentation, e.g.

"If you're cross-compiling for ARM, make sure you add=20
--disable-plugin-auth-pam to EXTRA_OPENVPN_CONFIG"

Thoughts?

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock

