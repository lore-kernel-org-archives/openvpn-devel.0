From: Russell Morris <openvpn@...1315...>
Date: Sat, 25 Feb 2012 08:22:01 -0600
Message-id: <1330179721253929500@...1315...>
In-reply-to: <CAOazyz3XLwxRqRLsaNyECbKEq5g8nN38OPkbBYmenwRaQmKneA@...278...>
References: <CAOazyz3CAK6Huf7qzAv_Uv+bn5QFFd_cC7A8S_s42HZQGNLC4g@...278...>
	<1330128297432870500@...1315...>
	<CAOazyz3e2ofYxXHiEfxc86nvht87w5_rMqZso8uhKp0i9Y=BhQ@...278...>
	<1330146723797070500@...1315...>
	<CAOazyz3ZC2wivR7RUJCVFW48neDoUob4oh0ciaOA4tS=_sc3YQ@...278...>
	<CAOazyz3XLwxRqRLsaNyECbKEq5g8nN38OPkbBYmenwRaQmKneA@...278...>
MIME-version: 1.0
Content-type: multipart/alternative;
	boundary="===axigen=4550969694090611078653590348796147617262=axigen==="
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
--===axigen=4550969694090611078653590348796147617262=axigen===
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

OK, I have done some digging - and I know what the issue is! Not sure how t=
o fix it though ... :-).

Inside the image-win64 directory, and then inside openvpn - running the bui=
ld script results in two directories, lib and lib64 (for image-win32 there =
is only the lib directory). The libraries noted as missing are inside lib64=
, not lib ... so they are not seen. I have seen this issue before. Then the=
 fix was to link lib64 to lib, and I tried this in this case - but the scri=
pt seems to delete the directories and recreate them (so the link is gone).

Thoughts?

Thanks!

... Russell



