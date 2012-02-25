From: Russell Morris <openvpn@...1315...>
Date: Fri, 24 Feb 2012 23:12:03 -0600
Message-id: <1330146723797070500@...1315...>
In-reply-to: <CAOazyz3e2ofYxXHiEfxc86nvht87w5_rMqZso8uhKp0i9Y=BhQ@...278...>
References: <CAOazyz3CAK6Huf7qzAv_Uv+bn5QFFd_cC7A8S_s42HZQGNLC4g@...278...>
	<1330128297432870500@...1315...>
	<CAOazyz3e2ofYxXHiEfxc86nvht87w5_rMqZso8uhKp0i9Y=BhQ@...278...>
MIME-version: 1.0
Content-type: multipart/alternative;
	boundary="===axigen=0239367924111157360721968452835416309005=axigen==="
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
--===axigen=0239367924111157360721968452835416309005=axigen===
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

I used the command line you provided below (actually, copied and pasted it =
to the command line). The one having issues is: IMAGEROOT=3D`pwd`/image-win=
64 CHOST=3Dx86_64-w64-mingw32 CBUILD=3Dx86_64-pc-linux-gnu ./build

Thanks!

... Russell


On Fri, 02/24/2012 06:11 PM, Alon Bar-Lev <alon.barlev@...277...> wrote:
> How exactly did you try to build?
> Please send command-line.
>=20
> The mingw32 suffix is historic, it is kept for compatibility as old
> autotools(config.guess) packages expects for mingw32 as a platform, in
> the old days there was no (forced) standard for specifying the arch.
>=20
> On Sat, Feb 25, 2012 at 2:04 AM, Russell Morris
> <openembedded@...1315...> wrote:
> > Hi,
> >
> > First of all - thanks for this! It's very much appreciated!
> >
> > I tried this on my Linux box, and it worked fine - for the win32 image.
> > However, the win64 image fails, with the following error ...
> >
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > /usr/lib64/gcc/x86_64-w64-mingw32/4.6.2/../../../../x86_64-w64-mingw32/=
bin/ld:
> > cannot find -llzo2
> > /usr/lib64/gcc/x86_64-w64-mingw32/4.6.2/../../../../x86_64-w64-mingw32/=
bin/ld:
> > cannot find -lpkcs11-helper
> > collect2: ld returned 1 exit status
> > make[3]: *** [openvpn.exe] Error 1
> > make[3]: Leaving directory
> > `/home/rmorris/Documents/Programming/openvpn-build/generic/tmp/openvpn-=
2.3-alpha1/src/openvpn'
> > make[2]: *** [install-recursive] Error 1
> > make[2]: Leaving directory
> > `/home/rmorris/Documents/Programming/openvpn-build/generic/tmp/openvpn-=
2.3-alpha1/src'
> > make[1]: *** [install-recursive] Error 1
> > make[1]: Leaving directory
> > `/home/rmorris/Documents/Programming/openvpn-build/generic/tmp/openvpn-=
2.3-alpha1'
> > make: *** [install-strip] Error 2
> > FATAL: make openvpn
> >
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > Has anyone else seen this? Any thoughts how to correct it?
> >
> > Also, if you don't mind me asking - can anyone explain the naming conve=
ntion
> > for i686-w64-mingw32 vs. x86_64-w64-mingw32? They both seem to be "ming=
w32",
> > so a bit confused how one is really 64 bit.
> >
> > Thanks again,
> > ... Russell
> >
> >
> >
> >
> > On Tue, 02/21/2012 06:12 PM, Alon Bar-Lev <alon.barlev@...277...> wrote:
> >
> > Hello people who actually use Windows!
> >
> > I will appreciate if you test my new windows build environment for Open=
VPN.
> >
> > You have many options, I guess all are needed.
> >
> > While you at it, please try to explain me why we need Visual Studio bui=
ld...
> > :)
> > .
> > Build is here[1]
> >
> > BEST METHOD - Compile on Linux
> >
> > This is a generic method, it can cross compile OpenVPN using any
> > toolchain to any environment.
> > For Windows, make sure you have mingw-w64 toolchain.
> > We are using nsis so we can also package files at Linux.
> >
> > $ cd generic
> > $ IMAGEROOT=3D`pwd`/image-win32 CHOST=3Di686-w64-mingw32
> > CBUILD=3Dx86_64-pc-linux-gnu ./build
> > $ IMAGEROOT=3D`pwd`/image-win64 CHOST=3Dx86_64-w64-mingw32
> > CBUILD=3Dx86_64-pc-linux-gnu ./build
> >
> > SLOWER METHOD - Compile on cygwin
> >
> > Read README for required packages.
> >
> > $ cd generic
> > $ IMAGEROOT=3D`pwd`/image-win32 CHOST=3Di686-w64-mingw32
> > CBUILD=3Di686-pc-cygwin ./build
> > $ IMAGEROOT=3D`pwd`/image-win64 CHOST=3Dx86_64-w64-mingw32
> > CBUILD=3Di686-pc-cygwin ./build
> >
> > Visual Studio Complete Batch
> >
> > install perl
> >
> >> cd msvc
> >> build
> >
> > Visual Studio IDE
> >
> > After you have the dependencies of Complete Batch or your own.
> > Create msvc-env-local.bat with OPENVPN_DEPROOT pointing to the
> > location of the dependencies.
> >
> >> msvc-dev
> >
> > MSBuild
> >
> > After you have the dependencies of Complete Batch or your own.
> > Create msvc-env-local.bat with OPENVPN_DEPROOT pointing to the
> > location of the dependencies.
> >
> >> msvc-build
> >
> > Good luck,
> > Alon.
> >
> > [1] https://github.com/alonbl/openvpn-build
> >
> > -----------------------------------------------------------------------=
-------
> > Virtualization & Cloud Management Using Capacity Planning
> > Cloud computing makes use of virtualization - but cloud computing
> > also focuses on allowing computing to be delivered as a service.
> > http://www.accelacomm.com/jaw/sfnl/114/51521223/
> > _______________________________________________
> > Openvpn-devel mailing list
> > Openvpn-devel@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>=20
> -------------------------------------------------------------------------=
-----
> Virtualization & Cloud Management Using Capacity Planning
> Cloud computing makes use of virtualization - but cloud computing=20
> also focuses on allowing computing to be delivered as a service.
> http://www.accelacomm.com/jaw/sfnl/114/51521223/
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>=20=

--===axigen=0239367924111157360721968452835416309005=axigen===
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<html><head><style id=3D"axi-htmleditor-style" type=3D"text/css">p { margin=
: 0px; }</style></head><body style=3D"font-size: 10pt; font-family: Arial; =
background-image: none; background-repeat: repeat; background-attachment: f=
ixed;">Hi,<br><br>I used the command line you provided below (actually, cop=
ied and pasted it to the command line). The one having issues is: IMAGEROOT=
=3D`pwd`/image-win64 CHOST=3Dx86_64-w64-mingw32 CBUILD=3Dx86_64-pc-linux-gn=
u ./build<br><br>Thanks!<br><br>... Russell<br><br><br>On Fri, 02/24/2012 0=
6:11 PM, Alon&nbsp;Bar-Lev&nbsp;&lt;alon.barlev@...277...&gt; wrote:<br><bl=
ockquote style=3D"border-left: 2px solid rgb(00, 00, 204); padding-left: 4p=
x; margin-left: 16px;"><div style=3D"font-family: Arial; font-size: 10pt;">=
How exactly did you try to build?<br>Please send command-line.<br><br>The m=
ingw32 suffix is historic, it is kept for compatibility as old<br>autotools=
(config.guess) packages expects for mingw32 as a platform, in<br>the old da=
ys there was no (forced) standard for specifying the arch.<br><br>On Sat, F=
eb 25, 2012 at 2:04 AM, Russell Morris<br>&lt;<a href=3D"mailto:openembedde=
d@...1315..." target=3D"_blank">openembedded@...1315...</a>&gt; wrote:<br>&=
gt; Hi,<br>&gt;<br>&gt; First of all - thanks for this! It's very much appr=
eciated!<br>&gt;<br>&gt; I tried this on my Linux box, and it worked fine -=
 for the win32 image.<br>&gt; However, the win64 image fails, with the foll=
owing error ...<br>&gt;<br>&gt; =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>&gt;<br>=
&gt; /usr/lib64/gcc/x86_64-w64-mingw32/4.6.2/../../../../x86_64-w64-mingw32=
/bin/ld:<br>&gt; cannot find -llzo2<br>&gt; /usr/lib64/gcc/x86_64-w64-mingw=
32/4.6.2/../../../../x86_64-w64-mingw32/bin/ld:<br>&gt; cannot find -lpkcs1=
1-helper<br>&gt; collect2: ld returned 1 exit status<br>&gt; make[3]: *** [=
openvpn.exe] Error 1<br>&gt; make[3]: Leaving directory<br>&gt; `/home/rmor=
ris/Documents/Programming/openvpn-build/generic/tmp/openvpn-2.3-alpha1/src/=
openvpn'<br>&gt; make[2]: *** [install-recursive] Error 1<br>&gt; make[2]: =
Leaving directory<br>&gt; `/home/rmorris/Documents/Programming/openvpn-buil=
d/generic/tmp/openvpn-2.3-alpha1/src'<br>&gt; make[1]: *** [install-recursi=
ve] Error 1<br>&gt; make[1]: Leaving directory<br>&gt; `/home/rmorris/Docum=
ents/Programming/openvpn-build/generic/tmp/openvpn-2.3-alpha1'<br>&gt; make=
: *** [install-strip] Error 2<br>&gt; FATAL: make openvpn<br>&gt;<br>&gt; =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>&gt;<br>&gt; Has anyone else seen this? A=
ny thoughts how to correct it?<br>&gt;<br>&gt; Also, if you don't mind me a=
sking - can anyone explain the naming convention<br>&gt; for i686-w64-mingw=
32 vs. x86_64-w64-mingw32? They both seem to be "mingw32",<br>&gt; so a bit=
 confused how one is really 64 bit.<br>&gt;<br>&gt; Thanks again,<br>&gt; .=
