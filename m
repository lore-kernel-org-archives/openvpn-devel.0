Message-ID: <53451ACE.1020300@...515...>
Date: Wed, 09 Apr 2014 13:02:54 +0300
From: =?ISO-8859-15?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
MIME-Version: 1.0
Subject: [Openvpn-devel] Regarding pkcs11 support in our Debian/Ubuntu
	packages
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
To: "openvpn-users@lists.sourceforge.net" <openvpn-users@lists.sourceforge.net>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Hi all,

It OpenVPN 2.3.3 requires libpkcs11-helper 1.11 or newer. What this
means is that unless I patch the OpenVPN sources I won't be able to
provide Debian/Ubuntu packages with pkcs11 support except for Ubuntu
14.04 which has 1.11 in default repos.

So, is anyone using pkcs11 with the Debian packages I've provided? If
not, I will simply remove pkcs11 support and be done with it. I could
patch the openvpn sources to allow an older libpkcs11, but I'm not sure
if that would cause problems elsewhere.

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock


