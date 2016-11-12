Date: Sat, 12 Nov 2016 16:00:47 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20161112150047.GE28918@...1296...>
References: <1476996158-5390-1-git-send-email-davids@...515...>
	<6c3649c3-75e0-df8a-d910-73441af695d9@...515...>
	<a2f226df-89b0-f8de-0af1-225351a90edd@...2080...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bdxr40zIsfYDFWP1"
Content-Disposition: inline
In-Reply-To: <a2f226df-89b0-f8de-0af1-225351a90edd@...2080...>
Subject: Re: [Openvpn-devel] [PATCH] systemd: Improve the systemd unit files
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net
Cc: David Sommerseth <davids@...515...>

--bdxr40zIsfYDFWP1
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Nov 11, 2016 at 01:35:57PM +0100, David Sommerseth wrote:
> We can of course investigate if we should enable systemd to restart
> OpenVPN, at least the server profile, if it dies unexpectedly.
> Currently, I am not fully convinced we want that.

I think this would be useful to have.  Server processes are expected to
be there - if they are not, it needs to be investigated why not, but
with some reasonable delay, they should be restarted.

(I thought this was what systemd was all about?  "Because sysvinit cannot
restart stuff!" - which was never true, but standard rc.d scripts do not
support it)

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--bdxr40zIsfYDFWP1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQCVAwUBWCcun6kuBuNlUUl1AQIeIQQAgsMZTaRB3S7AREY9ciIMeoPpirsCQAbb
1bAqk++WjEaRe+iIWC8gEK/uVkR/KV/nJ+KgC6hZFZJ9h809rEn9ktuhhJO6p0ay
btLXj29/vxpYYt6Rt4h6SV/Tug5YbVKmefWfsZCgjAB2C48126qUxMZiyYjM8AL0
PYHIVvJCaYs=
=x5B3
-----END PGP SIGNATURE-----

--bdxr40zIsfYDFWP1--