On Sat, 02/25/2012 03:23 AM, Alon Bar-Lev <alon.barlev@...277...> wrote:
> And also full output of the build script...
>=20
> ..... 2>&1 | gzip > /tmp/build.log
>=20
> On Sat, Feb 25, 2012 at 11:14 AM, Alon Bar-Lev <alon.barlev@...277...> wr=
ote:
> > I need the tmp/openvpn*/config.log
> >
> > On Sat, Feb 25, 2012 at 7:12 AM, Russell Morris <openvpn@...1315...> wr=
ote:
> >> Hi,
> >>
> >> I used the command line you provided below (actually, copied and paste=
d it
> >> to the command line). The one having issues is: IMAGEROOT=3D`pwd`/imag=
e-win64
> >> CHOST=3Dx86_64-w64-mingw32 CBUILD=3Dx86_64-pc-linux-gnu ./build
> >>
> >> Thanks!
> >>
> >> ... Russell
> >>
> >>
> >>
> >> On Fri, 02/24/2012 06:11 PM, Alon Bar-Lev <alon.barlev@...277...> wrot=
e:
> >>
> >> How exactly did you try to build?
> >> Please send command-line.
> >>
> >> The mingw32 suffix is historic, it is kept for compatibility as old
> >> autotools(config.guess) packages expects for mingw32 as a platform, in
> >> the old days there was no (forced) standard for specifying the arch.
> >>
> >> On Sat, Feb 25, 2012 at 2:04 AM, Russell Morris
> >> <openembedded@...1315...> wrote:
> >>> Hi,
> >>>
> >>> First of all - thanks for this! It's very much appreciated!
> >>>
> >>> I tried this on my Linux box, and it worked fine - for the win32 imag=
e.
> >>> However, the win64 image fails, with the following error ...
> >>>
> >>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>>
> >>>
> >>> /usr/lib64/gcc/x86_64-w64-mingw32/4.6.2/../../../../x86_64-w64-mingw3=
2/bin/ld:
> >>> cannot find -llzo2
> >>>
> >>> /usr/lib64/gcc/x86_64-w64-mingw32/4.6.2/../../../../x86_64-w64-mingw3=
2/bin/ld:
> >>> cannot find -lpkcs11-helper
> >>> collect2: ld returned 1 exit status
> >>> make[3]: *** [openvpn.exe] Error 1
> >>> make[3]: Leaving directory
> >>>
> >>> `/home/rmorris/Documents/Programming/openvpn-build/generic/tmp/openvp=
n-2.3-alpha1/src/openvpn'
> >>> make[2]: *** [install-recursive] Error 1
> >>> make[2]: Leaving directory
> >>>
> >>> `/home/rmorris/Documents/Programming/openvpn-build/generic/tmp/openvp=
n-2.3-alpha1/src'
> >>> make[1]: *** [install-recursive] Error 1
> >>> make[1]: Leaving directory
> >>>
> >>> `/home/rmorris/Documents/Programming/openvpn-build/generic/tmp/openvp=
n-2.3-alpha1'
> >>> make: *** [install-strip] Error 2
> >>> FATAL: make openvpn
> >>>
> >>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>>
> >>> Has anyone else seen this? Any thoughts how to correct it?
> >>>
> >>> Also, if you don't mind me asking - can anyone explain the naming
> >>> convention
> >>> for i686-w64-mingw32 vs. x86_64-w64-mingw32? They both seem to be
> >>> "mingw32",
> >>> so a bit confused how one is really 64 bit.
> >>>
> >>> Thanks again,
> >>> ... Russell
> >>>
> >>>
> >>>
> >>>
> >>> On Tue, 02/21/2012 06:12 PM, Alon Bar-Lev <alon.barlev@...277...> wro=
te:
> >>>
> >>> Hello people who actually use Windows!
> >>>
> >>> I will appreciate if you test my new windows build environment for
> >>> OpenVPN.
> >>>
> >>> You have many options, I guess all are needed.
> >>>
> >>> While you at it, please try to explain me why we need Visual Studio
> >>> build...
> >>> :)
> >>> .
> >>> Build is here[1]
> >>>
> >>> BEST METHOD - Compile on Linux
> >>>
> >>> This is a generic method, it can cross compile OpenVPN using any
> >>> toolchain to any environment.
> >>> For Windows, make sure you have mingw-w64 toolchain.
> >>> We are using nsis so we can also package files at Linux.
> >>>
> >>> $ cd generic
> >>> $ IMAGEROOT=3D`pwd`/image-win32 CHOST=3Di686-w64-mingw32
> >>> CBUILD=3Dx86_64-pc-linux-gnu ./build
> >>> $ IMAGEROOT=3D`pwd`/image-win64 CHOST=3Dx86_64-w64-mingw32
> >>> CBUILD=3Dx86_64-pc-linux-gnu ./build
> >>>
> >>> SLOWER METHOD - Compile on cygwin
> >>>
> >>> Read README for required packages.
> >>>
> >>> $ cd generic
> >>> $ IMAGEROOT=3D`pwd`/image-win32 CHOST=3Di686-w64-mingw32
> >>> CBUILD=3Di686-pc-cygwin ./build
> >>> $ IMAGEROOT=3D`pwd`/image-win64 CHOST=3Dx86_64-w64-mingw32
> >>> CBUILD=3Di686-pc-cygwin ./build
> >>>
> >>> Visual Studio Complete Batch
> >>>
> >>> install perl
> >>>
> >>>> cd msvc
> >>>> build
> >>>
> >>> Visual Studio IDE
> >>>
> >>> After you have the dependencies of Complete Batch or your own.
> >>> Create msvc-env-local.bat with OPENVPN_DEPROOT pointing to the
> >>> location of the dependencies.
> >>>
> >>>> msvc-dev
> >>>
> >>> MSBuild
> >>>
> >>> After you have the dependencies of Complete Batch or your own.
> >>> Create msvc-env-local.bat with OPENVPN_DEPROOT pointing to the
> >>> location of the dependencies.
> >>>
> >>>> msvc-build
> >>>
> >>> Good luck,
> >>> Alon.
> >>>
> >>> [1] https://github.com/alonbl/openvpn-build
> >>>
> >>>
> >>> ---------------------------------------------------------------------=
---------
> >>> Virtualization & Cloud Management Using Capacity Planning
> >>> Cloud computing makes use of virtualization - but cloud computing
> >>> also focuses on allowing computing to be delivered as a service.
> >>> http://www.accelacomm.com/jaw/sfnl/114/51521223/
> >>> _______________________________________________
> >>> Openvpn-devel mailing list
> >>> Openvpn-devel@lists.sourceforge.net
> >>> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
> >>
> >> ----------------------------------------------------------------------=
--------
> >> Virtualization & Cloud Management Using Capacity Planning
> >> Cloud computing makes use of virtualization - but cloud computing
> >> also focuses on allowing computing to be delivered as a service.
> >> http://www.accelacomm.com/jaw/sfnl/114/51521223/
> >> _______________________________________________
> >> Openvpn-devel mailing list
> >> Openvpn-devel@lists.sourceforge.net
> >> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>=20=

--===axigen=4550969694090611078653590348796147617262=axigen===
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<html><head><style id=3D"axi-htmleditor-style" type=3D"text/css">p { margin=
: 0px; }</style></head><body style=3D"font-size: 10pt; font-family: Arial; =
background-image: none; background-repeat: repeat; background-attachment: f=
ixed;">Hi,<br><br>OK, I have done some digging - and I know what the issue =
is! Not sure how to fix it though ... :-).<br><br>Inside the image-win64 di=
rectory, and then inside openvpn - running the build script results in two =
directories, lib and lib64 (for image-win32 there is only the lib directory=
). The libraries noted as missing are inside lib64, not lib ... so they are=
 not seen. I have seen this issue before. Then the fix was to link lib64 to=
 lib, and I tried this in this case - but the script seems to delete the di=
rectories and recreate them (so the link is gone).<br><br>Thoughts?<br><br>=
Thanks!<br><br>... Russell<br><br><br><br>On Sat, 02/25/2012 03:23 AM, Alon=
&nbsp;Bar-Lev&nbsp;&lt;alon.barlev@...277...&gt; wrote:<br><blockquote styl=
e=3D"border-left: 2px solid rgb(00, 00, 204); padding-left: 4px; margin-lef=
t: 16px;"><div style=3D"font-family: Arial; font-size: 10pt;">And also full=
 output of the build script...<br><br>..... 2&gt;&amp;1 | gzip &gt; /tmp/bu=
ild.log<br><br>On Sat, Feb 25, 2012 at 11:14 AM, Alon Bar-Lev &lt;<a href=
=3D"mailto:alon.barlev@...277..." target=3D"_blank">alon.barlev@...277...</=
a>&gt; wrote:<br>&gt; I need the tmp/openvpn*/config.log<br>&gt;<br>&gt; On=
 Sat, Feb 25, 2012 at 7:12 AM, Russell Morris &lt;<a href=3D"mailto:openvpn=
@...1315..." target=3D"_blank">openvpn@...1315...</a>&gt; wrote:<br>&gt;&gt=
; Hi,<br>&gt;&gt;<br>&gt;&gt; I used the command line you provided below (a=
ctually, copied and pasted it<br>&gt;&gt; to the command line). The one hav=
ing issues is: IMAGEROOT=3D`pwd`/image-win64<br>&gt;&gt; CHOST=3Dx86_64-w64=
-mingw32 CBUILD=3Dx86_64-pc-linux-gnu ./build<br>&gt;&gt;<br>&gt;&gt; Thank=
s!<br>&gt;&gt;<br>&gt;&gt; ... Russell<br>&gt;&gt;<br>&gt;&gt;<br>&gt;&gt;<=
br>&gt;&gt; On Fri, 02/24/2012 06:11 PM, Alon&nbsp;Bar-Lev&nbsp;&lt;<a href=
=3D"mailto:alon.barlev@...277..." target=3D"_blank">alon.barlev@...277...</=
a>&gt; wrote:<br>&gt;&gt;<br>&gt;&gt; How exactly did you try to build?<br>=
&gt;&gt; Please send command-line.<br>&gt;&gt;<br>&gt;&gt; The mingw32 suff=
ix is historic, it is kept for compatibility as old<br>&gt;&gt; autotools(c=
onfig.guess) packages expects for mingw32 as a platform, in<br>&gt;&gt; the=
 old days there was no (forced) standard for specifying the arch.<br>&gt;&g=
t;<br>&gt;&gt; On Sat, Feb 25, 2012 at 2:04 AM, Russell Morris<br>&gt;&gt; =
&lt;<a href=3D"mailto:openembedded@...1315..." target=3D"_blank">openembedd=
ed@...1315...</a>&gt; wrote:<br>&gt;&gt;&gt; Hi,<br>&gt;&gt;&gt;<br>&gt;&gt=
;&gt; First of all - thanks for this! It's very much appreciated!<br>&gt;&g=
t;&gt;<br>&gt;&gt;&gt; I tried this on my Linux box, and it worked fine - f=
or the win32 image.<br>&gt;&gt;&gt; However, the win64 image fails, with th=
e following error ...<br>&gt;&gt;&gt;<br>&gt;&gt;&gt; =3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D<br>&gt;&gt;&gt;<br>&gt;&gt;&gt;<br>&gt;&gt;&gt; /usr/lib64/gcc/x8=
6_64-w64-mingw32/4.6.2/../../../../x86_64-w64-mingw32/bin/ld:<br>&gt;&gt;&g=
t; cannot find -llzo2<br>&gt;&gt;&gt;<br>&gt;&gt;&gt; /usr/lib64/gcc/x86_64=
-w64-mingw32/4.6.2/../../../../x86_64-w64-mingw32/bin/ld:<br>&gt;&gt;&gt; c=
annot find -lpkcs11-helper<br>&gt;&gt;&gt; collect2: ld returned 1 exit sta=
tus<br>&gt;&gt;&gt; make[3]: *** [openvpn.exe] Error 1<br>&gt;&gt;&gt; make=
[3]: Leaving directory<br>&gt;&gt;&gt;<br>&gt;&gt;&gt; `/home/rmorris/Docum=
ents/Programming/openvpn-build/generic/tmp/openvpn-2.3-alpha1/src/openvpn'<=
br>&gt;&gt;&gt; make[2]: *** [install-recursive] Error 1<br>&gt;&gt;&gt; ma=
ke[2]: Leaving directory<br>&gt;&gt;&gt;<br>&gt;&gt;&gt; `/home/rmorris/Doc=
uments/Programming/openvpn-build/generic/tmp/openvpn-2.3-alpha1/src'<br>&gt=
;&gt;&gt; make[1]: *** [install-recursive] Error 1<br>&gt;&gt;&gt; make[1]:=
 Leaving directory<br>&gt;&gt;&gt;<br>&gt;&gt;&gt; `/home/rmorris/Documents=
