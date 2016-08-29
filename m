References: <CAHX+n4s+yo18TiCS_G2xLcbRwSh9Ox2vdmS+2c5MJJmaHEsTnQ@...278...>
	<CAHX+n4t4oBqvL7Jee7hjRAp13VKHcHjXw+=AP=6nXXLyjsVqBA@...278...>
	<5311bce1-b384-25d8-8c8c-89d9cbe4ff59@...515...>
	<CAHX+n4sJCs1_YLcvA_QUVd+DqRn_E0pd7fVr+2mQQqrXh3tbWQ@...278...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <c1738e6c-8d1d-a8b3-b167-3038fb3e43a2@...2080...>
Date: Mon, 29 Aug 2016 11:38:57 +0200
MIME-Version: 1.0
In-Reply-To: <CAHX+n4sJCs1_YLcvA_QUVd+DqRn_E0pd7fVr+2mQQqrXh3tbWQ@...278...>
Subject: Re: [Openvpn-devel] [PATCH (master)] Updated build parameters to
 match openvpn-install-2.3.12-I601
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: Bojan Komazec <bojan.komazec@...277...>
Cc: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 29/08/16 11:10, Bojan Komazec wrote:
> Thanks a lot Samuli.
>=20
> I cloned "openvpn-build" repo yesterday and created my patch branch
> off the last commit on "release/2.3" but after reading your email I
> checked it out again and saw that my "release/2.3" was actually 1
> commit behind the origin. I am still trying to understand how this
> difference happened but yeah, my patch is not necessary.
>=20
> Regarding the contribution process, I was reading
> https://community.openvpn.net/openvpn/wiki/CodeRepositories page=20
> which states: "All bug fixes should be developed against the
> master branch, and where it is decided to include such fixes in a
> minor release (2.1.x, 2.2.x, etc), it will be cherry-picked from
> the master branch and into the suitable release branches.". This is
> what made me thinking I should create a patch for "master" rather
> than "release/2.3". Did you suggest using release branch as a
> target because my patch was not a bug fix (but a simple build
> parameter update)?

We have a few different contribution processes, depending on which
sub-project you contribute to.  The process described above is for the
OpenVPN core; which is the part of OpenVPN which does all the crypto
stuff, tunnelling and networking stuff.  As this project is security
sensitive and a bad patch can truly compromise the security, we have
quite a strict regime of reviewing patches before they get accepted
and included.  In addition, with the OpenVPN core we want to have full
transparency in what gets accepted and in a distributed way which
keeps most of the important discussions preserved - even if GitHub
disappears in the future.

The openvpn-build project is more about building the OpenVPN core and
related packages.  Even though funky stuff can be done to the build
process, it is not considered as critical as other components by the
openvpn-build team.  Hence as simpler approach for contributing.  But
still, patches will be reviewed here too before they get merged; it's
just that the mailing list isn't mandatory for this project.

I hope this clarified a few things.


- --=20
kind regards,

David Sommerseth
OpenVPN Technologies, Inc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJXxAKxAAoJEIbPlEyWcf3yQQ8P/1ZgZyMCzinj2cWeaf9H2ACA
mQnOTmml0Bt0ELeZFH2vUDebt7VkkPT9QXivUbKVGkSxk7rvczgxS4PuHRJBRNwZ
OEvitqxQYJLcAQz/OBBKHpYYGQFEBKgaG+CqFqcaeimIr9V4maWExvwF2thqZQyq
eYRzOyYdxs8ZjYRN2JpI61ALfgXzoTG19Z2LBjSKNkkjIxE6g6PY5WYSZm7Vb3i6
BCAbBcGqf4UZeomo+wn7zkhI/5gRr3HQ2UAGHScSFmdrumFqJFgiW6/0xTElIEgs
R3v28hXuU3GNcmT3x2F50G8DJDZOH7t5xoEXckntZ0kASFvcxci7KYLNSAbgZ4rU
J9bhQuASnkKJzTbOXvanK9+Wet22+H1/GbB4lLcl6wnFbT5hZxT/0a3cg15VebYo
7K8MhvElZLK8/NIMX+u8AP1sUjXKCZN1REp8DIQozn9hhnDN+VUVm26YUhTL+jgi
7yxo9ErU9OIIqx4lccX/viLMVLN+f4PNjKqpi5/CzYvQbA1PLMNnhJ1/c9g6bK9D
leauLiKpKqU2Y2b+vO7IIzThdDyvlNwpinlAQa5qQrf1xL0SKksvdmXUYgmwmTwP
YmG14rFhgcHZQng8OZ19sLnQWKo9NQ8Ci1zEvczNBCpWvyDDYi0FzSeX3u+KB9HR
HFByTO1PT6guEm0c1UrP
=3DsZgx
-----END PGP SIGNATURE-----

