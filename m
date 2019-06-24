MIME-Version: 1.0
References: <e55f098a-1ba1-02d7-5f50-b12e4eec054a@...515...>
 <ef6133bb-cb4a-d70a-c0b4-1b9466fc19fd@...515...>
 <FF8443AE-D430-496D-881A-C75171649BA6@...2293...>
 <66e96fe1-46ef-ba52-8db3-ae575f105d1d@...515...>
 <e1a67659-043d-9ddd-1f5d-f4461e056aae@...515...>
In-Reply-To: <e1a67659-043d-9ddd-1f5d-f4461e056aae@...515...>
From: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Date: Tue, 25 Jun 2019 01:24:21 +0500
Message-ID: <CAFHpkQESwV=ykC1dX2pAoC9Pvoc56NiNeFJkwxnJZN4X9=q1kg@...278...>
Content-Type: multipart/alternative; boundary="0000000000009aa399058c17990c"
Subject: Re: [Openvpn-devel] Summary of the community meeting (20th June
 2019)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: =?UTF-8?Q?Samuli_Sepp=C3=A4nen?= <samuli@...515...>
Cc: Simon Rozman <simon@...2293...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--0000000000009aa399058c17990c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D0=BF=D0=BD, 24 =D0=B8=D1=8E=D0=BD. 2019 =D0=B3. =D0=B2 23:14, Samuli Sepp=
=C3=A4nen <samuli@...515...>:

> Hi,
>
> Il 24/06/19 14:33, Samuli Sepp=C3=A4nen ha scritto:
> > Hi Simon,
> >
> > Thanks for the info again!
> >
> > Il 21/06/19 18:59, Simon Rozman ha scritto:
> >> (21:04:58) mattock: assuming Microsoft's systems are happy with the
> test submission package, that is
> >> (21:05:12) mattock: they _should_ be, but we have not tested submitting
> anything yes
> >>
> >> 1. Do the SDV and DVL to get tap901.DVL.xml.
> >
> > I'm working on this right now. Based on brief practical testing EWDK may
> > not be able to do this, even though it is apparently possible to produce
> > SDV logs from the command-line:>
> >
> https://docs.microsoft.com/en-us/windows-hardware/drivers/develop/creatin=
g-a-log-file-for-static-driver-verifier
> >
> > It _seems_ that EWDK might not have all the necessary pieces for
> > producing SDV log files. MS does briefly mention that EWDK is not
> > suitable for doing driver testing, whatever that means. So, to play it
>
> Actually it is probably possible to use the EWDK for running Static
> Driver Verifier:
>
> <
> https://github.com/MicrosoftDocs/windows-driver-docs/blob/staging/windows=
-driver-docs-pr/develop/creating-a-driver-verification-log.md
> >
> <
> https://docs.microsoft.com/it-it/windows-hardware/drivers/devtest/static-=
driver-verifier
> >
>
> > safe, I'm installing Visual Studio 2019 plus the "normal" Windows Driver
> > Kit on my tapbuilder VM.
>
> So, I took a stab at producing the Static Driver Verifier logs in Visual
> Studio 2019 ("Extensions" -> "Static Driver Verifier"), but it just
> complains about
>
> "Please select a driver project for sdv to verify"
>
> I wonder if I just hit a usability problem, or if something is actually
> missing from tap-windows6?
>
> Attempting to run SDV from the command-line (adapted from first link
> above) fails as well. The /clean part works fine, but running SDV fails:
>
> PS> msbuild.exe src\tap-windows6.vcxproj /p:Configuration=3D"Release"
> /p:Platform=3Dx64 /target:sdv /p:inputs=3D"/clean"
>
> --- snip ---
>
> PS> msbuild.exe src\tap-windows6.vcxproj /p:Configuration=3D"Release"
> /p:Platform=3Dx64 /target:sdv /p:inputs=3D"/check:default.sdv"
>
>   [INFO] Validating XML against schema: C:\Program Files (x86)\Windows
> Kits\10\TOOLS\SDV\smv\bin\Config.xsd
>   [INFO] Running local scheduler with 2 threads
>   [FATAL ERROR] Unrecoverable error in NormalBuild stage.
> C:\Program Files (x86)\Windows
> Kits\10\build\windowsdriver.Sdv.targets(136,9): error MSB3073: The
> command "staticdv /ch
> eck:default.sdv" exited with code -1.
> [C:\Users\samuli\opt\tap-windows6\src\tap-windows6.vcxproj]
> Done Building Project
> "C:\Users\samuli\opt\tap-windows6\src\tap-windows6.vcxproj" (sdv
> target(s)) -- FAILED.
>
>
> Build FAILED.
>
> "C:\Users\samuli\opt\tap-windows6\src\tap-windows6.vcxproj" (sdv target)
> (1) ->
> (sdv target) ->
>   C:\Program Files (x86)\Windows
> Kits\10\build\windowsdriver.Sdv.targets(136,9): error MSB3073: The
> command "staticdv /
> check:default.sdv" exited with code -1.
> [C:\Users\samuli\opt\tap-windows6\src\tap-windows6.vcxproj]
>
>     0 Warning(s)
>     1 Error(s)
>
> Time Elapsed 00:00:02.65
>
> ---
>
> Am I missing something [that is obvious to a Windows developer]?
>

