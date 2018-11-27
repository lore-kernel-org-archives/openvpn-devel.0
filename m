References: <20181011184200.22175-1-a@...2181...>
 <20181011184200.22175-2-a@...2181...>
 <f9bc4804-b75a-ec1d-fbc3-f2f09376b387@...1227...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <cf9a251c-2135-cc5c-76c6-faef9fb47d0f@...2181...>
Date: Tue, 27 Nov 2018 10:53:58 +1000
MIME-Version: 1.0
In-Reply-To: <f9bc4804-b75a-ec1d-fbc3-f2f09376b387@...1227...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="Lc0ey2TzPp9RJ1a7zVC9Scn5hZet8VqZp"
Subject: Re: [Openvpn-devel] [PATCH v2 1/7] implement platform generic
 networking API
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Lc0ey2TzPp9RJ1a7zVC9Scn5hZet8VqZp
Content-Type: multipart/mixed; boundary="FdEMk92pgsb5YH6ucAqGLEaqTvrxIZ4nC";
 protected-headers="v1"
From: Antonio Quartulli <a@...2181...>
To: Arne Schwabe <arne@...1227...>
Cc: "openvpn-devel@lists.sourceforge.net"
 <openvpn-devel@lists.sourceforge.net>
Message-ID: <cf9a251c-2135-cc5c-76c6-faef9fb47d0f@...2181...>
Subject: Re: [Openvpn-devel] [PATCH v2 1/7] implement platform generic
 networking API
References: <20181011184200.22175-1-a@...2181...>
 <20181011184200.22175-2-a@...2181...>
 <f9bc4804-b75a-ec1d-fbc3-f2f09376b387@...1227...>
In-Reply-To: <f9bc4804-b75a-ec1d-fbc3-f2f09376b387@...1227...>

--FdEMk92pgsb5YH6ucAqGLEaqTvrxIZ4nC
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On 26/11/2018 22:55, Arne Schwabe wrote:
> Am 11.10.18 um 20:41 schrieb Antonio Quartulli:
>> tun.c and route.c contain all the code used by openvpn
>> to manage the tun interface and the routing table on all
>> the supported platforms.
>>
>> Across the years, this resulted in a longer functions
>> and series of ifdefs.
>>
>> This patch introduces a new "networking API" which aims at
>> creating a simple abstraction between the tun/route logic
>> and the platform dependent code.
>>
>> The is API expected to be implemented outside of tun.c/route.c
>> by using platform specific functionalities.
>=20
> If I understand it right, the goal is to create a platform independent
> API, Android needs either still hacks in the non platform specific code
> or the API needs to communicate also
>=20
> - route/adding addr before interface up
> - type of route to add (android wants to ignores the host route to VPN
> server and wants to isntall a 0.0.0.0/0 instead of two /1 even with def1
> in place, the last one to workaround buggy Samsung code that special
> cases 0.0.0.0/0 but sadly still needed.
>=20
> Should we try to design the API right from the start to allow also for
> these specifics?
>=20

This sounds like a problem that has to be addressed at a layer above
compared to what this networking API is doing.

With this I mean that the specific "Android case" you explained cannot
be addressed by changing the networking API (meant to be low level API
to configure/deconfigure th enetworking stack), but should be taken care
by the login in tun.c/route.c directly.

What yo are suggesting is a change to the logic passing the information
from the control plane to the platform dependent code.

This change to me seems independent from the technology used to
configure the interface (i.e. iproute/nettools/netlink/anything-else).

What you are after is probably an abstraction similar to the one we have
in OpenVPN 3, but that one is indeed implemented at an higher level
compared to what we are introducing with this patchset.

If you note, this is why my patches for OpenVPN 3 consists of two
components.

In my opinion, the logic change you are talking about is not required
because:
- this is already implemented in tun.c/route.c at the moment and won't
be changed for now
- this can be "improved" later once this networking API is in place,
because the code will have to deal with will already be much slimmer.

Attempting to work on both layers with one big change will just make
things more complicated imho, hence my proposal to go step by step.


Best Regards,


--=20
Antonio Quartulli


--FdEMk92pgsb5YH6ucAqGLEaqTvrxIZ4nC--

--Lc0ey2TzPp9RJ1a7zVC9Scn5hZet8VqZp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE3o8ejP0lUW4GTX3J9FVsWUWDDm0FAlv8laYACgkQ9FVsWUWD
Dm00nA//WY3+WmCMcqTbF3TvSogpOYJvr6rpT92t41bVf4kiQ1/LCX5afB9EjdeG
4kE2D54lgmXX4caIA6xc+JxU8zg/nMcMlahH+o/cBeD/a2n5BITTXNNjQQslU1xm
xu5u9zTqxfQMxnR4jwxo8iUFxV1fnl3YPSMTPFzUhT2AyLZXkiTAufUcomxKb/ev
C9LLOMPGgyKn4lIh37C9vWkxEgt2WtagPf2vkIhHsvyWmw2hQSwMxeq+fDvswRtZ
+rQIYtAvnw5cHEdR2p8h4fqIdtL0vYH1eIgjybZubMD5N5y/RcDyIWL6kXZOIQof
b1xaSPYiphk5xOETjb0V+hkIVxpEKg4XEpnVAedPd3FlcI1wQKNnc+COb7RDHlT3
caSZKueYjAkIyMCjvoATFUR4B2MJNqnFv2zcLguiS/HajwOJKFTc23/cyWG5/dRW
6WLhozrnZy+RxH+WlqOyGtIJUVbwIi0RuV4bqc3yRmhCn8cejVi4hZiGFtwtCxvH
vUtU9UAFs1q0lRO2va5pmoETrimjg2aPD+ekEiUrxwkgMKbG4Rz6Jnh7TwHAdkLc
3/d84xujTjA0s4UyUG+Njljl39BHd/TGiOVtMGhkX/CsSbLytNQ5aeoe4IxuRYpB
EcbLnkQYtDj18dOBdaHK8OBCN7C2kP+yAhrWEdiNS0EBh5PfuXI=
=X+TB
-----END PGP SIGNATURE-----

--Lc0ey2TzPp9RJ1a7zVC9Scn5hZet8VqZp--

