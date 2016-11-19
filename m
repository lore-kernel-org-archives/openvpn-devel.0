Date: Sat, 19 Nov 2016 21:12:38 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20161119201238.GA49297@...1296...>
References: <1479569756-23302-1-git-send-email-arne@...1227...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="nFreZHaLTZJo0R7j"
Content-Disposition: inline
In-Reply-To: <1479569756-23302-1-git-send-email-arne@...1227...>
Subject: Re: [Openvpn-devel] [PATCH] Remove compat-stdbool.h.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net

--nFreZHaLTZJo0R7j
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sat, Nov 19, 2016 at 04:35:56PM +0100, Arne Schwabe wrote:
> Since we use C99, we are guaranteed to have stdbool.h available
> ---
>  src/compat/compat-stdbool.h | 12 ------------
>  src/openvpn/syshead.h       |  2 +-
>  2 files changed, 1 insertion(+), 13 deletions(-)
>  delete mode 100644 src/compat/compat-stdbool.h

Meh!  When deleting a whole file, please take into account that this
might be referenced in "make dist"...

make[3]: *** No rule to make target `compat-stdbool.h', needed by `distdir'.

(Windows buildbot is currently broken because it builds tarballs first)

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--nFreZHaLTZJo0R7j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJYMLI2AAoJEB2Cnv7KVigSuZMMAIp/TqZlCFhEVFX5CUCJefHx
OJmwmHGOKhQknHAhIMWkZrrNjfrb9j8F/xClA2/rBtdQyAowBcvvk9uOdbCEhUcx
CtPza543KPYoe68BLXjyOwDfye+XXtXTdxZQNBPnP9cw7GHmzLSsgVGuWof1Hury
wI16FnYudfz3lJcZERfKB/8QSlYXLHqhMCO5ZNaO/WY/vbOZWtr8zO45zzS68r49
XYgtypClOeHFSrh/rWxo2pJ8Ffc2Z6st/GTphf+/LOm4VAq5Rd6mI1EogmpsbIyh
t7SViQddfodCMC+Ht3suUaru6nYoYoFaA6fqIRW/UTvVXnLVmNjsrwVAKk/WNuKO
gwLzQKhe2iIr1pKMcLAm/in2uzrrjJGDNRy3LnuoTrveH/+I/pPOBuxm+AsBAle9
arZqchHIAYwxcOT5b9EmJ4IWySS7bGOLKfgRMZbtxRy1nc0aPNLPZPU1L8Jc1OT6
MunUwE8lGaoNOzL1ye2Nx8+0XnABB4JjnsRZKhyP8A==
=8Igi
-----END PGP SIGNATURE-----

--nFreZHaLTZJo0R7j--

