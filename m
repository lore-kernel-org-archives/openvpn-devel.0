From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
Message-ID: <9853cf34-870d-b798-7858-7d55443f01d9@...515...>
Date: Tue, 25 Jul 2017 18:44:53 +0300
MIME-Version: 1.0
Content-Language: en-US
Subject: [Openvpn-devel] New 2.4.3 Windows installer with a security fix and
 improvements now available
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>, "openvpn-users@lists.sourceforge.net" <openvpn-users@lists.sourceforge.net>, openvpn-announce@lists.sourceforge.net

Hi all,

An updated 2.4 Windows installer is now available here:

<https://swupdate.openvpn.org/community/releases/openvpn-install-2.4.3-I602=
.exe>

This installer includes updated OpenVPN GUI (11.8.0.0) and easy-rsa (2.3.0).

The installer also fixes a security vulnerability in the service
installation code:

<https://community.openvpn.net/openvpn/wiki/UnquotedServicePathIn24WindowsI=
nstallers>

Systems where the C:\ drive is writable by limited users and which have
OpenVPN 2.4 installed are affected. Users of such systems should upgrade
to openvpn-install-2.4.3-I602.

--=20
Samuli Sepp=C3=A4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock

