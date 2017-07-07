Reply-To: openvpn-devel@lists.sourceforge.net
References: <20170707195941.61773-1-thomas.veerman@...1862...>
	<20170707231116.2bcf4fdf@...1799...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <47a8b958-b2b6-1a66-4cb0-ecba39ee8b7d@...2080...>
Date: Fri, 7 Jul 2017 23:15:12 +0200
MIME-Version: 1.0
In-Reply-To: <20170707231116.2bcf4fdf@...1799...>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature";
	boundary="VDG53Dcohaf6Raisqinla63hGbM2pFD1N"
Subject: Re: [Openvpn-devel] [PATCH] Fix socks_proxy_port pointing to
 invalid data
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Christian Hesse <list@...1798...>, Thomas Veerman via Openvpn-devel <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--VDG53Dcohaf6Raisqinla63hGbM2pFD1N
Content-Type: multipart/mixed; boundary="PSx7pbcHbSuw6NEPhOgK8NpfNS7eEUkId";
 protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
To: Christian Hesse <list@...1798...>,
 Thomas Veerman via Openvpn-devel <openvpn-devel@lists.sourceforge.net>
Message-ID: <47a8b958-b2b6-1a66-4cb0-ecba39ee8b7d@...2080...>
Subject: Re: [Openvpn-devel] [PATCH] Fix socks_proxy_port pointing to invalid
 data
References: <20170707195941.61773-1-thomas.veerman@...1862...>
 <20170707231116.2bcf4fdf@...1799...>
In-Reply-To: <20170707231116.2bcf4fdf@...1799...>

--PSx7pbcHbSuw6NEPhOgK8NpfNS7eEUkId
Content-Language: en-GB
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

On 07/07/17 23:11, Christian Hesse wrote:
> Thomas Veerman via Openvpn-devel <openvpn-devel@lists.sourceforge.net> on
> Fri, 2017/07/07 21:59:
>>          else if (streq(p[1], "SOCKS"))
>>          {
>>              ce->socks_proxy_server =3D string_alloc(p[2], gc);
>> -            ce->socks_proxy_port =3D p[3];
>> +            ce->socks_proxy_port =3D string_alloc(p[3], gc);
>>              ret =3D true;
>>          }
>>      }
>=20
> If we allocate memory here, is it freed later?
>=20
> A quick look at options.h shows this is (const char *).

It is allocated with a gc (garbage collector), so when there is is a
gc_free() on the gc, all allocations connected to that gc gets freed all
at once.


--=20
kind regards,

David Sommerseth
OpenVPN Technologies, Inc



--PSx7pbcHbSuw6NEPhOgK8NpfNS7eEUkId--

--VDG53Dcohaf6Raisqinla63hGbM2pFD1N
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCgAGBQJZX/ngAAoJEIbPlEyWcf3yTMAP/2zoYo1ru7dEFC1v/R9iAoX5
T0n9kzw/lgTbpTghQnJMC7djUB6ZgODbaeR350z0gbajRX3Lq+TAmatHp1Fkl5GM
babUt+8Ve4R7Oh8hgdsrdrRMdO4wTmCOo5KcFND+IXaOFzQwluTPkYYwQgu7kzx8
dU3NBJ125RrvlzvjroQbOSZjdD6B/Fhec8+tM405mEkVVkWFQsZWmpxqf3VH8C2V
Q040KJti1Haht7cVJYT0L9wx1zXsinsQ06p6t0OQF5a4717v20e0FknVEEAPN7w4
s25dPsqN+y7L48vVFqWJcN3TD6ZyPx9zklDJ746Iv+Wn7Nb4WMFZUkzqNNWU0m0H
ikgveRyg9dcChC2wyD6Rrk5gT9TwBdz9HoTqATF4aFS0O4eixEnHYCBXbMPAhMhl
ttkKRyhmzChBZmSt3bcD015c57Hbu9QwFNs0VuaTuCyhj9NT9lk2pj+hHgm0exlN
/yuzb6DpFItMkPCCfeYLzfrDH7sne+CO+7PNcBxle4mZfJNwjvO/G4tkp3qz72v3
dqZhNg4Fs1Et9+Xrkfif8/Pi4VU7Wqa6+7M8Djynd7N7Hxvi1AhquaV59kl0yn16
YrAfsGP+TChxICGKQqWGSKNa7yddmsn0WuINPELWsHibXA2FSJcmc95hLPMnGcsp
lHHUJOd5BSjQwhDVrH42
=qSpD
-----END PGP SIGNATURE-----

--VDG53Dcohaf6Raisqinla63hGbM2pFD1N--

