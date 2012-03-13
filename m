MIME-Version: 1.0
In-Reply-To: <CABT9mj9Xjs6T_hCA-pcEPUaoCe4ZxZ8-yGHB_MeDReM=wHBa8Q@...278...>
References: <CABT9mj_+3KRELoLQBGK5B14Q=Y_HGGjS48E6bEWnDPuCwBXgtw@...278...>
	<CAOazyz0zS1WjVrLv1u22ZN+cr18ewuzeZnc-5PrSHjss1Cn=ew@...278...>
	<CABT9mj9Xjs6T_hCA-pcEPUaoCe4ZxZ8-yGHB_MeDReM=wHBa8Q@...278...>
Date: Tue, 13 Mar 2012 19:27:23 +0200
Message-ID: <CABT9mj96OXMejAXm3bp3SxY-OHespaPV_tdiYcpCk01BoC94xg@...278...>
From: Athanasios Douitsis <aduitsis@...277...>
Content-Type: multipart/alternative; boundary=000e0cd1e90602fdb904bb232c0e
Subject: Re: [Openvpn-devel] mingw32-built openvpn-2.3-alpha1
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Alon Bar-Lev <alon.barlev@...277...>
Cc: openvpn-devel@lists.sourceforge.net

--000e0cd1e90602fdb904bb232c0e
Content-Type: text/plain; charset=ISO-8859-1

Hi again,

Some more feedback.

1.Trying to use MSVC2010 (or later I suppose) to build the project using
the new method outlined in your link, I noticed that 'vcbuild' has been
removed after vc2008. They recommend using msbuild, whatever that is, which
requires different cli parameters  and also requires that the project be
converted accordingly. You may want to note this for future reference. I
haven't been able to compile, currently trying to find a VC2008
installation to try again.

2.Sometimes the script fails to download the parts that are hosted on
github, I suspect because github emits a 302.


Kind regards,
Athanasios


On Sat, Mar 10, 2012 at 1:31 AM, Athanasios Douitsis <aduitsis@...277...>wrote:

