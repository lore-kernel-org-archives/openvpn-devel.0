From: Christian Daniel <cd@...154...>
MIME-Version: 1.0
Message-Id: <200402291538.45014.cd@...154...>
Subject: [Openvpn-devel] OpenVPN multi instancing
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
Date: Mon Mar  1 10:20:15 2004
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
To: openvpn-devel@lists.sourceforge.net

Hello everybody!

For a student research project I'm trying to add multi instance capability =
to=20
OpenVPN. The basic idea is to rip the main openvpn()-function apart, put al=
l=20
variables in a struct and then have only one select()-call for all open=20
tunnels at once.

Then there should be one unix-socket which can be connected by some=20
to-be-written control-application, which manages the tunnels. In detail it=
=20
should be possible to add and remove tunnels on demand just by sending the=
=20
appropriate config down that unix-socket.

Each tunnel should have it's own tun/tap-device open - the linux kernel has=
 no=20
problem to cope with so many interfaces... I don't think, that it's a good=
=20
idea, to create only one tun-device and then have some kind of internal=20
routing-engine...

My main problems so far are:
- which code-base should I use? Should I start with 1.5 oder should I take=
=20
code from CVS? CVS means shooting on a moving target...
- how to handle the garbage collection? Is it really necessary or is the co=
de=20
leak-free?

Is there any interest here to support that project? We will do it because i=
t=20
is out assignment - and we will finish it :)

Thank you for your help!
Christian

--=20
+-------------------------------------------------------+
| Christian Daniel                                      |
| Drechselblick 5        Mariannhillstra=DFe 6 / App. 220 |
| D-97816 Lohr am Main   D-97074 W=FCrzburg               |
+-----------------------+---------------+---------------+
| http://www.cdaniel.de | cd@...154... | ICQ: 95896119 |
+-----------------------+---------------+---------------+

