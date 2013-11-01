Date: Fri, 1 Nov 2013 19:34:01 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20131101183401.GZ161@...1296...>
References: <52456F61.3000104@...1114...>
	<CAN_jwOt4kiM09YjZi5=jh6qFgQTpLFgPOSO1opFOF72EY8fyCw@...278...>
	<CAN_jwOuJcwF-Co0r=pukUHO2z0a0ff5xtERp7_mc2PYot9yv-Q@...278...>
	<CAN_jwOuQR6rxUTA5Nho9tBkvSBMU75Yzfv=PFpFUHa2Kq8=E2A@...278...>
	<20131023141829.GA13900@...1296...>
	<20131023162618.GP161@...1296...>
	<CAN_jwOsnDbhxuR-buwk6JE2ST_JDfmaLuB0ffe=g6dAc4my6bQ@...278...>
	<20131030083523.GL161@...1296...>
	<CAN_jwOtJwZN-iJvVyiHhTuzpKnSuYoNqzv5WEEouqk+fQQ2FHQ@...278...>
	<CAN_jwOtCYq2+dWrb=CZJZxbimP8mE+SKbe4DGrCoYyfyceEhYg@...278...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+jMesTDEFHiw5APJ"
Content-Disposition: inline
In-Reply-To: <CAN_jwOtCYq2+dWrb=CZJZxbimP8mE+SKbe4DGrCoYyfyceEhYg@...278...>
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

--+jMesTDEFHiw5APJ
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Nov 01, 2013 at 06:40:32PM +0800, Brad Zhang wrote:
> You are right, it may be memory fragmentation, because I tested the openv=
pn
> 2.1_rc4, the memory was also increased.

OK, so 2.3.2+patch+openssl is no worse than 2.1_rc4, which means I found
what we broke in 2.2 - good.

Now, OpenVPN does a lot of small memory allocations and frees, and I think
this pretty much inevitably leads to some fragmentation.  This *should*
get cleaned up to a large extent when your clients disconnect, as OpenVPN
will then free everything allocated to the particular client.


OTOH:

> The result is :
> openvpn 2.1_rc4 200 clients:
>   2013/10/30 4:39 138372  2013/10/30 4:49 264164  2013/10/30 4:59
> 266540  2013/10/30
> 5:09 269180  2013/10/30 5:19 269444  2013/10/30 5:29 269444  2013/10/30 5=
:39
> 269444  2013/10/30 5:50 269444  2013/10/30 6:00 269708  2013/10/30 6:10
[..]
> 271556  2013/10/31 9:27 271556  2013/10/31 9:37 271556

... the growth in used memory is not fast, and I assume that it will=20
eventually slow down to a "steady state", at least if a few clients=20
reconnect here and there.

> I also have a question, is there a way to avoid the memory fragmentation?
> The memory fragmentation will  take a lot of memory if openvpn run long
> time with a lot of connections.

I'm not sure.  One would need to study memory usage much more closely
an see why it still increases after a day.  The code does a lot of things,
and I'm just guessing that it's fragmentation (it's definitely not a=20
"classic" memory leak, as valgrind would have found that)

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--+jMesTDEFHiw5APJ
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.13 (NetBSD)

iQCVAwUBUnP0GKkuBuNlUUl1AQJESQP+PB9l3MoYYjKSJcoJldd7nKqVAEs81AwB
LOBvrzFVd8kckxchvorsdHcY2MF3RsTTyag/JaslTi4gk/XFSIl8cYI+INsWr38i
2fNgmyoXV2LYzXSiKxUXcOAzAAl3lTajxlfdJCnuUmxTJekA+YBKXE3hWCsOtW6X
kYzJRWTjLvo=
=ydOz
-----END PGP SIGNATURE-----

--+jMesTDEFHiw5APJ--

