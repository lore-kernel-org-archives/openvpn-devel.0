References: <CAFHpkQE7qT8JZM+ZazgJy7PcGMbWawh+HE7OW-=SGNhnnL1pwA@...278...>
From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
Message-ID: <639d4a79-5f8c-50bf-b452-47896208de5d@...515...>
Date: Mon, 12 Dec 2016 11:22:53 +0200
MIME-Version: 1.0
In-Reply-To: <CAFHpkQE7qT8JZM+ZazgJy7PcGMbWawh+HE7OW-=SGNhnnL1pwA@...278...>
Subject: Re: [Openvpn-devel] openvpn windows feed ?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
To: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Il 11/12/2016 20:44, =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=D0=B8=D1=
=86=D0=B8=D0=BD ha scritto:
> Hello,
>
> as we release new versions of openvpn installer, there are at least two
> "channels"
>
> a) beta
> b) stable
>
> should we also host some rss/atom feed with the most recent versions of
> 2 channels ?
>
> so, that openvpn-gui could check "for updates"
> also, there's an exception for WinXP (which I've no idea what to do with).
>
> it will help users to understand "new version is released, probably I
> should upgrade".

Notifying the user would probably be ok, and for that we'd need some=20
feed. The feed could be much simpler than RSS/Atom, if only machines=20
would read it.

That said, I think Windows application auto-updaters are very=20
distracting, and I would prefer to publish new OpenVPN Windows packages=20
in a Chocolatey repository:

<https://chocolatey.org/>

Chocolatey, as "apt-get for Windows", would take care of OpenVPN=20
upgrades in a clean and non-intrusive fashion. It also removes the need=20
to reinvent the wheel in form of an auto-update daemon.

Cholatey is not just a random third-party application for managing=20
packages for Windows. It is also pluggable as a provider to a more=20
generic Microsoft framework for managing package managers called OneGet.=20
For details, look here:

<https://github.com/OneGet/oneget>
 >https://chocolatey.org/faq>
<http://www.hanselman.com/blog/AptGetForWindowsOneGetAndChocolateyOnWindows=
10.aspx>

One can use Chocolatey standalone, or use it as a OneGet package=20
provider. We could possibly integrate Chocolatey setup with the=20
standalone Windows installers as opt-in.

Anyways, after OpenVPN 2.4.0 is out, I will setup a Chocolatey=20
repository for OpenVPN snapshot packages and see how it works. That will=20
enable the more adventurous Windows users to live on the very edge with=20
minimal manual effort. It will also enable us to automate Windows=20
snapshot testing with openvpn-windows-test[1].

Samuli

[1] <https://github.com/OpenVPN/openvpn-windows-test>

>
> it is great amount of work, I think we can schedule it after 2.4
>
> Cheers,
> Ilya Shipitsin
>
>
>
> -------------------------------------------------------------------------=
-----
> Developer Access Program for Intel Xeon Phi Processors
> Access to Intel Xeon Phi processor-based developer platforms.
> With one year of Intel Parallel Studio XE.
> Training and support from Colfax.
> Order your platform today.http://sdm.link/xeonphi
>
>
>
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>