> Hi,
>
> Thanks! Yes I know it's dead, but I thought that, since I did it I might
> take a minute to share my findings, just in case. Can't hurt I suppose!...
>
> I'll try the new build system as well.
>
> Many thanks,
> Athanasios
>
>
>
> On Fri, Mar 9, 2012 at 7:08 PM, Alon Bar-Lev <alon.barlev@...277...>wrote:
>
>> Hello,
>>
>> I am just in the process of rewriting the openvpn build system.
>>
>> Some documentation is available[1].
>>
>> In your case, as you build on Windows, cygwin environment is the
>> appropriate environment. cygwin contains the new mingw toolchain from
>> mingw-w64 (including 32bit).
>>
>> cygwin is maintain, while msys is long dead.
>>
>> Please try it out.
>>
>> Thanks,
>> Alon Bar-Lev.
>>
>> [1]
>> https://community.openvpn.net/openvpn/wiki/BuildingUsingGenericBuildsystem
>>
>> On Fri, Mar 9, 2012 at 6:51 PM, Athanasios Douitsis <aduitsis@...277...>
>> wrote:
>> > Hi everyone,
>> >
>> > First of all, let me say that I am delighted to see 2.3 approaching
>> final
>> > release. This is truly great.
>> >
>> > Just wanted to let you know that there may be some rough edges when
>> trying
>> > to use the source tarball to compile openvpn using mingw32. I suppose
>> nobody
>> > uses mingw anymore, so this not too important, but anyway:
>> >
>> > 1.To get pass the ./configure phase in makeopenvpn, I had to insert a
>> > CFLAGS=' -I /c/mingw/include/ddk' before the ./configure invocation. The
>> > following check:
>> >
>> > dnl ipv6 support
>> > AC_CHECKING([for struct sockaddr_in6 for IPv6 support])
>> > AC_CHECK_TYPE(
>> >       [struct sockaddr_in6],
>> >       [],
>> >       [AC_MSG_ERROR([struct sockaddr_in6 not found, needed for ipv6
>> > transport support.])],
>> >       [#include "syshead.h"])
>> >
>> > in configure.ac could not find the ntddndis.h (located among other
>> places in
>> > /c/mingw/include/ddk) which is included in syshead.h:357. Maybe the
>> > configure.ac needs a little change but I'm not sure what change
>> exactly.
>> > Note, my installation used to be able to compile everything up to 2.2.1
>> > without tinkering. Since these headers are a seemingly new requirement,
>> > maybe a new command line option is needed in the configure script?
>> >
>> > 2.There is also a small error in makeopenvpn, in line 59, instead of
>> GENOUT,
>> > it says GENOOUT. Which, of course, leads to breakage :) Easily fixed,
>> that
>> > one.
>> > 3.Also, compiling OpenSSL from the source package leads to lib/ and bin/
>> > directories under the openssl target path, so the relevant openvpn
>> script
>> > (getopenssl) needs adjustment. Attaching my version for your reference.
>> This
>> > is not strictly an error, just letting everyone know.
>> >
>> > Best Regards,
>> > --
>> > Athanasios Douitsis
>> >
>> >
>> >
>> >
>> >
>> ------------------------------------------------------------------------------
>> > Virtualization & Cloud Management Using Capacity Planning
>> > Cloud computing makes use of virtualization - but cloud computing
>> > also focuses on allowing computing to be delivered as a service.
>> > http://www.accelacomm.com/jaw/sfnl/114/51521223/
>> > _______________________________________________
>> > Openvpn-devel mailing list
>> > Openvpn-devel@lists.sourceforge.net
>> > https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>> >
>>
>
>
>
> --
> Athanasios Douitsis
>
>
>
>


-- 
Athanasios Douitsis

--000e0cd1e90602fdb904bb232c0e
Content-Type: text/html; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi again,<br><br>Some more feedback. <br><br>1.Trying to use MSVC2010 (or l=
ater I suppose) to build the project using the new method outlined in your =
link, I noticed that &#39;vcbuild&#39; has been removed after vc2008. They =
recommend using msbuild, whatever that is, which requires different cli par=
ameters=A0 and also requires that the project be converted accordingly. You=
 may want to note this for future reference. I haven&#39;t been able to com=
pile, currently trying to find a VC2008 installation to try again. <br>
<br>2.Sometimes the script fails to download the parts that are hosted on g=
ithub, I suspect because github emits a 302. <br><br><br>Kind regards,<br>A=
thanasios<br><br><br><div class=3D"gmail_quote">On Sat, Mar 10, 2012 at 1:3=
1 AM, Athanasios Douitsis <span dir=3D"ltr">&lt;<a href=3D"mailto:aduitsis@=
...277...">aduitsis@...277...</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">Hi,<br><br>Thanks! Yes I know it&#39;s dead,=
 but I thought that, since I did it I might take a minute to share my findi=
ngs, just in case. Can&#39;t hurt I suppose!...<br>
<br>I&#39;ll try the new build system as well.<br><br>
Many thanks,<br>Athanasios<div class=3D"HOEnZb"><div class=3D"h5"><br><br><=
br><div class=3D"gmail_quote">On Fri, Mar 9, 2012 at 7:08 PM, Alon Bar-Lev =
<span dir=3D"ltr">&lt;<a href=3D"mailto:alon.barlev@...277..." target=3D"_b=
lank">alon.barlev@...277...</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
Hello,<br>
<br>
I am just in the process of rewriting the openvpn build system.<br>
<br>
Some documentation is available[1].<br>
<br>
In your case, as you build on Windows, cygwin environment is the<br>
appropriate environment. cygwin contains the new mingw toolchain from<br>
mingw-w64 (including 32bit).<br>
<br>
cygwin is maintain, while msys is long dead.<br>
<br>
Please try it out.<br>
<br>
Thanks,<br>
Alon Bar-Lev.<br>
<br>
[1] <a href=3D"https://community.openvpn.net/openvpn/wiki/BuildingUsingGene=
ricBuildsystem" target=3D"_blank">https://community.openvpn.net/openvpn/wik=
i/BuildingUsingGenericBuildsystem</a><br>
<div><div><br>
On Fri, Mar 9, 2012 at 6:51 PM, Athanasios Douitsis &lt;<a href=3D"mailto:a=
duitsis@...277..." target=3D"_blank">aduitsis@...277...</a>&gt; wrote:<br>
&gt; Hi everyone,<br>
&gt;<br>
&gt; First of all, let me say that I am delighted to see 2.3 approaching fi=
nal<br>
&gt; release. This is truly great.<br>
&gt;<br>
&gt; Just wanted to let you know that there may be some rough edges when tr=
ying<br>
&gt; to use the source tarball to compile openvpn using mingw32. I suppose =
nobody<br>
&gt; uses mingw anymore, so this not too important, but anyway:<br>
&gt;<br>
&gt; 1.To get pass the ./configure phase in makeopenvpn, I had to insert a<=
br>
&gt; CFLAGS=3D&#39; -I /c/mingw/include/ddk&#39; before the ./configure inv=
ocation. The<br>
&gt; following check:<br>
&gt;<br>
&gt; dnl ipv6 support<br>
&gt; AC_CHECKING([for struct sockaddr_in6 for IPv6 support])<br>
&gt; AC_CHECK_TYPE(<br>
&gt; =A0=A0=A0=A0=A0 [struct sockaddr_in6],<br>
&gt; =A0=A0=A0=A0=A0 [],<br>
&gt; =A0=A0=A0=A0=A0 [AC_MSG_ERROR([struct sockaddr_in6 not found, needed f=
or ipv6<br>
&gt; transport support.])],<br>
&gt; =A0=A0=A0=A0=A0 [#include &quot;syshead.h&quot;])<br>
&gt;<br>
&gt; in <a href=3D"http://configure.ac" target=3D"_blank">configure.ac</a> =
could not find the ntddndis.h (located among other places in<br>
&gt; /c/mingw/include/ddk) which is included in syshead.h:357. Maybe the<br>
&gt; <a href=3D"http://configure.ac" target=3D"_blank">configure.ac</a> nee=
ds a little change but I&#39;m not sure what change exactly.<br>
&gt; Note, my installation used to be able to compile everything up to 2.2.=
1<br>
&gt; without tinkering. Since these headers are a seemingly new requirement=
,<br>
&gt; maybe a new command line option is needed in the configure script?<br>
&gt;<br>
&gt; 2.There is also a small error in makeopenvpn, in line 59, instead of G=
ENOUT,<br>
&gt; it says GENOOUT. Which, of course, leads to breakage :) Easily fixed, =
that<br>
&gt; one.<br>
&gt; 3.Also, compiling OpenSSL from the source package leads to lib/ and bi=
n/<br>
&gt; directories under the openssl target path, so the relevant openvpn scr=
ipt<br>
&gt; (getopenssl) needs adjustment. Attaching my version for your reference=
. This<br>
&gt; is not strictly an error, just letting everyone know.<br>
&gt;<br>
&gt; Best Regards,<br>
&gt; --<br>
&gt; Athanasios Douitsis<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt;<br>
</div></div>&gt; ----------------------------------------------------------=
--------------------<br>
&gt; Virtualization &amp; Cloud Management Using Capacity Planning<br>
&gt; Cloud computing makes use of virtualization - but cloud computing<br>
&gt; also focuses on allowing computing to be delivered as a service.<br>
&gt; <a href=3D"http://www.accelacomm.com/jaw/sfnl/114/51521223/" target=3D=
"_blank">http://www.accelacomm.com/jaw/sfnl/114/51521223/</a><br>
&gt; _______________________________________________<br>
&gt; Openvpn-devel mailing list<br>
&gt; <a href=3D"mailto:Openvpn-devel@lists.sourceforge.net" target=3D"_blan=
k">Openvpn-devel@lists.sourceforge.net</a><br>
&gt; <a href=3D"https://lists.sourceforge.net/lists/listinfo/openvpn-devel"=
 target=3D"_blank">https://lists.sourceforge.net/lists/listinfo/openvpn-dev=
el</a><br>
&gt;<br>
</blockquote></div><br><br clear=3D"all"><br></div></div><span class=3D"HOE=
nZb"><font color=3D"#888888">-- <br>Athanasios Douitsis<br><br><br><br>
</font></span></blockquote></div><br><br clear=3D"all"><br>-- <br>Athanasio=
s Douitsis<br><br><br><br>

--000e0cd1e90602fdb904bb232c0e--

