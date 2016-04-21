MIME-Version: 1.0
In-Reply-To: <950C8167-A5FF-4F56-9020-C956EED49557@...2127...>
References: <950C8167-A5FF-4F56-9020-C956EED49557@...2127...>
Date: Thu, 21 Apr 2016 12:38:46 +0500
Message-ID: <CAFHpkQGX0Bt+w27nNsDvRYbZnz6+T3oOsYivxLKsoRWR1k8v7A@...278...>
From: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Content-Type: multipart/alternative; boundary=001a11412a4ef2201c0530f9cc16
Subject: Re: [Openvpn-devel] Unit testing in openvpn?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Jens <openvpn-devel@...2127...>
Cc: openvpn-devel <Openvpn-devel@lists.sourceforge.net>

--001a11412a4ef2201c0530f9cc16
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

the most comfortable for github is travis-ci (it runs tests even for pull
requests).
we already use it for openvpn-gui and openvpn-build projects (just build,
those projects do not have any tests yet):

https://travis-ci.org/OpenVPN/openvpn-gui
https://travis-ci.org/OpenVPN/openvpn-build

as for openvpn itself, there's special branch, which is used for coverity
scan on travis-ci:

https://travis-ci.org/OpenVPN/openvpn

and there's some tests for openvpn:
https://github.com/OpenVPN/openvpn/tree/master/tests

2016-04-21 12:12 GMT+05:00 Jens <openvpn-devel@...2127...>:

> Hi
>
> I think that adding unit tests would greatly improve the ease of
> implementing new features for openvpn.  I have spend a lot of time coding
> Java (and others), and unit testing greatly improved my code quality, my
> throughput, and last, but not least, my confidence in the code. Indeed I
> have become very humble when it comes to the question of =E2=80=98what co=
uld
> possibly go wrong with this small change?=E2=80=99
>
> What would be the steps to include unit testing?
> =E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=
=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=
=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=
=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94
>
> 1) Decide /if/ we want unit tests
> 2) Decide /how/ we want unit tests (this includes questions like
> dependency management, and the build system)
> 3) Decide /which/ framework to use
> 4) do it
>
> How: Dependency management
> =E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=
=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=
=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=
=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94
>
> Adding a test framework would require a way to include & track this
> dependency.
>
> I see three possibilities
>
> * Copy-and-forget: Add a copy the upstream testing framework and add it
> as-is to the source code repo.
> * Include-dependency-management: Add some kind of dependency management,
> e.g. cmake packages.
> * Use-the-SCM: Use git submodules to add the dependency.
>
> I dislike Copy-and-forget because it pollutes the repository, and makes
> tracking upstream changes very hard.
>
> I have no experience with Makefile based dependency management
>
> But I do know how to handle a git submodule.
>
> I have a very strong preference to using a git submodule for unit testing.
>
>
> Poll
> =E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=
=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=
=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=
=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94
>
> What are your thoughts? Should we add unit tests at all? What would be
> your preferred way for dependency management. Please defer discussion on
> /which/ unit testing framework to use until we have an agreement on the
> /if/ and /how/ (just to prevent the =E2=80=98paint the bike shed=E2=80=99=
 discussion).
>
> Cheers, Jens
>
> -------------------------------------------------------------------------=
-----
> Find and fix application performance issues faster with Applications
> Manager
> Applications Manager provides deep performance insights into multiple
> tiers of
> your business applications. It resolves application problems quickly and
> reduces your MTTR. Get your free trial!
> https://ad.doubleclick.net/ddm/clk/302982198;130105516;z
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>

