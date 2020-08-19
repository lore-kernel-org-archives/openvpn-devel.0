Date: Wed, 19 Aug 2020 08:03:27 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20200819060327.GE75094@...1296...>
References: <20200818063212.GW75094@...1296...>
 <CAKuzo_jEGvTnkbsgJVm5beW5SapWoy_xLk_LA+-N59oa6SbbkA@...278...>
 <81A6F618-2F74-417F-A476-BF290CCFF143@...277...>
 <20200818181820.GZ75094@...1296...>
 <2F7C4631-7E3C-47FB-BC8E-E4271F38AD9F@...277...>
 <20200818192104.GB75094@...1296...>
 <CAKuzo_h2hLeQodHsJ7uzetq_XeGPJiu3i-o2tXuL29HbJcG6bA@...278...>
 <20200818194248.GC75094@...1296...>
 <CAKuzo_jG-NOqD4wHZ1SL-2Ti5NgocUDzSOpV5yqMaTXZ2UXVrA@...278...>
 <CAAWBBYPby1vNtcmqy32=jJbVO=vxaZuHphjR4UxJfS9pOAMc-Q@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="pssgfZQbIK00CPi6"
Content-Disposition: inline
In-Reply-To: <CAAWBBYPby1vNtcmqy32=jJbVO=vxaZuHphjR4UxJfS9pOAMc-Q@...278...>
Subject: Re: [Openvpn-devel] 2.5-beta-1 Wintun requires SYSTEM privileges
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Rafael Gava <gava100@...277...>
Cc: Selva Nair <selva.nair@...277...>, Gert Doering <gert@...1296...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--pssgfZQbIK00CPi6
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Aug 18, 2020 at 07:30:12PM -0300, Rafael Gava wrote:
> Inspecting the wintun interface through the properties I saw that on the
> TCP/IPv4 Properties the default option selected is "Use the following IP
> address" but the IP address and the Subnet mask were empty. Should that be
> a problem?

No.  OpenVPN will set what is needed.

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--pssgfZQbIK00CPi6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJfPMCuAAoJEB2Cnv7KVigSVT8MAK2kdghg7gZ68NlGbR2Rs/DU
4sa0VUlgYbSx0RsGvT9FCgeil+/qBHDfLNSYjGPPd9oD9qwqdD7NGTBizpsEmQQo
TCfCAOUYP8dEjydrDNRuXhtC+t0w054NscnoJA+GuWPdmdUHRmXMovKCBUUvIQO0
um4kSnprt/Ktx4qu/uYGgVZgjjBvAdIAw+mfTSfuj6eGUu6dEE2QjXvUO3Bg34j4
5PWefbu/ZsB2RJozVYjn/uTtUcB9QUboNO6oD6Is+TV9agcaCOwJuRvKiIHYF8pP
iEwKrl0YFuFanmLEF+NPG52Ac3zc7pQsRR5H3DITy3mSW8gEAtWmXzGmP0hbh0At
iBpRNo3NSfZAPsd4YBu0cFN4SvnAUs8bYuyeismqWNK51GvnXtTZmTeMTW4tlu0q
KXh7SLxRkUDYFCYVSra23gDqrx0JW6BqJ4LDp5Wl51uytxZqX2OVx8uw1QW/PjeI
nOQ6JbRVxN7ZpITqzbQ6bqhORQWvcygf9WdAw9ZUrA==
=f1em
-----END PGP SIGNATURE-----

--pssgfZQbIK00CPi6--

