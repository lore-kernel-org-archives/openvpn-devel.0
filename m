Date: Tue, 22 Oct 2013 14:13:36 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20131022121336.GE161@...1296...>
References: <OF80C424FD.27405071-ONC1257C07.004692C7-C1257C07.004BC866@...1846...>
	<20131017141929.GC161@...1296...>
	<OF103608A1.B8847B78-ONC1257C0B.002E1D46-C1257C0B.002F1965@...1846...>
	<20131022114017.GD161@...1296...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2Mhf1+ydQLhYCbMZ"
Content-Disposition: inline
In-Reply-To: <20131022114017.GD161@...1296...>
Subject: Re: [Openvpn-devel] Openvpn 2.3.2 potential memory-leak after
	24hours (addendum3)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: arno.odermatt@...1845...
Cc: openvpn-devel@lists.sourceforge.net

--2Mhf1+ydQLhYCbMZ
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Oct 22, 2013 at 01:40:18PM +0200, Gert Doering wrote:
> I could use some ideas on how to debug this further - if valgrind isn't
> complaining, normally our memory management should be OK, but why is
> VSZ/RSZ still growing, then...?

Arne brought up a good point.  If we "lose" the memory inside the gc_*
functions (as in: use the same gc block for a very long time, like
"while OpenVPN runs", but *do* free it at the end), valgrind might not
be able to see it - after all, we nicely cleaned up later - but we'll=20
still grow out of bounds at runtime.

Now, since 2.1 is supposedly not doing this, but 2.2.2 *is*, and the
difference between those versions is not all that big, I really wonder
where and how this got introduced.  Maybe time to do some git bisect...

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--2Mhf1+ydQLhYCbMZ
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.13 (NetBSD)

iQCVAwUBUmZr76kuBuNlUUl1AQJY0QQAj7U86aD6rZ9a2PCQo3/S/ErV19MmlDEQ
fKb8K8reNZDr8VmgoSH3SXA9jSY324J8dwrWlB9BfWlcg3OZBDHaiEWDrMwYIlTU
WtAxNr0LvYFdL26J1/6HrWi+CVj0EHQkcmL0CDa+5onsT8DNhKrklXZvXcCmz+ql
+JlfIQjUyq4=
=K8zy
-----END PGP SIGNATURE-----

--2Mhf1+ydQLhYCbMZ--

