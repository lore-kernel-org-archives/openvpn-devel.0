References: <20200922004005.10268-1-themiron@...2010...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <75c379c2-35da-da12-d21f-44b1d6b1065b@...1227...>
Date: Tue, 22 Sep 2020 10:41:26 +0200
MIME-Version: 1.0
In-Reply-To: <20200922004005.10268-1-themiron@...2010...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="qtMAPexoNBt3GtpcKe5qCpuxu5mQrIEzr"
Subject: Re: [Openvpn-devel] [PATCH] Fix update_time() and
 openvpn_gettimeofday()
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Vladislav Grishenko <themiron@...2010...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--qtMAPexoNBt3GtpcKe5qCpuxu5mQrIEzr
Content-Type: multipart/mixed; boundary="Hx9ByXE9wVGZizXZ4cBgNaTXKB03OaUE4"

--Hx9ByXE9wVGZizXZ4cBgNaTXKB03OaUE4
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable


> --- a/src/openvpn/otime.h
> +++ b/src/openvpn/otime.h
> @@ -78,13 +78,9 @@ openvpn_gettimeofday(struct timeval *tv, void *tz)
>  static inline void
>  update_time(void)
>  {
> -#ifdef _WIN32
> -    /* on _WIN32, gettimeofday is faster than time(NULL) */
> +    /* can't use time(NULL), now_usec needs to be updated */
>      struct timeval tv;
>      openvpn_gettimeofday(&tv, NULL);
> -#else
> -    update_now(time(NULL));
> -#endif
>  }
>=20=20
>  #else /* !TIME_BACKTRACK_PROTECTION */
>=20

I am hesitant about this change, it mentions that gettimeofday is faster
on Windows than time(NULL) and we prefer it there for this reason. But
that also implies it is the other way round on other platforms. The
update_time function is called in multiple critical places. Do we have
any idea about this? I remember vaguely that the default gettimeofday in
FreeBSD is more accurate than the Linux variant (involves a kernel call)
but you can request a version similar to the Linux one by some flag
(reading from a shared readonly memory page that is read only).

Arne


--Hx9ByXE9wVGZizXZ4cBgNaTXKB03OaUE4--

--qtMAPexoNBt3GtpcKe5qCpuxu5mQrIEzr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE88wmPb+Azu8xbws3FRhsZwKxRFQFAl9puLYACgkQFRhsZwKx
RFSs2Q//TZH/j56hjkemXLswHJ+hosAGm/IdbtF7ttlu19eqfJ4zZX8pGmLUDjts
c8oS5FWUxOV2hWYmIetVeOj9Qt8EEtM3hX1RR6a32BPzGtljIMkWT9KWvsDsLlVE
piWf/GRaZzmZ7cQ0iHhxk61x36nrCNaLKfjyG3KSo3NP2N6Wdgn8piEaXGArthoK
eHNhxAYz1VemlTASuuFOMD08XI7u5BDRPTtaZdClXA/ACXO6N4F0xMuZUrG8LG/K
IFX34GOnF9uESclqA15/XeD4ErImA5c65+L9mykVPRhTSd9y8TqoWcCxs9ZsSEPc
DXuMgbc/ciTYXUUt1gUt5hj1XbRpafRmSjDqKkkWpSq90AFoWfmNAE63NfeRNduI
RBl/Vwi+0f5FkjeYoyzDCmR6eZ2Fj4UB4oi3NAJydC3+ak94EDDpxpDIGn54oyfs
0smFW14/hZm52By3eUUE+5oxo2HElLcuSpIlhK+6jAvavfFF/HraEEF0pZOFS78Q
hFCtQG2f39uVKXKLcOnttKqIT3hn8PfeVi9qVXnHI8QS0dqxeAbaT+aRtRCl7Wer
4CpH5sQAXXvDtN0NuJFU+/dPbKuxgs3A0IkM3UPrm/jH2y7WhwB6hmpDzT2uJVtK
vo5hUbIxY+vEfyWxN/cqFMCjcQvyJzjzKqgh4u0SJ/U9HxLt2BE=
=2+1N
-----END PGP SIGNATURE-----

--qtMAPexoNBt3GtpcKe5qCpuxu5mQrIEzr--

