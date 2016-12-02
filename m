Date: Fri, 2 Dec 2016 12:28:09 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20161202112809.GA78624@...1296...>
References: <1480542696-7123-1-git-send-email-selva.nair@...277...>
	<201612010821.uB18LTdC072864@...2054...>
	<CAKuzo_ix65GDUitzwTdFhCPm5Gyd6NjtHG0+78Rnu_fPmPUvuA@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yaap9KN+GmBP785v"
Content-Disposition: inline
In-Reply-To: <CAKuzo_ix65GDUitzwTdFhCPm5Gyd6NjtHG0+78Rnu_fPmPUvuA@...278...>
Subject: Re: [Openvpn-devel] [PATCH applied] Re: Do not restart dns client
 service as a part of --register-dns processing
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva Nair <selva.nair@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--yaap9KN+GmBP785v
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Dec 01, 2016 at 05:25:49PM -0500, Selva Nair wrote:
> Do we want this in 2.3.14 as well ? If so I'll send a patch with service
> part removed (note to self: remember to include docs and Changes.rst edit=
s)

My gut feeling is "leave 2.3 as it is, this could actually be *necessary*=20
on XP".

We're so close to 2.4 release that telling windows users that run into
this issue to "just upgrade to 2.4, it will no longer restart dnscache
*and* brings lots of more goodness anyway!" can be done with good faith.

It's not like we've had tons of bug reports about that so far...

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--yaap9KN+GmBP785v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJYQVrIAAoJEB2Cnv7KVigSgHcL/2TeTPwH31vg9db89Kb3L2j7
AFS1rd6YAMjVoGkJO5Rf6H2a7KLMYpBumgyrmMkWrUpFN3noZYbbPPCm5MV3Mk3k
7iemJRvWuUCp/IlvoXpA+p1Gyl3QK9vOIZT4BTDpa/h4CReIh90VDf1T5SvvVYnr
wGApdTgMJqwEUsbOx5QEQQie1QA07SBH8gYFjJno3RdzHJzWiwtG8elMsHTvqPVr
T2+LRXbUBpgYcXYmppj0C2kdCjRqp9tOJP/+GJo30fB75HOqORowFCdyAD7E+W80
BQSe8xASm9jNe5+9gM3GJuiw3BAX5FEQ6vqcRAb+9vG+vSMHp/I2nda3uR3TmPHf
zR8l6rhxRCuPFlcfy0F7H6r0dJUO/RGhJSPFQh7JQhizOColFzwl7ceu92Px2Ap6
1Q2mtai/L1Berdi+wCyY10flB8+qunJ3lvwkJLxY0u802F84XDcbw1iDj1qoqjJQ
j3Jtxp7oN5L0766nmsaUa81e5Bi0goW3eog2fj3y2w==
=Tstq
-----END PGP SIGNATURE-----

--yaap9KN+GmBP785v--

