Reply-To: openvpn-devel@lists.sourceforge.net
References: <CAKuzo_jF_fHfcEPUXeo6WKWQ4tw7T72-cexEUda=USGd9Ref7g@...278...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <e09e95cd-a6d1-e1c0-9c05-738362207278@...2080...>
Date: Mon, 22 Jan 2018 13:33:21 +0100
MIME-Version: 1.0
In-Reply-To: <CAKuzo_jF_fHfcEPUXeo6WKWQ4tw7T72-cexEUda=USGd9Ref7g@...278...>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="5SDCGkra9GN2IRDbqtcVMggVfzf4WlMJb"
Subject: Re: [Openvpn-devel] On testing with openssl 0.9.8
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva Nair <selva.nair@...277...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--5SDCGkra9GN2IRDbqtcVMggVfzf4WlMJb
Content-Type: multipart/mixed; boundary="VFwM9Ls05xq6rApeSR7Cdwl0NYdbQ9QaY";
 protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
To: Selva Nair <selva.nair@...277...>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Message-ID: <e09e95cd-a6d1-e1c0-9c05-738362207278@...2080...>
Subject: Re: [Openvpn-devel] On testing with openssl 0.9.8
References: <CAKuzo_jF_fHfcEPUXeo6WKWQ4tw7T72-cexEUda=USGd9Ref7g@...278...>
In-Reply-To: <CAKuzo_jF_fHfcEPUXeo6WKWQ4tw7T72-cexEUda=USGd9Ref7g@...278...>

--VFwM9Ls05xq6rApeSR7Cdwl0NYdbQ9QaY
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On 20/01/18 18:22, Selva Nair wrote:
> Hi,
>=20
> Does openvpn-vagrant include any VM provisioning with openssl-0.9.8?
> Until recently I had access to a few old debian boxes but now all
> updated and 0.9.8 testing is getting harder.

Let me rather twist this question around ... Do we want to support OpenSSL
0.9.8?  Are there any Linux distributions or other OSes out there in the wi=
ld
which is still supported which are also based on openssl-0.9.8?

Officially we dropped RHEL 5 support and moved to RHEL 6 as the oldest Linux
distribution we support OpenVPN on.  RHEL 6 ships with an openssl-1.0.1e ba=
seline.

For the other platforms ... In Windows, we define what we want to use - as =
we
need to embed OpenSSL in our own package.  I believe most of the current
stable *BSDs and derivatives are on an OpenSSL 1.x base (or the LibreSSL fo=
rk)
too (but I don't know that for a fact yet).  I expect Tunnelblick and macOS
users to use a far newer OpenSSL library too.

I would rather see us moving to officially drop 0.9.8 unless there are real=
ly
strong arguments and evidence of someone maintaining openssl-0.9.8 with
security backports.


--=20
kind regards,

David Sommerseth
OpenVPN Inc



--VFwM9Ls05xq6rApeSR7Cdwl0NYdbQ9QaY--

--5SDCGkra9GN2IRDbqtcVMggVfzf4WlMJb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCgAGBQJaZdoUAAoJEIbPlEyWcf3ymwoQAJBTJgC1Qyn1XerIIAznQof4
HqzyVZ/YqMRYZctT5q4UCG0A7XKr8IgYmYNBROvpEhDAhx/r1BRs08L15Hm8b2f+
ifxGM18GCXDRRO/gsbyz0S40eBKZ8QAqupQkVpCjsPHJKhIE7q+442zjh/z/oIiF
GB+Tj0UsUXOAOsR3tx9PTIanxX2Iq5aZYQWQc4NiNMPpq5MB9lVi3FewFr0copQp
DuZJuRSlQNzK1/7/+cA197OiSMjDlgp65RQGEeByAADIOl/qjmrhi6BNidrkp4yw
XPeqzVe0GFtu4Rdk4QKpj320MpS8I2ybPbAZqM91P4U+UNJ65sHVU0fgOe7Fp2ci
kmP2KLAN/cGnQOA3UDJvo5AA7EHYenrvTo1D0q6vSAVRjRTVy8fMJ4dnp175P5QE
H7kHUHwb7kFOQkfIkHufcp7mj3ctO9EraTclsx9eG1glt9Z93Yo5RY36vWtPUeQO
8M0Ln3FkCyHhwoN5bU3V7Zz0nfqMQhHY7PporKdOR6lpskKul1Rcgeb3i85CVUjF
zoK9z+2tpo4yfqZwWJcJQsRwZF/HWX30fA5TJLunop7mxkG/9mi9utcQskCLTYpT
hxexkf1GwRN/gohfAr2hShLg+Z85zINE/8EotdSt7no9ccAni48Wp9zQJVQ+vgJ5
NnTWrBHSYVbjn/3mGgmn
=W452
-----END PGP SIGNATURE-----

--5SDCGkra9GN2IRDbqtcVMggVfzf4WlMJb--

