Date: Mon, 12 Sep 2022 14:50:30 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <Yx8rFmv7B7vlXJYs@...1296...>
References: <20220808143424.65924-3-kprovost@...2661...>
 <YvPdlCSxQ6wvfIna@...1296...>
 <2DCBB302-1FB4-4EC0-8B4A-8D6EA075B0FD@...2661...>
 <YvVwcBtzGagtUgOA@...1296...>
 <8E0AADE4-350B-46A5-B4BD-5E97ADA642F4@...2661...>
 <YveWP9xh9XwsjwPY@...1296...> <Yve0gy+SuH+7unUj@...1296...>
 <7CB2FF09-EE1D-427E-BBD1-4128EAE1ED4A@...2661...>
 <Yx8hkCs4tOK5+dBl@...1296...>
 <F65A9C36-1FA7-44E2-8A13-8573DD3FEAA7@...2661...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="bfVZL2nouIrHqJpt"
Content-Disposition: inline
In-Reply-To: <F65A9C36-1FA7-44E2-8A13-8573DD3FEAA7@...2661...>
Subject: Re: [Openvpn-devel] big packet loss with FreeBSD DCO
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Kristof Provost <kprovost@...2661...>
Cc: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net

--bfVZL2nouIrHqJpt
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Sep 12, 2022 at 02:43:09PM +0200, Kristof Provost via Openvpn-devel=
 wrote:
> That???s very interesting information. You may be closing in on the cause.
> What version do you run on the t_client server? Perhaps that will help me=
 to reproduce it.

OpenVPN 2.6_git [git:master/26e40c48b89478cb

but I don't think that's actually needed, just looking at the difference
in packet size increase between DCO and non-DCO was already a good=20
indication :-)

So, see other mail, it's padding/rounding up, and for whatever reason,
this increases the encapsulated packet size for DCO - which normally gets
ignored on the receiving end, it seems, but for this particular packet
size range, the result is just too big.

[..]
> I???m on my way to Vienna for EuroBSDCon now, so I will be distracted unt=
il early next week, but when I???m back I should be able to dig into this a=
s well.

Enjoy!  I've been to EuroBSDcon in Belgrade a few years back, and it was
definitely one of the nicest conferences I've been to - good talks, and
very nice and friendly (and interesting!) people everywhere.  This year,
I need to get other stuff done...

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--bfVZL2nouIrHqJpt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGbBAEBAgAGBQJjHysVAAoJEB2Cnv7KVigSmO8L+ODZWjqknDg/s5Upp2JN1BX9
ZeMIkq9t5eLlBR2lpYHoh32FBhyG8I5qw3BrEYbqIEZ5xXwZw50mnlIZjzu61DRQ
jAn216rmzEcc6ZtX+tC7Iq3V061KeFLc+PXQ+espJJBa638/8A4PbTcAvNbzGpZV
mz2rRytuvDpeIOS/8+xHdKh91bx0s3ISNqbu/Kw+/Zktdo6gjz/0hacuSvxFTqHl
YefbgfPjv+j7IFV5b6TUmfh3RCl5g+3ISX9Nf2bkQQY9rkq9HaLjjgXVSvBeiPR2
C2owQPrvZSGSs+bWenPv16h1YRqoyDT3fk3a8Osg9XAQyRx9mja4jUf1bnMN8PqU
XjwqdiyZon1Cn9ysBgnGHaN+++bRHcrd58l70D9d1Gm8yowkZRAssiP92wg7W+pM
fzg9fV+pJK7IOfzE7bMWIH+9h0PGubFSieK7eJKTmKWoWaiunKxw0T3zcQgVj3kN
SA1NKmMO/Qj28tQdwwPIA97QRe3c5cZt3e9D7Fds
=vEgR
-----END PGP SIGNATURE-----

--bfVZL2nouIrHqJpt--

