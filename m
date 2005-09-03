From: James Yonan <jim@...41...>
Subject: Re: [Openvpn-devel] Re: OpenVPN Protocol
In-Reply-To: <loom.20050903T161843-258@...171...>
Message-ID: <Pine.LNX.4.58.0509031058010.16613@...41...>
References: <loom.20050902T143928-990@...171...> <m364tijlep.fsf@...409...>
 <loom.20050903T161843-258@...171...>
MIME-Version: 1.0
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
Date: Sat Sep  3 10:22:10 2005
Content-Type: TEXT/PLAIN; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
To: Gervasio Bernal <gervasiobernal@...447...>
Cc: openvpn-devel@lists.sourceforge.net

On Sat, 3 Sep 2005, Gervasio Bernal wrote:

> Lars Gullik Bj=C3=B8nnes <larsbj <at> gullik.net> writes:
>=20
> >=20
> > Gervasio Bernal <gervasiobernal <at> speedy.com.ar> writes:
> >=20
> > | First of all, I will explain what we are trying to develop. Basically=
, our=20
> idea=20
> > | is to make OpenVPN works at kernel level, not at user level, and use =
the=20
> linux=20
> > | cryptoapi instead of openssl.
> >=20
> > Just a question.
> >=20
> > Why do you want to do this? Performance or something else?
> >=20
> > To me running in userspace is one of the really good things about
> > OpenVPN.
> >=20
>=20
> You are right!, running in userspace is a great thing because it facilita=
tes the=20
> portability, but you lose performance. Obviously, if we run it at kernel =
level=20
> we will lose that portability, but we will win performance.

You also lose the security of running the OpenVPN process outside the=20
kernel as user/group nobody and chrooted to a sandbox.

If someone finds a remote code injection vulnerability, you are much worse=
=20
off than you would be if you were running as an unprivileged process,=20
chrooted to a sandbox, because now every remote compromise is a full root=20
compromise.

There are also stability issues -- what if there is a crash or assertion=20
failure?  Running in kernel space, you will bring down the entire machine.
When alpha & beta testing new features, it's important to be able to=20
convince users to test the new code, to help stabilize it.  People are=20
going to be less likely to test code that might crash their whole machine=20
as opposed to code which will only bring down a single process.

As far as performance is concerned, you will gain the time it normally=20
takes to switch between user and kernel space.  But this time may be small=
=20
in relation to the much higher cost of crypto operations.

The big question in my mind is whether this possibly small increase in=20
performance will justify the loss of portability, and some level=20
of stability and security.

James