/Programming/openvpn-build/generic/tmp/openvpn-2.3-alpha1'<br>&gt;&gt;&gt; =
make: *** [install-strip] Error 2<br>&gt;&gt;&gt; FATAL: make openvpn<br>&g=
t;&gt;&gt;<br>&gt;&gt;&gt; =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>&gt;&gt;&gt;<b=
r>&gt;&gt;&gt; Has anyone else seen this? Any thoughts how to correct it?<b=
r>&gt;&gt;&gt;<br>&gt;&gt;&gt; Also, if you don't mind me asking - can anyo=
ne explain the naming<br>&gt;&gt;&gt; convention<br>&gt;&gt;&gt; for i686-w=
64-mingw32 vs. x86_64-w64-mingw32? They both seem to be<br>&gt;&gt;&gt; "mi=
ngw32",<br>&gt;&gt;&gt; so a bit confused how one is really 64 bit.<br>&gt;=
&gt;&gt;<br>&gt;&gt;&gt; Thanks again,<br>&gt;&gt;&gt; ... Russell<br>&gt;&=
gt;&gt;<br>&gt;&gt;&gt;<br>&gt;&gt;&gt;<br>&gt;&gt;&gt;<br>&gt;&gt;&gt; On =
Tue, 02/21/2012 06:12 PM, Alon&nbsp;Bar-Lev&nbsp;&lt;<a href=3D"mailto:alon=
.barlev@...277..." target=3D"_blank">alon.barlev@...277...</a>&gt; wrote:<b=
r>&gt;&gt;&gt;<br>&gt;&gt;&gt; Hello people who actually use Windows!<br>&g=
t;&gt;&gt;<br>&gt;&gt;&gt; I will appreciate if you test my new windows bui=
ld environment for<br>&gt;&gt;&gt; OpenVPN.<br>&gt;&gt;&gt;<br>&gt;&gt;&gt;=
 You have many options, I guess all are needed.<br>&gt;&gt;&gt;<br>&gt;&gt;=
