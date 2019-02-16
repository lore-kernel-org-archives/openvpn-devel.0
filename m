MIME-Version: 1.0
References: <1549917961-632-1-git-send-email-selva.nair@...277...>
 <44fea524-53ef-8125-5d81-cd8aaac0ad16@...2080...>
 <CAKuzo_gfasWN8d1wNBGyX4OOsCNgx7sH74fOQ=via+r5La1P0w@...278...>
 <f7b5ad3b-cf85-2fe0-5c9d-80de89c191a3@...2080...>
In-Reply-To: <f7b5ad3b-cf85-2fe0-5c9d-80de89c191a3@...2080...>
From: Selva Nair <selva.nair@...277...>
Date: Sat, 16 Feb 2019 10:28:07 -0500
Message-ID: <CAKuzo_iLb5G5axP+_mVw+9mo5q=LPpy1o-u_Uvqi+1ktPC3whg@...278...>
Content-Type: multipart/alternative; boundary="000000000000c5d1630582048af3"
Subject: Re: [Openvpn-devel] [PATCH] Exit early when external scripts are
 specified with script-security < 2
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: David Sommerseth <openvpn@...2080...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--000000000000c5d1630582048af3
Content-Type: text/plain; charset="UTF-8"

Hi,

On Sat, Feb 16, 2019 at 8:19 AM David Sommerseth <
openvpn@...2080...> wrote:

