Date: Sun, 18 Sep 2016 17:44:35 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20160918154435.GZ78279@...1296...>
References: <1474208364-11251-1-git-send-email-chipitsine@...277...>
	<2ea62e71-fe65-714b-2a2e-27bfa8f480eb@...2080...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="koJ9MZU/OzzcQkbd"
Content-Disposition: inline
In-Reply-To: <2ea62e71-fe65-714b-2a2e-27bfa8f480eb@...2080...>
Subject: Re: [Openvpn-devel] [PATCH] cppcheck finding: add "ASSERT(
 maxoutput > 0 || separator != NULL )" to prevent possible null pointer
 derefence
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--koJ9MZU/OzzcQkbd
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sun, Sep 18, 2016 at 06:14:09PM +0300, David Sommerseth wrote:
> This looks dangerous and somewhat wrong.  This can actually stop a
> server completely if the ASSERT() check fails.  I'm not sure we want
> to do that.

This was discussed in a github PR, but I do not have the number right
now.

Basically, we *know* that we always call this like this, but if we should
ever call it differently, the alloc_buf_gc() call will lead to funnies
- thus, better ASSERT() in that case, so it's clear the calling contract
has been violated.

> I do see that there might be an issue if separator =3D=3D NULL
> (strlen(NULL) will segfault), so this needs to be checked far more
> carefully and compared against all the callers of format_hex_ex().

See PR :)

(And yes, if things are discussed in a PR and patches get then sent
to the list months(!) later, it would be useful to actually mention the
PR in the commit message - "commit --amend" before sending)

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--koJ9MZU/OzzcQkbd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQCVAwUBV962YqkuBuNlUUl1AQJk+wP/UP1TnhpzoMgcCqt9u5ez7ZsQIDxJybra
KQRAsEyQei7alWP9k6WqmO4qDl+oUD9KMQfLboFS9eTz1FG36VDUBwycvXJkixsD
UgGfFt2NJEcM10ACNUTgBpTv1ufEqGm2QrgHnH/PioqLLsG37/1JuHvlNJY7kTgE
nPRyoBKnR+M=
=7IS7
-----END PGP SIGNATURE-----

--koJ9MZU/OzzcQkbd--

