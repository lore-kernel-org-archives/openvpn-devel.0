Date: Thu, 31 Mar 2022 13:02:38 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <YkWKTthhlLISLXbl@...1296...>
References: <20220329192934.1415-1-timo@...2669...>
 <20220330205536.139-1-timo@...2669...>
 <9564ba11-d626-4e60-fa2f-979c114b95c2@...277...>
 <d18f61d5-3f4d-b6b1-2a57-d2b2ff9b7a25@...2080...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="YJZsjYwEzzdDkotV"
Content-Disposition: inline
In-Reply-To: <d18f61d5-3f4d-b6b1-2a57-d2b2ff9b7a25@...2080...>
Subject: Re: [Openvpn-devel] [PATCH v2] Retain CAP_NET_ADMIN when dropping
 privileges
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: David Sommerseth <openvpn@...2080...>
Cc: Jan Just Keijser <jan.just.keijser@...277...>, openvpn-devel@lists.sourceforge.net

--YJZsjYwEzzdDkotV
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Mar 31, 2022 at 12:06:06PM +0200, David Sommerseth wrote:
> There is however another related challenge in OpenVPN 2.x, which became=20
> even clearer than be fore with the sitnl implementation we switched over=
=20
> to on Linux by default with v2.5.  When using --user/--group without=20
> --persist-tun, a reconnect would tear down the interface but could not=20
> recover again and the connection dies.  Using --persist-tun, it could=20
> work a bit better *unless* it needs to change the IP address of the tun=20
> interface.  I'm not sure how well, OpenVPN 2.x works if new routes are=20
> being pushed (OpenVPN 3 supports that as well).  This challenge is also=20
> resolved by granting the process CAP_NET_ADMIN capabilities.

For most non-trivial stuff, OpenVPN with --user will run into problems,
be it route teardown, installing of new routes at renegotiation time,
...

So most people today just run 2.x as root, not getting any security=20
benefits.

> For now, my opinion is that it is currently acceptable to have=20
> CAP_NET_ADMIN available when running with ovpn-dco; to have a smooth=20
> user experience.  OpenVPN is after all a network related process.

I'd even go for "keep CAP_NET_ADMIN for DCO and sitnl" - because it
means "all the route/interface manipulation *and cleanup* stuff can
be done properly, without having to carry root privileges".

> As a way forward after this, the aspect of how much to trust,=20
> capabilities and privileges you put into a single process needs to be=20
> better defined.  OpenVPN 2.x has a monolithic design, and the=20
> architecture of privilege separation is lacking at best.

You might be surprised at what we have in 2.x :-) - with the service
pipe, we can run OpenVPN fully unprivileged, and do so on Windows.=20=20

We just never had anyone bother to implement a backend for this for
"Unixy" platforms...

The benefit of that, securitywise, wouldn't be very large anyway,
compared to "CAP_NET_ADMIN + --user nobody" - the service is still
able to mess up routing and interface config, and that's about what
privileges remain in that combo... - so, dubious benefits, lots of
work.

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--YJZsjYwEzzdDkotV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJiRYpOAAoJEB2Cnv7KVigSGcAMAKflxeJaPWCadp5mhK3W5N6B
0pms+DiSV+d+r2Jytq3t5HhcyGcKJFXzFqni3mdYQcwHUGckn5mSM+bgTJEgjKEX
JgB6KqRD2LMsq0qgNsGIgoGOraGXp7gNYq8VRgJk1B+Ho2p1JEt56CcLnWPqm+B7
1gsnOe47NZZWjc0pYKQSzAb8Qj9jdE7LoFTH2hDDWQyw1rEgfmPLQyKdCSBW01ZG
JaAjVpARBZiWkM/mpKe1WCb7MzE8cHa6HKkz97NaEjY0UeYuVp7C8iQPMhgCOdbv
5gWijUOCDzI/XIU0t2bm+UZOA1eYUVixiuBQg8n7FgWkkPEfUazcQS7bargwTB5o
vdmZBsaCuk/dWpwOj7bO3kiTMOiyU1K736rXRq636JNl+uj+FlVq1Ifn8muzFTRJ
f+pEJ8L2TDSEI5sevf/M53RTdgUPBHA+0QSpeC4Y3Rwf5RQ5aYH4WwG0FQfD8aWu
7Dl0Q+T0xkbmYKJufhmZCmZTVhDzCJOTZQErIIpZqg==
=L04I
-----END PGP SIGNATURE-----

--YJZsjYwEzzdDkotV--

