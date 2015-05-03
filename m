Date: Sun, 3 May 2015 13:51:44 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20150503115144.GD382@...1296...>
References: <1430645018-21324-1-git-send-email-steffan@...1856...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="RvYRPxT9kmUw5evD"
Content-Disposition: inline
In-Reply-To: <1430645018-21324-1-git-send-email-steffan@...1856...>
Subject: Re: [Openvpn-devel] [PATCH] polarssl: remove code duplication in
	key_state_write_plaintext{, _const}()
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan@...1856...>
Cc: openvpn-devel@lists.sourceforge.net

--RvYRPxT9kmUw5evD
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sun, May 03, 2015 at 11:23:38AM +0200, Steffan Karger wrote:
> Both functions had almost exactly the same code.  Instead of the code
> duplication, have key_state_write_plaintext() call
> key_state_write_plaintext_const() to do the actual work.  This is just
> a bit of cleanup, it should not change any behaviour.

I'm somewhat lazy so I just complain instead of searching... "it does not
apply for me".

Applying: polarssl: remove code duplication in key_state_write_plaintext{, =
_const}()
error: patch failed: src/openvpn/ssl_polarssl.c:828
error: src/openvpn/ssl_polarssl.c: patch does not apply
Patch failed at 0001 polarssl: remove code duplication in key_state_write_p=
laintext{, _const}()

(most likely the context differs enough in your tree - could you rebase
to master and resend, please?)

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--RvYRPxT9kmUw5evD
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVUYL0KkuBuNlUUl1AQLhWwP+Ml2t7Ikq1FRwqiSySA1ujrROYFoUJSGr
N6sghVznfXCwX6yHtnfgQhWRdjDgiBGHJAJS9kmO1rY9Q04oS+pgXk315QAzMoIf
bFD0GTbKh40FVoJ+gE9xm5N7g5caOz+YfbDXRw8Gdvyrg31RQ6BGZaiL3xEYeDrl
++z400PAbRE=
=Z+yJ
-----END PGP SIGNATURE-----

--RvYRPxT9kmUw5evD--

