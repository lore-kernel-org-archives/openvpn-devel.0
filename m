Message-ID: <4BD5DB78.7020908@...515...>
Date: Mon, 26 Apr 2010 21:29:12 +0300
From: =?ISO-8859-15?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
MIME-Version: 1.0
Subject: [Openvpn-devel] Certificate problem with community site Trac fixed
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
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Hi all,

Patel ("openvpn2009" in IRC) just informed me that he fixed the Trac
(Apache) certificate issue. The problem was caused by rekeying of the
wildcard certificate, which was required for our internal servers. This
caused the (old) certificate on community.openvpn.net to be revoked.
Anyways, Trac is now back in business at
<https://community.openvpn.net>. We'll do our best to avoid this kind of
issues in the future :).

Thanks for your patience,

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock



PS. I ironed out the remaining issues with the LDAP self-service
registration service ("pwm") today, so it's now ready for use. This
means we can open Trac for wider audience next Friday or next Monday -
depending on how easy it is to install our SSL certificate on Tomcat.