&gt; While you at it, please try to explain me why we need Visual Studio<br=
>&gt;&gt;&gt; build...<br>&gt;&gt;&gt; :)<br>&gt;&gt;&gt; .<br>&gt;&gt;&gt;=
 Build is here[1]<br>&gt;&gt;&gt;<br>&gt;&gt;&gt; BEST METHOD - Compile on =
Linux<br>&gt;&gt;&gt;<br>&gt;&gt;&gt; This is a generic method, it can cros=
s compile OpenVPN using any<br>&gt;&gt;&gt; toolchain to any environment.<b=
r>&gt;&gt;&gt; For Windows, make sure you have mingw-w64 toolchain.<br>&gt;=
&gt;&gt; We are using nsis so we can also package files at Linux.<br>&gt;&g=
t;&gt;<br>&gt;&gt;&gt; $ cd generic<br>&gt;&gt;&gt; $ IMAGEROOT=3D`pwd`/ima=
ge-win32 CHOST=3Di686-w64-mingw32<br>&gt;&gt;&gt; CBUILD=3Dx86_64-pc-linux-=
gnu ./build<br>&gt;&gt;&gt; $ IMAGEROOT=3D`pwd`/image-win64 CHOST=3Dx86_64-=
w64-mingw32<br>&gt;&gt;&gt; CBUILD=3Dx86_64-pc-linux-gnu ./build<br>&gt;&gt=
;&gt;<br>&gt;&gt;&gt; SLOWER METHOD - Compile on cygwin<br>&gt;&gt;&gt;<br>=
&gt;&gt;&gt; Read README for required packages.<br>&gt;&gt;&gt;<br>&gt;&gt;=
&gt; $ cd generic<br>&gt;&gt;&gt; $ IMAGEROOT=3D`pwd`/image-win32 CHOST=3Di=
686-w64-mingw32<br>&gt;&gt;&gt; CBUILD=3Di686-pc-cygwin ./build<br>&gt;&gt;=
&gt; $ IMAGEROOT=3D`pwd`/image-win64 CHOST=3Dx86_64-w64-mingw32<br>&gt;&gt;=
&gt; CBUILD=3Di686-pc-cygwin ./build<br>&gt;&gt;&gt;<br>&gt;&gt;&gt; Visual=
 Studio Complete Batch<br>&gt;&gt;&gt;<br>&gt;&gt;&gt; install perl<br>&gt;=
