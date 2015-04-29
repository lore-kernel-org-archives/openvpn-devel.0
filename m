Message-ID: <5540C63F.5010607@...515...>
Date: Wed, 29 Apr 2015 14:53:35 +0300
From: =?windows-1252?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
MIME-Version: 1.0
References: <1427784294-22175-1-git-send-email-samuli@...515...>
	<551A4A9B.6010508@...68...>
In-Reply-To: <551A4A9B.6010508@...68...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="9xv33suTM2bxnjjhnTGsr1HrqWQvfpLSe"
Subject: Re: [Openvpn-devel] [PATCH] Remove useless dash escapes from the
 man-page
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Matthias Andree <matthias.andree@...68...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--9xv33suTM2bxnjjhnTGsr1HrqWQvfpLSe
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable


> Am 31.03.2015 um 08:44 schrieb samuli@...515...:
>> From: Samuli Sepp=E4nen <samuli@...515...>
>>
>> This patch is against the release/2.3 branch
>>
>> Trac: 512
>> Signed-off-by: Samuli Sepp=E4nen <samuli@...515...>
>> ---
>>  doc/openvpn.8 | 1800 ++++++++++++++++++++++++++++----------------------=
-------
>>  1 file changed, 900 insertions(+), 900 deletions(-)
>>
>> diff --git a/doc/openvpn.8 b/doc/openvpn.8
>> index a95d353..bcd2d76 100644
>> --- a/doc/openvpn.8
>> +++ b/doc/openvpn.8
>> @@ -37,7 +37,7 @@
>>  .TH openvpn 8 "17 November 2008"
>>  .\"*********************************************************
>>  .SH NAME
>> -openvpn \- secure IP tunnel daemon.
>> +openvpn - secure IP tunnel daemon.
> I am concerned this will cause misformattings and inability to search
> for options with leading dashes on some systems - I don't recall
> versions, but I do know that some systems used some sort of Unicode
> (soft?) hyphen for a simple non-escaped MINUS character (ASCII 0x2B).
>
> So, for the release/2.3 branch, NAK for now, and more questions on the
> 2.4/trunk.
>
> My objections will be void the moment that we can be sure that those
> (major) distributions that played with the Unicode outside-ASCII hyphens
> in *roff have gone out of support, and supported versions no longer
> modify the plain ASCII minus, but render it verbatim.
Matthias: I did additional research and it seems that escaping dashes in
_options_ (but nowhere else) is the correct approach, see

<https://community.openvpn.net/openvpn/ticket/512#comment:9>

Any objections to this approach?

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock



--9xv33suTM2bxnjjhnTGsr1HrqWQvfpLSe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlVAxj8ACgkQwp2X7RmNIqPPTgCgo7tm6ql3GWCIPVlP3/Oh5Lsl
R5AAoMHrXpiXmKUFpIHL3cVEi2534yb5
=UTBh
-----END PGP SIGNATURE-----

--9xv33suTM2bxnjjhnTGsr1HrqWQvfpLSe--

