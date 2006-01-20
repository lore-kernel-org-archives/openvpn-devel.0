Message-ID: <57503.147.13.200.14.1137789189.squirrel@...531...>
From: "Roland Valtersson" <rolandva@...530...>
MIME-Version: 1.0
Subject: [Openvpn-devel] What after WriteFile?
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
Date: Fri Jan 20 12:34:03 2006
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: openvpn-devel@lists.sourceforge.net

Hi everyone,
I am playing around with the TAP driver for a course project. Right now I
can read from the tap, encapsulate, send over link, decapsulate and write
to TAP on other side.

On the sender side, all packets are redirected to the TAP device beause of
the route table (if destined to another host on that network). But what I
don't understand is how to make applications on the receiver side aware of
the write to the TAP interface? I mean, how do a server bound to the real
network card on the receiver side catch the info on the TAP? My program
ends with calling WriteFile. Like this:

Client program   ->  TAP  ------------->  TAP     ->  Server
192.168.0.2        10.8.0.2             10.8.0.1    192.168.0.3
^
|-- (send packet to 10.8.0.1 (but destined for 192.168.03)

Am I thinking totally wrong here?



