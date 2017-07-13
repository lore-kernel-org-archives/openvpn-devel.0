Date: Thu, 13 Jul 2017 08:59:07 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20170713065907.GZ97029@...1296...>
References: <20170713033848.11902-1-a@...2181...>
	<CAFHpkQG_gS9cZdfTDAJGHwApPzgpbCFS6923ysqjU6_AAaG7xQ@...278...>
	<a5f62ded-89be-7115-3f31-b4ee199bdad8@...2181...>
	<2de72e2e-5ccc-992f-505a-41cd00140844@...515...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Hv1ofmZ8iLMRcgIn"
Content-Disposition: inline
In-Reply-To: <2de72e2e-5ccc-992f-505a-41cd00140844@...515...>
Subject: Re: [Openvpn-devel] [PATCH] fix compilation for --disable-multi
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Samuli =?iso-8859-1?Q?Sepp=E4nen?= <samuli@...515...>
Cc: Antonio Quartulli <a@...2181...>, ???????? ?????????????? <chipitsine@...277...>, openvpn-devel@lists.sourceforge.net, ValdikSS <valdikss@...277...>

--Hv1ofmZ8iLMRcgIn
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Jul 13, 2017 at 09:16:13AM +0300, Samuli Sepp=E4nen wrote:
> There were no bugs reports about --disable-multi in Trac. I say scrap
> that option altogether and make the code slightly cleaner and less
> entangled.

I tend to agree with you here.  There are way too many #ifdef in our
code, and while Antonio's patch is technically fine, it adds more #ifdef
for a variant that nobody seems to be using - so that's not the way
to go.

P2MP_SERVER seems to have some uses, to be able to compile a client-only
binary for really small systems.  So I'd keep that one, plus the associated
configure options.

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--Hv1ofmZ8iLMRcgIn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJZZxo6AAoJEB2Cnv7KVigSV8YL/0G4o+OCQszaEfeQwy/yeaI8
6LtYXWUUkjDPD72xt3GCwrOt+bSRRklQe9gfPeyB8qL4Pu+Hpvy5b17SlGEgZr3W
8NYxrv3MtHJWlizNzKxLaGPBjCl9SyD6JoAnZfKzYrVg5LCpjv7vTouH1fg9zIOo
b4HDLv5lRFFv3v+uyKxHyQasysxQ9umSYadPiAttd4k1nU14Bzv2YRWralSb+cgt
6eyJvARr3uZh0ioBXegcGth+MRIVcA//iuh9o6XylsdEswhCJBwqEeXXVW0f8+Tw
cyXXr0mXFwQQj45chds2msRJiF80IZXOBxdrOKLXiZO/L1c09glEPZ7Nh2gC5GRH
qIgkPr+p9K89NaojE4y6uRmPgEYWSao4tQdBOJroogDJZ4CojE7yv+f9BrvdFf2x
XTsUM3ldJ9+HUBq6jqo+owF6oN1+QXjzyLE1vjqraQt1vayKew7rsSFbv8U6y/Xa
pNCdeO/cdLacD3PIQwCkZK6QhG3d3+u5CZT33nN2EQ==
=bh+l
-----END PGP SIGNATURE-----

--Hv1ofmZ8iLMRcgIn--

