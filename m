Date: Sun, 8 Apr 2012 13:13:50 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20120408111350.GO1359@...1296...>
References: <CAOazyz1Uy_SxZCjdQ5oA1SAS+yjNC3i23BgMPDBr_gSFD+h_Rg@...278...>
	<20120408105646.GN1359@...1296...>
	<CAOazyz0BVcVXeUyMbzEjL1bBoj36d77+X1w0DxsZoENRz=BRdw@...278...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1VlwRdCtlv6lWXmQ"
Content-Disposition: inline
In-Reply-To: <CAOazyz0BVcVXeUyMbzEjL1bBoj36d77+X1w0DxsZoENRz=BRdw@...278...>
Subject: Re: [Openvpn-devel] [RFC] tun cleanups
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Alon Bar-Lev <alon.barlev@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <Openvpn-devel@lists.sourceforge.net>

--1VlwRdCtlv6lWXmQ
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sun, Apr 08, 2012 at 02:01:55PM +0300, Alon Bar-Lev wrote:
> On Sun, Apr 8, 2012 at 1:56 PM, Gert Doering <gert@...1296...> wrote:
> > On Sun, Apr 08, 2012 at 01:43:12PM +0300, Alon Bar-Lev wrote:
> >> What I am asking is for people that wishes to work with me on this
> >> (not the ACK/NACK approach) to allow perfecting this *BEFORE* merge.
> >
> > I would actually ask for "no more cleanup changes to tun.c before 2.3" -
> > I have cleaned up and *tested* all non-Linux-platforms in the previous
> > months and everything is working well now (not looking very pretty, I'm
> > the first to agree on this), but *working* *now*.
>=20
> Did I wrote or implied that this is going to 2.3?

You asked for wishes :-) - and that's my wish: first focus on 2.3, and
then do the next round of C code cleanup.

[..]
> The IPv6 is one of the reason the code is so messy.
> Please help clean it up.
> For example, there is no reason not to use iovec in all cases as far
> as I understand.

I'm all willing to help clean up tun.c *and test the result on all=20
platforms* afterwards.  I just do no thave the necessary amount of=20
available time (a few contiguous days without too much disturbance) right=20
now, and I know that this will not improve before August/September.=20=20

So right now, I can't work on tun.c at all, sorry.

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--1VlwRdCtlv6lWXmQ
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (NetBSD)

iQCVAwUBT4Fy7qkuBuNlUUl1AQKLAAQAhR5bNj4N3Ce+/IblYBQSJNkZlkfarGy5
kLfv5KgEh3oGXBXCrAVObZ7FSTp8BNE6cFC2jbWJJfUhRv0sddKURt3EkdFjqOFK
cF+0p43kmGSPv00n5TvAWez8O+Tx5n3UtaRQX1s3TVqc8FNY+SO+NbCgBuS3aYqf
UNg++TD1H5s=
=IaJS
-----END PGP SIGNATURE-----

--1VlwRdCtlv6lWXmQ--

