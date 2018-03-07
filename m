Reply-To: openvpn-devel@lists.sourceforge.net
References: <1520262951-1807-1-git-send-email-arne@...1227...>
 <1520265024-2129-1-git-send-email-arne@...1227...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <68b5e196-ee80-7975-4a29-161d71521ec4@...2080...>
Date: Wed, 7 Mar 2018 23:38:29 +0100
MIME-Version: 1.0
In-Reply-To: <1520265024-2129-1-git-send-email-arne@...1227...>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="PBPjAJ6tyFB698IJPew9S9siPVW61sXc6"
Subject: Re: [Openvpn-devel] [PATCH v2] Rework OpenVPN auth-token support
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--PBPjAJ6tyFB698IJPew9S9siPVW61sXc6
Content-Type: multipart/mixed; boundary="3SIDzYbEqEehAl0zRogs98ZKaTb4nAgSx";
 protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
To: Arne Schwabe <arne@...1227...>, openvpn-devel@lists.sourceforge.net
Message-ID: <68b5e196-ee80-7975-4a29-161d71521ec4@...2080...>
Subject: Re: [Openvpn-devel] [PATCH v2] Rework OpenVPN auth-token support
References: <1520262951-1807-1-git-send-email-arne@...1227...>
 <1520265024-2129-1-git-send-email-arne@...1227...>
In-Reply-To: <1520265024-2129-1-git-send-email-arne@...1227...>

--3SIDzYbEqEehAl0zRogs98ZKaTb4nAgSx
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable


A bit more thorough review this time.

On 05/03/18 16:50, Arne Schwabe wrote:
[...snip...]
>=20
> This patch changes the client behaviour:
>=20
> - Treat a failed auth when using an auth-token as a soft error (USR1)
>   and clean the auth-token falling back to the original auth method

Conceptually, this makes sense.

> - Implement a new pushable option forget-token-reconnect that forces
>   to forget an auth-token when reconnecting

This I am not happy about.  We should use an AUTH_FAILED,SESSION:$message
approach instead.  This is what OpenVPN 3 based clients expects, and it sho=
uld
actually do (read: behave) as the previous point.  OpenVPN 2 does not do th=
at,
today, so it would need to be taught that instead.

> - Sending IV_PROTO=3D3 to signal that it is safe to send this client an
>   expiring auth-token

And as we shouldn't need forget-token-reconnect, this would also not be nee=
ded.

> The behaviour of the server option auth-gen-token:
>=20
> - Automatically push forget-token-reconnect to avoid a failed
>   authentication after reconnect
This should not be needed with the AUTH_FAILED,SESSION:$message approach.

> - By default only send auth-token to clients that will gracefully
>   handle auth-token to avoid having clients not able to reconnect

What do you mean with "gracefully handle auth-token"?  By fixing OpenVPN 2's
behaviour (as suggested above), it should behave gracefully by default.

And I'd be willing to /consider/ this fix even to OpenVPN 2.3 code base, for
those who can't upgrade.  But it will be a hard sell, though; OpenVPN 2.4 is
over a year old already.

> - Add a force option to auth-gen-token that allow to ignore if the
>   client can handle auth-tokens

And this should also not be needed.


I'll admit I might see this with a bit too narrow perspective.  But how I h=
ave
understood this issue is that OpenVPN 2.x does not behave correctly as it
doesn't understand *why* the authentication failed.  If the client side wou=
ld
understand why auth failed, then it can query the user for credentials agai=
n -
which I believe should resolve the current issues ... Or have I missed some=
thing?


--=20
kind regards,

David Sommerseth
OpenVPN Inc



--3SIDzYbEqEehAl0zRogs98ZKaTb4nAgSx--

--PBPjAJ6tyFB698IJPew9S9siPVW61sXc6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCgAGBQJaoGnlAAoJEIbPlEyWcf3y9JAP/2n4HT5B2gWv86qxBW+L4Qp+
9zqGgDYAsWygkmYAPsWHBh420rFOkiUb5wgtoJTTuKHnvup9zpnHhDhMa/RYuAzW
stMqV7bP2UBHmlz3ithIyUU+BmrRYeKeyItIHlhME3JBdcJtt/x1nGuF+Isr2v/n
JZU7k6hPCqXuSipfgfvUKrwpSErL2v1M5sxjT3KgXpAguRZ9cZJXQSb/iO97Fcmo
l1xscnP8EZAAVvXAH3UUMT9kzLaQ1cgWgk95/Pwwf1jr5VTzx+U7jHTGuUDF6R3j
PSO6t0XltqXQP5wqrKOaOBk4JsA11d14X7xGlI9oFNR5jSk1tpsTPizVpMe4rWFS
jlz3Xp8aRHHORDh3Hb24lZ+gl0bBo6ms1uNrYSGx/GXZ8+YSS+SdgYzlpNkHSHnu
lEAnMC0hsdB/cBB37K/Q22FqJnnweLRcDolbEglJKtfC77P0aE9EFlqlO1QW4cj2
I8g1B/pknL3g5xCPMGKbphvKlGbkgCDdQPXmZKLFBs+czdzIDnbt2z3HXdaO1s8N
m2Q8znm8kBUAQs2t8ix0aGkyFUTF/N8XI44Ks+XvtEMPNSPiXASgiGDw26WRpnGs
LvjZ3PRnX514h48VC5wIvrEbsUUNoglwE2x7Hr6USH0n11KCsejbewxij3FkInkJ
q1SnChQPmRZjF6G2xtih
=ISkR
-----END PGP SIGNATURE-----

--PBPjAJ6tyFB698IJPew9S9siPVW61sXc6--

