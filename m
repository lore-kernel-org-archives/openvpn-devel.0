From: "oyk" <oyk@...89...>
Mime-Version: 1.0
Message-ID: <E1BXJZc-0006L0-Tw@...230...>
Subject: [Openvpn-devel] how to implement the multi client in openvpn?
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Mon Jun  7 05:50:14 2004
Content-Type: text/plain; charset="GB2312"
Content-Transfer-Encoding: quoted-printable
To: 

Hi=A3=ACguys
   I want to know how the openvpn control the multi-client case in 2.0 vers=
ion.
for example:
  clientA---Internet---|             |----Internal Server1
                       |----Server---|----Internal Server2
  clientB---Internet---|             |----Internal Server3

Based on my comprehension, clientA (10.1.0.2) and clientB (10.1.0.3) can ma=
ke
a tunnel with Server (10.1.0.1) respectively using TCP connection.
clientA sockA----------Server SockA1
clientB sockB----------Server SockB1
When Server recieves the package from clientA or clientB, it pushs the pack=
ages
to the tun/tap device. And the Server box could route the package to the in=
ternal
server. And the internal server response the package to Server.

My question is: when OpenVPN Server recieves one package from one internal =
server,
how does it control the package and redirect to whom(clientA or clientB)?

   Please help, thanks!

PS: could I use windows version as OpenVPN Server?

Best Regards
   Ouyang Kai