> On 15/02/2019 21:31, Selva Nair wrote:
> > Hi
> >
> > On Fri, Feb 15, 2019 at 3:26 PM David Sommerseth
> > <openvpn@...2080... <mailto:
> openvpn@...2080...>>
> > wrote:
> >
> >     On 11/02/2019 21:46, selva.nair@...277... <mailto:
> selva.nair@...277...> wrote:
> >     > From: Selva Nair <selva.nair@...277... <mailto:
> selva.nair@...277...>>
> >     >
> >     > Currently this raises a warning only. A fatal error is triggered
> >     > later with a confusing message that script failed to execute.
> >     >
> >     > This helps the Windows GUI to show a relevant error message when
> >     > script-security is over-ridden as a security measure.
> >     >
> >     > Signed-off-by: Selva Nair <selva.nair@...277...
> >     <mailto:selva.nair@...277...>>
> >     > ---
> >     >  src/openvpn/init.c | 2 +-
> >     >  1 file changed, 1 insertion(+), 1 deletion(-)
> >     >
> >     > diff --git a/src/openvpn/init.c b/src/openvpn/init.c
> >     > index 3c44967..5863828 100644
> >     > --- a/src/openvpn/init.c
> >     > +++ b/src/openvpn/init.c
> >     > @@ -3206,7 +3206,7 @@ do_option_warnings(struct context *c)
> >     >          }
> >     >          else
> >     >          {
> >     > -            msg(M_WARN, "NOTE: starting with " PACKAGE_NAME " 2.1,
> >     '--script-security 2' or higher is required to call user-defined
> scripts
> >     or executables");
> >     > +            msg(M_FATAL, "ERROR: starting with " PACKAGE_NAME "
> 2.1,
> >     '--script-security 2' or higher is required to call user-defined
> scripts
> >     or executables");
> >
> >     Generally speaking, I am fine with this (so Feature-ACK).
> >
> >     What I am struggling with though is that this may break existing
> >     configurations for users who do have an invalid configuration file.
> In this
> >     case trying to use scripts without --script-security *and* ignoring
> that their
> >     scripts does not work.  The cynical me says "scr** them, they need
> to fix
> >     their configs".
> >
> > I fail to get this.. Users cannot ignore it as currently they do get a
> FATAL
> > error in such cases.
> > I'm only moving the error to happen earlier.
> > Am I missing something?
>
> So another M_FATAL occurs later on?  I haven't checked the code yet, but I
> was
> quite sure there were scenarios where scripts failed to run - with with
> some
> other complaints in the log.
>
> If all script hooks results in M_FATAL later on (server and client
> configs),
> then this is a non-issue.
>

That got me worried as I had checked this only with up/down scripts on
client
in which case it causes a FATAL error later in openvpn_run_script.

But you are right, not all scripts cause FATAL error when not executed or
failed..

In that case, a better option may be to get a proper error msg -- instead
of "external program fork failed"
we want "script not executed because of script-security < xxx " or
something like that..

Selva

--000000000000c5d1630582048af3
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi,</div><br><div class=3D"gmail_quote"><div dir=3D"l=
tr" class=3D"gmail_attr">On Sat, Feb 16, 2019 at 8:19 AM David Sommerseth &=
lt;<a href=3D"mailto:openvpn@...2080..." target=3D"_blank">openvpn@...2495...=
..</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margi=
n:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex=
">On 15/02/2019 21:31, Selva Nair wrote:<br>
&gt; Hi<br>
&gt; <br>
&gt; On Fri, Feb 15, 2019 at 3:26 PM David Sommerseth<br>
&gt; &lt;<a href=3D"mailto:openvpn@...2080..." target=3D"_blank">openvpn@...1186...=
.2080...</a> &lt;mailto:<a href=3D"mailto:openvpn@...2080..." target=3D"_bl=
ank">openvpn@...2080...</a>&gt;&gt;<br>
&gt; wrote:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0On 11/02/2019 21:46, <a href=3D"mailto:selva.nair@...220...=
..277..." target=3D"_blank">selva.nair@...277...</a> &lt;mailto:<a href=3D"=
mailto:selva.nair@...277..." target=3D"_blank">selva.nair@...277...</a>&gt;=
 wrote:<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; From: Selva Nair &lt;<a href=3D"mailto:selva.n=
air@...277..." target=3D"_blank">selva.nair@...277...</a> &lt;mailto:<a hre=
f=3D"mailto:selva.nair@...277..." target=3D"_blank">selva.nair@...277...</a=
>&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; Currently this raises a warning only. A fatal =
error is triggered<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; later with a confusing message that script fai=
led to execute.<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; This helps the Windows GUI to show a relevant =
error message when<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; script-security is over-ridden as a security m=
easure.<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; Signed-off-by: Selva Nair &lt;<a href=3D"mailt=
o:selva.nair@...277..." target=3D"_blank">selva.nair@...277...</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mailto:selva.nair@...277..." =
target=3D"_blank">selva.nair@...277...</a>&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; ---<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 src/openvpn/init.c | 2 +-<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 1 file changed, 1 insertion(+), 1 deleti=
on(-)<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; diff --git a/src/openvpn/init.c b/src/openvpn/=
init.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; index 3c44967..5863828 100644<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; --- a/src/openvpn/init.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +++ b/src/openvpn/init.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; @@ -3206,7 +3206,7 @@ do_option_warnings(struc=
t context *c)<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 msg=
(M_WARN, &quot;NOTE: starting with &quot; PACKAGE_NAME &quot; 2.1,<br>
&gt;=C2=A0 =C2=A0 =C2=A0&#39;--script-security 2&#39; or higher is required=
 to call user-defined scripts<br>
&gt;=C2=A0 =C2=A0 =C2=A0or executables&quot;);<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 msg=
(M_FATAL, &quot;ERROR: starting with &quot; PACKAGE_NAME &quot; 2.1,<br>
&gt;=C2=A0 =C2=A0 =C2=A0&#39;--script-security 2&#39; or higher is required=
 to call user-defined scripts<br>
&gt;=C2=A0 =C2=A0 =C2=A0or executables&quot;);<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Generally speaking, I am fine with this (so Feature=
-ACK).<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0What I am struggling with though is that this may b=
reak existing<br>
&gt;=C2=A0 =C2=A0 =C2=A0configurations for users who do have an invalid con=
figuration file.=C2=A0 In this<br>
&gt;=C2=A0 =C2=A0 =C2=A0case trying to use scripts without --script-securit=
y *and* ignoring that their<br>
&gt;=C2=A0 =C2=A0 =C2=A0scripts does not work.=C2=A0 The cynical me says &q=
uot;scr** them, they need to fix<br>
&gt;=C2=A0 =C2=A0 =C2=A0their configs&quot;.<br>
&gt; <br>
&gt; I fail to get this.. Users cannot ignore it as currently they do get a=
 FATAL<br>
&gt; error in such cases.<br>
&gt; I&#39;m only moving the error to happen earlier.<br>
&gt; Am I missing something?<br>
<br>
So another M_FATAL occurs later on?=C2=A0 I haven&#39;t checked the code ye=
t, but I was<br>
quite sure there were scenarios where scripts failed to run - with with som=
e<br>
other complaints in the log.<br>
<br>
If all script hooks results in M_FATAL later on (server and client configs)=
,<br>
then this is a non-issue.<br></blockquote><div><br></div><div>That got me w=
orried as I had checked this only with up/down scripts on client</div><div>=
in which case it causes a FATAL error later in openvpn_run_script.</div><di=
v><br></div><div>But you are right, not all scripts cause FATAL error when =
not executed or failed..</div><div><br></div><div>In that case, a better op=
tion may be to get a proper error msg -- instead of &quot;external program =
fork failed&quot;</div><div>we want &quot;script not executed because of sc=
ript-security &lt; xxx &quot; or something like that..</div><div><br></div>=
<div>Selva</div></div></div>

--000000000000c5d1630582048af3--

