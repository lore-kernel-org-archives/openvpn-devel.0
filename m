References: <1484297432-14435-1-git-send-email-chipitsine@...277...>
	<7dc75a19-451e-effa-503a-ac5b75a23bab@...515...>
	<ac93d2de-d56a-0ff9-b97a-a590923f5cf8@...2080...>
	<CAFHpkQEHRCveRiiBWscwLQ7U3UoJ+yY5_0Lx82UMc=f4ucwMbQ@...278...>
	<CAFHpkQFs5x_7MEH5gjieUsp=1f2SPdG9Fr6PeakgBGrSEPQC_Q@...278...>
	<6256c846-ca60-be4f-7122-60465374a322@...515...>
	<7e7799f0-e2f1-8773-18aa-6a89b87d3500@...2080...>
	<b907084b-77a5-3152-3ff9-366ecd1bf5a4@...515...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <c5ee49ab-4a0e-5b13-7571-8422184645e6@...2080...>
Date: Thu, 2 Feb 2017 14:25:19 +0100
MIME-Version: 1.0
In-Reply-To: <b907084b-77a5-3152-3ff9-366ecd1bf5a4@...515...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="oKUeWri11XBrpEl92n34qkMjPf3Ak6BfB"
Subject: Re: [Openvpn-devel] [PATCH] add PR template in order to simplify
 new developers cooperate properly if they open PR. discussed here:
 https://sourceforge.net/p/openvpn/mailman/message/35601310/
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>, openvpn-devel@lists.sourceforge.net, =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC4?= =?UTF-8?B?0L0=?= <chipitsine@...277...>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--oKUeWri11XBrpEl92n34qkMjPf3Ak6BfB
Content-Type: multipart/mixed; boundary="9EirIssSesbBpHj35Lcwgvpl17kWWMMAA";
	protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
To: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>,
	openvpn-devel@lists.sourceforge.net,
	=?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC4?=
	=?UTF-8?B?0L0=?= <chipitsine@...277...>
Message-ID: <c5ee49ab-4a0e-5b13-7571-8422184645e6@...2080...>
Subject: Re: [Openvpn-devel] [PATCH] add PR template in order to simplify new
	developers cooperate properly if they open PR. discussed here:
	https://sourceforge.net/p/openvpn/mailman/message/35601310/
References: <1484297432-14435-1-git-send-email-chipitsine@...277...>
	<7dc75a19-451e-effa-503a-ac5b75a23bab@...515...>
	<ac93d2de-d56a-0ff9-b97a-a590923f5cf8@...2080...>
	<CAFHpkQEHRCveRiiBWscwLQ7U3UoJ+yY5_0Lx82UMc=f4ucwMbQ@...278...>
	<CAFHpkQFs5x_7MEH5gjieUsp=1f2SPdG9Fr6PeakgBGrSEPQC_Q@...278...>
	<6256c846-ca60-be4f-7122-60465374a322@...515...>
	<7e7799f0-e2f1-8773-18aa-6a89b87d3500@...2080...>
	<b907084b-77a5-3152-3ff9-366ecd1bf5a4@...515...>
In-Reply-To: <b907084b-77a5-3152-3ff9-366ecd1bf5a4@...515...>

