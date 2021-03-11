MIME-Version: 1.0
References: <20210310124808.14741-1-gert@...1296...>
 <202103111723.12BHNAYE012156@...2054...>
In-Reply-To: <202103111723.12BHNAYE012156@...2054...>
From: Selva Nair <selva.nair@...277...>
Date: Thu, 11 Mar 2021 13:12:04 -0500
Message-ID: <CAKuzo_g4xteFB=tAbTaZ94F3mRieJmmzvDRV7bhxzNC99q-LUw@...278...>
Content-Type: multipart/alternative; boundary="000000000000902a8b05bd46b908"
Subject: Re: [Openvpn-devel] [PATCH applied] Re: Require at least 100MB of
 mlock()-able memory if --mlock is used.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--000000000000902a8b05bd46b908
Content-Type: text/plain; charset="UTF-8"

Hi,

On Thu, Mar 11, 2021 at 12:24 PM Gert Doering <gert@...1296...> wrote:

> Thanks, Selva.
>
> v3 has actually been buildbot-tested on all the platforms (I tested
> v2 after the ACK, and it failed OpenSolaris, so I grumbled and adjusted
> the #ifdef's...).  It has been "tested for real" on Linux, which has
> "prlimit" to tell you the currently-active limits for *other* processes
> - haven't found something equivalent on the BSDs, so only "it will
> report the right value(s) and not explode"-tested (+ buildbot compile).
>

prlimit on Linux is handy as it can change the limits of a running process
as well.
On FreeBSD probably "limits -P pid ... " can do the same?

Selva

>
> Patch has been applied to the master branch.
>
> commit b0bff5590152fbcc5b4d47c18817838fd00c58c3
> Author: Gert Doering
> Date:   Wed Mar 10 13:48:08 2021 +0100
>
>      Require at least 100MB of mlock()-able memory if --mlock is used.
>
>      Signed-off-by: Gert Doering <gert@...1296...>
>      Acked-by: Selva Nair <selva.nair@...277...>
>      Message-Id: <20210310124808.14741-1-gert@...1296...>
>      URL:
> https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg21657.html
>      Signed-off-by: Gert Doering <gert@...1296...>
>
>
> --
> kind regards,
>
> Gert Doering
>
>
>
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>

--000000000000902a8b05bd46b908
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi,</div><br><div class=3D"gmail_quote"><div dir=3D"l=
tr" class=3D"gmail_attr">On Thu, Mar 11, 2021 at 12:24 PM Gert Doering &lt;=
<a href=3D"mailto:gert@...1296...">gert@...1296...</a>&gt; wrote:<br></div>=
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left:1px solid rgb(204,204,204);padding-left:1ex">Thanks, Selva.<br>
<br>
v3 has actually been buildbot-tested on all the platforms (I tested<br>
v2 after the ACK, and it failed OpenSolaris, so I grumbled and adjusted<br>
the #ifdef&#39;s...).=C2=A0 It has been &quot;tested for real&quot; on Linu=
x, which has<br>
&quot;prlimit&quot; to tell you the currently-active limits for *other* pro=
cesses <br>
- haven&#39;t found something equivalent on the BSDs, so only &quot;it will=
<br>
report the right value(s) and not explode&quot;-tested (+ buildbot compile)=
.<br></blockquote><div><br></div><div>prlimit on Linux is handy as it can c=
hange the limits of a running process as well.</div><div>On FreeBSD probabl=
y &quot;limits -P pid ... &quot; can do the same?</div><div><br></div><div>=
Selva=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px =
0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
Patch has been applied to the master branch.<br>
<br>
commit b0bff5590152fbcc5b4d47c18817838fd00c58c3<br>
Author: Gert Doering<br>
Date:=C2=A0 =C2=A0Wed Mar 10 13:48:08 2021 +0100<br>
<br>
=C2=A0 =C2=A0 =C2=A0Require at least 100MB of mlock()-able memory if --mloc=
k is used.<br>
<br>
=C2=A0 =C2=A0 =C2=A0Signed-off-by: Gert Doering &lt;<a href=3D"mailto:gert@=
...1296..." target=3D"_blank">gert@...1296...</a>&gt;<br>
=C2=A0 =C2=A0 =C2=A0Acked-by: Selva Nair &lt;<a href=3D"mailto:selva.nair@...220...=
..277..." target=3D"_blank">selva.nair@...277...</a>&gt;<br>
=C2=A0 =C2=A0 =C2=A0Message-Id: &lt;<a href=3D"mailto:20210310124808.14741-=
1-gert@...1296..." target=3D"_blank">20210310124808.14741-1-gert@...1296...=
</a>&gt;<br>
=C2=A0 =C2=A0 =C2=A0URL: <a href=3D"https://www.mail-archive.com/openvpn-de=
vel@lists.sourceforge.net/msg21657.html" rel=3D"noreferrer" target=3D"_blan=
k">https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg2165=
7.html</a><br>
=C2=A0 =C2=A0 =C2=A0Signed-off-by: Gert Doering &lt;<a href=3D"mailto:gert@=
...1296..." target=3D"_blank">gert@...1296...</a>&gt;<br>
<br>
<br>
--<br>
kind regards,<br>
<br>
Gert Doering<br>
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

--000000000000902a8b05bd46b908--