.. Russell<br>&gt;<br>&gt;<br>&gt;<br>&gt;<br>&gt; On Tue, 02/21/2012 06:12=
 PM, Alon&nbsp;Bar-Lev&nbsp;&lt;<a href=3D"mailto:alon.barlev@...277..." ta=
rget=3D"_blank">alon.barlev@...277...</a>&gt; wrote:<br>&gt;<br>&gt; Hello =
people who actually use Windows!<br>&gt;<br>&gt; I will appreciate if you t=
est my new windows build environment for OpenVPN.<br>&gt;<br>&gt; You have =
many options, I guess all are needed.<br>&gt;<br>&gt; While you at it, plea=
se try to explain me why we need Visual Studio build...<br>&gt; :)<br>&gt; =
.<br>&gt; Build is here[1]<br>&gt;<br>&gt; BEST METHOD - Compile on Linux<b=
r>&gt;<br>&gt; This is a generic method, it can cross compile OpenVPN using=
 any<br>&gt; toolchain to any environment.<br>&gt; For Windows, make sure y=
ou have mingw-w64 toolchain.<br>&gt; We are using nsis so we can also packa=
ge files at Linux.<br>&gt;<br>&gt; $ cd generic<br>&gt; $ IMAGEROOT=3D`pwd`=
/image-win32 CHOST=3Di686-w64-mingw32<br>&gt; CBUILD=3Dx86_64-pc-linux-gnu =
./build<br>&gt; $ IMAGEROOT=3D`pwd`/image-win64 CHOST=3Dx86_64-w64-mingw32<=
br>&gt; CBUILD=3Dx86_64-pc-linux-gnu ./build<br>&gt;<br>&gt; SLOWER METHOD =
- Compile on cygwin<br>&gt;<br>&gt; Read README for required packages.<br>&=
gt;<br>&gt; $ cd generic<br>&gt; $ IMAGEROOT=3D`pwd`/image-win32 CHOST=3Di6=
86-w64-mingw32<br>&gt; CBUILD=3Di686-pc-cygwin ./build<br>&gt; $ IMAGEROOT=
=3D`pwd`/image-win64 CHOST=3Dx86_64-w64-mingw32<br>&gt; CBUILD=3Di686-pc-cy=
gwin ./build<br>&gt;<br>&gt; Visual Studio Complete Batch<br>&gt;<br>&gt; i=
nstall perl<br>&gt;<br>&gt;&gt; cd msvc<br>&gt;&gt; build<br>&gt;<br>&gt; V=
isual Studio IDE<br>&gt;<br>&gt; After you have the dependencies of Complet=
e Batch or your own.<br>&gt; Create msvc-env-local.bat with OPENVPN_DEPROOT=
 pointing to the<br>&gt; location of the dependencies.<br>&gt;<br>&gt;&gt; =
