Date: Fri, 15 Sep 2017 18:14:20 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20170915161420.GN70062@...1296...>
References: <1505450463-459-1-git-send-email-selva.nair@...277...>
 <20170915154011.GM70062@...1296...>
 <CAKuzo_iHmRi9t2fANHy+GBZsLPWZzgXyBBgmsF9hJeToOvAh0g@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="trRLnZT3leHHTjS+"
Content-Disposition: inline
In-Reply-To: <CAKuzo_iHmRi9t2fANHy+GBZsLPWZzgXyBBgmsF9hJeToOvAh0g@...278...>
Subject: Re: [Openvpn-devel] [PATCH] Check whether in pull_mode before
 warning about previous connection blocks
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva <selva.nair@...277...>
Cc: Gert Doering <gert@...1296...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--trRLnZT3leHHTjS+
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Sep 15, 2017 at 11:53:59AM -0400, Selva wrote:
> No it doesn't change any functionality. By not including OPT_P_CONNECTION
> in the mask sent to verify permission the previous connection blacks check
> is disabled.  And this is done only when pull_mode is True.

I was totally misreading the code, apologies :-) - now I read up
on what OPT_P_CONNECTION *does*, and it's not a "normal" flag for
"this is not an acceptable option in this mode" but a "warning if..."
one.

[..]
> The key here is that check pull_mode to know that we are processing a
> pushed option.

What about moving the pull_mode check into verify_permission() so it
applies to all pushed option that could trigger the warning (as Arne=20
pointed out)?

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--trRLnZT3leHHTjS+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJZu/xbAAoJEB2Cnv7KVigS1YwL/1mUzX7Q7c2gPWp56MSMakKX
PyrZnjeIpW5cYM1u1UmPQX01TW6+XeEMfzRIaoFd3jUxaqD9c38rQdqa9RqQhSv0
gpmn/izNPvGX99Zfm2UsvOIVwDAcarzdtAn9mldGE/9jDYdMjFtdw6YnR0DxyTi8
pkfuImXalSyfPXjwmUWQnOWyegzkFH6Hy9hWHeR8DHhcYgcvahP9gyw+AbMFsyJu
np+vICPUNS0vK+FrXnRwVxVGUgWN6yeI8sKPkjy2giAEO6Trb+W0rlSY7lVmPjWX
MECJnZA2UrVervKHrORH7C0c9VzvviDV4RjARRxmBo62zpY5LZvw3piUX0RLZnFx
z1MpWr/jXx2hjnmkbcEgE+LnJqxgO2iUQ0mv6I7F5c9cPbl6HrNer20Wii8DCZAV
3rKEmos8YMTf1Fy+65x+D0MpvLSJX5lUGLhbyhRsoq/2wNHKzBVD2OvBaxwNW+tU
bFQXgvWApj2pSmR/Is7l8bQs8VM7ZBS0jkeTw0TptA==
=g5GV
-----END PGP SIGNATURE-----

--trRLnZT3leHHTjS+--

