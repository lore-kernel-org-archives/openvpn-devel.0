References: <345db0ac-f6e8-8490-a80a-ffbd81972c07@...1856...>
	<20170221211205.GF93896@...1296...>
	<250998c4-9b20-dcc0-90eb-d432a911e7ba@...2080...>
	<20170222073910.GG93896@...1296...>
	<dc42f147-496f-1ea7-0fb3-a14197a697dd@...1435...>
	<20170222095447.GJ12961@...2182...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <21640c66-ed5a-3861-9608-2eec52972a17@...2080...>
Date: Wed, 22 Feb 2017 14:47:47 +0100
MIME-Version: 1.0
In-Reply-To: <20170222095447.GJ12961@...2182...>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="LCHEJ1x39hMpuxn2bD8E9PSgPVvOsd4vu"
Subject: Re: [Openvpn-devel] [PATCH] Fix segfault when using crypto lib
 without AES-256-CTR or SHA256
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Antonio Quartulli <a@...2181...>, Steffan Karger <steffan.karger@...1435...>
Cc: openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--LCHEJ1x39hMpuxn2bD8E9PSgPVvOsd4vu
Content-Type: multipart/mixed; boundary="KIC0Wjlfe5uhC1oruEl2whKGqUl3jCilW";
	protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
To: Antonio Quartulli <a@...2181...>,
	Steffan Karger <steffan.karger@...1435...>
Cc: openvpn-devel@lists.sourceforge.net
Message-ID: <21640c66-ed5a-3861-9608-2eec52972a17@...2080...>
Subject: Re: [Openvpn-devel] [PATCH] Fix segfault when using crypto lib
	without AES-256-CTR or SHA256
References: <345db0ac-f6e8-8490-a80a-ffbd81972c07@...1856...>
	<20170221211205.GF93896@...1296...>
	<250998c4-9b20-dcc0-90eb-d432a911e7ba@...2080...>
	<20170222073910.GG93896@...1296...>
	<dc42f147-496f-1ea7-0fb3-a14197a697dd@...1435...>
	<20170222095447.GJ12961@...2182...>
In-Reply-To: <20170222095447.GJ12961@...2182...>

--KIC0Wjlfe5uhC1oruEl2whKGqUl3jCilW
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

On 22/02/17 10:54, Antonio Quartulli wrote:
> On Wed, Feb 22, 2017 at 09:30:39AM +0100, Steffan Karger wrote:
>> On 22-02-17 08:39, Gert Doering wrote:
>>> On Wed, Feb 22, 2017 at 02:21:35AM +0100, David Sommerseth wrote:
>>>>>> >From d97f526a2ddbf2abe60a64260601ebd742fc00cc Mon Sep 17 00:00:00 2=
001
>>>>>> From: "Simon (simix)" <via-trac>
>>>>>
>>>>> Do we have a policy how to handle patches with missing author info?
>>>>
>>>> I see no reason at all why we should not give proper credit with full
>>>> name.=20=20
>>>
>>> That was only half the question - of course I *want* to give full credi=
ts,
>>> but is "not having this information available & no SoB line" a reason
>>> for rejecting a patch?
>>>
>>> The patch in question is quite obvious, so this is not something to bri=
ng
>>> in the lawyers - more a matter of general policy.
>>
>> Same here.
>>
>> For this specific patch:  I asked the reporter on trac for full name and
>> email last night.  We can wait for a bit to see if he replies.
>>
>> In general: what do we do when we don't get a full name and email, but
>> do want to apply the patch?  Wait forever?  Claim authorship (but refer
>> to the trac ticket in the commit msg)?  Apply anyway?  ...?
>=20
> IMHO somebody has to take ownership of every piece of code release under =
a given
> license (just to avoid any future problem). So the patch should not be ap=
plied
> as is.
>=20
> Then ...
> in theory, you can't take ownership of somebody else' work, but nothing p=
revents
> you from re-writing a "very similar" patch and sign it yourself. In parti=
cular
> if the author did not show any interest in pursuing this any further.
>=20

+1


--=20
kind regards,

David Sommerseth
OpenVPN Technologies, Inc



--KIC0Wjlfe5uhC1oruEl2whKGqUl3jCilW--

--LCHEJ1x39hMpuxn2bD8E9PSgPVvOsd4vu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCAAGBQJYrZaHAAoJEIbPlEyWcf3yPg8QAIrJ+OjQehLU+WO7ruScEhmG
iUIsIe0k7RVt1BiXG9gqekCN1J7E6Kp3JhZVrd3VzwIR2Tb8qSYYF4m6r2w5OHBO
rfZR4WmbylWeaA/ENocB9gEuDpPAZNY6pFHNhPSNh4FLTRY2rT0gA0bA9E1Wuy7G
2iZ23Ts7sYweCGliLiaKxTDDFIor0DenVoUBWT51aRMS3+xkKugNZDwLv9iAlrOf
gUK/+CgveRXwSDBSktI69NVH14MW1cgnhFy3JlCIhSd8RmBdSirlA/SKeIn1rDO2
WUQ/YzNhpwfSLlIKL3AAtTbYB9aIPJJy41ItCo5UEZDFNlaQA6MxpNozFCjQ727A
aAVCz4MZp174JXL+lPpIA6S1V9p9m8X39OAcxztPtiEJ261yLOJme800VVz3Sg+U
FPP/JFC7IrBYr5phOW4Hi4OSKvxCFjoC/Dc+//AmqNHlqvfV32l4dRYLBhhh2U4Q
PINuXQy46cl2mltDqHOem0GNunYaG5cBb6aV9Hx2xjyLTPp6ZHXcWujaASF2y27I
LR8TokX5Baw6V5Kb4Bevjcs8LrikB+1xeWn4Pks/ZViPanjQRW/E0JF/7tk/JokL
xTcPOkHLrW7vwEr2FBKyyv1WrT/K/+vfYqqHfmEe6mzgURV1tapxpsdOD7qgvWJJ
4nITIDXlQJ1bmFRYJQQe
=uhV2
-----END PGP SIGNATURE-----

--LCHEJ1x39hMpuxn2bD8E9PSgPVvOsd4vu--

