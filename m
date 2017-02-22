References: <345db0ac-f6e8-8490-a80a-ffbd81972c07@...1856...>
	<20170221211205.GF93896@...1296...>
	<250998c4-9b20-dcc0-90eb-d432a911e7ba@...2080...>
	<20170222073910.GG93896@...1296...>
From: Steffan Karger <steffan.karger@...1435...>
Message-ID: <dc42f147-496f-1ea7-0fb3-a14197a697dd@...1435...>
Date: Wed, 22 Feb 2017 09:30:39 +0100
MIME-Version: 1.0
In-Reply-To: <20170222073910.GG93896@...1296...>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="rL70seOW5PwPn4lO1LPw4wl5Vsqi3tC1G"
Subject: Re: [Openvpn-devel] [PATCH] Fix segfault when using crypto lib
 without AES-256-CTR or SHA256
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--rL70seOW5PwPn4lO1LPw4wl5Vsqi3tC1G
Content-Type: multipart/mixed; boundary="L1pQU9nwGVfqbieVEujjExL13x7KFLxo0";
	protected-headers="v1"
From: Steffan Karger <steffan.karger@...1435...>
To: openvpn-devel@lists.sourceforge.net
Message-ID: <dc42f147-496f-1ea7-0fb3-a14197a697dd@...1435...>
Subject: Re: [Openvpn-devel] [PATCH] Fix segfault when using crypto lib
	without AES-256-CTR or SHA256
References: <345db0ac-f6e8-8490-a80a-ffbd81972c07@...1856...>
	<20170221211205.GF93896@...1296...>
	<250998c4-9b20-dcc0-90eb-d432a911e7ba@...2080...>
	<20170222073910.GG93896@...1296...>
In-Reply-To: <20170222073910.GG93896@...1296...>

--L1pQU9nwGVfqbieVEujjExL13x7KFLxo0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

On 22-02-17 08:39, Gert Doering wrote:
> On Wed, Feb 22, 2017 at 02:21:35AM +0100, David Sommerseth wrote:
>>>> >From d97f526a2ddbf2abe60a64260601ebd742fc00cc Mon Sep 17 00:00:00 2001
>>>> From: "Simon (simix)" <via-trac>
>>>
>>> Do we have a policy how to handle patches with missing author info?
>>
>> I see no reason at all why we should not give proper credit with full
>> name.=20=20
>=20
> That was only half the question - of course I *want* to give full credits,
> but is "not having this information available & no SoB line" a reason
> for rejecting a patch?
>=20
> The patch in question is quite obvious, so this is not something to bring
> in the lawyers - more a matter of general policy.

Same here.

For this specific patch:  I asked the reporter on trac for full name and
email last night.  We can wait for a bit to see if he replies.

In general: what do we do when we don't get a full name and email, but
do want to apply the patch?  Wait forever?  Claim authorship (but refer
to the trac ticket in the commit msg)?  Apply anyway?  ...?

(While typing this, I realize this sounds like a topic for the meeting
tonight.  I'll put it on the agenda.)

-Steffan


--L1pQU9nwGVfqbieVEujjExL13x7KFLxo0--

--rL70seOW5PwPn4lO1LPw4wl5Vsqi3tC1G
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJYrUwvAAoJEEEwndWOY1w5MfIH/j11PzcqLw3WD51BpOoFGsZ5
9mXnICGMcwOhqYxMV7MfxiXjyEEusLfbHeAjNmr3HelruEijz86/ev7Gos16BXUr
LpghFHDr5FkZlev/cVaeYfT3pfmKTmt+ENJhcAopNt8vkJ3Fy2KFv5rII9tMRySF
/KMJ0pz6ucV2j3VV9jTq9mdXdnx4mzJNanvWOVXkQK5y29fbK1iVlgc3I/T63+cQ
A0tlHEfGpTtVFhpluVYNQ4D2WYe7LK+Nie5Tb/20qpSfaBqzi+qD8Re673Mpbas7
4T1h2Md/8sAvk0aUK6WTbmwvO1TxFxeP8Z1iz+SfrwRzTPmXKHuWvgZiYh219y4=
=jhg+
-----END PGP SIGNATURE-----

--rL70seOW5PwPn4lO1LPw4wl5Vsqi3tC1G--

