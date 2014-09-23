Date: Tue, 23 Sep 2014 08:45:45 -0400 (EDT)
From: Hubert Kario <hkario@...1347...>
Message-ID: <373411786.14344069.1411476345082.JavaMail.zimbra@...1347...>
In-Reply-To: <1827991635.14343530.1411476262740.JavaMail.zimbra@...1347...>
MIME-Version: 1.0
Subject: [Openvpn-devel] OCSP_check.sh fixup
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
To: openvpn-devel@lists.sourceforge.net

There are few serious issues with the OCSP_check.sh script:
 1. It will accept OCSP responses with bad signatures
 2. It may accept OCSP old responses as currently valid

detailed description on bug tracker:
https://community.openvpn.net/openvpn/ticket/450#ticket

Pull request with fixes:
https://github.com/OpenVPN/openvpn/pull/17

--=20
Regards,
Hubert Kario
Quality Engineer, QE BaseOS Security team
Email: hkario@...1347...
Web: www.cz.redhat.com
Red Hat Czech s.r.o., Purky=C5=88ova 99/71, 612 45, Brno, Czech Republic

