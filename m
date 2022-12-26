MIME-Version: 1.0
References: <20210825210232.22509-1-selva.nair@...277...>
 <20210907223126.8440-1-selva.nair@...277...>
 <0366748c-832f-2704-9693-ef6842489977@...1227...>
In-Reply-To: <0366748c-832f-2704-9693-ef6842489977@...1227...>
From: Selva Nair <selva.nair@...277...>
Date: Mon, 26 Dec 2022 17:30:23 -0500
Message-ID: <CAKuzo_gmU-iP2dY9Vh1T2ZgJQEMJUCfnRj5ZnKiFLbCCAeK+sA@...278...>
Content-Type: multipart/alternative; boundary="0000000000005392b405f0c2af62"
Subject: Re: [Openvpn-devel] [PATCH v3 1/3] Add remote-count and
 remote-entry query via management
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net

--0000000000005392b405f0c2af62
Content-Type: text/plain; charset="UTF-8"

Hi

On Mon, Dec 26, 2022 at 2:45 PM Arne Schwabe <arne@...1227...> wrote:

> Am 08.09.21 um 00:31 schrieb selva.nair@...277...:
> > From: Selva Nair <selva.nair@...277...>
> >
> > Selecting the remote host via the management iterface
>
> *sigh* I reviewed the v2 instead of the v3 but the typo is still here :P
>
> > +static void
> > +man_remote_entry_count(struct management *man)
> > +{
> > +    unsigned count = 0;
> > +    if (man->persist.callback.remote_entry_count)
> > +    {
> > +        count =
> (*man->persist.callback.remote_entry_count)(man->persist.callback.arg);
>
> We could use C99 style here.
>
> > +        msg(M_CLIENT, "%u", count);
> > +        msg(M_CLIENT, "END");
> > +    }
> > +    else
> > +    {
> > +        msg(M_CLIENT, "ERROR: The remote-entry-count command is not
> supported by the current daemon mode");
> > +    }
> > +}
> > +
> > +#define min(a,b) ((a) < (b) ? (a) : (b))
>
> We already have min_int and min_uint in integer.h. For consistency I
> would prefer using those instead of adding a macro.
>
>
> > +
> > +static void
> > +man_remote_entry_get(struct management *man, const char *p1, const char
> *p2)
> > +{
> > +    ASSERT(p1);
> > +
> > +    if (man->persist.callback.remote_entry_get
> > +        && man->persist.callback.remote_entry_count)
> > +    {
> > +        bool res;
> > +        unsigned int from, to;
> > +        unsigned int count =
> (*man->persist.callback.remote_entry_count)(man->persist.callback.arg);
> > +
> > +        from = (unsigned int) atoi(p1);
> > +        to = p2? (unsigned int) atoi(p2) : from + 1;
> > +
>
> We probably want a space after p2.
>
> I know this has been very long and we are very close to 2.6 so
>
> Acked-By: Arne Schwabe <arne@...1227...>
>

Thanks..


>
> Maybe we can do a follow up patch to fix the mentioned small issues.
>

Will do as a followup or in the rebased pachc depending what Gert asks for.

Would it be too much to ask for a review of this one too ?
https://patchwork.openvpn.net/project/openvpn2/patch/20210907223614.8574-1-selva.nair@...277.../

Selva

--0000000000005392b405f0c2af62
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi</div><br><div class=3D"gmail_quote"><div dir=3D"lt=
r" class=3D"gmail_attr">On Mon, Dec 26, 2022 at 2:45 PM Arne Schwabe &lt;<a=
 href=3D"mailto:arne@...1227...">arne@...1227...</a>&gt; wrote:<br></div><b=
lockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-le=
ft:1px solid rgb(204,204,204);padding-left:1ex">Am 08.09.21 um 00:31 schrie=
b <a href=3D"mailto:selva.nair@...277..." target=3D"_blank">selva.nair@...1665...=
77...</a>:<br>
&gt; From: Selva Nair &lt;<a href=3D"mailto:selva.nair@...277..." target=3D=
"_blank">selva.nair@...277...</a>&gt;<br>
&gt; <br>
&gt; Selecting the remote host via the management iterface<br>
<br>
*sigh* I reviewed the v2 instead of the v3 but the typo is still here :P<br>
<br>
&gt; +static void<br>
&gt; +man_remote_entry_count(struct management *man)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 unsigned count =3D 0;<br>
&gt; +=C2=A0 =C2=A0 if (man-&gt;persist.callback.remote_entry_count)<br>
&gt; +=C2=A0 =C2=A0 {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 count =3D (*man-&gt;persist.callback.remo=
te_entry_count)(man-&gt;persist.callback.arg);<br>
<br>
We could use C99 style here.<br>
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 msg(M_CLIENT, &quot;%u&quot;, count);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 msg(M_CLIENT, &quot;END&quot;);<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 else<br>
&gt; +=C2=A0 =C2=A0 {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 msg(M_CLIENT, &quot;ERROR: The remote-ent=
ry-count command is not supported by the current daemon mode&quot;);<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +}<br>
&gt; +<br>
&gt; +#define min(a,b) ((a) &lt; (b) ? (a) : (b))<br>
<br>
We already have min_int and min_uint in integer.h. For consistency I <br>
would prefer using those instead of adding a macro.<br>
<br>
<br>
&gt; +<br>
&gt; +static void<br>
&gt; +man_remote_entry_get(struct management *man, const char *p1, const ch=
ar *p2)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 ASSERT(p1);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (man-&gt;persist.callback.remote_entry_get<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;&amp; man-&gt;persist.callback.remot=
e_entry_count)<br>
&gt; +=C2=A0 =C2=A0 {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 bool res;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned int from, to;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned int count =3D (*man-&gt;persist.=
callback.remote_entry_count)(man-&gt;persist.callback.arg);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 from =3D (unsigned int) atoi(p1);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 to =3D p2? (unsigned int) atoi(p2) : from=
 + 1;<br>
&gt; +<br>
<br>
We probably want a space after p2.<br>
<br>
I know this has been very long and we are very close to 2.6 so<br>
<br>
Acked-By: Arne Schwabe &lt;<a href=3D"mailto:arne@...1227..." target=3D"_bl=
ank">arne@...1227...</a>&gt;<br></blockquote><div><br></div><div>Thanks..</=
div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px =
0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
Maybe we can do a follow up patch to fix the mentioned small issues.<br></b=
lockquote><div><br></div><div>Will do as a followup=C2=A0or in the rebased =
pachc depending what Gert asks for.<br></div><div><br></div><div>Would it b=
e too much to ask for a review of this one too ?</div><div><a href=3D"https=
://patchwork.openvpn.net/project/openvpn2/patch/20210907223614.8574-1-selva=
.nair@...277.../">https://patchwork.openvpn.net/project/openvpn2/patch/2021=
0907223614.8574-1-selva.nair@...277.../</a><br></div><div><br></div><div>Se=
lva</div></div></div>

--0000000000005392b405f0c2af62--

