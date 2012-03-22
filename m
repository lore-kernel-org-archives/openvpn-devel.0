MIME-Version: 1.0
In-Reply-To: <CAOazyz36gy_Ji6uKxPUzRSYeWxWL5WnZ6j-3vPWfMpT=_6xwrQ@...278...>
References: <4F632647.30603@...515...>
	<20120316114747.GV6615@...1330...>
	<CAOazyz2K4s3V3Yq6W8f9Q2us+vk9ArLT1UX3gKCS4Zxr245o+g@...278...>
	<4F633670.1000807@...1114...>
	<CAOazyz0nMAdD5H2MbBR=+ssOPPHgFsdgxr2g-SwWb4BHzDMdcw@...278...>
	<4F633B0C.8080502@...515...>
	<20120316152145.GF1359@...1296...>
	<4F66EE39.5050405@...515...> <4F66F5ED.30006@...1114...>
	<4F66FE98.4030707@...1114...>
	<20120319094235.GM1359@...1296...>
	<4F6700E1.60201@...1114...>
	<CAOazyz1aPWoiWWg=T7Ykw0YUL0S_wdAE-T6Gg=djpc=iwF9YXg@...278...>
	<4F6B10DC.1080306@...1114...>
	<CAOazyz1d2xRaX6QCqOE3kqNCdSEu+Uj4sf2NVxf-Lxxb4x_nEw@...278...>
	<4F6B2FBF.8050202@...1114...>
	<CAOazyz36gy_Ji6uKxPUzRSYeWxWL5WnZ6j-3vPWfMpT=_6xwrQ@...278...>
Date: Thu, 22 Mar 2012 19:13:16 +0200
Message-ID: <CAOazyz1b443Na6KAmtqfWu3LBX2HuGSbhrhAakAienMt-4pKvw@...278...>
From: Alon Bar-Lev <alon.barlev@...277...>
Subject: Re: [Openvpn-devel] New generic buildsystem: lzo enabled or
 disabled by default?
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
To: David Sommerseth <openvpn.list@...1114...>, =?UTF-8?Q?Samuli_Sepp=C3=A4nen?= <samuli@...515...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Hello,

I will try to rephrase this in different angle as well.

During the time you made a review and found no issues, I took the time
for reviewing my own code and further test, and I found issues to be
fixed, sent the patches to me back to review.

Just think of it as another developer would have found issue which
caused patch resubmit.

The fact that I did find issues while nobody else found means that I
am doing good job in reviewing as well :)

You should take the branch as-is, unless you have explicit comments
for the quality of the code and/or solution.

Alon.

On Thu, Mar 22, 2012 at 5:37 PM, Alon Bar-Lev <alon.barlev@...277...> wrote:
> No.
> Please don't take the patches from the mailing list.
> As I explicitly requested in the past *SEVERAL* times.
>
> I've done minor fixups in my repository.
> As you see my work is in good quality and without comments, issues I
> fixed needs to be fixed in tree as well.
>
> As I requested this approach several times and got no rejection I
> assumed this is acceptable.
>
> This is a *COMPLETE* show stopper.
>
> If you insist in doing that this way I will resend the patch series to th=
e list.
>
> Alon.
>
>
> On Thu, Mar 22, 2012 at 3:57 PM, David Sommerseth
> <openvpn.list@...1114...> wrote:
>> -----BEGIN PGP SIGNED MESSAGE-----
>> Hash: SHA1
>>
>> On 22/03/12 12:47, Alon Bar-Lev wrote:
>>> On Thu, Mar 22, 2012 at 1:45 PM, David Sommerseth
>>> <openvpn.list@...1114...> wrote:
>>>> -----BEGIN PGP SIGNED MESSAGE----- Hash: SHA1
>>>>
>>>> On 19/03/12 16:16, Alon Bar-Lev wrote:
>>>>> The only component that is in question is lzo. I still think this
>>>>> is packager responsibility, not sure why this is an exception. But
>>>>> if it will make people happy, I will enable lzo by default. All
>>>>> the other components are optional by they nature, and again it is
>>>>> up to packager to decide what good for his configuration.
>>>>
>>>> Hi Alon,
>>>>
>>>> Okay, based on the discussion on this thread, it makes sense to then
>>>> flip LZO to be enabled by default.
>>>>
>>>> No need to hurry with any patches, as I can add such a patch on top
>>>> of everything when the merging is completed. =C2=A0The patch will be
>>>> submitted to the mailing list when it's ready to be implemented.
>>>>
>>>
>>> OK, great. I will modify the branch with this (rebase) so it won't
>>> create additional noise. So you be able to do a clean pull with
>>> complete feature set.
>>
>> No, I will take this change as an additional patch - as I stated in my
>> previous response. =C2=A0I don't want to base such changes on patches wh=
ich
>> are already reviewed and ACKed. =C2=A0That invalidates the work queue I'=
m on
>> already. =C2=A0I'm taking patches from the mailing list, that works very=
 well
>> in my workflow - and it gives a good chance of providing the Acked-by
>> statements in the git log.
>>
>>
>> kind regards,
>>
>> David Sommerseth
>>
>> -----BEGIN PGP SIGNATURE-----
>> Version: GnuPG v1.4.11 (GNU/Linux)
>> Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/
>>
>> iEYEARECAAYFAk9rL74ACgkQDC186MBRfroCqwCgqIzkHlcJ7m3qRLMVFapIcVdj
>> OZgAnAzlHiBtFBanDaO/KBO1MQo8zooU
>> =3D+ET7
>> -----END PGP SIGNATURE-----

