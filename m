References: <1482585739-14441-1-git-send-email-steffan@...1856...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <b535a74e-ebe5-7235-329a-371738d90c9e@...2080...>
Date: Wed, 25 Jan 2017 18:25:54 +0100
MIME-Version: 1.0
In-Reply-To: <1482585739-14441-1-git-send-email-steffan@...1856...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="e3TieSHGl4o4WED2B3GDSU9BQgRre3crM"
Subject: Re: [Openvpn-devel] [PATCH] Feedback wanted: proof-of-concept
 recvmmsg() support
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan@...1856...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--e3TieSHGl4o4WED2B3GDSU9BQgRre3crM
Content-Type: multipart/mixed; boundary="V8IOvPFt1uM7cQv6WRfi9ACNe1boMmBKI";
	protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
To: Steffan Karger <steffan@...1856...>, openvpn-devel@lists.sourceforge.net
Message-ID: <b535a74e-ebe5-7235-329a-371738d90c9e@...2080...>
Subject: Re: [Openvpn-devel] [PATCH] Feedback wanted: proof-of-concept
	recvmmsg() support
References: <1482585739-14441-1-git-send-email-steffan@...1856...>
In-Reply-To: <1482585739-14441-1-git-send-email-steffan@...1856...>

--V8IOvPFt1uM7cQv6WRfi9ACNe1boMmBKI
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

On 24/12/16 14:22, Steffan Karger wrote:
> This patch is not done, but I would like to get some early feedback
> because I'm not very familiar with this part of the code, nor with the
> APIs involved.  So I expect to have made some rooky mistakes.
>=20
> A while back, I experimented a bit with recvmmsg(), to see if using it
> would yield some performance gain.  Simple tests (I don't have a good
> stress test setup handy) indicate that this improves throughput by a few
> percent.  I would expect more gain on the server side for P2MP servers
> though, where multiple client can be spamming the server at once.
>=20
> What definitely still needs to be done:
>  * Improve error messages
>  * Improve documentation (doxygen, openvpn.8, Changes.rst)
>  * Figure out good default values
>=20
> So, please, let me know what you think of the code.  And if you do have
> a good setup for performance testing, I'd love to hear what this change
> does for you.

Too bad I have changed employer ... as I have some vague memories doing
some recvmmsg() send even sendmmsg() testing on kernel-rt, when these
features were added there.  I'll meet some of my ex-colleagues later
this week and weekend (devconf.cz happens now) ... so I'll see if I can
get some help retrieving some reasonable test scenarios.

So to the patch ...

First of all, not all kernels carry these system calls, I believe they
were added in some of the 3.x kernels - but, IIRC, it has been
backported to at least the RHEL6 2.6.32 kernels.  My memory is scarce
about the 2.6.18 kernel base on RHEL5, but I believe only recvmmsg() is
supported there.

But kernel support isn't enough.  It needs to be supported in glibc as
well, where recvmmsg() arrived in glibc-2.12 and sendmmsg() arrived in
glibc-2.14.  And if glibc support is missing ... there's needed to so
some tweaks here, having a wrapper which does the proper syscall() with
SYS_recvmmsg and/or SYS_sendmmsg as the syscall number reference. (see
/usr/include/bits/syscall.h and man syscall(2) for more info) ... but
step carefully with such wrappers - as we need to consider
cross-platforms (not saying we should support this feature on all
platforms).

So all this considered, configure.ac will need to do some probing if
recvmmsg() and sendmmsg() are supported.

I know this patch covers recvmmsg() only.  But I think you can gain even
more performance if looking into sendmmsg() as well.

I'll try to play a bit with this patch and see how things go on my side
though.


--=20
kind regards,

David Sommerseth
OpenVPN Technologies, Inc



--V8IOvPFt1uM7cQv6WRfi9ACNe1boMmBKI--

--e3TieSHGl4o4WED2B3GDSU9BQgRre3crM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJYiN+iAAoJEIbPlEyWcf3ymRMQALX3cWNMF6NBXY3UdpxQtO14
Ur9mUeTCDkHcjOTxQUaa8sjJE6q7iAmxR+8FX6xZJHXIFkeM/QldHgr10b6e4oPX
g6oRv8ROG3n9UHRiVyScbHJcP4r8fiXFk2D+/GIchgoHfT5nHsG+IQklWXtet8sn
FFoVt5la4yiJmB6MThM+e6H3HrSiTqBdjZncfxMDfv25VWdxUvhz4Vt/xC4lQ7OR
FZUmvqPEQZ55Nk17+OwTmNv+3Pc4E59zCH0ETkpMQwDI0oc7gURX/VS3V5uGYg70
BtvdIpDzX9xmn3mXxMmLF/9rgvgw6oIjC+6tbb1P87sEJSJdVb9Ucon4OG4Ff8JW
d+vHIEbyjnFYcemTsB0Kdbsu5DVuTNRMdLGluloO0dV5yujkzk+dviV/QtPWIw1K
S0Q+d1Hcvfc4Mi8qFViKkZYMW7XT7On0YEsyYJJzBE0cNEFsJPtI6ceXkSKPewP1
8lMuiXAXBnQDPY8KxnxsoUaXgi9jAdRZWAxhNcTZKnfxMkDea46lQqi5oAzNxXSl
ZRkdTLic5mN5K5iBcqrQfG1osY9yfRaJej80hcnVx5iwx/OE3TttusN1xxUEUBAx
H34DMM9uAnUADjfv8fNrHZNRkiZ+o1o5FeqPAPlPccCh9dZp+j7E0pxZ0JukBl1p
ITIeQUDZxofjiq6uTlip
=M06o
-----END PGP SIGNATURE-----

--e3TieSHGl4o4WED2B3GDSU9BQgRre3crM--

