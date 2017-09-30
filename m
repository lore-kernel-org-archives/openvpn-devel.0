MIME-Version: 1.0
In-Reply-To: <5cd04f5c-fb34-5586-f60d-ea65c8dea445@...2181...>
References: <1505450463-459-1-git-send-email-selva.nair@...277...>
 <1505501175-9016-1-git-send-email-selva.nair@...277...>
 <CAKuzo_iN6kzukk7ZETjwb6A8pXTkAgXUuQs3E1cf_enYbh-uCA@...278...>
 <5cd04f5c-fb34-5586-f60d-ea65c8dea445@...2181...>
From: Selva <selva.nair@...277...>
Date: Sat, 30 Sep 2017 11:29:22 -0400
Message-ID: <CAKuzo_i5MMar3XmrHes_aLUHsuisRJgXTWYTN3Xx-GM9bm8x=Q@...278...>
Content-Type: multipart/alternative; boundary="001a11499908880e1c055a69cf97"
Subject: Re: [Openvpn-devel] [PATCH v2] Check whether in pull_mode before
 warning about previous connection blocks
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Antonio Quartulli <a@...2181...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>, Gert Doering <gert@...1296...>

--001a11499908880e1c055a69cf97
Content-Type: text/plain; charset="UTF-8"

Hi,

On Thu, Sep 21, 2017 at 12:58 PM, Antonio Quartulli <a@...2181...> wrote:

>
>
> On 20/09/17 23:34, Selva wrote:
> > Hi,
> >
> > On Fri, Sep 15, 2017 at 2:46 PM, <selva.nair@...277...> wrote:
> >
> >> From: Selva Nair <selva.nair@...277...>
> >>
> >> In particular, this eliminates the message that says
> "explicit-exit-notify
> >> is ignored by previous <connection> blocks" when the option is pushed.
> >>
> >> Note: pull_mode is identified as "allowed & OPT_P_PULL_MODE" matching
> with
> >> the
> >> definition in add_options().
> >>
> >> Reported by: Eike Lohmann e.lohmann@...1294...
> >> https://www.mail-archive.com/openvpn-users@...1199...
> >> sourceforge.net/msg04052.html
> >>
> >> v2: move the check to verify_permissions() as suggested by
> >> Gert <gert@...1296...>
> >>
> >> Signed-off-by: Selva Nair <selva.nair@...277...>
> >> ---
> >>  src/openvpn/options.c | 4 +++-
> >>  1 file changed, 3 insertions(+), 1 deletion(-)
> >>
> >
> >
> > Does this look good now?
>
> pull_mode is already computed in add_options() and could just be passed
> to verify_permission(). However, adding another parameter to the
> function call is probably not worth the gain.
>
> Personally, I think this patch looks good now.
>
>
> Cheers,
>

Thanks :)

Selva

--001a11499908880e1c055a69cf97
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<br><div class=3D"gmail_extra"><br><div class=3D"gmail_=
quote">On Thu, Sep 21, 2017 at 12:58 PM, Antonio Quartulli <span dir=3D"ltr=
">&lt;<a href=3D"mailto:a@...2181..." target=3D"_blank">a@...2181...</a>&gt=
;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 =
.8ex;border-left:1px #ccc solid;padding-left:1ex"><span class=3D""><br>
<br>
On 20/09/17 23:34, Selva wrote:<br>
&gt; Hi,<br>
&gt;<br>
&gt; On Fri, Sep 15, 2017 at 2:46 PM, &lt;<a href=3D"mailto:selva.nair@...1665...=
77...">selva.nair@...277...</a>&gt; wrote:<br>
&gt;<br>
&gt;&gt; From: Selva Nair &lt;<a href=3D"mailto:selva.nair@...277...">selva=
.nair@...277...</a>&gt;<br>
&gt;&gt;<br>
&gt;&gt; In particular, this eliminates the message that says &quot;explici=
t-exit-notify<br>
&gt;&gt; is ignored by previous &lt;connection&gt; blocks&quot; when the op=
tion is pushed.<br>
&gt;&gt;<br>
&gt;&gt; Note: pull_mode is identified as &quot;allowed &amp; OPT_P_PULL_MO=
DE&quot; matching with<br>
&gt;&gt; the<br>
&gt;&gt; definition in add_options().<br>
&gt;&gt;<br>
&gt;&gt; Reported by: Eike Lohmann <a href=3D"mailto:e.lohmann@...1294...">=
e.lohmann@...1294...</a><br>
&gt;&gt; <a href=3D"https://www.mail-archive.com/openvpn-users@...1697..." =
rel=3D"noreferrer" target=3D"_blank">https://www.mail-archive.com/<wbr>open=
vpn-users@...1697...</a>.<br>
&gt;&gt; <a href=3D"http://sourceforge.net/msg04052.html" rel=3D"noreferrer=
" target=3D"_blank">sourceforge.net/msg04052.html</a><br>
&gt;&gt;<br>
&gt;&gt; v2: move the check to verify_permissions() as suggested by<br>
&gt;&gt; Gert &lt;<a href=3D"mailto:gert@...1296...">gert@...1296...</a>&gt=
;<br>
&gt;&gt;<br>
&gt;&gt; Signed-off-by: Selva Nair &lt;<a href=3D"mailto:selva.nair@...1354...=
..">selva.nair@...277...</a>&gt;<br>
&gt;&gt; ---<br>
&gt;&gt;=C2=A0 src/openvpn/options.c | 4 +++-<br>
&gt;&gt;=C2=A0 1 file changed, 3 insertions(+), 1 deletion(-)<br>
&gt;&gt;<br>
&gt;<br>
&gt;<br>
&gt; Does this look good now?<br>
<br>
</span>pull_mode is already computed in add_options() and could just be pas=
sed<br>
to verify_permission(). However, adding another parameter to the<br>
function call is probably not worth the gain.<br>
<br>
Personally, I think this patch looks good now.<br>
<br>
<br>
Cheers,<br></blockquote><div><br></div><div>Thanks :)</div><div><br></div><=
div>Selva=C2=A0</div></div></div></div>

--001a11499908880e1c055a69cf97--

