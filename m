MIME-Version: 1.0
In-Reply-To: <4F9A9EEE.4010101@...515...>
References: <4F9A9B06.8080105@...515...>
	<CAOazyz12EN3XN0Yq_F4x6yAtOexuZ559R38ZPYwg3VenPowghw@...278...>
	<4F9A9EEE.4010101@...515...>
Date: Fri, 27 Apr 2012 16:32:32 +0300
Message-ID: <CAOazyz28aDw=eyLbQRBXU1KaaXom937adipzcAh_UW0rvuB7XQ@...278...>
From: Alon Bar-Lev <alon.barlev@...277...>
Subject: Re: [Openvpn-devel] Passing custom configure flags to "generic"
	buildsystem?
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
To: =?UTF-8?Q?Samuli_Sepp=C3=A4nen?= <samuli@...515...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

2012/4/27 Samuli Sepp=C3=A4nen <samuli@...515...>:
>
>> 2012/4/27 Samuli Sepp=C3=A4nen <samuli@...515...>:
>>> Hi,
>>>
>>> What is the recommended way of passing configure flags to the "generic"
>>> buildsystem? I'd like to cross-compile for win64 on Linux and have some
>>> features turned on.
>>>
>>> Samuli
>> Hello,
>>
>> Just define the EXTRA_OPENVPN_CONFIG environment variable.
>> Or I don't understand your question....
>>
>> Alon.
> Ok, so I assumed. Tried that already, and from build output it looks as
> if it's working:
>
> --- snip ---
> running CONFIG_SHELL=3D/bin/bash /bin/bash ./configure --prefix=3D/
> --libdir=3D//lib --host=3Dx86_64-w64-mingw32 --target=3D
> --build=3Dx86_64-pc-linux-gnu --program-prefix=3D'' --sbindir=3D/bin
> --enable-password-save
> --- snip ---
>
> However, the resulting binary gives "enable_password_save=3Dfalse", and
> actually using a credentials file fails. I tried this a number of times,
> deleting "image-win64" directory each time.
>
> Any ideas what could cause this?

Reproduced.
I will check this out.

Alon.

