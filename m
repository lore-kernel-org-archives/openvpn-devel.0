MIME-Version: 1.0
In-Reply-To: <4F421C32.1040403@...1114...>
References: <1329594252-5257-1-git-send-email-heiko.hund@...1489...>
	<4F421C32.1040403@...1114...>
Date: Mon, 20 Feb 2012 15:44:54 +0200
Message-ID: <CAOazyz3-M4_tqhW0wdBjMsCM5HDBYNGVj4h-1BHTurAqfocvsA@...278...>
From: Alon Bar-Lev <alon.barlev@...277...>
Subject: Re: [Openvpn-devel] [PATCH] define access mode flag X_OK as 0 on
	Windows
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
To: David Sommerseth <openvpn.list@...1114...>, Heiko Hund <heiko.hund@...1489...>
Cc: openvpn-devel@lists.sourceforge.net

Big NAK.

This X_OK is standard define.
It exists in mingw as 1.
OpenVPN should not check execute if unsupported by OS, not changing
standard constants.

Heiko,
Where exactly is the problem?
When directories are checked or script?
Correct patch would be to have a macro for execute ok in option.c
which is declared differently for windows.

Alon.

On Mon, Feb 20, 2012 at 12:10 PM, David Sommerseth
<openvpn.list@...1114...> wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> On 18/02/12 20:44, Heiko Hund wrote:
>> The _access and _waccess functions in Windows don't know about X_OK
>> (1). If you pass an uneven mode flag the C runtime's default invalid
>> parameter handler ends execution of openvpn.
>>
>> Signed-off-by: Heiko Hund <heiko.hund@...1489...> --- win/config.h.in
>> | =C2=A0 =C2=A02 +- 1 files changed, 1 insertions(+), 1 deletions(-)
>>
>
> ACK and applied to master branch on -testing and -stable trees.
>
> commit 4ebc587eab73e03ef64d344a5707d84e7f8d875a
> Author: Heiko Hund <heiko.hund@...1489...>
> Date: =C2=A0 Sat Feb 18 20:44:12 2012 +0100
>
> =C2=A0 =C2=A0define access mode flag X_OK as 0 on Windows
>
> =C2=A0 =C2=A0Signed-off-by: Heiko Hund <heiko.hund@...1489...>
> =C2=A0 =C2=A0Acked-by: David Sommerseth <davids@...1347...>
> =C2=A0 =C2=A0Signed-off-by: David Sommerseth <davids@...1347...>
>
>
> kind regards,
>
> David Sommerseth
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.4.11 (GNU/Linux)
> Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/
>
> iEYEARECAAYFAk9CHC8ACgkQDC186MBRfrrHegCfUMxu2lHG4Rso8cw1qt7eLEZN
> OgAAn0cAwDCQKUq5MLJd6WAZJeVsdyje
> =3D2vak
> -----END PGP SIGNATURE-----
>
> -------------------------------------------------------------------------=
-----
> Try before you buy =3D See our experts in action!
> The most comprehensive online learning library for Microsoft developers
> is just $99.99! Visual Studio, SharePoint, SQL - plus HTML5, CSS3, MVC3,
> Metro Style Apps, more. Free future releases when you subscribe now!
> http://p.sf.net/sfu/learndevnow-dev2
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel

