MIME-Version: 1.0
In-Reply-To: <4C96158E.4010201@...1114...>
References: <AANLkTin2N8TOJ9H+kDFVojiTaaG+AxM+dNc9xFM9XpuF@...278...>
	<20100913182543.12172.qmail@...1287...>
	<AANLkTi=a+_88TDwR_8soAkY6EKqzn8u3Kd2rsq8Oc9S2@...278...>
	<4C96158E.4010201@...1114...>
Date: Sun, 19 Sep 2010 21:32:55 +0200
Message-ID: <AANLkTi=jP53kz84e_emCLgekvoWaHnEjLWoEXYiWP=Fi@...278...>
From: Alon Bar-Lev <alon.barlev@...277...>
Subject: Re: [Openvpn-devel] Windows build was messed up!
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
Cc: openvpn-devel@lists.sourceforge.net

Look at the date.... Since ~2007 we are discussing modular.
It is so needed... :)
Better later than ever...

---------- Forwarded message ----------
From: Alon Bar-Lev <alon.barlev@...277...>
Date: Wed, Dec 27, 2006 at 8:20 PM
Subject: Re: [openvpn] cross compile
To: James Yonan <jim@...41...>



Silent again... :)
So there must be something else wrong.
I think that the System of nsis can be replaced with a simple
program/script/file detection.
And I don't know if to convert the DDK build environment to mingw will
be the best think to do, although it is very interesting to do
that :)

So I thought I will raise another idea you won't like...
Why won't you package the easy-rsa and tap in separate packages,
maintaining them with their own versions?
I recommend people to use easy-rsa... But they don't with
to/understand why install OpenVPN.
Also co-linux uses the tap implementation...

I don't mean all component should not be under the same installer...
But maintained as separate components, each have its own installer.

Best Regards,
Alon Bar-Lev.


On Sun, Sep 19, 2010 at 3:52 PM, David Sommerseth
<openvpn.list@...1114...> wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> On 13/09/10 21:15, Alon Bar-Lev wrote:
>> On Mon, Sep 13, 2010 at 8:25 PM, Peter Stuge <peter@...1287...> wrote:
>>> autotools is absolutely alien in Windows, and to be honest a bit of a
>>> hassle to set up if you're already a VS wizard.
>>
>> In OpenVPN upstream provides binaries using mingw anyway.
>> So there is no need to support any other environment for Windows.
>> This makes it easy.
>> Also, please keep in mind that OpenVPN is not a library... so much
>> easier to manage.
>>
>>>> and the mixture of different projects: openvpn, tap, windows
>>>> installer, easy-rsa.
>>>
>>> How can the installer situation be improved? I want to make an NSIS
>>> installer as well, and I would quite like to keep it *within* the
>>
>> I just saying that most users do not interested in compiling the tap
>> driver, also compiling the tap driver requires Microsoft DDK. So
>> separating the tap into its own release management would be wise... a
>> separate MSI for the TAP that can be embedded within other installers.
>>
>> Easy-rsa has nothing to do with openvpn, it is great that it is
>> provided, but as a separate process, fix in easy-rsa should not modify
>> openvpn release
>>
>> The same for Windows installer, a fix in Windows installer should not
>> modify openvpn version, as it has nothing to do with it.
>
> Alon, I completely agree with you! =C2=A0And I think this is going to bit=
e us
> harder in the future if we don't begin to think about alternatives. =C2=
=A0So
> thank you for brining this up!
>
> - From my point of view, it makes not much sense to provide building
> support for other Windows platforms than mingw for the OpenVPN binary.
> And I do share your opinion about the TAP driver, as well as easy-rsa
> and Windows installer.
>
> Another issue which has bitten us lately is also that we needed to
> release a new OpenVPN *version* because the build scripts changed, which
> meant increasing the version number. =C2=A0In this case, we should normal=
ly
> just need to update a build number on Windows and not the complete
> OpenVPN release version for all platforms. =C2=A0How things are now, we e=
ven
> need to update the OpenVPN version number if we only update the Windows
> TAP driver, which is relevant for only one platform.
>
> My suggestion is that we first move those parts related to the Windows
> TAP driver, Windows installer and easy-rsa into separate git trees.
> Next, the Windows building scripts needs to be split up, so that there's
> a separate building process for Windows TAP driver and the OpenVPN
> binary. =C2=A0As those processes *are* different, it should actually simp=
lify
> the building process in the long run. =C2=A0Then we need to come up with a
> better Windows installer process, which f.ex. can require a pre-compiled
> TAP and OpenVPN binary.
>
> This way, it can also be easier for people creating installers for Mac
> OSX as well, maybe even other platforms which uses their own installers.
>
> For those wanting to pull down everything in one go ... we can always
> look into git submodule, which can pull down several separate git trees
> in a few operations. =C2=A0This might be useful for the Windows installer,
> especially to include the easy-rsa files.
>
> The time frame I imagine for this is when OpenVPN 2.2 is released.
> That's a reasonable time to think this through and we need to do some
> other improvements to the git tree when we release OpenVPN 2.2. =C2=A0As a
> side-note, I hope we will be able to get 2.2 released within this year.
>
>
> Alon, when it comes to your patch, I've looked at it, and it looks sane
> to me. =C2=A0But as I'm neither a Windows developer nor an autotools expe=
rt,
> I'll wait for an ACK from someone who can understand it better. =C2=A0But
> I'll try to remember to bring it up on Thursday's developments meeting,
> unless someone ACKs it earlier.
>
>
> kind regards,
>
> David Sommerseth
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.4.10 (GNU/Linux)
> Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/
>
> iEYEARECAAYFAkyWFYoACgkQDC186MBRfrrZKQCfbZIH4kLB/lFLO/CVdbTxRT3f
> iXAAmQGl+sndowcQlqXXwDzK4Wv/xEI9
> =3DmvMe
> -----END PGP SIGNATURE-----
>

