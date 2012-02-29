MIME-Version: 1.0
In-Reply-To: <4F4E6104.2000900@...1114...>
References: <CAOBzU4PN6qDxf39+s4noXEiW8hNbDy-hkQWGSauBd3hX0pu2hw@...278...>
	<CAOazyz0f3sERwjZsf3Ts3Xu7CQqBEf_-_VdbUZ7TrzhLbmTEsg@...278...>
	<CAOazyz1buhSdSF7g6MzePAiQ=irD_Qo-RKPC_jXoR9AVqbtkvQ@...278...>
	<CAOBzU4P0SxY-jF7rb_HsvmtSH8i9PCk+qe5iDQiwJhajsBuYuw@...278...>
	<CAOazyz1naScdf+M0pnePS6-bb5deAHsAniTiv+DFw3ZQdAN+kg@...278...>
	<CAOazyz1DE7Y-P9HFK3LN8-HeoGbHzYeqofX3RiEuK0C-zcxnug@...278...>
	<CAOazyz0nV8P8Age_wyFCvu1J4g1MECA7YdTAAL4of7TTVctXow@...278...>
	<1CED409804E2164C8104F9E623B08B90129350BEDF@...1436...>
	<CAOazyz0daYPAH=ooKDenavTyG1qK1=wJv8ZJ0VF+u-vXWBE2xQ@...278...>
	<4F4B456A.8010208@...515...> <4F4B542D.9090309@...1114...>
	<CAOazyz1E809DFQ7-GBvopezmELL+SuW+A5A+EKgbXTsZTNVd8w@...278...>
	<4F4E6104.2000900@...1114...>
Date: Wed, 29 Feb 2012 19:38:20 +0200
Message-ID: <CAOazyz3fg_qSWb92ftSeq3Z7qN1fhfEBnuURfxenOsBbxGWQ4g@...278...>
From: Alon Bar-Lev <alon.barlev@...277...>
Subject: Re: [Openvpn-devel] [PATCH 00/35] build revolution
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: David Sommerseth <openvpn.list@...1114...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

On Wed, Feb 29, 2012 at 7:31 PM, David Sommerseth
<openvpn.list@...1114...> wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> On 28/02/12 22:31, Alon Bar-Lev wrote:
>> Hello,
>>
>> I think I finished. David, tell me if you want me to send the patches
>> to the list. I think these are way too long.
>
> Great! =C2=A0Thank you very much for digging deep into this. =C2=A0I must=
 admit, I
> didn't expect you to go so thoroughly through everything. =C2=A0But we
> definitely will review them asap.

This is 1st stage.
After merge I need to do the 2nd stage - get rid of syshead.h conditionals.

>
> I see something like 52 patches in total, and you've already sent the
> first 35 to the mailing list. =C2=A0I see no issues getting the last 17
> patches to the ML too. =C2=A0Or have you done some kind of rebasing which=
 have
> reordered the patches, which have changed what you've already mailed?

I did.... :)

>
> However, I'm not terrified of 52 patches to the mailing list. =C2=A0That's
> definitely doable.

OK.

>
> Again, thank you very much for all your work!
>
> To the others reading this mail:
>> I will be happy if people can test this.
>
> Please do that ... and report back any issues you find! =C2=A0It would be
> great to have this verified, tested and reviewed in the next coming week
> or so. =C2=A0Then I'll have things applied to the upstream tree.
>
>
> kind regards,
>
> David Sommerseth
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.4.11 (GNU/Linux)
> Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/
>
> iEYEARECAAYFAk9OYQIACgkQDC186MBRfroMGQCgsV1SpO0UmIwJLqaXBTaOJwju
> XjsAmwSv+djd1Ab4tMFqY7R/O2GcW/9K
> =3D6hqo
> -----END PGP SIGNATURE-----