&gt;&gt;<br>&gt;&gt;&gt;&gt; cd msvc<br>&gt;&gt;&gt;&gt; build<br>&gt;&gt;&=
gt;<br>&gt;&gt;&gt; Visual Studio IDE<br>&gt;&gt;&gt;<br>&gt;&gt;&gt; After=
 you have the dependencies of Complete Batch or your own.<br>&gt;&gt;&gt; C=
reate msvc-env-local.bat with OPENVPN_DEPROOT pointing to the<br>&gt;&gt;&g=
t; location of the dependencies.<br>&gt;&gt;&gt;<br>&gt;&gt;&gt;&gt; msvc-d=
ev<br>&gt;&gt;&gt;<br>&gt;&gt;&gt; MSBuild<br>&gt;&gt;&gt;<br>&gt;&gt;&gt; =
After you have the dependencies of Complete Batch or your own.<br>&gt;&gt;&=
gt; Create msvc-env-local.bat with OPENVPN_DEPROOT pointing to the<br>&gt;&=
gt;&gt; location of the dependencies.<br>&gt;&gt;&gt;<br>&gt;&gt;&gt;&gt; m=
svc-build<br>&gt;&gt;&gt;<br>&gt;&gt;&gt; Good luck,<br>&gt;&gt;&gt; Alon.<=
br>&gt;&gt;&gt;<br>&gt;&gt;&gt; [1] <a href=3D"https://github.com/alonbl/op=
envpn-build" target=3D"_blank">https://github.com/alonbl/openvpn-build</a><=
br>&gt;&gt;&gt;<br>&gt;&gt;&gt;<br>&gt;&gt;&gt; ---------------------------=
---------------------------------------------------<br>&gt;&gt;&gt; Virtual=
ization &amp; Cloud Management Using Capacity Planning<br>&gt;&gt;&gt; Clou=
d computing makes use of virtualization - but cloud computing<br>&gt;&gt;&g=
t; also focuses on allowing computing to be delivered as a service.<br>&gt;=
&gt;&gt; <a href=3D"http://www.accelacomm.com/jaw/sfnl/114/51521223/" targe=
t=3D"_blank">http://www.accelacomm.com/jaw/sfnl/114/51521223/</a><br>&gt;&g=
t;&gt; _______________________________________________<br>&gt;&gt;&gt; Open=
vpn-devel mailing list<br>&gt;&gt;&gt;<a href=3D"mailto:%20Openvpn-devel@...1224...=
sts.sourceforge.net" target=3D"_blank"> Openvpn-devel@lists.sourceforge.net=
</a><br>&gt;&gt;&gt; <a href=3D"https://lists.sourceforge.net/lists/listinf=
o/openvpn-devel" target=3D"_blank">https://lists.sourceforge.net/lists/list=
info/openvpn-devel</a><br>&gt;&gt;<br>&gt;&gt; ----------------------------=
--------------------------------------------------<br>&gt;&gt; Virtualizati=
on &amp; Cloud Management Using Capacity Planning<br>&gt;&gt; Cloud computi=
ng makes use of virtualization - but cloud computing<br>&gt;&gt; also focus=
es on allowing computing to be delivered as a service.<br>&gt;&gt; <a href=
=3D"http://www.accelacomm.com/jaw/sfnl/114/51521223/" target=3D"_blank">htt=
p://www.accelacomm.com/jaw/sfnl/114/51521223/</a><br>&gt;&gt; _____________=
__________________________________<br>&gt;&gt; Openvpn-devel mailing list<b=
r>&gt;&gt;<a href=3D"mailto:%20Openvpn-devel@lists.sourceforge.net" target=
=3D"_blank"> Openvpn-devel@lists.sourceforge.net</a><br>&gt;&gt; <a href=3D=
"https://lists.sourceforge.net/lists/listinfo/openvpn-devel" target=3D"_bla=
nk">https://lists.sourceforge.net/lists/listinfo/openvpn-devel</a><br></div=
></blockquote></body></html>=

--===axigen=4550969694090611078653590348796147617262=axigen===--


