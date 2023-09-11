MIME-Version: 1.0
References: <20230709231929.195048-1-jeremyfleischman@...277...>
 <20230906171758.344862-1-jeremyfleischman@...277...>
 <f4cd60f6.AMcAACR4FjUAAAAAAAAAAW9e-ykAAYCsnhYAAAAAABXTlQBk_taJ@...2677...>
In-Reply-To: <f4cd60f6.AMcAACR4FjUAAAAAAAAAAW9e-ykAAYCsnhYAAAAAABXTlQBk_taJ@...2677...>
From: Jeremy Fleischman <jeremyfleischman@...277...>
Date: Mon, 11 Sep 2023 02:00:17 -0700
Message-ID: <CAHpv4cP2zuSHn+KNy5X6LGL+4tKQt400sy7WgoeHbXY0q7u9GA@...278...>
Content-Type: multipart/alternative; boundary="000000000000f101de0605118e17"
Subject: Re: [Openvpn-devel] [PATCH v2] Fix StatusChangeCallback so it works
 without a LogCallback
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: David Sommerseth <dazo+openvpn@...2108...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--000000000000f101de0605118e17
Content-Type: text/plain; charset="UTF-8"

Thank you for the update, and patience. My first email-based patch :)

On Mon, Sep 11, 2023, 1:57 AM David Sommerseth <dazo+openvpn@...2108...>
wrote:

> On 06/09/2023 19:17, Jeremy Fleischman wrote:
> > `StatusChangeCallback` requires that LogForward be enabled, which
> > previously only happened in `LogCallback`. Now both of them do it, which
> > requires a bit of bookkeeping. This fixes
> > https://github.com/OpenVPN/openvpn3-linux/issues/197
> >
> > Signed-off-by: Jeremy Fleischman <jeremyfleischman@...277...>
> > ---
> >   src/python/openvpn3/SessionManager.py | 69 ++++++++++++++++++++++-----
> >   1 file changed, 58 insertions(+), 11 deletions(-)
> >
>
> Thanks a lot for your patience and persistence through this review.
>
> Your patch has been put into the queue for the coming v21 release.  I've
> not yet pushed out that branch, as I'm waiting for our QA team to
> complete the testing of an updated OpenVPN 3 Core library release first;
> which is required to be able to build OpenVPN 3 Linux from the public
> repos.
>
> But consider your patch applied.  I've only done minor edits to some
> comments and commit messages, but the code itself is unchanged.
>
> I'll follow-up with an update once this commit is public.
>
>
> --
> kind regards,
>
> David Sommerseth
> OpenVPN Inc
>
>
>

--000000000000f101de0605118e17
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div>Thank you for the update, and patience. My first ema=
il-based patch :)=C2=A0</div><div dir=3D"auto"><br><div class=3D"gmail_quot=
e" dir=3D"auto"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Sep 11, 2023,=
 1:57 AM David Sommerseth &lt;<a href=3D"mailto:dazo%2Bopenvpn@...2108...">=
dazo+openvpn@...2108...</a>&gt; wrote:<br></div><blockquote class=3D"gmail_=
quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1=
ex">On 06/09/2023 19:17, Jeremy Fleischman wrote:<br>
&gt; `StatusChangeCallback` requires that LogForward be enabled, which<br>
&gt; previously only happened in `LogCallback`. Now both of them do it, whi=
ch<br>
&gt; requires a bit of bookkeeping. This fixes<br>
&gt; <a href=3D"https://github.com/OpenVPN/openvpn3-linux/issues/197" rel=
=3D"noreferrer noreferrer" target=3D"_blank">https://github.com/OpenVPN/ope=
nvpn3-linux/issues/197</a><br>
&gt; <br>
&gt; Signed-off-by: Jeremy Fleischman &lt;<a href=3D"mailto:jeremyfleischma=
n@...277..." target=3D"_blank" rel=3D"noreferrer">jeremyfleischman@...1663...=
.</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0src/python/openvpn3/SessionManager.py | 69 +++++++++++++++=
+++++++-----<br>
&gt;=C2=A0 =C2=A01 file changed, 58 insertions(+), 11 deletions(-)<br>
&gt; <br>
<br>
Thanks a lot for your patience and persistence through this review.<br>
<br>
Your patch has been put into the queue for the coming v21 release.=C2=A0 I&=
#39;ve <br>
not yet pushed out that branch, as I&#39;m waiting for our QA team to <br>
complete the testing of an updated OpenVPN 3 Core library release first; <b=
r>
which is required to be able to build OpenVPN 3 Linux from the public repos=
.<br>
<br>
But consider your patch applied.=C2=A0 I&#39;ve only done minor edits to so=
me <br>
comments and commit messages, but the code itself is unchanged.<br>
<br>
I&#39;ll follow-up with an update once this commit is public.<br>
<br>
<br>
-- <br>
kind regards,<br>
<br>
David Sommerseth<br>
OpenVPN Inc<br>
<br>
<br>
</blockquote></div></div></div>

--000000000000f101de0605118e17--

