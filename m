Date: Tue, 7 Jun 2016 12:02:40 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20160607100240.GS53051@...1296...>
References: <1464976163-6162-1-git-send-email-openvpn@...2080...>
	<20160603181404.GM53051@...1296...>
	<CAKuzo_hyz1g_VqiU_AR-Q69FiXA_9K+MmPYsE=J3M41iKjyDeA@...278...>
	<CAKuzo_geGTkH_d42-xnx7NJUXBRFyahajJAdW8+eZ0eYn2HRpg@...278...>
	<0EB7FB8D-1A08-4320-A587-435B0B280071@...2127...>
	<c9f39c1c-918b-843d-9a9b-220908198a90@...515...>
	<20160607075659.GM53051@...1296...>
	<448a7afe-aece-b97b-a6ea-afb8f1b8526e@...515...>
	<20160607082014.GQ53051@...1296...>
	<CAFHpkQH4_D7Gi-ivDADk=uyqBFm7wh0t-YShiJbBadanWOkKxQ@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="un9Em1h3RhnB9zF/"
Content-Disposition: inline
In-Reply-To: <CAFHpkQH4_D7Gi-ivDADk=uyqBFm7wh0t-YShiJbBadanWOkKxQ@...278...>
Subject: Re: [Openvpn-devel] [PATCH] Another fix related to unit test
 framework
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: ???????? ?????????????? <chipitsine@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--un9Em1h3RhnB9zF/
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Jun 07, 2016 at 01:27:52PM +0500, ???????? ?????????????? wrote:
> as for Travis-CI builds, there's such possibility already
>=20
> 1) register at github.com
> 2) add your own repo to travis-ci.org
> 3) voila, you can attack Pentagon from travis-ci cloud
>=20
> the way of "add some attacking code to openvpn codebase" seems to be much
> more complicated

This is not about "attacking other people" - it's about compromising the
integrity of my buildslaves (which could then be used to do anything,
like "host malware downloads" etc).

Is this a very likely scenario, and likely to go undetected?  No :-) - but
still, I'm not opening these systems to Joe Random and his friends.

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--un9Em1h3RhnB9zF/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBV1abv6kuBuNlUUl1AQJ2vQP9Gcp2XIP/fteIUNFaWAVjO6UmyKp+f7RR
iungciIlkBOEAuCmWw1qOqlFOI+KbyGJ+cGzA2nRcxLJhspcnsYlIi8B0KfNLfGs
AZrjNhgoUFv6Nj8tw0vgM3lYw+MyJhkzMLo3QymD6q9scYahuIGFCK/YlkEKPCKs
EMG0sxrgmWQ=
=kC8q
-----END PGP SIGNATURE-----

--un9Em1h3RhnB9zF/--

