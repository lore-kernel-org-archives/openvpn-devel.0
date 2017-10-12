Reply-To: openvpn-devel@lists.sourceforge.net
References: <20171011134530.6676-1-simon@...2293...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <58155e1c-bdf3-9529-8b98-f4193dc6114f@...2080...>
Date: Thu, 12 Oct 2017 11:12:38 +0200
MIME-Version: 1.0
In-Reply-To: <20171011134530.6676-1-simon@...2293...>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="pSXWN1A3Ue6WPHABktj1kNtKs1fQ2LFjC"
Subject: Re: [Openvpn-devel] [PATCH] Document ">PASSWORD:Auth-Token"
 real-time message
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: simon@...2293..., openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--pSXWN1A3Ue6WPHABktj1kNtKs1fQ2LFjC
Content-Type: multipart/mixed; boundary="RIEEx6jDxtmKllEdNQiqLmbQC3fmnoQn4";
 protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
To: simon@...2293..., openvpn-devel@lists.sourceforge.net
Message-ID: <58155e1c-bdf3-9529-8b98-f4193dc6114f@...2080...>
Subject: Re: [Openvpn-devel] [PATCH] Document ">PASSWORD:Auth-Token" real-time
 message
References: <20171011134530.6676-1-simon@...2293...>
In-Reply-To: <20171011134530.6676-1-simon@...2293...>

--RIEEx6jDxtmKllEdNQiqLmbQC3fmnoQn4
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable


Hi Simon,

Really great to see all your patches!  Thanks a lot!


On 11/10/17 15:45, simon@...2293... wrote:
> From: Simon Rozman <simon@...2293...>
>=20
> Authentication tokens are security enhancement eliminating client
> need to cache passwords, and are indispensable at two factor
> authentication methods, such as HOTP or TOTP.
>=20
> The ">PASSWORD:Auth-Token" message was not mentioned anywhere in
> the OpenVPN Management Interface Notes. This patch adds a simple use
> case example, while the more detailed feature description remains
> explained in the OpenVPN manual.
> ---
>  doc/management-notes.txt | 7 +++++++
>  1 file changed, 7 insertions(+)
>=20
> diff --git a/doc/management-notes.txt b/doc/management-notes.txt
> index 0e7a7d4..c31ff5c 100644
> --- a/doc/management-notes.txt
> +++ b/doc/management-notes.txt
> @@ -317,6 +317,13 @@ COMMAND -- password and username
>=20=20
>      >PASSWORD:Verification Failed: 'custom server-generated string'
>=20=20
> +  Example 6: If server pushes --auth-token to the client, the OpenVPN
> +  will produce a real-time PASSWORD message:
> +
> +    >PASSWORD:Auth-Token:foobar
> +
> +  The client should replace the local password with the "foobar".
> +

This area is part of the code I've been involved with fairly recently.

You are not incorrect, and this was the behaviour until we released
OpenVPN 2.4.4.  As of v2.4.4, the >PASSWORD: line will be sent to the
management interface, but the code which implements usage of the
management interface can basically ignore it.  The caching of the
token is now handled properly by the OpenVPN core, also if you are using
--auth-nocache in the client config.

(Quick remark, it seems we did not fix this issue in v2.3 at all, it
only have a partial fix but is lacking a backport of commit 3322c558fa7)

We might actually consider to remove the >PASSWORD: response in the future.

I can give this patch an ACK if we just remove the line about "replacing
the local password".  For me, that can be done on-the-fly on commit time
in this case.


--=20
kind regards,

David Sommerseth
OpenVPN, Inc



--RIEEx6jDxtmKllEdNQiqLmbQC3fmnoQn4--

--pSXWN1A3Ue6WPHABktj1kNtKs1fQ2LFjC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCgAGBQJZ3zIHAAoJEIbPlEyWcf3yzhAQAJnd9LFp24ovJoGCWHme78YS
h+D3GJZFiYlECxhzfaJYrQU+4yqH4DndrS5cJuKaR1Wg7AXjM2PD+d0CrPUjxcWD
Pl1EWUMHpFMtJcVEoX+Aj7eNzndzFWz1ThAhguD98u2TevU+zX+ktsDtzRmpA1In
ooPlgdVA9s5m3iJ4KEQe+diQI/NoWMRjJdxOIdU6BtfXtEtmLkYMom70XS/618jA
6aHBkW90Vy7VK/XZzUGWW++nzSaYVC1AOTtDx+cjUQXtjkcBkBatgP6cv1eH3VvY
oYVfbK8XlMuBxSGOwxLs2hYGRDJoDLQZh+MamrRWw6qpwdYSd+7w8CQfWA3fn7aW
j2lIwb6bJuwA7XxnowbWgdlnEYf7VPyaSr7Aol2WQ5bepCVacHR5KbyVyZqqX1jk
Zj6sHlCg3Dya5MbkHbEe19qfwrMSoxqfOpipDetYrep9JiKIY4TA6TsDSXzlFUG0
ufuIA/uu2OF65/igpJ4KXkLT8xmaPHTkpYSmOIXcpBuqlBguUqb8QPZNtaJHx9n0
a/27joyKXH05m7esdrAOZDMHUf0zHiliLscnle45oZf9NAGQF6dDLRYR76n0sTgd
XZBp9K8qIA9UNyOk4jezHIyJXcbgsXylTuDKG9iH34pHBsjdRejvFXkbT+OztPKP
+qAQ/R4TzsT0ZyiWIkxs
=Jy4x
-----END PGP SIGNATURE-----

--pSXWN1A3Ue6WPHABktj1kNtKs1fQ2LFjC--

