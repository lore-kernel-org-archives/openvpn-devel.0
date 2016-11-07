References: <915ececd-c052-01b7-6051-74b3bc87b5fb@...515...>
	<CAFHpkQHU-AO88yQBuxpV9yWGYAsaMjkPX6_cramD4fHP5PtSBg@...278...>
	<992ac0c7-1938-1f18-3b85-67d39c114c75@...515...>
	<CAFHpkQFD4W=Mk1VMQXvGtJa2RwjOasDxZ7=ibmE9+d2gEHz-_w@...278...>
	<d76496aa-07f1-0819-35fc-96c9416858a5@...515...>
	<CAFHpkQELZELZC+OJF6BtciQEWkbTJcuCQE66PJr=o-ELm8uCKg@...278...>
From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
Message-ID: <bd61206b-bdf7-3585-53ed-bc6ea1667add@...515...>
Date: Mon, 7 Nov 2016 19:32:05 +0200
MIME-Version: 1.0
In-Reply-To: <CAFHpkQELZELZC+OJF6BtciQEWkbTJcuCQE66PJr=o-ELm8uCKg@...278...>
Subject: Re: [Openvpn-devel] Topics for the upcoming (Monday,
 7th Nov 2016) community meeting
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
To: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Il 07/11/2016 19:16, =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=D0=B8=D1=
=86=D0=B8=D0=BD ha scritto:
> the automatic update functionality is definetily missing for windows part.
> I'll try chocolatey for that.

Yeah. The last time I checked (~year ago) setting up Chocolatey repos=20
was a bit painful. The "normal" way to setup a repository was to use=20
some horrible Visual Studio kludge integrated with IIS. There were, at=20
that time, other options for settin up repositories on *NIX, but I did=20
not have time to look into them in any detail.

Let me know how it goes! I will also try to dive into this a.s.a.p.

Samuli


>
> 2016-11-07 22:11 GMT+05:00 Samuli Sepp=C3=A4nen <samuli@...515...
> <mailto:samuli@...515...>>:
>
>     Il 07/11/2016 18:56, =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=D0=
=B8=D1=86=D0=B8=D0=BD ha scritto:
>
>
>
>         2016-11-07 20:50 GMT+05:00 Samuli Sepp=C3=A4nen <samuli@...515...
>         <mailto:samuli@...515...>
>         <mailto:samuli@...515... <mailto:samuli@...515...>>>:
>
>             Il 07/11/2016 15:15, =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=
=BF=D0=B8=D1=86=D0=B8=D0=BD ha scritto:
>
>                 Hello,
>
>                 I used @mattock's powershell scripts
>
>                 voila :)
>
>
>         https://jk.testkontur.ru/job/openvpn%20connect%20to%20jk-test/3/c=
onsole
>         <https://jk.testkontur.ru/job/openvpn%20connect%20to%20jk-test/3/=
console>
>
>         <https://jk.testkontur.ru/job/openvpn%20connect%20to%20jk-test/3/=
console
>         <https://jk.testkontur.ru/job/openvpn%20connect%20to%20jk-test/3/=
console>>
>
>                 it is strange for few reasons, but it looks very
>         promising. we can
>                 automate a lot of testing in such way.
>
>
>             Nice! At some point I wanted to implement a Powershell-based
>             "buildslave" that could run in the background on Windows.
>         Several
>             people could run that "buildslave" to test latest OpenVPN
>         Windows
>             build against their respective OpenVPN servers.
>
>
>         it is not that hard to run jenkins buildslave, we use it in
>         production.
>
>         https://jk.testkontur.ru/job/openvpn%20connect%20to%20jk-test/4/c=
onsole
>         <https://jk.testkontur.ru/job/openvpn%20connect%20to%20jk-test/4/=
console>
>
>
>         it's getting better :)
>
>
>     Yeah, and I'm definitely _not_ adding Jenkins to _our_ mix right now =
:).
>
>     Windows is special in the sense that we don't build OpenVPN on that
>     platform. The cross-compile part is being tested on several levels
>     already, so testing the openvpn.exe executable is the more
>     interesting part.
>
>     One way to get the latest cross-compiled Windows installers easily
>     into the hands of testers would be to setup our own Chocolatey[1]
>     repository and automatically push latest installers there. The said
>     repository could be used by the Windows "buildslave" to
>     automatically fetch the latest snapshot, install it, and to run
>     connectivity tests using openvpn-windows-test powershell scripts,
>     and to report back any failures.
>
>     This would also speed up Windows release process, as the installers
>     would not really need much extra testing. And we would not have to
>     have as many unused release tags (e.g. 2.4_alpha1) because something
>     got fixed after tagging but before release.
>
>     --
>     Samuli Sepp=C3=A4nen
>     Community Manager
>     OpenVPN Technologies, Inc
>
>     irc freenode net: mattock
>
>
>     [1] Essentially "apt-get/yum/dnf for Windows":
>
>         <https://chocolatey.org/>
>
>


