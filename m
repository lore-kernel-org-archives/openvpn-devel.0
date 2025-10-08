Date: Wed, 8 Oct 2025 10:16:28 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <aOYd3LR8qNpYx9W-@...1296...>
References: <20251007202816.27730-1-gert@...1296...>
 <202510080814.5988EF17075991@...2054...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="9Nh1SUe4L3jyQ33Z"
Content-Disposition: inline
In-Reply-To: <202510080814.5988EF17075991@...2054...>
Subject: Re: [Openvpn-devel] [PATCH applied] Re: Document that tls-crypt-v2
 can be used in connection profile
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan@...1856...>
Cc: openvpn-devel@lists.sourceforge.net

--9Nh1SUe4L3jyQ33Z
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, Oct 08, 2025 at 10:14:15AM +0200, Gert Doering wrote:
> Good to hear from you :-) - and such a nice patch, not even a one-line fi=
x,
> just a one-word addition.
>=20
> (And indeed, the code talks about "ce", so it very much confirms what
> you wrote)
>=20
> Your patch has been applied to the master branch.
>=20
> commit d19e431b3102a511136befa7c3b8fb6a28b89f54
> Author: Steffan Karger
> Date:   Tue Oct 7 22:28:10 2025 +0200

Meh.  Due to the mail-archive org issues I need to --amend my commits
and the script that pre-generates the mails does not know that.  So the
right commit ID is

commit 7fa59cdf0c38972bdaa9d9106e78f468179d6bff
Author: Steffan Karger <steffan@...1856...>
Date:   Tue Oct 7 22:28:10 2025 +0200

    Document that tls-crypt-v2 can be used in connection profile

(same change, different commit message "URL:" part)

Sorry.

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--9Nh1SUe4L3jyQ33Z
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJo5h3cAAoJEB2Cnv7KVigSfjgL/0/2Mc9PhhdnjGSuHsmtwUKX
0+TdpfO3cRStFCH8L7SnBg0cFiPjMzU8//e2DSYhzng0jTvfoOD+JHQAWgz+GnT7
5Urkthuwx7DSBvoGhQ7ZFHMOv9IDlNGfA7BdCpR14RSw/oH5Uael0QHx3bNQn34o
zjs9nCzc7Qn2LRUBgWdhGDDy6Cc98pY32eIdt1cFVpCfD5MqxbixeM+FGfi+0qSq
nWcmDPdvJyA3COVNSh14lFY975X8uTasFkKaVMcbW4ar53vPezpISsCBonD34dMk
A1deQG4PwtJKHMI2T9AxopYtGr3PHe0tCA3bMBJdFJ9eiic/W2Dsw/CDIG2i97is
8QQu/AOQVZe7zeHUf1itNR14Cy7hNE+QlaYVqgSi6R6q9H3GEWvG2YQBPiAMlfLA
eGkwLwYxujEoAoNShvIkSyuA3QtkLrp/9YVVZ07/8GqzUKXqo7b2geGYdT2/cq3y
BFHbd9EDP918BU4R8EpxOQdkQle7OZhmXF8RIQJoBw==
=Knde
-----END PGP SIGNATURE-----

--9Nh1SUe4L3jyQ33Z--

