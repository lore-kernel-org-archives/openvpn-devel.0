Reply-To: openvpn-devel@lists.sourceforge.net
References: <CAATJJ0JWDwT-BLR2W4bxRrJJu+jooVOhGpG2yrRvoXW3H1ii8g@...278...>
 <80bf080e-a293-70a5-fab0-c4f814dd154e@...515...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <b75c0d30-f98d-6457-10d4-9b78a02261a7@...2080...>
Date: Fri, 7 Sep 2018 12:22:57 +0200
MIME-Version: 1.0
In-Reply-To: <80bf080e-a293-70a5-fab0-c4f814dd154e@...515...>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="rc3TyAZjoRrMNviLPDnHbUkQZKnhFXIEw"
Subject: Re: [Openvpn-devel] sbuild_wrapper: please unify service rules with
 openvpn repository
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--rc3TyAZjoRrMNviLPDnHbUkQZKnhFXIEw
Content-Type: multipart/mixed; boundary="pznhqmzeyx3jBXOokEJdEVO2iMkRhJwUc";
 protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
To: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>,
 openvpn-devel@lists.sourceforge.net
Message-ID: <b75c0d30-f98d-6457-10d4-9b78a02261a7@...2080...>
Subject: Re: [Openvpn-devel] sbuild_wrapper: please unify service rules with
 openvpn repository
References: <CAATJJ0JWDwT-BLR2W4bxRrJJu+jooVOhGpG2yrRvoXW3H1ii8g@...278...>
 <80bf080e-a293-70a5-fab0-c4f814dd154e@...515...>
In-Reply-To: <80bf080e-a293-70a5-fab0-c4f814dd154e@...515...>

--pznhqmzeyx3jBXOokEJdEVO2iMkRhJwUc
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On 06/09/18 14:25, Samuli Sepp=C3=A4nen wrote:
> Hi,
>=20
> I maintain the Debian/Ubuntu packages for OpenVPN.
>=20
> Il 03/09/2018 12:24, Christian Ehrhardt ha scritto:
>> Hi,
>> the upstream provided .deb [1] e.g. for Ubuntu Xenial gets its service
>> file from [2] which is outdated.
>> This makes the upstream Repos [3] not being in sync=20
>> I'd ask you to follow the main repo [4] on that to eliminate some Delta.
>>
>> In general I think that some of the packaging is outdated and
>> sbuild_wrapper could fetch some more from Debian [5] and Ubuntu [6]
>> (which match among each other on this)
>=20
> I've generally reused packaging files in OpenVPN packages provided by
> the Ubuntu and Debian projects. In some cases, though, the packaging
> files may be from a package meant for a (slightly) older operating
> system version.
>=20
> Do you happen to have a diff at hand? I would not mind updating the
> service files if the changes are fairly minor or fix a bug. But I don't
> want to break setups that depend on the behavior of the outdated service
> files.

This is the location of the unit files which we really should use.

<https://github.com/OpenVPN/openvpn/tree/master/distro/systemd>

It should break anything if you have the openvpn-{client,server}@.service
files packaged.  It would actually fix a few bugs instead.

I haven't checked the current state of what's in our .deb packages, but we
should really ship the very latest at any time.  And DO NOT ship the
brokenness of openvpn.service and openvpn@...1685... ... those are not
maintained by us and will make things work even worse; especially since
openvpn 2.4.x and newer is systemd aware and integrates much better.

> Also, we don't have packages for Ubuntu 18.04 yet. So using the
> packaging files from Ubuntu's repositories makes perfect sense there and
> can't break anything.

Yes!  Latest and greatest from our own sources.  Always.  ;-)  And do not s=
hip
openvpn.service and openvpn@...2450...


--=20
kind regards,

David Sommerseth
OpenVPN Inc



--pznhqmzeyx3jBXOokEJdEVO2iMkRhJwUc--

--rc3TyAZjoRrMNviLPDnHbUkQZKnhFXIEw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCgAGBQJbklGDAAoJEIbPlEyWcf3yNtsP+weLnUX+9X3Tv8ToemfOfjuj
nrSmNnXlqg6z77GDjtcuVRYjYwkH+S+O1TccaNCfps/Ec3jLNGJ8dL7wRR1exxEN
KjRaoR4SgVjHuUBbmuxPRHFEGT4Lc2QMhFj8+qjhsmUJapmm4t6aYciiSs0KTl8y
Hg1E7rA83ath/mPqhx/CjAfIFxpK7SLwvb2o5sgZcPfNdwZk+BwTjpAfJcRkl1V3
LFFyNZHMRhW+B1v/VoH8XSYaduk1lU5Dc2Osb5bbq0lf8Qtc/Qwz1CObeNdDOJNT
TUiqReZjILLOAeU3ZvLTfeNZfb8bJGoXHxm2D9Y9a68hocT2OoWOfbn7UkL1zC3H
uHt8ME32nbwyFFtVof3Z6SodPSemX2U4KHIuzg31EyHpdrVCUi2GPdjrcY9pRbfU
BZ5ASwU1Uh1HvSzcqJSrZiE8oDGP31l8H3owQe3ly5OTdSFG/DXGlXhxZlSW1CV3
+sweAJ3L/zsMVJzGuWBugdb6lKSU/FAV1Stqd4pJ4rALaFpjn6CXUo/qJJltezNa
tYiXWDTnfRFAUiWXse2oT8bZonsKjlFAeXEryVEGwR/4RBiugKx1XyXCKWEVF/pj
F/gPJSjUet13eexoyhXvo415zrhI/avHzT3I4guyDfgcC1codkJz/iOXC1GmXbtT
g2qVAGSMGe+9HyveFmdU
=BuIc
-----END PGP SIGNATURE-----

--rc3TyAZjoRrMNviLPDnHbUkQZKnhFXIEw--

