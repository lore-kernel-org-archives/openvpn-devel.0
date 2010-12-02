From: Adriaan de Jong <dejong@...1435...>
Date: Thu, 2 Dec 2010 10:05:49 +0100
Message-ID: <BF88BCF2F8AD5843B2250C5DB8DDE0AFBEE7137C@...1436...>
Content-Language: en-US
MIME-Version: 1.0
Subject: [Openvpn-devel] Documentation and alternative SSL backend patches
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Hi List,=20

We've been working on OpenVPN in preparation for a security evaluation. Thi=
s entailed documenting OpenVPN at a relatively high level, removing the dep=
endencies on OpenSSL, and adding support for a simpler, easier to evaluate =
library (PolarSSL).

This was done in a series of patches:
- Patch 1: Adds documentation to OpenVPN through Doxygen.
- Patch 2: Splits out OpenSSL-specific code, defining a clean "backend" int=
erface for both the crypto and SSL modules. Splits the SSL module into chan=
nel setup and verification sub-modules.
- Patch 3: Adds a backend for PolarSSL.

We'd love to release these patches to the community. Unfortunately, the pat=
ches are now based on 2.1.4, and need to be rebased to a newer version. Bef=
ore we spend time on updating the patches to the current revision of OpenVP=
N, we'd like to know whether there is an interest in these patches from the=
 community.

Kind regards,

Adriaan de Jong

---
Fox-IT=A0=A0=A0=A0...for a more secure society=20

