Date: Wed, 16 Nov 2016 17:50:02 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20161116165002.GI28918@...1296...>
References: <1478870201-17943-1-git-send-email-davids@...515...>
	<1479165185-11730-1-git-send-email-davids@...515...>
	<20161116162621.GH28918@...1296...>
	<09f25564-0781-b702-a1dc-9e4aa0eb8dfd@...2080...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="igABDXH78n6Jl+Hn"
Content-Disposition: inline
In-Reply-To: <09f25564-0781-b702-a1dc-9e4aa0eb8dfd@...2080...>
Subject: Re: [Openvpn-devel] [PATCH v2] tun: Fix compiler warnings
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net
Cc: David Sommerseth <davids@...515...>

--igABDXH78n6Jl+Hn
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, Nov 16, 2016 at 05:32:48PM +0100, David Sommerseth wrote:
> > On Tue, Nov 15, 2016 at 12:13:05AM +0100, David Sommerseth wrote:
> >> Fixes two compiler warnings idetified by using CFLAGS=3D-O2
> > Spelling...
> Meh. Will fix that one.
[..]

As discussed on IRC - there's a few issues with the patch (some stylistic
disagreement, and WIN32 vs. _WIN32), but it compiles and passes IPv6-releva=
nt
tests on OpenSolaris, and that is the most important goal.

So, ACK, with amendments to the style and WIN32 bits on the fly.

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--igABDXH78n6Jl+Hn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQCVAwUBWCyOOakuBuNlUUl1AQIXHwQAsjNX8Sb2j4Kec+MVP1ivSwcImYwTmOVt
dgu428XxHZx09e5kbZqpmnwt6Un+vYwfAQI1/aiA5DUspByhpE4yEn/DZHdjvFQ+
PVnta1kHOdPYNu+9II/0JVZMWwgd8OWZDj1mZAOWBKTdtJ0piRE0a8xxQFx/lKvh
sI/HOhcSbuo=
=Y8KO
-----END PGP SIGNATURE-----

--igABDXH78n6Jl+Hn--

