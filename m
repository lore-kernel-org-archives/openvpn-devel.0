Message-ID: <4F4B542D.9090309@...1114...>
Date: Mon, 27 Feb 2012 11:00:13 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <CAOBzU4PN6qDxf39+s4noXEiW8hNbDy-hkQWGSauBd3hX0pu2hw@...278...>
	<CAOazyz0f3sERwjZsf3Ts3Xu7CQqBEf_-_VdbUZ7TrzhLbmTEsg@...278...>
	<CAOazyz1buhSdSF7g6MzePAiQ=irD_Qo-RKPC_jXoR9AVqbtkvQ@...278...>
	<CAOBzU4P0SxY-jF7rb_HsvmtSH8i9PCk+qe5iDQiwJhajsBuYuw@...278...>
	<CAOazyz1naScdf+M0pnePS6-bb5deAHsAniTiv+DFw3ZQdAN+kg@...278...>
	<CAOazyz1DE7Y-P9HFK3LN8-HeoGbHzYeqofX3RiEuK0C-zcxnug@...278...>
	<CAOazyz0nV8P8Age_wyFCvu1J4g1MECA7YdTAAL4of7TTVctXow@...278...>
	<1CED409804E2164C8104F9E623B08B90129350BEDF@...1436...>
	<CAOazyz0daYPAH=ooKDenavTyG1qK1=wJv8ZJ0VF+u-vXWBE2xQ@...278...>
	<4F4B456A.8010208@...515...>
In-Reply-To: <4F4B456A.8010208@...515...>
Subject: Re: [Openvpn-devel] [PATCH 00/35] build revolution
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
To: =?ISO-8859-1?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
Cc: Alon Bar-Lev <alon.barlev@...277...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 27/02/12 09:57, Samuli Sepp=E4nen wrote:
>=20
>> On Fri, Feb 24, 2012 at 9:33 AM, Adriaan de Jong <dejong@...1435...>
>> wrote:
>>>> I did not add the UI stuff, I think there should be a discussion
>>>> why these are embedded.
>>>>=20
>>> One of the few pieces criticism we got about the OpenVPN-NL
>>> release was the fact that we didn't bundle the GUI. End-users
>>> expect an all-in-one installer for a simple user experience. As an
>>> end user of OpenVPN, I agree. On Windows, I don't want to use the
>>> command line, as it is very painful.
>> There are two options which are better.
>>=20
>> 1. Embed openvpn installer within the UI of your choice.
>>=20
>> 2. Embed more defined UI installer into openvpn installer.
>>=20
>> In both cases every project handles the installation of its own
>> components.
>>=20
> Makes sense, especially when as we're splitting the TAP-driver,=20
> easy-rsa, etc. into separate subprojects. I would prefer 2) where
> each subproject would have it's own installer, which the OpenVPN
> "bundle" installer could call as necessary. As a bonus, each
> subproject could be installed separately without touching OpenVPN
> itself. The only downside would be some duplicate code in the
> installer scripts.

If each sub-project just bundles .msi installers, that would just be
smooth!  Where a "global" installer bundles it into a single package for
OpenVPN.  Which means other projects which needs a TAP driver on Windows
can just pull down our MSI installer and bundle that one.

Upgrades could also be handled much smoother than now.  The "global"
installer detects if the sub-components are up-to-date or not, and
updates just the needed packages.


kind regards,

David Sommerseth



-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk9LVCoACgkQDC186MBRfroAJACfZ0GB+2wiHKk9FJlgVxbbsyo0
fTsAn3YwKBltC35+UBeb0i8kbPSKIq8z
=3DI3lE
-----END PGP SIGNATURE-----

