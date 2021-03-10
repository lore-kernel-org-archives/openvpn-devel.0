Date: Wed, 10 Mar 2021 10:20:37 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20210310092037.GA976@...1296...>
References: <CAGyAFMXE66-Tg1f2OMrjTbKYZdkufrAoJJYd_y1CRme-tBQvMw@...278...>
 <20210201150340.19305-1-arne@...1227...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="vMz8+YhKF5X17bEK"
Content-Disposition: inline
In-Reply-To: <20210201150340.19305-1-arne@...1227...>
Subject: Re: [Openvpn-devel] [PATCH v3] Change parameter of
 send_auth_pending_messages from context to tls_multi
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

--vMz8+YhKF5X17bEK
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Feb 01, 2021 at 04:03:40PM +0100, Arne Schwabe wrote:
> This prepares send_auth_pending_messages to be used a in context that
> does not have context c available but also does not need to schedule
> an immediate sending of the message (auth plugin/script)
>=20
> Patch V2: Adjust the comment of reschedule_multi_process to actually fit a
>           function.
> Patch V3: Rebase needed because v3 of 3/11

The change itself is good, and basically just moving around things a bit
(different calling convention, so no more "c" available, thus calling
"send_control_channel_string_dowork()" instead of the other function,
*thus* needing to call interval_action() in the caller, which is easier
if folded into reschedule_multi_process().  So, ACK on the intention.

Alas, the v3 patch does not compile :-( - so "Changes Requested".

../../../openvpn/src/openvpn/push.c:366:1: error: conflicting types for 'se=
nd_auth_pending_messages'
  366 | send_auth_pending_messages(struct tls_multi *tls_multi, const char =
*extra,
      | ^~~~~~~~~~~~~~~~~~~~~~~~~~
In file included from ../../../openvpn/src/openvpn/push.c:32:
../../../openvpn/src/openvpn/push.h:81:1: note: previous declaration of 'se=
nd_auth_pending_messages' was here
   81 | send_auth_pending_messages(struct context *c, const char *extra,
      | ^~~~~~~~~~~~~~~~~~~~~~~~~~

changing of the prototype in push.h is missing.

That said, the patch also introduces two extra blank lines, which I would
have fixed on-the fly - but if you re-send anyway with push.h fixed, please
fix that, too :-)

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--vMz8+YhKF5X17bEK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJgSI9kAAoJEB2Cnv7KVigSiXcMAIozAgEp6nAvIQI0vCvdKeYT
Tdd12DqiHdCLT8KdsqIrXItJ3WwSFAq9+id240oZeju6M+n/2k9L7ZAfcfEWu/MF
z6+nM3lJiH9iQFqXBGge4OPKxsuai8SEugjknMxAcLH7ySWHV77KXGsMghi1XOEd
Su1hOsy9T19DDyVlJK80dfl3lcEdKuXv00QVcMLCrVsJ4gct/cCH9EZKu1PSBQdV
TxXtoc8tlP9hWAt2HseYSFIzOOjGz2qDpkcmDbp8IgvzhbqKurTaVyPgKJhxs/Z/
rIK9Q94qYbmmkNM4nbFGELMn3+a/+qPL/OKtLNaAnP+OAFMEMFVZNtT64lbArX9q
HwZ6NexpsTkI/TvaoScoAeAMy8GNA9jK0B19O+arV6Eq8ARciG5Ctn5xWxM/dJYN
NZeYbtDRUcg6U67tyO0W+KmKuFkXEdSyrjQs7mHeQ0IBcsni5pbWNEkTYj+0+txi
y3T0xydnF6lFR5Ney5Ngv8i5BkiC1cke6/XmF0xCtg==
=E4k+
-----END PGP SIGNATURE-----

--vMz8+YhKF5X17bEK--

