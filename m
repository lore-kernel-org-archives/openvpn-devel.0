References: <1486364115-9801-1-git-send-email-chipitsine@...277...>
	<20170206104444.12662-1-davids@...515...>
	<13044f0c-953c-af95-79dc-d7b641ae6573@...515...>
	<7cfc9e24-236d-ad55-9ed3-5904c4042a06@...515...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <cbab7858-a753-d599-97ec-782f1b686f99@...2080...>
Date: Tue, 7 Feb 2017 14:03:22 +0100
MIME-Version: 1.0
In-Reply-To: <7cfc9e24-236d-ad55-9ed3-5904c4042a06@...515...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="E148Phx7tfPMCrOR7frWNgocs3BC1hMWx"
Subject: Re: [Openvpn-devel] [PATCH applied] github: Add PR template with
 contributor related information
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>, David Sommerseth <davids@...515...>, chipitsine@...277...
Cc: openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--E148Phx7tfPMCrOR7frWNgocs3BC1hMWx
Content-Type: multipart/mixed; boundary="xmWaCK62lTm7DlBfX6B2hpmC8r8F83wkD";
	protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
To: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>,
	David Sommerseth <davids@...515...>, chipitsine@...277...
Cc: openvpn-devel@lists.sourceforge.net
Message-ID: <cbab7858-a753-d599-97ec-782f1b686f99@...2080...>
Subject: Re: [Openvpn-devel] [PATCH applied] github: Add PR template with
	contributor related information
References: <1486364115-9801-1-git-send-email-chipitsine@...277...>
	<20170206104444.12662-1-davids@...515...>
	<13044f0c-953c-af95-79dc-d7b641ae6573@...515...>
	<7cfc9e24-236d-ad55-9ed3-5904c4042a06@...515...>
In-Reply-To: <7cfc9e24-236d-ad55-9ed3-5904c4042a06@...515...>

--xmWaCK62lTm7DlBfX6B2hpmC8r8F83wkD
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

On 07/02/17 11:09, Samuli Sepp=E4nen wrote:
> Actually, that was just the line length for _code_, not for commit=20
> messages. So the only indirect guideline for Git commit message line=20
> length was

Correct.

> "The maximum length of the line differs between projects, it's usually=20
> somewhere between 50 and 78 characters"
>
> which was on this page:
>=20
> <http://who-t.blogspot.fi/2009/12/on-commit-messages.html>
>=20
> The "seven rules" URL David linked to says the following:
>=20
> * Limit the subject line to 50 characters
> * Wrap the body at 72 characters
>=20
> I can't recall us ever agreeing to such limits.

That is actually a pretty much a de-facto standard among all git users.
The subject line at 50 chars is because it makes git shortlog, git log
--oneline and similar tools produce reasonable outputs which keeps the
total line length, including indenting, within 78 characters.

In addition github, gitlab, gerrit, etc will also truncate subject lines
which are longer than 50 characters.

Similarly the body wrapping at 72, is to account for a similar indenting
which git does when presenting the body message text.

And it just takes a quick look at our git log to see that we try to stay
beyond that limit.  We do sometimes exceed 50 characters, and we let
that pass silently.  But more than 3 times longer, then something must
be done.


--=20
kind regards,

David Sommerseth
OpenVPN Technologies, Inc



--xmWaCK62lTm7DlBfX6B2hpmC8r8F83wkD--

--E148Phx7tfPMCrOR7frWNgocs3BC1hMWx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJYmcWaAAoJEIbPlEyWcf3yzacQAMX57Iart/1tkhGu5VMlGpgF
P2rFzJUaHnbPk+ZjcPdS3J/W3i/s+bfthMxaPglF3Be2JcWTO0AYABmdwGcIAjAL
3wAprw9+tjgOBOF5xcDuu1SAtv6dzW31CZaD23TBkeXWGUKPCNgMVUShIQDr0VEU
Lc/jrDJiBhT0t8NevIS4caJAx7UELv30XAbonFXWtcg8piBgVKgA7mvRV4WyQoCg
JOPEbo7luO6oPP3tkmDA/bOn80RG+qbhh/0h+6Is0q3p7yrK3D7NarJpmhI7/kCX
9D7B0/28nYIWnwDppgOOIBZtbi6yg7+YnyNwcNJk1vbE8oO5joPLIO1DIHaLkuNX
jYsHZAE12G+seUEaEk0GZYb3ScQMdQq3a/LkMRciFBCeBSAn1yzxNdKpAWJyPgj5
Hj8ynFmQIBFf6NgQFvmjE/ppre0IdutX2IuF4JS+td+wKNwe/FzF+9D0RziYAaUv
22WuLVKEfBblSVmXRWLvVeEpkE2OlBNaB4HvhMrXdabV71hcGv2Nt3tDslX5jdrm
tI+bnOdAUBhuv7pgtgr331Y1Q2TO07t9QDfmqkNVTzFKWJ1s+vF48w5oQKKqaEG4
x+nbch0EA18BrSiD5cmyXXmF8w8EbOzAVIBstg59CXEhD9BYU9BvBN1wl8Wbhn9Z
HEbvB3L1XtCYiAPbrjet
=5BgC
-----END PGP SIGNATURE-----

--E148Phx7tfPMCrOR7frWNgocs3BC1hMWx--

