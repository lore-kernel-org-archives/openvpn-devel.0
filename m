Message-ID: <4EE21D63.40003@...515...>
Date: Fri, 09 Dec 2011 16:38:27 +0200
From: =?ISO-8859-15?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
MIME-Version: 1.0
Subject: [Openvpn-devel] OpenVPN 2.2.2 preview installer for Windows with
 pkcs11 support now available
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
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>, "openvpn-users@lists.sourceforge.net" <openvpn-users@lists.sourceforge.net>

Hi,

As some of you may have noticed, Windows versions of OpenVPN 2.2* have
so far lacked pkcs11 support. This is hopefully fixed now. If you want
help get 2.2.2 out a.s.a.p. and use pkcs11, please test the installer
you can find from here:

<https://community.openvpn.net/openvpn/ticket/145#comment:5>

I've only verified that "openvpn --help" finds pkcs11-related options,
nothing more. The installer also contains a new versions of
pkcs11-helper (1.09) and OpenSSL (1.0.0e).

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock


