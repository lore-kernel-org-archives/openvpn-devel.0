Date: Wed, 20 Nov 2013 19:27:33 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20131120182733.GS161@...1296...>
References: <CAN_jwOuJcwF-Co0r=pukUHO2z0a0ff5xtERp7_mc2PYot9yv-Q@...278...>
	<CAN_jwOuQR6rxUTA5Nho9tBkvSBMU75Yzfv=PFpFUHa2Kq8=E2A@...278...>
	<20131023141829.GA13900@...1296...>
	<20131023162618.GP161@...1296...>
	<CAN_jwOsnDbhxuR-buwk6JE2ST_JDfmaLuB0ffe=g6dAc4my6bQ@...278...>
	<20131030083523.GL161@...1296...>
	<CAN_jwOtJwZN-iJvVyiHhTuzpKnSuYoNqzv5WEEouqk+fQQ2FHQ@...278...>
	<CAN_jwOtCYq2+dWrb=CZJZxbimP8mE+SKbe4DGrCoYyfyceEhYg@...278...>
	<20131101183401.GZ161@...1296...>
	<CAN_jwOvg9rP1TzJQhcLcozMS_-niv764f4OHob29WHuGoYx4fg@...278...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dWVCIqx4J1bxisq0"
Content-Disposition: inline
In-Reply-To: <CAN_jwOvg9rP1TzJQhcLcozMS_-niv764f4OHob29WHuGoYx4fg@...278...>
Subject: Re: [Openvpn-devel] Does openvpn 2.3.2 has memory leak?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Brad Zhang <hebei5000@...277...>
Cc: openvpn-devel@lists.sourceforge.net

--dWVCIqx4J1bxisq0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

to bring this discussion to an end...

On Thu, Nov 07, 2013 at 06:25:55PM +0800, Brad Zhang wrote:
> Thank you so much. I am testing Openvpn 2.3.2 with your patch memory usage
> some days. Here is result:

Thanks for the exhaustive tests.  This is really good to see, and it's
impressive how much less memory PolarSSL need!

The patch in question has been acked by David, has been pushed to git,
and will be in 2.3.3 when we release that.

[..]
> I noticed your mail said if clients are disconnected, the memory will be
> free, but when I tested openvpn + polarssl (no your patch), the memory did
> not free completely, for example:
> Openvpn 2.3.2 + Polarssl
> 62672  55m 1408 S  0.0  2.8   0:06.91 openvpn  (Have 200 connections)
> 37864  34m 1412 S  0.0  1.7   0:06.84 openvpn  (disconnect all connection=
s)
[..]
> It is odd that memory do not free completely because I saw all the clients
> disconnect correctly from Openvpn server logs.
> I tried to disable the option "persist-key" and "persist-tun", it did not
> make better when clients disconnected.

Finding the reason for that is not trivial.  What comes into play here is
how the "malloc()" and "free()" functions works on that particular=20
operating system - usually, not all malloc() requests fetch memory from the
kernel directly, but usually malloc() will request a larger block (with
sbrk() or mmap()), and maintain that locally in the process, saving on=20
syscall overhead.  free() will also work only locally first, and only if
the library decides "it's worth returing something to the kernel" it will
actually do so - so it's not unusual to never see memory usage actually
go down if your library just keeps the memory chunks around...

So it might be that in this case, there's a memory allocation right in
the middle of a larger area which is still in use, so the larger area
cannot be returned (but the memory might be re-used when the clients
connect again, so is not "lost") - but without very extensive debugging,
including fully understanding the way the local malloc()/free()=20
implementations work, this is impossible to give a definite answer to.

What we know, and this is good :-), is that openvpn *does* call free()
on everything it allocates - this we can learn from valgrind, but it
will only tell us how the situation is at program end, not how the
memory layout looks like while it runs (I think it can be told to do
so, but there are *many* short-lived malloc()/free() uses in OpenVPN,
so looking at the log files would be a huge amount of work).

Anyway.  I think what we have is "good enough" given the amount of
work we can invest here, and that there are so many other areas where
we need to fix bugs...

Thanks for bringing this up, and making us reconsider the buffer changes
we did in best faith :-)

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--dWVCIqx4J1bxisq0
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.13 (NetBSD)

iQCVAwUBUoz/FKkuBuNlUUl1AQL5+QP/WuHAKOCkHJSJCZV7ywLHSgZnTI7BUCpL
mleNv+mxjzv264JyQy04wbnTRAinu0TBS4wMFmfJOzvyrBRRHHenvEmJHu8JzdyL
FNfEnr79LiEnBNm67YEXHwLot4uSS+HbSvXiBTrs8AFU0nQKcjy3lEYfZ3AdaWJl
gSC4oLTXN3o=
=O7ge
-----END PGP SIGNATURE-----

--dWVCIqx4J1bxisq0--

