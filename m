Message-ID: <53579352.2000900@...1227...>
Date: Wed, 23 Apr 2014 12:17:54 +0200
From: Arne Schwabe <arne@...1227...>
MIME-Version: 1.0
References: <1398064204-26476-1-git-send-email-james@...515...>
	<1398064204-26476-2-git-send-email-james@...515...>
	<53550084.2070404@...1227...> <535570CB.8010005@...515...>
In-Reply-To: <535570CB.8010005@...515...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="bEfI3RVdCOmuf6kL6dIntQGPNN9kMXsOv"
Subject: Re: [Openvpn-devel] [PATCH 2/4] Added PIP_OPT_MASK for
 process_ip_header fast exit path.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: James Yonan <james@...515...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--bEfI3RVdCOmuf6kL6dIntQGPNN9kMXsOv
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

Am 21.04.14 21:26, schrieb James Yonan:
> On 21/04/2014 05:27, Arne Schwabe wrote:
>> On 21.04.2014 09:10, James Yonan wrote:
>>> Define PIP_OPT_MASK to represent all flags of interest to
>>> process_ip_header, so that it can have a fast exit path
>>> if no flags are set.
>>
>> I haven't look at the code but if remember  correctly, this method does
>> not get passed the actual flags but the flags should *potientially* be
>> checked.
>
> Yes, the point is to aggregate the potential flags of interest to
> process_ip_header under a single mask, i.e. PIP_OPT_MASK.
>
> So instead of having "if (flags & (PIPV4_PASSTOS|PIP_MSSFIX|...|...))"
> you just have "if (flags & PIP_OPT_MASK)".
>
> The main issue for us is that we have an internal patch for one of our
> services that adds an additional flag, and the previous usage is a
> merge conflict attractor because all the flags of interest are
> explicitly given on a single line.
>
I only wanted to point out my patch also exits. I looked at the code again.

I think to really get rid of the #ifdef here we also need to
unconditionally enable the other &=3D ~ statements:

Change

#if PASSTOS_CAPABILITY
  if (!c->options.passtos)
    flags &=3D ~PIPV4_PASSTOS;
#endif

to

#if PASSTOS_CAPABILITY
  if (!c->options.passtos)
#endif
    flags &=3D ~PIPV4_PASSTOS;


Otherwise if the function is called with PIPV4_PASSTOS but not compiled
with PASSTOS_CAPABILITY the

flags & PIP_OPT_MASK will be always true.

Arne






--bEfI3RVdCOmuf6kL6dIntQGPNN9kMXsOv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlNXk1IACgkQe8+cMNS4zReSMwCeIiyUrZnq/VZE+ukoMFhDBSHC
VHMAoLdlBRuw4KqDNYXC5qS2PUcIcUph
=QofX
-----END PGP SIGNATURE-----

--bEfI3RVdCOmuf6kL6dIntQGPNN9kMXsOv--

