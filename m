MIME-Version: 1.0
References: <1538141209-32330-1-git-send-email-lstipakov@...277...>
 <99D61A626FDA8A4B90A270669121BE10991F46BA@...2294...>
In-Reply-To: <99D61A626FDA8A4B90A270669121BE10991F46BA@...2294...>
From: Lev Stipakov <lstipakov@...277...>
Date: Sun, 30 Sep 2018 08:19:01 +0300
Message-ID: <CAGyAFMXddqfZAHu-_aaue49zu_TCaFz4yMBpo6kV9XbZBPqgoQ@...278...>
Content-Type: multipart/alternative; boundary="0000000000001d848505770fd439"
Subject: Re: [Openvpn-devel] [PATCH] win: support for Visual Studio 2017
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: simon@...2293...
Cc: openvpn-devel@lists.sourceforge.net

--0000000000001d848505770fd439
Content-Type: text/plain; charset="UTF-8"

Hi,

>
> I was very delighted to see this contribution. However, after hours of
> struggling to compile and prepare pre-requisites, I gave up my attempts to
> test this patch. The openvpn-build/msvc/build.bat was indeed helpful,
> though a
> bit outdated to be directly usable.
>

Sorry, I probably have to state it more clear in email - I have prepared
patch to openvpn-build as well,
see https://github.com/OpenVPN/openvpn-build/pull/137 The new version
should be usable out of the box.

I don't think you need autoconf or anything besides VS2017 and ActiveState
Perl. Certainly you
are not supposed to copy or edit files manually. Here is build log from
AppVeyor:

https://ci.appveyor.com/project/lstipakov/openvpn-build/build/openvpn-build-19/job/kl2ky4ncbhiqw8gg?fullLog=true


> Now, I have begun to question the rationale of this patch... If it is too
> hard
> to setup building environment for me (Visual Studio is my daily working
> environment from 1998),


We should sort it out. To build with VS you are only supposed to

1) clone openvpn-build
2) run msvc/build.bat
3) (optionally) open msvc/build.tmp/openvpn-master/openvpn.sln with Visual
Studio IDE and enjoy coding

Would have been nice to add Windows 10 ARM64 support, but remembered
> somebody
> needs to compile pre-requisites for ARM64 nightmare...
>

Can TAP driver be compiled for ARM64?


> BTW, I have a patch in my forked repo re-establishing Visual Studio 2017
> support for compiling openvpnserv.exe. I needed it to debug while
> developing
> support for multi-instances
>

With this and openvpn-build patch I was able to debug (run and attach to
process) both openvpn and openvpnserv.exe


> Best regards,
> Simon
>

-- 
-Lev

--0000000000001d848505770fd439
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr">Hi,<div=
 class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margin:0p=
x 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><b=
r>
I was very delighted to see this contribution. However, after hours of <br>
struggling to compile and prepare pre-requisites, I gave up my attempts to =
<br>
test this patch. The openvpn-build/msvc/build.bat was indeed helpful, thoug=
h a <br>
bit outdated to be directly usable.=C2=A0<br></blockquote><div><br></div><d=
iv>Sorry, I probably have to state it more clear in email - I have prepared=
 patch to openvpn-build as well,</div><div>see=C2=A0<a href=3D"https://gith=
ub.com/OpenVPN/openvpn-build/pull/137">https://github.com/OpenVPN/openvpn-b=
uild/pull/137</a> The new version should be usable out of the box.</div><di=
v><br></div><div>I don&#39;t think you need autoconf or anything besides VS=
2017 and ActiveState Perl. Certainly you=C2=A0</div><div>are not supposed t=
o copy or edit files manually. Here is build log from AppVeyor:</div><div><=
br></div><div><a href=3D"https://ci.appveyor.com/project/lstipakov/openvpn-=
build/build/openvpn-build-19/job/kl2ky4ncbhiqw8gg?fullLog=3Dtrue">https://c=
i.appveyor.com/project/lstipakov/openvpn-build/build/openvpn-build-19/job/k=
l2ky4ncbhiqw8gg?fullLog=3Dtrue</a><br></div><div>=C2=A0</div><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid=
 rgb(204,204,204);padding-left:1ex">
Now, I have begun to question the rationale of this patch... If it is too h=
ard <br>
to setup building environment for me (Visual Studio is my daily working <br>
environment from 1998), </blockquote><div><br></div><div>We should sort it =
out. To build with VS you are only supposed to=C2=A0=C2=A0</div><div><br></=
div><div>1) clone openvpn-build</div><div>2) run msvc/build.bat</div><div>3=
) (optionally) open msvc/build.tmp/openvpn-master/openvpn.sln with Visual S=
tudio IDE and enjoy coding</div><div><br></div><blockquote class=3D"gmail_q=
uote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,2=
04);padding-left:1ex">
Would have been nice to add Windows 10 ARM64 support, but remembered somebo=
dy <br>
needs to compile pre-requisites for ARM64 nightmare...<br></blockquote><div=
><br></div><div>Can TAP driver be compiled for ARM64?</div><div>=C2=A0<br><=
/div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bo=
rder-left:1px solid rgb(204,204,204);padding-left:1ex">
BTW, I have a patch in my forked repo re-establishing Visual Studio 2017 <b=
r>
support for compiling openvpnserv.exe. I needed it to debug while developin=
g <br>
support for multi-instances<br></blockquote><div><br></div><div>With this a=
nd openvpn-build patch I was able to debug (run and attach to process) both=
 openvpn and openvpnserv.exe</div><div>=C2=A0</div><blockquote class=3D"gma=
il_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,2=
04,204);padding-left:1ex">
Best regards,<br>
Simon<br>
</blockquote></div><div><br></div>-- <br><div dir=3D"ltr" class=3D"gmail-m_=
-9058010025696570987gmail_signature">-Lev</div></div></div></div></div>

--0000000000001d848505770fd439--

