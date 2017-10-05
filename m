Reply-To: openvpn-devel@lists.sourceforge.net
References: <ff439b51-a63e-049c-afc6-56018e3b88b3@...515...>
 <58f3d304-2cb4-8393-b69d-4e4d5b44fefe@...515...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <2a84b696-bfdc-ba86-cb08-90a2dbb900c4@...2080...>
Date: Thu, 5 Oct 2017 13:20:04 +0200
MIME-Version: 1.0
In-Reply-To: <58f3d304-2cb4-8393-b69d-4e4d5b44fefe@...515...>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="MaSHgnfhBwLiBH267n9frc0e91fQf9Dae"
Subject: Re: [Openvpn-devel] How to manage code under the contrib/ directory?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--MaSHgnfhBwLiBH267n9frc0e91fQf9Dae
Content-Type: multipart/mixed; boundary="4b1kfxQNFhEwkwbcI29648JNrP1oUC6Qh";
 protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
To: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>,
 "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>
Message-ID: <2a84b696-bfdc-ba86-cb08-90a2dbb900c4@...2080...>
Subject: Re: [Openvpn-devel] How to manage code under the contrib/ directory?
References: <ff439b51-a63e-049c-afc6-56018e3b88b3@...515...>
 <58f3d304-2cb4-8393-b69d-4e4d5b44fefe@...515...>
In-Reply-To: <58f3d304-2cb4-8393-b69d-4e4d5b44fefe@...515...>

--4b1kfxQNFhEwkwbcI29648JNrP1oUC6Qh
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On 05/10/17 12:40, Samuli Sepp=C3=A4nen wrote:
>=20
> On 05/10/2017 13:35, Samuli Sepp=C3=A4nen wrote:
>>
>> We do not wish to "drop the ball" on code under "contrib/". We would
>> also like to avoid the fate of the OpenVPN RADIUS plugin, which has been
>> forked several times in a row by individuals, leaving users with no idea
>> of which version is the least buggy one.
>=20
> Responding to myself as I did not want to pollute the introductory email
> with specifics.
>=20
> What if we take the "least bad" version of RADIUS plugin and put it
> under "OpenVPN" organization on GitHub and notify all of its previous
> developers and see what happens. With some luck we would get a few
> people maintaining it in a single place without adding any overhead at
> our end.

This makes sense.  But as contrib/ is less official, we should be open
to make both the RADIUS and LDAP modules (where is in a similar state as
RADIUS) more official.

One approach could by moving them into src/plugins/ - similar to what we
do with auth-pam.  Both RADIUS and LDAP are important for many
installations, I believe this /could/ be a big win.

BUT!  That requires more people to step up and get involved and be
active in maintenance of these plug-ins.  Until that happens contrib/ is
currently the best location.


--=20
kind regards,

David Sommerseth
OpenVPN Technologies, Inc



--4b1kfxQNFhEwkwbcI29648JNrP1oUC6Qh--

--MaSHgnfhBwLiBH267n9frc0e91fQf9Dae
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCgAGBQJZ1hVlAAoJEIbPlEyWcf3yYvEP/1plrd+XGn508XXQ+RduvyYv
kXucYuAyGNWknUVAyUkgUr7NQF+G7Kiirhc6fa7c8232sZXoTf2NXmU6MOSS2epe
c52SDGZZa0g2AMT+AXCnrxEWI7/We4O1hfkUZZybdeSIEk+VgZO2ccZ040cXGomX
YcMlMfU40JK5V9dpnNv526s2pikC6mdEnmnBEJx31jUygX9IWb3RFVBYaaFU6JD9
lrtwhwD1eNivBJyKCIpVmJq32MrJATyBAyrSZB+5aoWpyiYA0hBBJlvDgZiFROd3
zLtU822gDaaPs+Cfs1Fq1H4eNiaRzC5OpGQ6Ri4x+5P9lifzZTrMvlVuLynwYiYI
RywqiVbv2xaOML9V13ZUWZCuzd6Ptq6s7kDY/FA/MPAdu707fhX2+Q52i6QOyP60
NfyyN6NRUuLmbHjE0BRMu/QS460DTGPqKqh9fONGomTO6Nq2+wICc8NWmCDZFrWf
55ekdR6VD935cvkXwjFzHtEahgx7fRvPtN6QY5Wh4bktLDMihF15oAPZpW2YCmjd
rL/R2Fhhap5gLpGnk284QvND5gzZ+/PwWz9Pmijz5/bSF6nKoKY7TN/Vr03B+Fna
RLHVhTFG+v9/qWtOkHBANkblScJd3YEom57J2OlfJ+3WZDr2j+gF6sNh+ysAEt5w
m5ZL91hm0U7oyBt0pFIO
=8nWa
-----END PGP SIGNATURE-----

--MaSHgnfhBwLiBH267n9frc0e91fQf9Dae--

