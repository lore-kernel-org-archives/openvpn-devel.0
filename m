From: "Randolph A. Krenz" <randy.krenz@...793...>
Date: Thu, 19 Jul 2007 09:16:17 -0400
Message-Id: <1184850977.5586.5.camel@...23...>
Mime-Version: 1.0
Subject: [Openvpn-devel] OpenVPN RFC-2246 Compliance Question
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: openvpn-devel@lists.sourceforge.net

I have a need to utilize OpenVPN in a Server/multi-Client, TCP, TUN mode
on port 443.  OpenVPN generally works fine but I=E2=80=99ve recently had a =
need
to pass this traffic through a firewall with stateful packet inspection
(that can=E2=80=99t be circumvented).  The firewall complains that the traf=
fic
does not comply with section 7.4.1.2 of RFC-2246 (The TLS protocol)
which states that a =E2=80=9Cclient hello=E2=80=9D must be sent as the clie=
nt=E2=80=99s first
message.  The traffic is dropped as a result.  I don=E2=80=99t see any obvi=
ous
OpenVPN configuration changes that would affect this behavior.  Is there
anything I can do, from a configuration perspective, to cause the
OpenVPN client to send the =E2=80=9Cclient hello=E2=80=9D?  Not sure if thi=
s would be
the only (or just the first) obstacle in getting through the SPI.

Thanks,
Randy



