From: Russell Morris <openvpn@...1315...>
Date: Sun, 26 Feb 2012 10:21:44 -0600
Message-id: <1330273304732282500@...1315...>
In-reply-to: <CAOazyz22spHgCtT7L=w5Jbk3Vhsh2f4_DJjd=mL-=GF4vgW7ew@...278...>
References: <CAOazyz3CAK6Huf7qzAv_Uv+bn5QFFd_cC7A8S_s42HZQGNLC4g@...278...>
	<1330128297432870500@...1315...>
	<CAOazyz3e2ofYxXHiEfxc86nvht87w5_rMqZso8uhKp0i9Y=BhQ@...278...>
	<1330146723797070500@...1315...>
	<CAOazyz3ZC2wivR7RUJCVFW48neDoUob4oh0ciaOA4tS=_sc3YQ@...278...>
	<CAOazyz3XLwxRqRLsaNyECbKEq5g8nN38OPkbBYmenwRaQmKneA@...278...>
	<1330179721253929500@...1315...>
	<CAOazyz32nTGTfN-tMeeEsFzBdOPA9k45zN5KgekfnjxZqiZ4kQ@...278...>
	<CAOazyz22spHgCtT7L=w5Jbk3Vhsh2f4_DJjd=mL-=GF4vgW7ew@...278...>
MIME-version: 1.0
Content-type: multipart/alternative;
	boundary="===axigen=8569780234506728508220164556475213043977=axigen==="
Subject: Re: [Openvpn-devel] [build] Windows build test
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Alon Bar-Lev <alon.barlev@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <Openvpn-devel@lists.sourceforge.net>

This is a MIME message. You may need a MIME compliant mail user agent.
--===axigen=8569780234506728508220164556475213043977=axigen===
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

That does it - it works now, thanks!!!

=20

... Russell

=20



On Sat, 02/25/2012 12:58 PM, Alon Bar-Lev <alon.barlev@...277...> wrote:


