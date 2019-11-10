Date: Sun, 10 Nov 2019 18:03:38 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20191110170338.GP40538@...1296...>
References: <20191110133525.6069-1-a@...2181...>
 <20191110133525.6069-3-a@...2181...>
 <CAKuzo_ha8xxM+bw=Lrq01dnCNhNDqzS1EQGaptjUrdDq5pqcLg@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="+yOEb87YRmRdrPqC"
Content-Disposition: inline
In-Reply-To: <CAKuzo_ha8xxM+bw=Lrq01dnCNhNDqzS1EQGaptjUrdDq5pqcLg@...278...>
Subject: Re: [Openvpn-devel] [PATCH 3/3] travis: compile with -Werror on
 Linux
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva Nair <selva.nair@...277...>
Cc: Antonio Quartulli <a@...2181...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--+yOEb87YRmRdrPqC
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sun, Nov 10, 2019 at 11:48:16AM -0500, Selva Nair wrote:
> But it seems it may also affect mingw builds on travis. I would resist the
> temptation to add -Werror in general and to Windows cross-build in
> particular.

Yeah, we're not intending to.

The plan is to have "default builds (no configure options) on Linux with
sufficiently current C compilers" warning-free.  Which can be achieved
with the current code base.

> Not all warnings can be fixed easily. Often the only option is to hide the
> warning  (e.g, by adding a cast) which imo is not always a good strategy.
> -Werror just forces one's hand to use tricks that hide warnings.

Right.  Older systems will warn, oddball systems will warn, non-default
build options will warn (and I take one "unused global variable" warning=20
vs.  "adding two lines #ifdef/#endif").

gert


--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--+yOEb87YRmRdrPqC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJdyELmAAoJEB2Cnv7KVigSqZkMAKzAosTY6a17GwHIZAVxanOm
4c36h24nyy2JyXZnrunswElghXW4L66PP07blTSA3f16JU/kgs9o+yO/thqKsAN4
QyHn0EgoSQ4rRWyX0SOagGd9cm8baft8tLiQD8tv5WWcLeFCi1VleSJ2gb2ICwmx
UbAa/MQaaVJFHrIKg5bA5jTIjXrEvxlj6WVboJoGgL7WveWH09jbiTAgZ8uWUQwj
4pof9kWQn2z5dcK5mN+aVQFmFgcEHZMlbpB4Ih78cFen2tY/eYYc40TcUMZTnkiw
g4iOUCSpd0lGKV/tVXdPjWi3CRb+kr24Zq/UdYZJoeQQHpUiJgeVu+3p+bR4wQnc
hLBQZzYRx0BK4gdmQABQeButjqdRq0VRULZTF8IBjEV9EDVEQdBi6uc7nuQZ1lv2
EKJ2HxnQV6SDVvTUtmvaQZ0H9Kb1gp2TKrfClHmGRpFMLR6Ol/bPGxaG26nmSY3C
U7+NGdVuRGCxXyfZKSL6cybG/1OlJRWbRRlhM45Esg==
=wAkf
-----END PGP SIGNATURE-----

--+yOEb87YRmRdrPqC--

