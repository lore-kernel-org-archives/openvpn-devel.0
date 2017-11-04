Date: Sat, 4 Nov 2017 18:58:14 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20171104175814.GY958@...1296...>
References: <1509192147.3021.6.camel@...2316...>
 <1509192205.3021.7.camel@...2316...>
 <CAFHpkQHXWrXn42B1xr0YuPvQUrOSvUqQU6h8RkP_EgP_iBP5Qw@...278...>
 <1509289652.3116.11.camel@...2316...>
 <72a75ffb-67df-0986-7b64-9080254cc084@...2181...>
 <1509292633.3116.16.camel@...2316...>
 <d2079a55-a8c4-95be-4385-75d164a9f8c5@...1856...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="EOP8HhwRQvhZjZeP"
Content-Disposition: inline
In-Reply-To: <d2079a55-a8c4-95be-4385-75d164a9f8c5@...1856...>
Subject: Re: [Openvpn-devel] [PATCH 1/1] openssl: add engine method for
 loading the key
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

--EOP8HhwRQvhZjZeP
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, Nov 01, 2017 at 07:24:02PM +0100, Steffan Karger wrote:
> This looks like it should use our user query wrappers from (e.g.)
> console.h.  David, you're the expert here, what should James use to
> query for passwords?

The mechanics are "query_user_...()", most conveniently

/**
 * A plain "make Gert happy" wrapper.  Same arguments as @query_user_add
 */
static inline bool
query_user_SINGLE(char *prompt, size_t prompt_len,
                  char *resp, size_t resp_len,
                  bool echo)

(console.h)

... most notably this is important because it can use "other mechanisms"
if console input is not available, for example, systemd querying.

gert


--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--EOP8HhwRQvhZjZeP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJZ/f+2AAoJEB2Cnv7KVigSjfYMAKTmfo3YeGxe5qqyfc/R25/L
pQj3r3pf/x4ZW9kPvu/thjmqEg4ULag4uGH6frzBCYtLBRMKuKuyzlzR4C7HQ96d
9aQY0T/BrCReUXam/O1OPS9Dc+zhkM3Ri75bYsPwIaAdlxPr7/YjZPDW07bxCr/9
TccFtwLkSy4MzCQggN5QVXvgZlkC0FTMzTZ3ySRk4J8qBO6Lv3dwN8zzHHcbAOVG
2xNJKkjQrurj+TrBc43w2ZAyL8iSyEgn8OLWyOyQqxbmZ8vbF+AH9vqUgP3ReB5R
GnB9VAkD+ABPLRCXvCcXiM6S2+xjeuIk1vZt7BuRKFgybyiIxCqQ9lFZbQzq42C4
AuW8fZDJVW4vU5nr3eWPFWmGWiNEjrZGUeLc+8qOkFH8AIoAIzcUzTK7SnsZBmR1
kLeoS5RILo5s3JuyqAYzGNUlenuBQK6loj31PF7+sFSwpcsGSk6r2k6NXtrISiks
nX63X/ozhr4NQnBeMZXKfysgoLhqHWtjWfGXrlQPMg==
=NqLQ
-----END PGP SIGNATURE-----

--EOP8HhwRQvhZjZeP--