>=20
Never mind.
> I guess that mingw is configured as multilib somehow.
> I forced all to use /lib.
> Can you please try again?
>=20
> On Sat, Feb 25, 2012 at 7:28 PM, Alon Bar-Lev <alon.barlev@...277...> wro=
te:
> > Can you send me list:
> > $ find image-win32/openvpn/lib
> > $ find image-win32/openvpn/lib64
> >
> >
> > On Sat, Feb 25, 2012 at 4:22 PM, Russell Morris <openvpn@...1315...> wr=
ote:
> >> Hi,
> >>
> >> OK, I have done some digging - and I know what the issue is! Not sure =
how to
> >> fix it though ... :-).
> >>
> >> Inside the image-win64 directory, and then inside openvpn - running the
> >> build script results in two directories, lib and lib64 (for image-win32
> >> there is only the lib directory). The libraries noted as missing are i=
nside
> >> lib64, not lib ... so they are not seen. I have seen this issue before=
. Then
> >> the fix was to link lib64 to lib, and I tried this in this case - but =
the
> >> script seems to delete the directories and recreate them (so the link =
is
> >> gone).
> >>
> >> Thoughts?
> >>
> >> Thanks!
> >>
> >> ... Russell
> >>
> >>
> >>
> >>
> >> On Sat, 02/25/2012 03:23 AM, Alon Bar-Lev <alon.barlev@...277...> wrot=
e:
> >>
> >> And also full output of the build script...
> >>
> >> ..... 2>&1 | gzip > /tmp/build.log
> >>
> >> On Sat, Feb 25, 2012 at 11:14 AM, Alon Bar-Lev <alon.barlev@...277...>
> >> wrote:
> >>> I need the tmp/openvpn*/config.log
> >>>
> >>> On Sat, Feb 25, 2012 at 7:12 AM, Russell Morris <openvpn@...1315...>
> >>> wrote:
> >>>> Hi,
> >>>>
> >>>> I used the command line you provided below (actually, copied and pas=
ted
> >>>> it
> >>>> to the command line). The one having issues is:
> >>>> IMAGEROOT=3D`pwd`/image-win64
> >>>> CHOST=3Dx86_64-w64-mingw32 CBUILD=3Dx86_64-pc-linux-gnu ./build
> >>>>
> >>>> Thanks!
> >>>>
> >>>> ... Russell
> >>>>
> >>>>
> >>>>
> >>>> On Fri, 02/24/2012 06:11 PM, Alon Bar-Lev <alon.barlev@...277...> wr=
ote:
> >>>>
> >>>> How exactly did you try to build?
> >>>> Please send command-line.
> >>>>
> >>>> The mingw32 suffix is historic, it is kept for compatibility as old
> >>>> autotools(config.guess) packages expects for mingw32 as a platform, =
in
> >>>> the old days there was no (forced) standard for specifying the arch.
> >>>>
> >>>> On Sat, Feb 25, 2012 at 2:04 AM, Russell Morris
> >>>> <openembedded@...1315...> wrote:
> >>>>> Hi,
> >>>>>
> >>>>> First of all - thanks for this! It's very much appreciated!
> >>>>>
> >>>>> I tried this on my Linux box, and it worked fine - for the win32 im=
age.
> >>>>> However, the win64 image fails, with the following error ...
> >>>>>
> >>>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>>>>
> >>>>>
> >>>>>
> >>>>> /usr/lib64/gcc/x86_64-w64-mingw32/4.6.2/../../../../x86_64-w64-ming=
w32/bin/ld:
> >>>>> cannot find -llzo2
> >>>>>
> >>>>>
> >>>>> /usr/lib64/gcc/x86_64-w64-mingw32/4.6.2/../../../../x86_64-w64-ming=
w32/bin/ld:
> >>>>> cannot find -lpkcs11-helper
> >>>>> collect2: ld returned 1 exit status
> >>>>> make[3]: *** [openvpn.exe] Error 1
> >>>>> make[3]: Leaving directory
> >>>>>
> >>>>>
> >>>>> `/home/rmorris/Documents/Programming/openvpn-build/generic/tmp/open=
vpn-2.3-alpha1/src/openvpn'
> >>>>> make[2]: *** [install-recursive] Error 1
> >>>>> make[2]: Leaving directory
> >>>>>
> >>>>>
> >>>>> `/home/rmorris/Documents/Programming/openvpn-build/generic/tmp/open=
vpn-2.3-alpha1/src'
> >>>>> make[1]: *** [install-recursive] Error 1
> >>>>> make[1]: Leaving directory
> >>>>>
> >>>>>
> >>>>> `/home/rmorris/Documents/Programming/openvpn-build/generic/tmp/open=
vpn-2.3-alpha1'
> >>>>> make: *** [install-strip] Error 2
> >>>>> FATAL: make openvpn
> >>>>>
> >>>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>>>>
> >>>>> Has anyone else seen this? Any thoughts how to correct it?
> >>>>>
> >>>>> Also, if you don't mind me asking - can anyone explain the naming
> >>>>> convention
> >>>>> for i686-w64-mingw32 vs. x86_64-w64-mingw32? They both seem to be
> >>>>> "mingw32",
> >>>>> so a bit confused how one is really 64 bit.
> >>>>>
> >>>>> Thanks again,
> >>>>> ... Russell
> >>>>>
> >>>>>
> >>>>>
> >>>>>
> >>>>> On Tue, 02/21/2012 06:12 PM, Alon Bar-Lev <alon.barlev@...277...> w=
rote:
> >>>>>
> >>>>> Hello people who actually use Windows!
> >>>>>
> >>>>> I will appreciate if you test my new windows build environment for
> >>>>> OpenVPN.
> >>>>>
> >>>>> You have many options, I guess all are needed.
> >>>>>
> >>>>> While you at it, please try to explain me why we need Visual Studio
> >>>>> build...
> >>>>> :)
> >>>>> .
> >>>>> Build is here[1]
> >>>>>
> >>>>> BEST METHOD - Compile on Linux
> >>>>>
> >>>>> This is a generic method, it can cross compile OpenVPN using any
> >>>>> toolchain to any environment.
> >>>>> For Windows, make sure you have mingw-w64 toolchain.
> >>>>> We are using nsis so we can also package files at Linux.
> >>>>>
> >>>>> $ cd generic
> >>>>> $ IMAGEROOT=3D`pwd`/image-win32 CHOST=3Di686-w64-mingw32
> >>>>> CBUILD=3Dx86_64-pc-linux-gnu ./build
> >>>>> $ IMAGEROOT=3D`pwd`/image-win64 CHOST=3Dx86_64-w64-mingw32
> >>>>> CBUILD=3Dx86_64-pc-linux-gnu ./build
> >>>>>
> >>>>> SLOWER METHOD - Compile on cygwin
> >>>>>
> >>>>> Read README for required packages.
> >>>>>
> >>>>> $ cd generic
> >>>>> $ IMAGEROOT=3D`pwd`/image-win32 CHOST=3Di686-w64-mingw32
> >>>>> CBUILD=3Di686-pc-cygwin ./build
> >>>>> $ IMAGEROOT=3D`pwd`/image-win64 CHOST=3Dx86_64-w64-mingw32
> >>>>> CBUILD=3Di686-pc-cygwin ./build
> >>>>>
> >>>>> Visual Studio Complete Batch
> >>>>>
> >>>>> install perl
> >>>>>
> >>>>>> cd msvc
> >>>>>> build
> >>>>>
> >>>>> Visual Studio IDE
> >>>>>
> >>>>> After you have the dependencies of Complete Batch or your own.
> >>>>> Create msvc-env-local.bat with OPENVPN_DEPROOT pointing to the
> >>>>> location of the dependencies.
> >>>>>
> >>>>>> msvc-dev
> >>>>>
> >>>>> MSBuild
> >>>>>
> >>>>> After you have the dependencies of Complete Batch or your own.
> >>>>> Create msvc-env-local.bat with OPENVPN_DEPROOT pointing to the
> >>>>> location of the dependencies.
> >>>>>
> >>>>>> msvc-build
> >>>>>
> >>>>> Good luck,
> >>>>> Alon.
> >>>>>
> >>>>> [1] https://github.com/alonbl/openvpn-build
> >>>>>
> >>>>>
> >>>>>
> >>>>> -------------------------------------------------------------------=
-----------
> >>>>> Virtualization & Cloud Management Using Capacity Planning
> >>>>> Cloud computing makes use of virtualization - but cloud computing
> >>>>> also focuses on allowing computing to be delivered as a service.
> >>>>> http://www.accelacomm.com/jaw/sfnl/114/51521223/
> >>>>> _______________________________________________
> >>>>> Openvpn-devel mailing list
> >>>>> Openvpn-devel@lists.sourceforge.net
> >>>>> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
> >>>>
> >>>>
> >>>> --------------------------------------------------------------------=
----------
> >>>> Virtualization & Cloud Management Using Capacity Planning
> >>>> Cloud computing makes use of virtualization - but cloud computing
> >>>> also focuses on allowing computing to be delivered as a service.
> >>>> http://www.accelacomm.com/jaw/sfnl/114/51521223/
> >>>> _______________________________________________
> >>>> Openvpn-devel mailing list
> >>>> Openvpn-devel@lists.sourceforge.net
> >>>> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>=20=

--===axigen=8569780234506728508220164556475213043977=axigen===
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<html><head><style id=3D"axi-htmleditor-style" type=3D"text/css">p { margin=
: 0px; }</style></head><body style=3D"font-size: 10pt; font-family: Arial; =
background-image: none; background-repeat: repeat; background-attachment: f=
ixed;"><P>That does it - it works now, thanks!!!</P>
<P>&nbsp;</P>
<P>... Russell</P>
<P>&nbsp;</P>
<P><BR><BR>On Sat, 02/25/2012 12:58 PM, Alon&nbsp;Bar-Lev&nbsp;&lt;alon.bar=
lev@...277...&gt; wrote:<BR></P>
<BLOCKQUOTE style=3D"BORDER-LEFT: rgb(0,0,204) 2px solid; PADDING-LEFT: 4px=
; MARGIN-LEFT: 16px">
<DIV style=3D"FONT-FAMILY: Arial; FONT-SIZE: 10pt">Never mind.<BR>I guess t=
hat mingw is configured as multilib somehow.<BR>I forced all to use /lib.<B=
R>Can you please try again?<BR><BR>On Sat, Feb 25, 2012 at 7:28 PM, Alon Ba=
r-Lev &lt;<A href=3D"mailto:alon.barlev@...277..." target=3D_blank>alon.bar=
lev@...277...</A>&gt; wrote:<BR>&gt; Can you send me list:<BR>&gt; $ find i=
mage-win32/openvpn/lib<BR>&gt; $ find image-win32/openvpn/lib64<BR>&gt;<BR>=
&gt;<BR>&gt; On Sat, Feb 25, 2012 at 4:22 PM, Russell Morris &lt;<A href=3D=
"mailto:openvpn@...1315..." target=3D_blank>openvpn@...1315...</A>&gt; wrot=
e:<BR>&gt;&gt; Hi,<BR>&gt;&gt;<BR>&gt;&gt; OK, I have done some digging - a=
nd I know what the issue is! Not sure how to<BR>&gt;&gt; fix it though ... =
:-).<BR>&gt;&gt;<BR>&gt;&gt; Inside the image-win64 directory, and then ins=
ide openvpn - running the<BR>&gt;&gt; build script results in two directori=
es, lib and lib64 (for image-win32<BR>&gt;&gt; there is only the lib direct=
ory). The libraries noted as missing are inside<BR>&gt;&gt; lib64, not lib =
... so they are not seen. I have seen this issue before. Then<BR>&gt;&gt; t=
he fix was to link lib64 to lib, and I tried this in this case - but the<BR=
>&gt;&gt; script seems to delete the directories and recreate them (so the =
link is<BR>&gt;&gt; gone).<BR>&gt;&gt;<BR>&gt;&gt; Thoughts?<BR>&gt;&gt;<BR=
>&gt;&gt; Thanks!<BR>&gt;&gt;<BR>&gt;&gt; ... Russell<BR>&gt;&gt;<BR>&gt;&g=
t;<BR>&gt;&gt;<BR>&gt;&gt;<BR>&gt;&gt; On Sat, 02/25/2012 03:23 AM, Alon&nb=
sp;Bar-Lev&nbsp;&lt;<A href=3D"mailto:alon.barlev@...277..." target=3D_blan=
k>alon.barlev@...277...</A>&gt; wrote:<BR>&gt;&gt;<BR>&gt;&gt; And also ful=
l output of the build script...<BR>&gt;&gt;<BR>&gt;&gt; ..... 2&gt;&amp;1 |=
 gzip &gt; /tmp/build.log<BR>&gt;&gt;<BR>&gt;&gt; On Sat, Feb 25, 2012 at 1=
1:14 AM, Alon Bar-Lev &lt;<A href=3D"mailto:alon.barlev@...277..." target=
=3D_blank>alon.barlev@...277...</A>&gt;<BR>&gt;&gt; wrote:<BR>&gt;&gt;&gt; =
I need the tmp/openvpn*/config.log<BR>&gt;&gt;&gt;<BR>&gt;&gt;&gt; On Sat, =
Feb 25, 2012 at 7:12 AM, Russell Morris &lt;<A href=3D"mailto:openvpn@...1666...=
15..." target=3D_blank>openvpn@...1315...</A>&gt;<BR>&gt;&gt;&gt; wrote:<BR=
>&gt;&gt;&gt;&gt; Hi,<BR>&gt;&gt;&gt;&gt;<BR>&gt;&gt;&gt;&gt; I used the co=
mmand line you provided below (actually, copied and pasted<BR>&gt;&gt;&gt;&=
gt; it<BR>&gt;&gt;&gt;&gt; to the command line). The one having issues is:<=
BR>&gt;&gt;&gt;&gt; IMAGEROOT=3D`pwd`/image-win64<BR>&gt;&gt;&gt;&gt; CHOST=
=3Dx86_64-w64-mingw32 CBUILD=3Dx86_64-pc-linux-gnu ./build<BR>&gt;&gt;&gt;&=
gt;<BR>&gt;&gt;&gt;&gt; Thanks!<BR>&gt;&gt;&gt;&gt;<BR>&gt;&gt;&gt;&gt; ...=
 Russell<BR>&gt;&gt;&gt;&gt;<BR>&gt;&gt;&gt;&gt;<BR>&gt;&gt;&gt;&gt;<BR>&gt=
;&gt;&gt;&gt; On Fri, 02/24/2012 06:11 PM, Alon&nbsp;Bar-Lev&nbsp;&lt;<A hr=
ef=3D"mailto:alon.barlev@...277..." target=3D_blank>alon.barlev@...277...</=
A>&gt; wrote:<BR>&gt;&gt;&gt;&gt;<BR>&gt;&gt;&gt;&gt; How exactly did you t=
ry to build?<BR>&gt;&gt;&gt;&gt; Please send command-line.<BR>&gt;&gt;&gt;&=
gt;<BR>&gt;&gt;&gt;&gt; The mingw32 suffix is historic, it is kept for comp=
atibility as old<BR>&gt;&gt;&gt;&gt; autotools(config.guess) packages expec=
ts for mingw32 as a platform, in<BR>&gt;&gt;&gt;&gt; the old days there was=
 no (forced) standard for specifying the arch.<BR>&gt;&gt;&gt;&gt;<BR>&gt;&=
gt;&gt;&gt; On Sat, Feb 25, 2012 at 2:04 AM, Russell Morris<BR>&gt;&gt;&gt;=
&gt; &lt;<A href=3D"mailto:openembedded@...1315..." target=3D_blank>openemb=
edded@...1315...</A>&gt; wrote:<BR>&gt;&gt;&gt;&gt;&gt; Hi,<BR>&gt;&gt;&gt;=
&gt;&gt;<BR>&gt;&gt;&gt;&gt;&gt; First of all - thanks for this! It's very =
much appreciated!<BR>&gt;&gt;&gt;&gt;&gt;<BR>&gt;&gt;&gt;&gt;&gt; I tried t=
his on my Linux box, and it worked fine - for the win32 image.<BR>&gt;&gt;&=
gt;&gt;&gt; However, the win64 image fails, with the following error ...<BR=
>&gt;&gt;&gt;&gt;&gt;<BR>&gt;&gt;&gt;&gt;&gt; =3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D<BR>&gt;&gt;&gt;&gt;&gt;<BR>&gt;&gt;&gt;&gt;&gt;<BR>&gt;&gt;&gt;&gt;&gt;=
<BR>&gt;&gt;&gt;&gt;&gt; /usr/lib64/gcc/x86_64-w64-mingw32/4.6.2/../../../.=
./x86_64-w64-mingw32/bin/ld:<BR>&gt;&gt;&gt;&gt;&gt; cannot find -llzo2<BR>=
&gt;&gt;&gt;&gt;&gt;<BR>&gt;&gt;&gt;&gt;&gt;<BR>&gt;&gt;&gt;&gt;&gt; /usr/l=
ib64/gcc/x86_64-w64-mingw32/4.6.2/../../../../x86_64-w64-mingw32/bin/ld:<BR=
>&gt;&gt;&gt;&gt;&gt; cannot find -lpkcs11-helper<BR>&gt;&gt;&gt;&gt;&gt; c=
ollect2: ld returned 1 exit status<BR>&gt;&gt;&gt;&gt;&gt; make[3]: *** [op=
envpn.exe] Error 1<BR>&gt;&gt;&gt;&gt;&gt; make[3]: Leaving directory<BR>&g=
t;&gt;&gt;&gt;&gt;<BR>&gt;&gt;&gt;&gt;&gt;<BR>&gt;&gt;&gt;&gt;&gt; `/home/r=
morris/Documents/Programming/openvpn-build/generic/tmp/openvpn-2.3-alpha1/s=
rc/openvpn'<BR>&gt;&gt;&gt;&gt;&gt; make[2]: *** [install-recursive] Error =
1<BR>&gt;&gt;&gt;&gt;&gt; make[2]: Leaving directory<BR>&gt;&gt;&gt;&gt;&gt=
;<BR>&gt;&gt;&gt;&gt;&gt;<BR>&gt;&gt;&gt;&gt;&gt; `/home/rmorris/Documents/=
Programming/openvpn-build/generic/tmp/openvpn-2.3-alpha1/src'<BR>&gt;&gt;&g=
t;&gt;&gt; make[1]: *** [install-recursive] Error 1<BR>&gt;&gt;&gt;&gt;&gt;=
 make[1]: Leaving directory<BR>&gt;&gt;&gt;&gt;&gt;<BR>&gt;&gt;&gt;&gt;&gt;=
<BR>&gt;&gt;&gt;&gt;&gt; `/home/rmorris/Documents/Programming/openvpn-build=
/generic/tmp/openvpn-2.3-alpha1'<BR>&gt;&gt;&gt;&gt;&gt; make: *** [install=
-strip] Error 2<BR>&gt;&gt;&gt;&gt;&gt; FATAL: make openvpn<BR>&gt;&gt;&gt;=
&gt;&gt;<BR>&gt;&gt;&gt;&gt;&gt; =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<BR>&gt;&gt;=
&gt;&gt;&gt;<BR>&gt;&gt;&gt;&gt;&gt; Has anyone else seen this? Any thought=
s how to correct it?<BR>&gt;&gt;&gt;&gt;&gt;<BR>&gt;&gt;&gt;&gt;&gt; Also, =
if you don't mind me asking - can anyone explain the naming<BR>&gt;&gt;&gt;=
&gt;&gt; convention<BR>&gt;&gt;&gt;&gt;&gt; for i686-w64-mingw32 vs. x86_64=
-w64-mingw32? They both seem to be<BR>&gt;&gt;&gt;&gt;&gt; "mingw32",<BR>&g=
t;&gt;&gt;&gt;&gt; so a bit confused how one is really 64 bit.<BR>&gt;&gt;&=
gt;&gt;&gt;<BR>&gt;&gt;&gt;&gt;&gt; Thanks again,<BR>&gt;&gt;&gt;&gt;&gt; .=
.. Russell<BR>&gt;&gt;&gt;&gt;&gt;<BR>&gt;&gt;&gt;&gt;&gt;<BR>&gt;&gt;&gt;&=
gt;&gt;<BR>&gt;&gt;&gt;&gt;&gt;<BR>&gt;&gt;&gt;&gt;&gt; On Tue, 02/21/2012 =
06:12 PM, Alon&nbsp;Bar-Lev&nbsp;&lt;<A href=3D"mailto:alon.barlev@...1663...=
." target=3D_blank>alon.barlev@...277...</A>&gt; wrote:<BR>&gt;&gt;&gt;&gt;=
&gt;<BR>&gt;&gt;&gt;&gt;&gt; Hello people who actually use Windows!<BR>&gt;=
&gt;&gt;&gt;&gt;<BR>&gt;&gt;&gt;&gt;&gt; I will appreciate if you test my n=
ew windows build environment for<BR>&gt;&gt;&gt;&gt;&gt; OpenVPN.<BR>&gt;&g=
t;&gt;&gt;&gt;<BR>&gt;&gt;&gt;&gt;&gt; You have many options, I guess all a=
re needed.<BR>&gt;&gt;&gt;&gt;&gt;<BR>&gt;&gt;&gt;&gt;&gt; While you at it,=
 please try to explain me why we need Visual Studio<BR>&gt;&gt;&gt;&gt;&gt;=
 build...<BR>&gt;&gt;&gt;&gt;&gt; :)<BR>&gt;&gt;&gt;&gt;&gt; .<BR>&gt;&gt;&=