can you try adding /v:d

to the following line

msbuild.exe src\tap-windows6.vcxproj /p:Configuration=3D"Release"
/p:Platform=3Dx64 /target:sdv /p:inputs=3D"/check:default.sdv"

?

(it means verbosity detailed)



>
> Samuli
>
> [*] Adapting the instructions of the first link, above
>
> >
> >> 2. Compile the driver and EV sign it. Save PDBs too.
> >
> > I assume this is not really necessary if I'm using WDKTest certificates
> > and have enabled test-signing?
> >
> >> 3. Deploy the driver on test computers (including tap901.DVL.xml,
> remember?).
> >> 4. Do the WHLK.
> >> 5. When creating submission package, add the driver binaries and PDBs
> (on HLK Studio submission page).
> >> 6. Submit the driver to Microsoft WHQL.
> >> 7. Miscrosoft should return you a WHQL signed driver in about 10
> minutes.
> >>
> >> (21:07:09) mattock: worst case scenario is that I have to reinstall the
> HLK client as Windows Server 2019 core _if_ Microsoft is not happy with t=
he
> "Operate in Server Core" having been run on a virtual machine, or on some
> old i5 laptop which does not have the required 4 physical processor cores
> >>
> >> Microsoft is fine with that test being run on a virtual Windows Server
> 2019 Core in Wintun case. And this test is pretty straight forward - just
> checks that driver loads and adapter responds, it doesn't need to be
> connected and have traffic. Use devcon to make a single TAP adapter on the
> Server Core. No need to have a running OpenVPN connection for this test to
> pass.
> >
> > This is good news. I can just use a Virtualbox VM then. This test used
> > to pass even on EC2 Windows instances.
> >
> >> (21:14:42) mattock: I also finally ate our own dogfood and installer
> OpenVPN on the virtual host running the HLK controller so that I can acce=
ss
> the HLK controller and clients remotely, which speeds the testing up quite
> a bit
> >>
> >> Not a good idea, as WHLK tests can and will interfere with all
> TAP-Windows6 adapters on test computers. Not just the one that is being
> tested. Expect OpenVPN connections to flicker or die. Just use it to acce=
ss
> controller server only. I never experienced any issues requiring
> intervention on test computers.
> >
> > The OpenVPN client I'm talking about is installed on a Linux laptop that
> > works as a Virtualbox host. The HLK controller is a VM on that host.
> > None of the HLK computers know about its existence.
> >
> > The HLK test client and support machine do have OpenVPN setup, but that
> > is a completely separate p2p bridged setup used to allow the two-machine
> > NDIS tests pass. And it works well for that purpose.
> >
>
>
>
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>

