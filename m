MIME-Version: 1.0
In-Reply-To: <20160225125742.GA21087@...1296...>
References: <1455937988-12414-1-git-send-email-selva.nair@...277...>
	<201602251201.u1PC1qiO020709@...2054...>
	<20160225125742.GA21087@...1296...>
From: Selva Nair <selva.nair@...277...>
Date: Thu, 25 Feb 2016 10:57:52 -0500
Message-ID: <CAKuzo_h4TxqCnQ9jzQ1D07jKjvfGJJAhjJR-OpPUU_cpNw20WA@...278...>
Content-Type: multipart/alternative; boundary=001a113dde34dd4ef4052c9a3f94
Subject: Re: [Openvpn-devel] [PATCH applied] Re: Restrict options/configs
 for startup through interactive service
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--001a113dde34dd4ef4052c9a3f94
Content-Type: text/plain; charset=UTF-8

On Thu, Feb 25, 2016 at 7:57 AM, Gert Doering <gert@...1296...> wrote:

> Hi,
>
> On Thu, Feb 25, 2016 at 01:01:52PM +0100, Gert Doering wrote:
> > ACK.  Needed functionality, and the implementation looks good to me
> > (I wouldn't mind more closed scrutiny by one of the more experienced
> > windows programmers, but since they are all too busy, my reading of
> > the code will have to do).  I fixed one typo ("Retrurns") in a comment.
> >
> > Your patch has been applied to the master branch.
>
> Mmmh.  It breaks compilation on Samuli's buildbot...
>
> /bin/bash ../../libtool  --tag=CC   --mode=link i686-w64-mingw32-gcc
> -municode -D_UNICODE -UNTDDI_VERSION -U_WIN32_WINNT
> -D_WIN32_WINNT=_WIN32_WINNT_VISTA    -o openvpnserv.exe
> openvpnserv-common.o openvpnserv-automatic.o openvpnserv-interactive.o
> openvpnserv-service.o openvpnserv-validate.o openvpnserv_resources.o
> -ladvapi32 -luserenv -liphlpapi -lshlwapi -lnetapi32 -lws2_32
> libtool: link: i686-w64-mingw32-gcc -municode -D_UNICODE -UNTDDI_VERSION
> -U_WIN32_WINNT -D_WIN32_WINNT=_WIN32_WINNT_VISTA -o .libs/openvpnserv.exe
> openvpnserv-common.o openvpnserv-automatic.o openvpnserv-interactive.o
> openvpnserv-service.o openvpnserv-validate.o openvpnserv_resources.o
> -ladvapi32 -luserenv -liphlpapi -lshlwapi -lnetapi32 -lws2_32
> openvpnserv-validate.o:validate.c:(.text+0x54): undefined reference to
> `PathIsRelativeW'
> openvpnserv-validate.o:validate.c:(.text+0x31f): undefined reference to
> `NetApiBufferFree'
>
> the microsoft documentation says, PathIsRelativeW() is in "Shlwapi.dll",
> and I can see the link line pulling that in...  "NetApiBufferFree()" is
> in "Netapi32.dll", and that is *also* linked...
>
> I'm a bit at a loss why it is bombing here...
>

Ah, sorry I should have checked 32 bit compilation. Its due to missing
includes, not a big problem for 64 bit as dll import names are not mangled,
but in 32 bit linker may be looking for _PathIsRelativeW etc.. (I think..)
Anyway my mistake.. Will do a patch..

Selva

--001a113dde34dd4ef4052c9a3f94
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Thu, Feb 25, 2016 at 7:57 AM, Gert Doering <span dir=3D"ltr">&lt;<a href=
=3D"mailto:gert@...1296..." target=3D"_blank">gert@...1296...</a>&gt;</span=
> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bo=
rder-left:1px #ccc solid;padding-left:1ex"><div id=3D":3sm" class=3D"a3s" s=
tyle=3D"overflow:hidden">Hi,<br>
<span class=3D""><br>
On Thu, Feb 25, 2016 at 01:01:52PM +0100, Gert Doering wrote:<br>
&gt; ACK.=C2=A0 Needed functionality, and the implementation looks good to =
me<br>
&gt; (I wouldn&#39;t mind more closed scrutiny by one of the more experienc=
ed<br>
&gt; windows programmers, but since they are all too busy, my reading of<br>
&gt; the code will have to do).=C2=A0 I fixed one typo (&quot;Retrurns&quot=
;) in a comment.<br>
&gt;<br>
&gt; Your patch has been applied to the master branch.<br>
<br>
</span>Mmmh.=C2=A0 It breaks compilation on Samuli&#39;s buildbot...<br>
<br>
/bin/bash ../../libtool=C2=A0 --tag=3DCC=C2=A0 =C2=A0--mode=3Dlink i686-w64=
-mingw32-gcc -municode -D_UNICODE -UNTDDI_VERSION -U_WIN32_WINNT -D_WIN32_W=
INNT=3D_WIN32_WINNT_VISTA=C2=A0 =C2=A0 -o openvpnserv.exe openvpnserv-commo=
n.o openvpnserv-automatic.o openvpnserv-interactive.o openvpnserv-service.o=
 openvpnserv-validate.o openvpnserv_resources.o -ladvapi32 -luserenv -liphl=
papi -lshlwapi -lnetapi32 -lws2_32<br>
libtool: link: i686-w64-mingw32-gcc -municode -D_UNICODE -UNTDDI_VERSION -U=
_WIN32_WINNT -D_WIN32_WINNT=3D_WIN32_WINNT_VISTA -o .libs/openvpnserv.exe o=
penvpnserv-common.o openvpnserv-automatic.o openvpnserv-interactive.o openv=
pnserv-service.o openvpnserv-validate.o openvpnserv_resources.o=C2=A0 -ladv=
api32 -luserenv -liphlpapi -lshlwapi -lnetapi32 -lws2_32<br>
openvpnserv-validate.o:validate.c:(.text+0x54): undefined reference to `Pat=
hIsRelativeW&#39;<br>
openvpnserv-validate.o:validate.c:(.text+0x31f): undefined reference to `Ne=
tApiBufferFree&#39;<br>
<br>
the microsoft documentation says, PathIsRelativeW() is in &quot;Shlwapi.dll=
&quot;,<br>
and I can see the link line pulling that in...=C2=A0 &quot;NetApiBufferFree=
()&quot; is<br>
in &quot;Netapi32.dll&quot;, and that is *also* linked...<br>
<br>
I&#39;m a bit at a loss why it is bombing here...</div></blockquote></div><=
br>Ah, sorry I should have checked 32 bit compilation. Its due to missing i=
ncludes, not a big problem for 64 bit as dll import names are not mangled, =
but in 32 bit linker may be looking for _PathIsRelativeW etc.. (I think..) =
Anyway my mistake.. Will do a patch..</div><div class=3D"gmail_extra"><br><=
/div><div class=3D"gmail_extra">Selva</div><div class=3D"gmail_extra"><br><=
/div><div class=3D"gmail_extra">=C2=A0=C2=A0</div></div>

--001a113dde34dd4ef4052c9a3f94--

