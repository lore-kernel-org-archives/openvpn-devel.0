References: <20201005005114.13619-1-themiron@...2010...>
 <202010051036.095AaG7a076271@...2054...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <ee3da095-b755-754e-07b3-c18c6e6f5c5d@...2080...>
Date: Thu, 8 Oct 2020 20:47:31 +0200
MIME-Version: 1.0
In-Reply-To: <202010051036.095AaG7a076271@...2054...>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="YPkUMEo02ieSmAjWWhr6lZ93KrEvAGujF"
Subject: Re: [Openvpn-devel] [PATCH applied] Re: Support X509 field list to
 be username
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--YPkUMEo02ieSmAjWWhr6lZ93KrEvAGujF
Content-Type: multipart/mixed; boundary="4xTbIHc8S3gKABg30GbiynN3tmEHXDNsw";
 protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
To: openvpn-devel@lists.sourceforge.net
Message-ID: <ee3da095-b755-754e-07b3-c18c6e6f5c5d@...2080...>
Subject: Re: [Openvpn-devel] [PATCH applied] Re: Support X509 field list to be
 username
References: <20201005005114.13619-1-themiron@...2010...>
 <202010051036.095AaG7a076271@...2054...>
In-Reply-To: <202010051036.095AaG7a076271@...2054...>

--4xTbIHc8S3gKABg30GbiynN3tmEHXDNsw
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On 05/10/2020 12:36, Gert Doering wrote:
> After quite some deliberation I've decided that this is "new feature"
> and "too late for 2.5", so not applied to release/2.5 - it was not=20
> an easy decision, as this could indeed be a very useful feature for
> server operators running "distribution provided" binaries, which=20
> usually is "2.5".  OTOH, at some point we want to get 2.5.0 *out*,
> and if we keep adding features, we need more RCs, and then we'll
> never get there.  OTOH, again, this is a fairly isolated change - so
> if enough users yell at me that THEY MUST HAVE THIS, we could put
> it in 2.5.1 or 2.5.2 ("small and isolated new features can be done
> in small-numbered subreleases").

I agree, this is not 2.5 stuff.  If it is not a new feature, it is at
least a feature extension - not a bug, security or stability fix which
is what we should focus on now in the 2.5_rc phase.

> Also, we do want 2.6.0 to happen "soonish" this time, like "in one
> year, not in four years".  Let's see...

Yeah, lets get 2.6 out sooner - with lesser new features on the plate,
and rather save some goodies for post 2.6 releases - to help the overall
development/release cycles go faster.


--=20
kind regards,

David Sommerseth
OpenVPN Inc



--4xTbIHc8S3gKABg30GbiynN3tmEHXDNsw--

--YPkUMEo02ieSmAjWWhr6lZ93KrEvAGujF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCgAGBQJff17KAAoJEIbPlEyWcf3y/fMP+wTOsk5xaYsTbNoiyo5//hKd
8Pv0Yp0pj9lg1UW3Okr0as2cr4C6eHhcXupoMsoX4HQ8465PDEMHhIMRS5V7BGc6
syOu+QtSt0tBjA1+9b8s4ti5jGqZId9ZCnVPntlYHGsN/yuvvqSoRiooSAiZaCvP
ifwkDnNcKZ8lgQ1Iv9aMzAYbgZnJ6OCttLZl6Kb8NjCWK4N+Gkn6RPnKpqQg5/+u
XmAFeneYqvjB36FYQum7Jz/c68mJt40AvRSlYSySDri4oCWnDAV9p8gGyAxmqWSW
r3g4aYDbsCBAvsZhHMydmz41eiBr481HbTaB9O6dk8RYOnpecn24ycLhqDX0gtW4
Q/MUJRhzpJ1uhgLwuiUllpT+8QJMlK6JGwHh8+++848A9MIKB5TVQZ63MCsPYAbz
yU/3ltdf32d9IX+t8M/otNUYHuFjl+7CCMHI3lSWX6/ck0j60xOw3dOjKuVJgHsD
b9VU4gnt68JA74r1WK10MMVrJtoUyD37Qy+C1s2oqIudySyid7BGU/R/3FP6Ediy
PIf4zcEjxrpuidsZrVs+SfARwPx+vfRYLhhPXLdXKSz0QEOnio4WQyYguJEqwEO9
OR93GDKE+3RiCiPiMqlvR51tuARrPCJeIp1/gIe7Ih59mMZbDCNBc+wcD3wHmUph
OzC/4MwhVahxrtKEi3Eo
=9exf
-----END PGP SIGNATURE-----

--YPkUMEo02ieSmAjWWhr6lZ93KrEvAGujF--