--001a11412a4ef2201c0530f9cc16
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div><div>the most comfortable for github is travis-c=
i (it runs tests even for pull requests).<br></div>we already use it for op=
envpn-gui and openvpn-build projects (just build, those projects do not hav=
e any tests yet):<br><br><a href=3D"https://travis-ci.org/OpenVPN/openvpn-g=
ui">https://travis-ci.org/OpenVPN/openvpn-gui</a><br><a href=3D"https://tra=
vis-ci.org/OpenVPN/openvpn-build">https://travis-ci.org/OpenVPN/openvpn-bui=
ld</a><br><br></div>as for openvpn itself, there&#39;s special branch, whic=
h is used for coverity scan on travis-ci:<br><br><a href=3D"https://travis-=
ci.org/OpenVPN/openvpn">https://travis-ci.org/OpenVPN/openvpn</a><br><br></=
div>and there&#39;s some tests for openvpn: <a href=3D"https://github.com/O=
penVPN/openvpn/tree/master/tests">https://github.com/OpenVPN/openvpn/tree/m=
aster/tests</a><br></div><div class=3D"gmail_extra"><br><div class=3D"gmail=
_quote">2016-04-21 12:12 GMT+05:00 Jens <span dir=3D"ltr">&lt;<a href=3D"ma=
ilto:openvpn-devel@...2127..." target=3D"_blank">openvpn-devel@...2127...</=
a>&gt;</span>:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .=
8ex;border-left:1px #ccc solid;padding-left:1ex">Hi<br>
<br>
I think that adding unit tests would greatly improve the ease of implementi=
ng new features for openvpn.=C2=A0 I have spend a lot of time coding Java (=
and others), and unit testing greatly improved my code quality, my throughp=
ut, and last, but not least, my confidence in the code. Indeed I have becom=
e very humble when it comes to the question of =E2=80=98what could possibly=
 go wrong with this small change?=E2=80=99<br>
<br>
What would be the steps to include unit testing?<br>
=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=
=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=
=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=
=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94<br>
<br>
1) Decide /if/ we want unit tests<br>
2) Decide /how/ we want unit tests (this includes questions like dependency=
 management, and the build system)<br>
3) Decide /which/ framework to use<br>
4) do it<br>
<br>
How: Dependency management<br>
=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=
=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=
=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=
=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94<br>
<br>
Adding a test framework would require a way to include &amp; track this dep=
endency.<br>
<br>
I see three possibilities<br>
<br>
* Copy-and-forget: Add a copy the upstream testing framework and add it as-=
is to the source code repo.<br>
* Include-dependency-management: Add some kind of dependency management, e.=
g. cmake packages.<br>
* Use-the-SCM: Use git submodules to add the dependency.<br>
<br>
I dislike Copy-and-forget because it pollutes the repository, and makes tra=
cking upstream changes very hard.<br>
<br>
I have no experience with Makefile based dependency management<br>
<br>
But I do know how to handle a git submodule.<br>
<br>
I have a very strong preference to using a git submodule for unit testing.<=
br>
<br>
<br>
Poll<br>
=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=
=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=
=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=
=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94<br>
<br>
What are your thoughts? Should we add unit tests at all? What would be your=
 preferred way for dependency management. Please defer discussion on /which=
/ unit testing framework to use until we have an agreement on the /if/ and =
/how/ (just to prevent the =E2=80=98paint the bike shed=E2=80=99 discussion=
).<br>
<br>
Cheers, Jens<br>
---------------------------------------------------------------------------=
---<br>
Find and fix application performance issues faster with Applications Manage=
r<br>
Applications Manager provides deep performance insights into multiple tiers=
 of<br>
your business applications. It resolves application problems quickly and<br>
reduces your MTTR. Get your free trial!<br>
<a href=3D"https://ad.doubleclick.net/ddm/clk/302982198;130105516;z" rel=3D=
"noreferrer" target=3D"_blank">https://ad.doubleclick.net/ddm/clk/302982198=
;130105516;z</a><br>
_______________________________________________<br>
Openvpn-devel mailing list<br>
<a href=3D"mailto:Openvpn-devel@lists.sourceforge.net">Openvpn-devel@...1199...=
sourceforge.net</a><br>
<a href=3D"https://lists.sourceforge.net/lists/listinfo/openvpn-devel" rel=
=3D"noreferrer" target=3D"_blank">https://lists.sourceforge.net/lists/listi=
nfo/openvpn-devel</a><br>
</blockquote></div><br></div>

--001a11412a4ef2201c0530f9cc16--

