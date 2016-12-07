Date: Wed, 7 Dec 2016 14:01:54 +0100
From: Alberto Gonzalez Iniesta <agi@...64...>
Message-ID: <20161207130154.3ivyeknnuhn2tiv4@...30...>
References: <20161206091059.y3dzup635wvzkw6y@...30...>
	<1481027162-12165-1-git-send-email-gert@...1296...>
	<da199ee2-77b1-50ce-5b07-64044af47ba3@...1227...>
MIME-Version: 1.0
In-Reply-To: <da199ee2-77b1-50ce-5b07-64044af47ba3@...1227...>
Subject: Re: [Openvpn-devel] [PATCH v3] Refactor setting close-on-exec for
 socket FDs
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
Content-Disposition: inline
To: openvpn-devel@lists.sourceforge.net

On Tue, Dec 06, 2016 at 01:36:04PM +0100, Arne Schwabe wrote:
> Am 06.12.16 um 13:26 schrieb Gert Doering:
> > The existing code can leak socket FDs to the "--up" script, which is
> > not desired.  Brought up by Alberto Gonzalez Iniesta, based on debian
> > bug 367716.
> >=20
> > Since different sockets get create at different times, just moving the
> > set_cloexec() to link_socket_init_phase1() is not good enough - so move
> > the call into create_socket_<family>(), so we will catch ALL socket
> > creations, no matter when or under which conditions they will be
> > created (SOCKS proxy socket, listening socket, ...).
>=20
> Patch looks good. ACK from me. I also looked at the port-share code path
> but that part isn't touched by this commit.
>=20

Works for me (tm)

I'm just waiting for the pkcs11-helper maintainer [1] to upload 2.4~rc1
to Debian. If he decides to build against OpenSSL 1.1 I'd have to remove
PKCS #11 support from Debian's package in Stretch.



[1] https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D828506

--=20
Alberto Gonzalez Iniesta    | Formaci=F3n, consultor=EDa y soporte t=E9cnico
mailto/sip: agi@...64... | en GNU/Linux y software libre
Encrypted mail preferred    | http://inittab.com

Key fingerprint =3D 5347 CBD8 3E30 A9EB 4D7D  4BF2 009B 3375 6B9A AA55

