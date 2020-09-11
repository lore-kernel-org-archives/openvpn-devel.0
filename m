MIME-Version: 1.0
References: <CAAWBBYNLPWmjJ3whY6FAj2G8tT_qkPWZR-gUsKFHe1memta2Og@...278...>
 <CAAF3xa8T=mmZUQdyF3=AZMZZf46TJ85zH=WwAm7ORZiiGGWqZg@...278...>
 <CAKuzo_iTQWBA3t=to4sKdt21pxotNECVfTMFP_fhrEeQ3ejnQQ@...278...>
 <CAAF3xa_Jz1bjw52zBLLdXjgMymk8q+47kt9R8bP8K9Fpt8+s3g@...278...>
 <CAKuzo_jj0SXCVLrthzeCJddK2iKKXAAg4SGTA_pNRXYqcJfTQw@...278...>
 <CAAF3xa-fQ_m=Tow44wqf3DMqWEq9z90n+6Xgg6NvW-UdTaVjHQ@...278...>
 <CAKuzo_gEfixxkFVz3H4myjX9tQAXgGBMpKMJH4fWF2PesHDKDA@...278...>
 <21A02C2A-4FB5-4E3E-9D9C-B09253C9EBD9@...277...>
 <20200910073321.GR75094@...1296...>
 <CAAF3xa9CHb_xe0fn5tdiYRx-Bp3gpTfTL-KfHKqMEMdxe+XFkQ@...278...>
 <20200911055839.GZ75094@...1296...>
In-Reply-To: <20200911055839.GZ75094@...1296...>
From: Selva Nair <selva.nair@...277...>
Date: Fri, 11 Sep 2020 12:47:08 -0400
Message-ID: <CAKuzo_hA2sSzCcYjgtqstX4o8knzBE9HjFboNX8s+T7pPY4=6Q@...278...>
Content-Type: multipart/alternative; boundary="000000000000ce420505af0c707b"
Subject: Re: [Openvpn-devel] problem with beta3 and wintun
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--000000000000ce420505af0c707b
Content-Type: text/plain; charset="UTF-8"

Hi,

On Fri, Sep 11, 2020 at 1:58 AM Gert Doering <gert@...1296...> wrote:

> Hi,
>
> On Thu, Sep 10, 2020 at 06:10:17PM -0700, Marvin wrote:
> > To All 3,
> > Thank you with your help I found the issue. UAC was disabled in the
> > registry on this image.  IIRC we had trouble updating some software by
> > automated script and turning UAC off was required.
> >
> > After re-enabling UAC, wintun started normally.
>
> Cool, thanks for digging into this and reporting back.
>
> Selva, is there any reasonable way to detect this?  Or do we just go
> for "we always use the iservice if it is running, no matter what
> privs the GUI is running with"?


I think TokenElevationType will indicate whether using split token (UAC
enabled) or not.

Personally, I would like to show a warning when the GUI is started with
privileges but some users may not like it. And we could make iservice a
requirement for the GUI. The service is mature enough now and has become a
necessity with wintun support.

Although we don't have any reason not to connect to named pipes as admin in
post-vista systems, the idea that the GUI should be run without elevated
privileges appeals to me. Unless the user has taken deliberate steps to
force running it as admin, it just works that way. Disabling UAC and then
log in as admin for day to day work is like using root for browsing the
web.

That said, I won't object to a patch that removes the restriction when the
runtime version is Win7 and newer.

Selva

--000000000000ce420505af0c707b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi,</div><br><div class=3D"gmail_quote"><=
div dir=3D"ltr" class=3D"gmail_attr">On Fri, Sep 11, 2020 at 1:58 AM Gert D=
oering &lt;<a href=3D"mailto:gert@...1296..." target=3D"_blank">gert@...1826...=
6...</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"mar=
gin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1=
ex">Hi,<br>
<br>
On Thu, Sep 10, 2020 at 06:10:17PM -0700, Marvin wrote:<br>
&gt; To All 3,<br>
&gt; Thank you with your help I found the issue. UAC was disabled in the<br>
&gt; registry on this image.=C2=A0 IIRC we had trouble updating some softwa=
re by<br>
&gt; automated script and turning UAC off was required.<br>
&gt; <br>
&gt; After re-enabling UAC, wintun started normally.<br>
<br>
Cool, thanks for digging into this and reporting back.<br>
<br>
Selva, is there any reasonable way to detect this?=C2=A0 Or do we just go<b=
r>
for &quot;we always use the iservice if it is running, no matter what <br>
privs the GUI is running with&quot;?</blockquote><div><br></div><div>I thin=
k TokenElevationType will indicate whether using split token (UAC enabled) =
or not.</div><div><br></div><div>Personally, I would like to show a warning=
 when the GUI is started with privileges but some users may not like it. An=
d we could make iservice a requirement for=C2=A0the=C2=A0GUI. The service i=
s mature enough now and has become a necessity with wintun support.</div><d=
iv><br></div><div>Although we don&#39;t=C2=A0have any reason not to connect=
 to named=C2=A0pipes as admin in post-vista systems, the idea that the GUI =
should be run without elevated privileges appeals to me. Unless the user ha=
s taken deliberate steps to force running it as admin, it just works that w=
ay. Disabling UAC and then log in as admin for day=C2=A0to day work is like=
 using root for browsing the web.=C2=A0</div><div><br></div><div>That said,=
 I won&#39;t=C2=A0object to a patch that removes the restriction when the r=
untime version is Win7 and newer.</div><div><br></div><div>Selva</div></div=
></div>

--000000000000ce420505af0c707b--

