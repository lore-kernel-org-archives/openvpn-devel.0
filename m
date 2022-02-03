Date: Thu, 3 Feb 2022 17:57:13 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <YfwJaQO5eU4KkSDO@...1296...>
References: <20220101162532.2251835-1-arne@...1227...>
 <20220101162532.2251835-10-arne@...1227...>
 <YfvY/nkJOQ5qS8hG@...1296...> <YfwFRFzA0063yY9R@...1296...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="QYlEAZvcPMmZ+nzJ"
Content-Disposition: inline
In-Reply-To: <YfwFRFzA0063yY9R@...1296...>
Subject: Re: [Openvpn-devel] [PATCH v3 09/14] Add mtu paramter to --fragment
 and change fragment calculation
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net

--QYlEAZvcPMmZ+nzJ
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Feb 03, 2022 at 05:39:32PM +0100, Gert Doering wrote:
> Maybe this is a transient effect which will disappear when all of the
> patchset is in... trying this next.

This is transient.

12/14 ("Replace TUN_MTU_SIZE with frame->tun_mtu") makes the code
return to "the ifconfig mtu is 1500 unless --tun-mtu is used, in
which case it uses exactly what is configured".  It needs 13/14
("Remove frame->link_mtu") to compile, though.

So we have a patchset that introduces subtle brokenness for
06+07+09+10+11 (breaks t_client, so might get in the way of bisecting),=20
compile-time brokenness for 12, and back to "everything works" in 13.=20=20

How shall we handle this?  (Discuss on IRC tomorrow)

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--QYlEAZvcPMmZ+nzJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJh/AlpAAoJEB2Cnv7KVigSICMMAIgK2Z4HTR3/LnDqKhCegrXF
VkNBYf/J9AcdOX5XQfErd/pwVqoLXT/m4bM4XbzVm11V1D1GLoktFm95dc2wQ+1W
kJvE8caZH1Gm7aDJR2tfv7wBi57btcXcN6SO321JuaxkfRWICY+JCKSJ6nJj3H3Q
EuYIiqZznB3jLATwz3nmm96eHkjAURYSdjU7Q0TPHqd9ughZbDJZsxOvUeIKr13P
ysml8df0BI0WJlRv9kk+2YYtIKRIWmZqyjti80EeCRwQSsVvZkVObg1V+W1CpSaJ
O5/Erbt3t2VbbeDE60O3e3+jsI5/esy+FPubo2B9jV3+yOPhIVUKUXyp+oCye7K4
GGErtTTJMslmHziOORMw52SB8jJ3q/87ub5xAaU0yhIrEP+lJ2mJSq7fF4pTAA6+
QVGnnpN3tNSONv96FSl/lGlrb3RJUUpgMRAXgeYa7bp+x/xw+TPQBG7xzEpbFPCU
AxVanhcSNn1yrk9PZ99ydYzQqFJ1oHDnJV1MRKZQFg==
=wqnq
-----END PGP SIGNATURE-----

--QYlEAZvcPMmZ+nzJ--

