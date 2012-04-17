MIME-Version: 1.0
In-Reply-To: <4F8D1282.1020803@...515...>
References: <4F881610.5010304@...515...>
	<CAOazyz3RcTS4b8Gc-_ort0T0Zw-hEbUMz-NYab21Ww4pZ4Bxkw@...278...>
	<4F8D1282.1020803@...515...>
Date: Tue, 17 Apr 2012 11:47:44 +0300
Message-ID: <CAOazyz3u1qHqVOBh0ZDUobg17be5SAjVctVC7icqnkAvHjGHNw@...278...>
From: Alon Bar-Lev <alon.barlev@...277...>
Subject: Re: [Openvpn-devel] MSVC build tests on Git "master"
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

2012/4/17 Samuli Sepp=C3=A4nen <samuli@...515...>
>
> Hi Alon,
> >
> >> This allowed the build to proceed, but then I got tons of errors. Those
> >> seem to be caused by Visual Studio 2010 peculiarities; see [4] for a
> >> partial log. The full error log is 1396k in size - If you need it just
> >> let me know.
> > I don't quite understand who you tried to build this... manually or
> > using the openvpn-build/msvc.
> > If you try to build manually, please send me the exact commands you
> > used.
> I used the "msvc-build.bat" (renamed "build.bat" from Git "master") with
> no parameters.

Hmmm.... I still don't follow, sorry.

What is renamed? I see that in git master we have msvc-build.bat....
Or you mean you used this one, which is OK.
But then probably the dependencies setup are wrong.

Please first try to complete build from the openvpn-build project[1].

Use:
> cd msvc
> build

If that's working, then it will be easy to trace problems in your environme=
nt.
If that's not working, it will be easy to trace differences from my environ=
ment.

Thanks!

[1] https://github.com/alonbl/openvpn-build

