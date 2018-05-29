Date: Tue, 29 May 2018 21:08:50 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20180529190850.GK79551@...1296...>
References: <1527587707-21417-1-git-send-email-lev@...515...>
 <1527594447-10710-1-git-send-email-lev@...515...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="suroagWEfFHnktSq"
Content-Disposition: inline
In-Reply-To: <1527594447-10710-1-git-send-email-lev@...515...>
Subject: Re: [Openvpn-devel] [PATCH v2] Improve "recursive routing" warning
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Lev Stipakov <lstipakov@...277...>
Cc: openvpn-devel@lists.sourceforge.net, Lev Stipakov <lev@...515...>

--suroagWEfFHnktSq
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, May 29, 2018 at 02:47:27PM +0300, Lev Stipakov wrote:
> V2: style fixes
>=20
> - print protocol, source/dest addresses and ports
> - mention "--allow-recursive-routing"
> - add possible usecase to manpage
>=20
> Trac #843

I'm not sure I'm convinced.  This is quite a lot of extra code for
an "add a few extra fields to a warning" enhancement - especially
given that those that are already confused by the warning today=20
will be more confused by "more numbers"...



> @@ -1094,7 +1099,7 @@ drop_if_recursive_routing(struct context *c, struct=
 buffer *buf)
>          const struct openvpn_iphdr *pip;
>=20=20
>          /* make sure we got whole IP header */
> -        if (BLEN(buf) < ((int) sizeof(struct openvpn_iphdr) + ip_hdr_off=
set))
> +        if (BLEN(buf) < ((int)sizeof(struct openvpn_iphdr) + ip_hdr_offs=
et))

In addition, these changes look funny.  The existing code style was produced
by the scripted big code cleanup for 2.4, so there should never be a
reason to change the style in a patch for "master".

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--suroagWEfFHnktSq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJbDaVCAAoJEB2Cnv7KVigSf7YMAI9TH72VYJkJ759mOLUVQXos
3HHiDlpdVgKPDxAeZyYOUsmIjCf1DRWD5OAuRw9lrBRGU1s5DNuiu1t8LO9xYd9K
ppQG+WqBG2mhgvApVv4ULkAMH9wcDNm7lw2HkYCbRT2XGvS5XQJ5ttRb7W5q3MA8
CPR8Gjhh84Svp53vahulJsyhQfVlZOaf5BmDZ72+3hCt+UBM5axBOVrwzM6XUJBc
l9RQ7GtNnzElRnr7RBAgijfJJWli5qUpSaCH+5O0f5KUP1B5Se+56hyAZE66hox2
Q+VWS0Tt9l5HP4k6SWsTlNFc7QZWY5g849oLwCkOi3vZUWvfKOA7GcfWXYJP1OVx
QEC/sYvmIdABYVXgeO9IFa5pPgUP4deKk3EgyjwBcgd1rMuod7+YkIDSR0Zw7GOG
RxhUXHpCUfH9lXYlFy/OTpNBEpj2t4ly9Z4ODdQMt4wq4/+FwC0QVA2zYOaTtmd3
JxEle2v2Uw1+9XGxQrAbkG608vVR6bGj/q5Geq2o8Q==
=ae92
-----END PGP SIGNATURE-----

--suroagWEfFHnktSq--