--0000000000009aa399058c17990c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">=D0=BF=D0=BD, 24 =D0=B8=D1=8E=D0=BD. =
2019 =D0=B3. =D0=B2 23:14, Samuli Sepp=C3=A4nen &lt;<a href=3D"mailto:samul=
i@...515...">samuli@...515...</a>&gt;:<br></div><blockquote class=3D"gmail_=
quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,=
204);padding-left:1ex">Hi,<br>
<br>
Il 24/06/19 14:33, Samuli Sepp=C3=A4nen ha scritto:<br>
&gt; Hi Simon,<br>
&gt; <br>
&gt; Thanks for the info again!<br>
&gt; <br>
&gt; Il 21/06/19 18:59, Simon Rozman ha scritto:<br>
&gt;&gt; (21:04:58) mattock: assuming Microsoft&#39;s systems are happy wit=
h the test submission package, that is<br>
&gt;&gt; (21:05:12) mattock: they _should_ be, but we have not tested submi=
tting anything yes<br>
&gt;&gt;<br>
&gt;&gt; 1. Do the SDV and DVL to get tap901.DVL.xml.<br>
&gt; <br>
&gt; I&#39;m working on this right now. Based on brief practical testing EW=
DK may<br>
&gt; not be able to do this, even though it is apparently possible to produ=
ce<br>
&gt; SDV logs from the command-line:&gt;<br>
&gt; <a href=3D"https://docs.microsoft.com/en-us/windows-hardware/drivers/d=
evelop/creating-a-log-file-for-static-driver-verifier" rel=3D"noreferrer" t=
arget=3D"_blank">https://docs.microsoft.com/en-us/windows-hardware/drivers/=
develop/creating-a-log-file-for-static-driver-verifier</a><br>
&gt; <br>
&gt; It _seems_ that EWDK might not have all the necessary pieces for<br>
&gt; producing SDV log files. MS does briefly mention that EWDK is not<br>
&gt; suitable for doing driver testing, whatever that means. So, to play it=
<br>
<br>
Actually it is probably possible to use the EWDK for running Static<br>
Driver Verifier:<br>
<br>
&lt;<a href=3D"https://github.com/MicrosoftDocs/windows-driver-docs/blob/st=
aging/windows-driver-docs-pr/develop/creating-a-driver-verification-log.md"=
 rel=3D"noreferrer" target=3D"_blank">https://github.com/MicrosoftDocs/wind=
ows-driver-docs/blob/staging/windows-driver-docs-pr/develop/creating-a-driv=
er-verification-log.md</a>&gt;<br>
&lt;<a href=3D"https://docs.microsoft.com/it-it/windows-hardware/drivers/de=
vtest/static-driver-verifier" rel=3D"noreferrer" target=3D"_blank">https://=
docs.microsoft.com/it-it/windows-hardware/drivers/devtest/static-driver-ver=
ifier</a>&gt;<br>
<br>
&gt; safe, I&#39;m installing Visual Studio 2019 plus the &quot;normal&quot=
; Windows Driver<br>
&gt; Kit on my tapbuilder VM.<br>
<br>
So, I took a stab at producing the Static Driver Verifier logs in Visual<br>
Studio 2019 (&quot;Extensions&quot; -&gt; &quot;Static Driver Verifier&quot=
;), but it just<br>
complains about<br>
<br>
&quot;Please select a driver project for sdv to verify&quot;<br>
<br>
I wonder if I just hit a usability problem, or if something is actually<br>
missing from tap-windows6?<br>
<br>
Attempting to run SDV from the command-line (adapted from first link<br>
above) fails as well. The /clean part works fine, but running SDV fails:<br>
<br>
PS&gt; msbuild.exe src\tap-windows6.vcxproj /p:Configuration=3D&quot;Releas=
e&quot;<br>
/p:Platform=3Dx64 /target:sdv /p:inputs=3D&quot;/clean&quot;<br>
<br>
--- snip ---<br>
<br>
PS&gt; msbuild.exe src\tap-windows6.vcxproj /p:Configuration=3D&quot;Releas=
e&quot;<br>
/p:Platform=3Dx64 /target:sdv /p:inputs=3D&quot;/check:default.sdv&quot;<br>
<br>
=C2=A0 [INFO] Validating XML against schema: C:\Program Files (x86)\Windows=
<br>
Kits\10\TOOLS\SDV\smv\bin\Config.xsd<br>
=C2=A0 [INFO] Running local scheduler with 2 threads<br>
=C2=A0 [FATAL ERROR] Unrecoverable error in NormalBuild stage.<br>
C:\Program Files (x86)\Windows<br>
Kits\10\build\windowsdriver.Sdv.targets(136,9): error MSB3073: The<br>
command &quot;staticdv /ch<br>
eck:default.sdv&quot; exited with code -1.<br>
[C:\Users\samuli\opt\tap-windows6\src\tap-windows6.vcxproj]<br>
Done Building Project<br>
&quot;C:\Users\samuli\opt\tap-windows6\src\tap-windows6.vcxproj&quot; (sdv<=
br>
target(s)) -- FAILED.<br>
<br>
<br>
Build FAILED.<br>
<br>
&quot;C:\Users\samuli\opt\tap-windows6\src\tap-windows6.vcxproj&quot; (sdv =
target)<br>
(1) -&gt;<br>
(sdv target) -&gt;<br>
=C2=A0 C:\Program Files (x86)\Windows<br>
Kits\10\build\windowsdriver.Sdv.targets(136,9): error MSB3073: The<br>
command &quot;staticdv /<br>
check:default.sdv&quot; exited with code -1.<br>
[C:\Users\samuli\opt\tap-windows6\src\tap-windows6.vcxproj]<br>
<br>
=C2=A0 =C2=A0 0 Warning(s)<br>
=C2=A0 =C2=A0 1 Error(s)<br>
<br>
Time Elapsed 00:00:02.65<br>
<br>
---<br>
<br>
Am I missing something [that is obvious to a Windows developer]?<br></block=
quote><div><br></div><div>can you try adding /v:d</div><div><br></div><div>=
to the following line</div><div><br></div><div>msbuild.exe src\tap-windows6=
.vcxproj /p:Configuration=3D&quot;Release&quot;<br>/p:Platform=3Dx64 /targe=
t:sdv /p:inputs=3D&quot;/check:default.sdv&quot;<br></div><div><br></div><d=
iv>?</div><div><br></div><div>(it means verbosity detailed)</div><div><br><=
/div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px=
 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
