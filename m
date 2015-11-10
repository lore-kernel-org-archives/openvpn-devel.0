Date: Tue, 10 Nov 2015 20:48:53 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20151110194853.GR24952@...1296...>
References: <1397645317-20116-2-git-send-email-Holger.Kummert@...1516...>
	<1404459325-11064-1-git-send-email-Holger.Kummert@...1516...>
	<561D8BCF.60304@...1856...> <563371FD.70206@...1516...>
	<CAA1AbxKuF3ewuhn_XTvymCfq_my8vqK+-Q1mj59VBZp4jOK7VA@...278...>
	<563379B3.90905@...1516...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="i/CQJCAqWP/GQJtX"
Content-Disposition: inline
In-Reply-To: <563379B3.90905@...1516...>
Subject: Re: [Openvpn-devel] [PATCHv2 1/2] Get NTLMv1 and NTLMv2 up and
 running
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Holger Kummert <Holger.Kummert@...1516...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--i/CQJCAqWP/GQJtX
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Oct 30, 2015 at 03:07:47PM +0100, Holger Kummert wrote:
> Am 30.10.2015 um 14:58 schrieb Steffan Karger:
[..]
> > Seems I forgot the * before the second msg_bufpos, sorry.  msg_bufpos
> > itself is a pointer indeed, but *msg_bufpos is (used as) an offset
> > into msg_buf:
> >
> >     memcpy(&msg_buf[*msg_bufpos], data, msg_buf[sb_offset]);
> >
> > msg_bufpos (without the *) is not related to msg_buf.
>=20
> Ah, then your first proposal makes sense
> (i.e. if (msg_buflen - length < *msg_bufpos) )
>=20
> We could take that.

So, how do we move onward here?  Holger, can you send a new patch (set)=20
incorporating Steffan's comments?

Since we found a proper reviewer now, merging this looks possible, after
all the time... ;-)

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--i/CQJCAqWP/GQJtX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVkJKI6kuBuNlUUl1AQKOXgQAoaYMKVajJEkn2WXStHFOb5GNiWYlAOnp
7tkiOqsxX+8vocS3uw9XDdMmqaEgbGhVk9oM3DKj7FuL81jrvappcKafwLba3Wtx
rxMnwiThSHKq1wyN5IkaumleOwzAEV/fuFnIL7m1Yxt64bL+VbkTulBleZqtecpP
0QPZu8jUNlg=
=m4Q5
-----END PGP SIGNATURE-----

--i/CQJCAqWP/GQJtX--

