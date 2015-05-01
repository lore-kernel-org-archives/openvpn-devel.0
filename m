Message-ID: <1430518805.21119.82.camel@...1866...>
From: David Woodhouse <dwmw2@...1866...>
Date: Fri, 01 May 2015 23:20:05 +0100
Content-Type: multipart/signed; micalg="sha-1";
	protocol="application/x-pkcs7-signature"; 
	boundary="=-KW6gaUmrqGZh+bbu2CUx"
Mime-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Use vfork() in openvpn_execve() instead of
	fork()
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net
Cc: Alon Bar-Lev <alon.barlev@...277...>

--=-KW6gaUmrqGZh+bbu2CUx
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

The pkcs11-helper library installs a pthread_atfork() handler which,
in the child, will call the C_Initialize() method on any PKCS#11
provider module which is active in the parent.

I'm going to assume that Alon knows what he's doing and that this is
actually the correct thing for pkcs11-helper to be doing.
Nevertheless, it does seem to be central to a number of issues.

Firstly, OpenVPN is forking to spawn systemd-ask-password from
*within* the PIN request callback, which is expressly forbidden and
leads directly to a deadlock.

Secondly, even if we work around that by disabling systemd support, we
find that the OpenSC PKCS#11 module doesn't cope. It ends up confusing
pcscd by interacting with it over two separate connections, as
described at=20
http://sourceforge.net/p/opensc/mailman/message/34073754/

Third, the p11-kit-proxy.so module also doesn't cope, and suffers an
internal deadlock as described at
https://www.mail-archive.com/p11-glue@...2028.../msg00126.html


Even if this behaviour of calling C_Initialize() in the child is
strictly correct, it doesn't seem that we can rely on provider modules
to cope with it in the general case. Perhaps it would be safer to not
actually reinitialise the modules until later, if they are really
going to be accessed again?
--=-KW6gaUmrqGZh+bbu2CUx--