Samuli<br>
<br>
[*] Adapting the instructions of the first link, above<br>
<br>
&gt; <br>
&gt;&gt; 2. Compile the driver and EV sign it. Save PDBs too.<br>
&gt; <br>
&gt; I assume this is not really necessary if I&#39;m using WDKTest certifi=
cates<br>
&gt; and have enabled test-signing?<br>
&gt; <br>
&gt;&gt; 3. Deploy the driver on test computers (including tap901.DVL.xml, =
remember?).<br>
&gt;&gt; 4. Do the WHLK.<br>
&gt;&gt; 5. When creating submission package, add the driver binaries and P=
DBs (on HLK Studio submission page).<br>
&gt;&gt; 6. Submit the driver to Microsoft WHQL.<br>
&gt;&gt; 7. Miscrosoft should return you a WHQL signed driver in about 10 m=
inutes.<br>
&gt;&gt;<br>
&gt;&gt; (21:07:09) mattock: worst case scenario is that I have to reinstal=
l the HLK client as Windows Server 2019 core _if_ Microsoft is not happy wi=
th the &quot;Operate in Server Core&quot; having been run on a virtual mach=
ine, or on some old i5 laptop which does not have the required 4 physical p=
rocessor cores<br>
&gt;&gt;<br>
&gt;&gt; Microsoft is fine with that test being run on a virtual Windows Se=
rver 2019 Core in Wintun case. And this test is pretty straight forward - j=
ust checks that driver loads and adapter responds, it doesn&#39;t need to b=
e connected and have traffic. Use devcon to make a single TAP adapter on th=
e Server Core. No need to have a running OpenVPN connection for this test t=
o pass.<br>
&gt; <br>
&gt; This is good news. I can just use a Virtualbox VM then. This test used=
<br>
&gt; to pass even on EC2 Windows instances.<br>
&gt; <br>
&gt;&gt; (21:14:42) mattock: I also finally ate our own dogfood and install=
er OpenVPN on the virtual host running the HLK controller so that I can acc=
ess the HLK controller and clients remotely, which speeds the testing up qu=
ite a bit<br>
&gt;&gt;<br>
&gt;&gt; Not a good idea, as WHLK tests can and will interfere with all TAP=
-Windows6 adapters on test computers. Not just the one that is being tested=
. Expect OpenVPN connections to flicker or die. Just use it to access contr=
oller server only. I never experienced any issues requiring intervention on=
 test computers.<br>
&gt; <br>
&gt; The OpenVPN client I&#39;m talking about is installed on a Linux lapto=
p that<br>
&gt; works as a Virtualbox host. The HLK controller is a VM on that host.<b=
r>
&gt; None of the HLK computers know about its existence.<br>
&gt; <br>
&gt; The HLK test client and support machine do have OpenVPN setup, but tha=
t<br>
&gt; is a completely separate p2p bridged setup used to allow the two-machi=
ne<br>
&gt; NDIS tests pass. And it works well for that purpose.<br>
&gt; <br>
<br>
<br>
<br>
_______________________________________________<br>
Openvpn-devel mailing list<br>
<a href=3D"mailto:Openvpn-devel@lists.sourceforge.net" target=3D"_blank">Op=
envpn-devel@lists.sourceforge.net</a><br>
<a href=3D"https://lists.sourceforge.net/lists/listinfo/openvpn-devel" rel=
=3D"noreferrer" target=3D"_blank">https://lists.sourceforge.net/lists/listi=
nfo/openvpn-devel</a><br>
</blockquote></div></div>

--0000000000009aa399058c17990c--

