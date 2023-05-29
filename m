Date: Mon, 29 May 2023 21:07:51 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <ZHT4Byn9GUBRl8oX@...1296...>
References: <20230128215901.2207208-1-selva.nair@...277...>
 <Y9jx+xrcrids9fgk@...2685...>
 <CAKuzo_i898TWdDNEV+MeaBWQneCqsemp7CmkzOwsnFXwzU9KPQ@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="ZyDpscN2oCLoJlrl"
Content-Disposition: inline
In-Reply-To: <CAKuzo_i898TWdDNEV+MeaBWQneCqsemp7CmkzOwsnFXwzU9KPQ@...278...>
Subject: Re: [Openvpn-devel] [PATCH 1/2] Improve signal handling using POSIX
 sigaction
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva Nair <selva.nair@...277...>
Cc: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net

--ZyDpscN2oCLoJlrl
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, May 25, 2023 at 02:41:10PM -0400, Selva Nair wrote:
> Now that 2.6 appears to have reached a fairly stable state, may I request
> you to look into this patch for 2.7 -- this one has an ACK (thanks to
> Frank), 2/2 may need a closer look but that one is small.
>=20
> I dread the prospect of this developing serious merge conflicts and having
> to drill down into the details to resolve them. Right now it looks like no
> one has yet touched related chunks.

Will not really have much available time next week, but I have heard
the message - will look into this the week after.  If not, please feel
free to send me another reminder.

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--ZyDpscN2oCLoJlrl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJkdPgHAAoJEB2Cnv7KVigSOB8L/Rbh0zaEu+GrdUu+T7h+VIS2
hR+gTo6jpwKBxdNRmIeEfD2aybgvQqcMP8GruxcB1lVaMBsAvxjxeKMtjvvVM5Jy
06HNG3hJRvPaq55HEkhxim6N6o0XU4h8TVKIt3JNd+wzULE0G+xr5f1xyysYTrfV
r88MzFeeYLs7AP3SPMdEZH2bOAuCR2PAnThjs1szWwWRfRbB8zdYeLEIlUdBhVDV
RGtg8fPnUNLJqYv6abhwEWIFlWtGHq0rwU7W8jRd8+oP94Hiorm1YxkWeaScaUY1
7ocyNVd6oCv6q7DEuPODNIJ3g5w2Yhs3rsOLZnx1A9d4NWBWDvlE0S5vI4d1vxyQ
yH8LqzACWyas27w7KAosQ1+WCbmnl7HMVA75dywilTI24g+yG1WgkrQvI93buti9
EQKJs49N5hLwEtVTeBdmnZuOUTycrQeboHYfKC9GWzAnnRsZlwz2OhdbA969/teK
CwurMxmUaoj7ZtR8XQTeHYQ0iaU5vnsl1vbwI31vxQ==
=+612
-----END PGP SIGNATURE-----

--ZyDpscN2oCLoJlrl--