gt;&gt;&gt; Build is here[1]<BR>&gt;&gt;&gt;&gt;&gt;<BR>&gt;&gt;&gt;&gt;&gt=
; BEST METHOD - Compile on Linux<BR>&gt;&gt;&gt;&gt;&gt;<BR>&gt;&gt;&gt;&gt=
;&gt; This is a generic method, it can cross compile OpenVPN using any<BR>&=
gt;&gt;&gt;&gt;&gt; toolchain to any environment.<BR>&gt;&gt;&gt;&gt;&gt; F=
or Windows, make sure you have mingw-w64 toolchain.<BR>&gt;&gt;&gt;&gt;&gt;=
 We are using nsis so we can also package files at Linux.<BR>&gt;&gt;&gt;&g=
t;&gt;<BR>&gt;&gt;&gt;&gt;&gt; $ cd generic<BR>&gt;&gt;&gt;&gt;&gt; $ IMAGE=
ROOT=3D`pwd`/image-win32 CHOST=3Di686-w64-mingw32<BR>&gt;&gt;&gt;&gt;&gt; C=
BUILD=3Dx86_64-pc-linux-gnu ./build<BR>&gt;&gt;&gt;&gt;&gt; $ IMAGEROOT=3D`=
pwd`/image-win64 CHOST=3Dx86_64-w64-mingw32<BR>&gt;&gt;&gt;&gt;&gt; CBUILD=
=3Dx86_64-pc-linux-gnu ./build<BR>&gt;&gt;&gt;&gt;&gt;<BR>&gt;&gt;&gt;&gt;&=
gt; SLOWER METHOD - Compile on cygwin<BR>&gt;&gt;&gt;&gt;&gt;<BR>&gt;&gt;&g=
t;&gt;&gt; Read README for required packages.<BR>&gt;&gt;&gt;&gt;&gt;<BR>&g=
t;&gt;&gt;&gt;&gt; $ cd generic<BR>&gt;&gt;&gt;&gt;&gt; $ IMAGEROOT=3D`pwd`=
/image-win32 CHOST=3Di686-w64-mingw32<BR>&gt;&gt;&gt;&gt;&gt; CBUILD=3Di686=
-pc-cygwin ./build<BR>&gt;&gt;&gt;&gt;&gt; $ IMAGEROOT=3D`pwd`/image-win64 =
CHOST=3Dx86_64-w64-mingw32<BR>&gt;&gt;&gt;&gt;&gt; CBUILD=3Di686-pc-cygwin =
./build<BR>&gt;&gt;&gt;&gt;&gt;<BR>&gt;&gt;&gt;&gt;&gt; Visual Studio Compl=
ete Batch<BR>&gt;&gt;&gt;&gt;&gt;<BR>&gt;&gt;&gt;&gt;&gt; install perl<BR>&=
gt;&gt;&gt;&gt;&gt;<BR>&gt;&gt;&gt;&gt;&gt;&gt; cd msvc<BR>&gt;&gt;&gt;&gt;=
&gt;&gt; build<BR>&gt;&gt;&gt;&gt;&gt;<BR>&gt;&gt;&gt;&gt;&gt; Visual Studi=
o IDE<BR>&gt;&gt;&gt;&gt;&gt;<BR>&gt;&gt;&gt;&gt;&gt; After you have the de=
pendencies of Complete Batch or your own.<BR>&gt;&gt;&gt;&gt;&gt; Create ms=
vc-env-local.bat with OPENVPN_DEPROOT pointing to the<BR>&gt;&gt;&gt;&gt;&g=
t; location of the dependencies.<BR>&gt;&gt;&gt;&gt;&gt;<BR>&gt;&gt;&gt;&gt=
;&gt;&gt; msvc-dev<BR>&gt;&gt;&gt;&gt;&gt;<BR>&gt;&gt;&gt;&gt;&gt; MSBuild<=
BR>&gt;&gt;&gt;&gt;&gt;<BR>&gt;&gt;&gt;&gt;&gt; After you have the dependen=
cies of Complete Batch or your own.<BR>&gt;&gt;&gt;&gt;&gt; Create msvc-env=
-local.bat with OPENVPN_DEPROOT pointing to the<BR>&gt;&gt;&gt;&gt;&gt; loc=
ation of the dependencies.<BR>&gt;&gt;&gt;&gt;&gt;<BR>&gt;&gt;&gt;&gt;&gt;&=
gt; msvc-build<BR>&gt;&gt;&gt;&gt;&gt;<BR>&gt;&gt;&gt;&gt;&gt; Good luck,<B=
R>&gt;&gt;&gt;&gt;&gt; Alon.<BR>&gt;&gt;&gt;&gt;&gt;<BR>&gt;&gt;&gt;&gt;&gt=
; [1] <A href=3D"http://server.home:8080/redir.hsp?url=3D%68%74%74%70%73%3A=
%2F%2F%67%69%74%68%75%62%2E%63%6F%6D%2F%61%6C%6F%6E%62%6C%2F%6F%70%65%6E%76=
%70%6E%2D%62%75%69%6C%64" target=3D_blank>https://github.com/alonbl/openvpn=
-build</A><BR>&gt;&gt;&gt;&gt;&gt;<BR>&gt;&gt;&gt;&gt;&gt;<BR>&gt;&gt;&gt;&=
gt;&gt;<BR>&gt;&gt;&gt;&gt;&gt; -------------------------------------------=
-----------------------------------<BR>&gt;&gt;&gt;&gt;&gt; Virtualization =
&amp; Cloud Management Using Capacity Planning<BR>&gt;&gt;&gt;&gt;&gt; Clou=
d computing makes use of virtualization - but cloud computing<BR>&gt;&gt;&g=
t;&gt;&gt; also focuses on allowing computing to be delivered as a service.=
<BR>&gt;&gt;&gt;&gt;&gt; <A href=3D"http://server.home:8080/redir.hsp?url=
=3D%68%74%74%70%3A%2F%2F%77%77%77%2E%61%63%63%65%6C%61%63%6F%6D%6D%2E%63%6F=
%6D%2F%6A%61%77%2F%73%66%6E%6C%2F%31%31%34%2F%35%31%35%32%31%32%32%33%2F" t=
arget=3D_blank>http://www.accelacomm.com/jaw/sfnl/114/51521223/</A><BR>&gt;=
&gt;&gt;&gt;&gt; _______________________________________________<BR>&gt;&gt=
;&gt;&gt;&gt; Openvpn-devel mailing list<BR>&gt;&gt;&gt;&gt;&gt;<A href=3D"=
mailto:%20Openvpn-devel@lists.sourceforge.net" target=3D_blank> Openvpn-dev=
el@lists.sourceforge.net</A><BR>&gt;&gt;&gt;&gt;&gt; <A href=3D"http://serv=
er.home:8080/redir.hsp?url=3D%68%74%74%70%73%3A%2F%2F%6C%69%73%74%73%2E%73%=
6F%75%72%63%65%66%6F%72%67%65%2E%6E%65%74%2F%6C%69%73%74%73%2F%6C%69%73%74%=
69%6E%66%6F%2F%6F%70%65%6E%76%70%6E%2D%64%65%76%65%6C" target=3D_blank>http=
s://lists.sourceforge.net/lists/listinfo/openvpn-devel</A><BR>&gt;&gt;&gt;&=
gt;<BR>&gt;&gt;&gt;&gt;<BR>&gt;&gt;&gt;&gt; -------------------------------=
-----------------------------------------------<BR>&gt;&gt;&gt;&gt; Virtual=
ization &amp; Cloud Management Using Capacity Planning<BR>&gt;&gt;&gt;&gt; =
Cloud computing makes use of virtualization - but cloud computing<BR>&gt;&g=
t;&gt;&gt; also focuses on allowing computing to be delivered as a service.=
<BR>&gt;&gt;&gt;&gt; <A href=3D"http://server.home:8080/redir.hsp?url=3D%68=
%74%74%70%3A%2F%2F%77%77%77%2E%61%63%63%65%6C%61%63%6F%6D%6D%2E%63%6F%6D%2F=
%6A%61%77%2F%73%66%6E%6C%2F%31%31%34%2F%35%31%35%32%31%32%32%33%2F" target=
=3D_blank>http://www.accelacomm.com/jaw/sfnl/114/51521223/</A><BR>&gt;&gt;&=
gt;&gt; _______________________________________________<BR>&gt;&gt;&gt;&gt;=
 Openvpn-devel mailing list<BR>&gt;&gt;&gt;&gt;<A href=3D"mailto:%20Openvpn=
-devel@lists.sourceforge.net" target=3D_blank> Openvpn-devel@...1357...=
rge.net</A><BR>&gt;&gt;&gt;&gt; <A href=3D"http://server.home:8080/redir.hs=
p?url=3D%68%74%74%70%73%3A%2F%2F%6C%69%73%74%73%2E%73%6F%75%72%63%65%66%6F%=
72%67%65%2E%6E%65%74%2F%6C%69%73%74%73%2F%6C%69%73%74%69%6E%66%6F%2F%6F%70%=
65%6E%76%70%6E%2D%64%65%76%65%6C" target=3D_blank>https://lists.sourceforge=
.net/lists/listinfo/openvpn-devel</A><BR></DIV></BLOCKQUOTE></body></html>=

--===axigen=8569780234506728508220164556475213043977=axigen===--