--9EirIssSesbBpHj35Lcwgvpl17kWWMMAA
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On 02/02/17 09:27, Samuli Sepp=C3=A4nen wrote:
> On 31/01/2017 15:49, David Sommerseth wrote:
>> On 30/01/17 13:34, Samuli Sepp=C3=A4nen wrote:
>>> I agree with you on keeping the pull request template minimal and having
>>> the more fine-grained information in Trac.
>>>
>>> ACK.
>>
>> Don't get me wrong!  I agree we should keep the template minimal.  But I
>> yet have to see a developer full of enthusiasm with a fix ready, who
>> just clicked "Send pull request!" who will actually instantly go reading
>> further.  And especially when the information need is fairly
>> comprehensive and not even directly in the first URL being listed.
>>
>> In fact the first place where the patch process is described is here:
>> <https://community.openvpn.net/openvpn/wiki/DeveloperDocumentation#Commu=
nitypatchesandtheacceptanceprocessofthesepatches>.
>>  That is "hidden" in the middle of the wiki on the second URL.  And the
>> first URL provides just a link to the same DeveloperDocumentation wiki p=
age.
>>
>> So I kindly ask you to reconsider the text more carefully once more.
>>
>> From my experience, to get the best success, provide the most critical
>> and as accurate information as quickly as possible.  Once things are
>> behind one URL you need to visit, many ignores it.  If you need to read
>> through more text on that URL, even more will fall off.  But provide
>> links to the more verbose documentation, as some will read it if the
>> first 2-3 sentences sounds intriguing and the contributor have time to
>> be curious.
>>
>> Most developers are lazy beasts ... they just want their patches out
>> ASAP, and documentation are too easily ignored.
>>
>>
>=20
> Well, I asked if anyone had any comments regarding the PR template text,=
=20
> and nobody did. Except when it was ACKed, of course :).
>=20
> I think we need to lure GitHub people into sending patches to the=20
> mailing list. If we describe the full process in the pull request=20
> template, many will just say "meh, too difficult". Once they've sent=20
> their patch to the list they're quite far already, and are unlikely to=20
> quit if we ask them to make minor changes.
>=20
> So what about this:
>=20
> ---
>=20
> # Thank you for your contribution
>=20
> You are welcome to open PR, but they are used for discussion only. All
> patches must eventually go to the openvpn-devel mailing list for review:
>=20
> * https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>=20
> Please send your patch using=20
> [git-send-email](https://git-scm.com/docs/git-send-email). For example=20
> to send your latest commit to the list:
>=20
>      $ git-send-email --to=3Dopenvpn-devel@lists.sourceforge.net HEAD~1
>=20
> For details, see these Wiki articles:
>=20
> * https://community.openvpn.net/openvpn/wiki/Contributing
> * https://community.openvpn.net/openvpn/wiki/DeveloperDocumentation

Thank you!  Much better!

I would just change the order of the URLs below, the Contributing one is
very generic and not very developer specific.  The second one got the
core development contribution details.

For the git-send-email/git send-email ... Antonio and Gert have already
covered that (both are correct).


--=20
kind regards,

David Sommerseth
OpenVPN Technologies, Inc



--9EirIssSesbBpHj35Lcwgvpl17kWWMMAA--

--oKUeWri11XBrpEl92n34qkMjPf3Ak6BfB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJYkzNEAAoJEIbPlEyWcf3yFxgP/1GIzqI8iN35hfsyM0faohvW
LsVFo1hQriyG1vla9ysxDwVOom0/fsOVVyWxLfXrUAwFTb9dEcjPgjpyjqW99hBQ
CTezLJpc264OR/K2R92DEwOl1yXQSBr0yXlxk6bS6goZv1Ot5CIkPJ9ydDG3tHX3
QfsNEeql86k6ZhVuSKvmFP9AnoyfY1JjLk+okgGmO4VawNh7W01XoMl5FS8D4y7R
sltlBl/Q6qKYBe9K0nstU5o/fILcAYW35RP1SAYVM+/V7R2NJO3ze/qv4P5+SoCt
Bop2tPArg2Bq+2mJIepexCVafgjuOjegZzr4ZNUAPZamEa+DEVI1uikUF1dZiZit
PNMhhTB1MB5k24gbVPnYaV1Ecwj6191VHBwmyu+q0IuNVKAoEvoxCfRY6USBSx0D
9gb3iSGdOciYScZ15gJBcdsmyDuBBPFLzS4yZrT4OmU+MQ1v/g5j4ah6bsUTrj3a
Dgze4Cv4Hmdt6f6MxFw/nQ+x0lTRDyLkepAu5lNrvn068w/XdCgpBfI5PKjS3p3c
zZUQOCGNC1TkvxIVqTADTCN8WqOAuBvSQQdvfIDzgOBYv1n5xAMGfEcSKGnpIiun
FzcNyK1UX1qefFQCcaMngGGZz0bGr04rRro01vBBImY7V4sYJUiDAdvRhFeZ2ocO
kQOFJQ73NXWoNniBXPWI
=V7+p
-----END PGP SIGNATURE-----

--oKUeWri11XBrpEl92n34qkMjPf3Ak6BfB--

