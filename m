Date: Sat, 13 Aug 2022 14:46:54 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <YvedPvy6OUcr5MRm@...1296...>
References: <20220812134154.16729-2-kprovost@...2661...>
 <202208131222.27DCMtaw040249@...2054...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="faxzGmBtCBjrdRnQ"
Content-Disposition: inline
In-Reply-To: <202208131222.27DCMtaw040249@...2054...>
Subject: Re: [Openvpn-devel] [PATCH applied] Re: ovpn-dco: introduce FreeBSD
 data-channel offload support
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Kristof Provost <kp@...1249...>
Cc: openvpn-devel@lists.sourceforge.net

--faxzGmBtCBjrdRnQ
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sat, Aug 13, 2022 at 02:22:55PM +0200, Gert Doering wrote:
> Uncrustify complained about a few tab-vs-space things, which I adjusted
> (mostly in ovpn_dco_freebsd.h).

And promptly forgot to do "git commit --amend" on *both* files.  So
here comes a whitespace correction commit again...

commit 702a4a2c237842bb4adef5de98d82746e5715f78 (HEAD -> master)
Author: Gert Doering <gert@...1296...>
Date:   Sat Aug 13 14:44:38 2022 +0200

    Apply uncrustify changes that were forgotten in the FreeBSD DCO 1/2 pat=
ch.

*sigh*

I need to be away from the keyboard now, and bake a cake for a change :-)

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--faxzGmBtCBjrdRnQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJi950+AAoJEB2Cnv7KVigSEHsL/i+7tEtLSXPf+3h5secNiJzQ
2gPqa7WotOmZgGXzpvWjWWIJloP+Lq3Vr2B0tOcXRGUC2wgtHiu+q+XB2ai3lg71
IYmUBawcfAG8HP4X7jc8Yvjpcs6/6jeUa0pa95WzEQ4XiKi2ha1gt/xi0qv37h9z
K7KBcgFn3v9zwVGZSwedULXoHohf04aISHKPNA/ebKHP1sVmwqFXxzY/ejxBaJfz
o9DF+GUK/8DznXGj4TXpRnrnDkFa+ehUsi0C7p1NsLWXXvaZLjmisSvXljM4Ntsz
d+7B+e+hFClIGyHlssWy7/M/x+0J3jp2KGo6GkdDCy4IUFbS7jVyOjRq5uW8GhmS
5sRq3QEF3Zy/biubSFP5KICAkJ70Snp9N4WZHJPLdTlxusgfZ3SWOzm/j2j5M3Z9
nEXUrmZNxzAZHv6XEKyT7fFoe9jELU0JdlSjsSxpIoPUkkMsDW35nBf27zWfxwmJ
d65471ONXGbswY0kXmqsyTgQG9PLqKHy2wYFHQuyhQ==
=xrbm
-----END PGP SIGNATURE-----

--faxzGmBtCBjrdRnQ--

