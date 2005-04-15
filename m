Message-ID: <1113553156.425f790404e31@...372...>
From: cedric.hertault@...260...
MIME-Version: 1.0
Subject: [Openvpn-devel] forking TCP server (multiple clients) : SSL/TLS needed
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
Date: Fri Apr 15 01:23:01 2005
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
To: openvpn-devel@lists.sourceforge.net

Hello!

I have to build a bridge server with just 2 openvpn clients. The goal is to
create one network with 3 sites with a layer 2 vpn. The 2 openvpn clients h=
ave
the same remote server, so i decided to use xinetd with the nowait option in
order to create more than one instance of the server.

But the condition is, with openvpn, i have to use SSL/TLS! but the use of t=
he
static key is sufficient. So i modified the source and delete the SSL/TLS
condition on the --inetd nowait option (option.c file). Now it is ok, xinetd
create a new server instance on demand, with the static key.

All i want to say with this example is i don't think that the SSL/TLS
requirement for the nowait inetd option is not justified for a network arch
like mine, and the use of the static key has to be possible.

Let the openvpn user decide what to do (ssl/tls or static key) with the now=
ait
option, what do you think of this?

Cedric

