MIME-Version: 1.0
References: <20210825040122.14244-1-selva.nair@...277...>
 <87212698-ffd0-3178-8b46-d3f088092eb8@...1227...>
In-Reply-To: <87212698-ffd0-3178-8b46-d3f088092eb8@...1227...>
From: Selva Nair <selva.nair@...277...>
Date: Wed, 25 Aug 2021 12:10:16 -0400
Message-ID: <CAKuzo_jZBzEpM2kbrYsui-5KDf_cv3Xjeapoa7CY+7PpFT+1Bg@...278...>
Content-Type: multipart/alternative; boundary="0000000000007807b805ca6485fd"
Subject: Re: [Openvpn-devel] [PATCH 1/2] Add remote-count and remote-entry
 query via management
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--0000000000007807b805ca6485fd
Content-Type: text/plain; charset="UTF-8"

Hi

On Wed, Aug 25, 2021 at 10:24 AM Arne Schwabe <arne@...1227...> wrote:

>
> >
> > +static bool
> > +management_callback_remote_entry(void *arg, unsigned *count, char
> **remote)
> > +{
> > +    assert(arg);
> > +    assert(count);
> > +
> > +    struct context *c = (struct context *) arg;
> > +    struct connection_list *l = c->options.connection_list;
> > +    bool ret = true;
> > +
> > +    if (!remote) /* query is for the count of entries */
> > +    {
> > +        *count = l->len;
> > +    }
> > +    else if (*count < l->len) /* the query is for entry with index =
> count */
> > +    {
> > +        struct connection_entry *ce = l->array[*count];
> > +        const char *proto = proto2ascii(ce->proto, ce->af, false);
> > +
> > +        /* space for output including 2 commas and a nul */
> > +        int len = strlen(ce->remote) + strlen(ce->remote_port) +
> strlen(proto) + 2 + 1;
> > +        char *out = malloc(len);
> > +        check_malloc_return(out);
> > +
> > +        openvpn_snprintf(out, len, "%s,%s,%s", ce->remote,
> ce->remote_port, proto);
> > +        *remote = out;
> > +    }
> > +    else
> > +    {
> > +        ret = false;
> > +        msg(M_WARN, "Invalid arguments in management query for remote
> entry: count = %u", *count);
> > +    }
> > +    return ret;
> > +}
> > +
>
> I am not sure mixing two related but different functions into one
> function has any real advantages. A function that just returns the count
> would simplify that function and this function.
>

Makes sense. v2 is coming.


> > +static void
> > +man_remote_entry_count(struct management *man)
> > +{
> > +    unsigned count = 0;
> > +    if (man->persist.callback.remote_entry)
> > +    {
> > +
> (*man->persist.callback.remote_entry)(man->persist.callback.arg, &count,
> NULL);
>
> The return value is not used here, this might upset some compilers.
>

The above will fix that too.


>
> > +        msg(M_CLIENT, ">REMOTE-ENTRY-COUNT:%u", count);
> > +    }
> > +    else
> > +    {
> > +        msg(M_CLIENT, "ERROR: The remote-entry-count command is not
> supported by the current daemon mode");
> > +    }
> > +}
>
> At some point we should do a helper function that does this boilerplate
> code that we copy&paste here over and over.
>

Actually this else could be possibly eliminated as, in this case, the
callback is not conditionally compiled in. Unlike things like pkcs11-id
support. Will check and simplify.

Thanks,

Selva

--0000000000007807b805ca6485fd
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi</div><br><div class=3D"gmail_quote"><div dir=3D"lt=
r" class=3D"gmail_attr">On Wed, Aug 25, 2021 at 10:24 AM Arne Schwabe &lt;<=
a href=3D"mailto:arne@...1227...">arne@...1227...</a>&gt; wrote:<br></div><=
blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-l=
eft:1px solid rgb(204,204,204);padding-left:1ex"><br>
&gt;=C2=A0 <br>
&gt; +static bool<br>
&gt; +management_callback_remote_entry(void *arg, unsigned *count, char **r=
emote)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 assert(arg);<br>
&gt; +=C2=A0 =C2=A0 assert(count);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 struct context *c =3D (struct context *) arg;<br>
&gt; +=C2=A0 =C2=A0 struct connection_list *l =3D c-&gt;options.connection_=
list;<br>
&gt; +=C2=A0 =C2=A0 bool ret =3D true;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (!remote) /* query is for the count of entries */<br>
&gt; +=C2=A0 =C2=A0 {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 *count =3D l-&gt;len;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 else if (*count &lt; l-&gt;len) /* the query is for ent=
ry with index =3D count */<br>
&gt; +=C2=A0 =C2=A0 {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct connection_entry *ce =3D l-&gt;arr=
ay[*count];<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 const char *proto =3D proto2ascii(ce-&gt;=
proto, ce-&gt;af, false);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* space for output including 2 commas an=
d a nul */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 int len =3D strlen(ce-&gt;remote) + strle=
n(ce-&gt;remote_port) + strlen(proto) + 2 + 1;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 char *out =3D malloc(len);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 check_malloc_return(out);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 openvpn_snprintf(out, len, &quot;%s,%s,%s=
&quot;, ce-&gt;remote, ce-&gt;remote_port, proto);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 *remote =3D out;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 else<br>
&gt; +=C2=A0 =C2=A0 {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D false;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 msg(M_WARN, &quot;Invalid arguments in ma=
nagement query for remote entry: count =3D %u&quot;, *count);<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 return ret;<br>
&gt; +}<br>
&gt; +<br>
<br>
I am not sure mixing two related but different functions into one<br>
function has any real advantages. A function that just returns the count<br>
would simplify that function and this function.<br></blockquote><div><br></=
div><div>Makes sense. v2 is coming.</div><div>=C2=A0</div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">
&gt; +static void<br>
&gt; +man_remote_entry_count(struct management *man)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 unsigned count =3D 0;<br>
&gt; +=C2=A0 =C2=A0 if (man-&gt;persist.callback.remote_entry)<br>
&gt; +=C2=A0 =C2=A0 {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 (*man-&gt;persist.callback.remote_entry)(=
man-&gt;persist.callback.arg, &amp;count, NULL);<br>
<br>
The return value is not used here, this might upset some compilers.<br></bl=
ockquote><div><br></div><div>The above will fix that too.</div><div>=C2=A0<=
/div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bo=
rder-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 msg(M_CLIENT, &quot;&gt;REMOTE-ENTRY-COUN=
T:%u&quot;, count);<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 else<br>
&gt; +=C2=A0 =C2=A0 {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 msg(M_CLIENT, &quot;ERROR: The remote-ent=
ry-count command is not supported by the current daemon mode&quot;);<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +}<br>
<br>
At some point we should do a helper function that does this boilerplate<br>
code that we copy&amp;paste here over and over.<br></blockquote><div><br></=
div><div>Actually this else could be possibly eliminated as, in this case, =
the callback is not conditionally compiled in. Unlike things like pkcs11-id=
 support. Will check and simplify.<br></div><div><br></div><div>Thanks,</di=
v><div><br></div><div>Selva</div></div></div>

--0000000000007807b805ca6485fd--

