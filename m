Date: Tue, 18 Feb 2014 09:16:27 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20140218081626.GT16637@...1296...>
References: <52CFF667.7080600@...1790...> <52CFFAF4.8050306@...1227...>
	<52CFFDA4.4060601@...1790...> <52D07F70.8030609@...1227...>
	<52D08946.6010906@...1790...> <20140119140416.GP226@...1296...>
	<530262FB.7080206@...1790...> <20140217213435.GS16637@...1296...>
	<5302FAB1.9000509@...1790...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bPyaW7MGXh1mijq1"
Content-Disposition: inline
In-Reply-To: <5302FAB1.9000509@...1790...>
Subject: Re: [Openvpn-devel] git master proto udp6+multihome is broken
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Tore Anderson <tore@...1790...>
Cc: openvpn-devel@lists.sourceforge.net

--bPyaW7MGXh1mijq1
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Feb 18, 2014 at 07:16:17AM +0100, Tore Anderson wrote:
> > Could you run my test program to see whether that gets it right?
>=20
> It doesn't:

Meh!

> This is 64-bit Linux, yes:

I'll re-test.  I *did* test it on mine...

Linux gentoo 3.3.8-gentoo #1 SMP Fri Jun 29 14:10:01 CEST 2012 x86_64 Intel=
(R) Xeon(R) CPU X7350 @ 2.93GHz GenuineIntel GNU/Linux

... but after the first cup of tea this morning, my brain is starting to
wake up - of course I couldn't test sending, as v4 already broke for
receiving (v6 worked).

Kernel update time...  (hrm, and maybe I should clone the VM beforehand)

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--bPyaW7MGXh1mijq1
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.13 (NetBSD)

iQCVAwUBUwMW2qkuBuNlUUl1AQKozAP8CUkWaqg8+2zZ4g7ncwF+fmMkVVfTH8QJ
aCCOLJK8dwMdys8gNwmpYwbdruTATnbiRTc+lJxfqyYdzJZNb6iabV77IO5N81h5
2Fek38be22n5TJJ6t5XsEUbL2osSJg8UZSc00BL+sdgl5Nrnp+BVdvJ2o4xWxxxU
rfWuWawrLwk=
=BKn6
-----END PGP SIGNATURE-----

--bPyaW7MGXh1mijq1--