msvc-dev<br>&gt;<br>&gt; MSBuild<br>&gt;<br>&gt; After you have the depende=
ncies of Complete Batch or your own.<br>&gt; Create msvc-env-local.bat with=
 OPENVPN_DEPROOT pointing to the<br>&gt; location of the dependencies.<br>&=
gt;<br>&gt;&gt; msvc-build<br>&gt;<br>&gt; Good luck,<br>&gt; Alon.<br>&gt;=
<br>&gt; [1] <a href=3D"https://github.com/alonbl/openvpn-build" target=3D"=
_blank">https://github.com/alonbl/openvpn-build</a><br>&gt;<br>&gt; -------=
-----------------------------------------------------------------------<br>=
&gt; Virtualization &amp; Cloud Management Using Capacity Planning<br>&gt; =
Cloud computing makes use of virtualization - but cloud computing<br>&gt; a=
lso focuses on allowing computing to be delivered as a service.<br>&gt; <a =
href=3D"http://www.accelacomm.com/jaw/sfnl/114/51521223/" target=3D"_blank"=
>http://www.accelacomm.com/jaw/sfnl/114/51521223/</a><br>&gt; _____________=
__________________________________<br>&gt; Openvpn-devel mailing list<br>&g=
t;<a href=3D"mailto:%20Openvpn-devel@lists.sourceforge.net" target=3D"_blan=
k"> Openvpn-devel@lists.sourceforge.net</a><br>&gt; <a href=3D"https://list=
s.sourceforge.net/lists/listinfo/openvpn-devel" target=3D"_blank">https://l=
ists.sourceforge.net/lists/listinfo/openvpn-devel</a><br><br>--------------=
----------------------------------------------------------------<br>Virtual=
ization &amp; Cloud Management Using Capacity Planning<br>Cloud computing m=
akes use of virtualization - but cloud computing <br>also focuses on allowi=
ng computing to be delivered as a service.<br><a href=3D"http://www.accelac=
omm.com/jaw/sfnl/114/51521223/" target=3D"_blank">http://www.accelacomm.com=
/jaw/sfnl/114/51521223/</a><br>____________________________________________=
___<br>Openvpn-devel mailing list<br><a href=3D"mailto:Openvpn-devel@...1199...=
sourceforge.net" target=3D"_blank">Openvpn-devel@lists.sourceforge.net</a><=
br><a href=3D"https://lists.sourceforge.net/lists/listinfo/openvpn-devel" t=
arget=3D"_blank">https://lists.sourceforge.net/lists/listinfo/openvpn-devel=
</a><br></div></blockquote></body></html>=

--===axigen=0239367924111157360721968452835416309005=axigen===--


