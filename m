MIME-Version: 1.0
In-Reply-To: <CAKuzo_h3Kq7A+ETd-GOsx_Mhv-LHBP-z8sb8OqD0nJBED6y5AQ@...278...>
References: <20171202085438.2393-1-a@...2181...>
 <CAKuzo_hgmFaE8ygqJ18YfP+WL+gaVh8yjnNCU0P0zQ=meOPeTg@...278...>
 <e0935209-c578-aa2c-a236-e1fee8452345@...2181...>
 <CAKuzo_h3Kq7A+ETd-GOsx_Mhv-LHBP-z8sb8OqD0nJBED6y5AQ@...278...>
From: Selva Nair <selva.nair@...277...>
Date: Sat, 2 Dec 2017 22:39:22 -0500
Message-ID: <CAKuzo_gCcxfr7jC27E=pymP04bYiPUSMhXkWF=qHte4DpwJ+ow@...278...>
Content-Type: multipart/alternative; boundary="001a1147603c2dd4e5055f675ae7"
Subject: [Openvpn-devel] Fwd: [PATCH v2] ifconfig-ipv6(-push): allow using
 hostnames
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--001a1147603c2dd4e5055f675ae7
Content-Type: text/plain; charset="UTF-8"

oops forgot to cc the list..

---------- Forwarded message ----------
From: Selva Nair <selva.nair@...277...>
Date: Sat, Dec 2, 2017 at 10:16 PM
Subject: Re: [Openvpn-devel] [PATCH v2] ifconfig-ipv6(-push): allow using
hostnames
To: Antonio Quartulli <a@...2181...>


Hi,

On Sat, Dec 2, 2017 at 9:25 PM, Antonio Quartulli <a@...2181...> wrote:

> Hi,
>
> On 03/12/17 04:27, Selva Nair wrote:
>
> >> +    /* we need to modify the hostname received as input, but we don't
> >> want to
> >> +     * touch it directly as it might be a constant string.
> >> +     *
> >> +     * Therefore, we clone the string here and free it at the end of
> the
> >> +     * function */
> >> +    var_host = strdup(hostname);
> >> +    ASSERT(var_host);
> >>
> >
> > I think ASSERT should be used only to catch errors in coding logic,
> > not for plausible runtime errors like this. Especially since this happens
> > on the server, no reason to terminate the process here.
> >
> > Instead, log an error (M_NONFTAL|M_ERRNO will do nicely) and return -1
> > or goto out. The option parser will log a generic warning, but still
> useful
> > to log here using M_ERRNO for more specific info.
> >
>
> I agree. I am also not a big fan of ASSERT(). I think I had copy/pasted
> this chunk of code from somewhere else (and consider that this patch is
> quite old even though I have re-sent it now).
>
> I will get rid of the ASSERTs.
>
> > Alternatively one could use a buffer on the stack --  easy to do as good
> > old dns names are limited in size (255 octets max?) and the current
> option
> > parser also limits the argument passed here to < 255 bytes. But if we
> > support
> > internationalized domain names (currently we do not, do we?) and if the
> line
> > length in option parser is ever increased, a much larger buffer would be
> > needed.
>
> Are you sure we have a limit of 255 octects? I am not so sure. Anyway,
> this is not extremely important for now.
>

Yes, not important for this patch and stdup is anyway fine as long as we do
not
ASSERT.

The 255 byte limit comes from the config file or option parser which reads
the
input from ccd or client-connect script output. The length of a line is
limited
to  #define OPTION_LINE_SIZE 256 in options.h


> >
> >
> >> +
> >> +    /* check if this hostname has a /bits suffix */
> >> +    sep = strchr(var_host , '/');
> >> +    if (sep)
> >> +    {
> >> +        bits = strtoul(sep + 1, &endp, 10);
> >
> >
> > There are a number of such type coercions in the patch
> > (ulong to uint8_t, size_t  to unit8_t etc.) that some compilers (aka
> MSVC:)
> > may warn about, but I do not personally care. All are safe and deliberate
> > except for the nitpicking below.
> >
> > +        if ((*endp != '\0') || (bits > max_bits))
> >
> >
> > That (bits > max_bits) check will not catch many input errors, as the
> > input is  already truncated to uint8_t. For example, /255 will be flagged
> > as an error, but /256 will pass as 0.
> >
>
> These are probably all copy/paste from other parts of the code. So the
> logic here is also used in other parts of the code. If we believe this
> is not the proper way to handle these cases, I'd suggest to take a note
> and fix these behaviors with a dedicated patch.
>

Please bear with me: Quoting from the patch:

-    char *sep, *endp;
-    int bits;
-    struct in6_addr t_network;

So, the original code had bits defined as int, so why change to unit8_t?
Changing the original int to unsigned int would've made sense
as we are parsing using strtoul and returning the result in an unsigned int.
But uint8_t brings in hardly any gain and causes all those regressions and
type conversions I pointed out..

> Though its not possible to catch all input errors, keeping bits as
> unsigned
> > int (instead of uint8_t) may be better here. That'll  also match netbits
> > in the function signature, return value of strtoul etc..


Regards,

Selva

--001a1147603c2dd4e5055f675ae7
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">oops forgot to cc the list..<div><br><div class=3D"gmail_q=
uote">---------- Forwarded message ----------<br>From: <b class=3D"gmail_se=
ndername">Selva Nair</b> <span dir=3D"ltr">&lt;<a href=3D"mailto:selva.nair=
@...277..." target=3D"_blank">selva.nair@...277...</a>&gt;</span><br>Date: =
Sat, Dec 2, 2017 at 10:16 PM<br>Subject: Re: [Openvpn-devel] [PATCH v2] ifc=
onfig-ipv6(-push): allow using hostnames<br>To: Antonio Quartulli &lt;a@...493...=
2181...&gt;<br><br><br><div dir=3D"ltr">Hi,<br><div class=3D"gmail_extra"><=
br><div class=3D"gmail_quote"><span>On Sat, Dec 2, 2017 at 9:25 PM, Antonio=
 Quartulli <span dir=3D"ltr">&lt;<a href=3D"mailto:a@...2181..." target=3D"=
_blank">a@...2181...</a>&gt;</span> wrote:<br></span><blockquote class=3D"g=
mail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204=
,204,204);padding-left:1ex"><span>Hi,<br>
<span class=3D"m_-5010737242329053804m_-7953305568631425660m_-6269457561558=
969180m_-1336617319804002374gmail-"><br>
On 03/12/17 04:27, Selva Nair wrote:<br></span></span><div><div class=3D"m_=
-5010737242329053804h5"><div><div class=3D"m_-5010737242329053804m_-7953305=
568631425660m_-6269457561558969180m_-1336617319804002374gmail-h5"><br>
&gt;&gt; +=C2=A0 =C2=A0 /* we need to modify the hostname received as input=
, but we don&#39;t<br>
&gt;&gt; want to<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0* touch it directly as it might be a constant=
 string.<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0*<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0* Therefore, we clone the string here and fre=
e it at the end of the<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0* function */<br>
&gt;&gt; +=C2=A0 =C2=A0 var_host =3D strdup(hostname);<br>
&gt;&gt; +=C2=A0 =C2=A0 ASSERT(var_host);<br>
&gt;&gt;<br>
&gt;<br>
&gt; I think ASSERT should be used only to catch errors in coding logic,<br>
&gt; not for plausible runtime errors like this. Especially since this happ=
ens<br>
&gt; on the server, no reason to terminate the process here.<br>
&gt;<br>
&gt; Instead, log an error (M_NONFTAL|M_ERRNO will do nicely) and return -1=
<br>
&gt; or goto out. The option parser will log a generic warning, but still u=
seful<br>
&gt; to log here using M_ERRNO for more specific info.<br>
&gt;<br>
<br>
</div></div>I agree. I am also not a big fan of ASSERT(). I think I had cop=
y/pasted<br>
this chunk of code from somewhere else (and consider that this patch is<br>
quite old even though I have re-sent it now).<br>
<br>
I will get rid of the ASSERTs.<br>
<span class=3D"m_-5010737242329053804m_-7953305568631425660m_-6269457561558=
969180m_-1336617319804002374gmail-"><br>
&gt; Alternatively one could use a buffer on the stack --=C2=A0 easy to do =
as good<br>
&gt; old dns names are limited in size (255 octets max?) and the current op=
tion<br>
&gt; parser also limits the argument passed here to &lt; 255 bytes. But if =
we<br>
&gt; support<br>
&gt; internationalized domain names (currently we do not, do we?) and if th=
e line<br>
&gt; length in option parser is ever increased, a much larger buffer would =
be<br>
&gt; needed.<br>
<br>
</span>Are you sure we have a limit of 255 octects? I am not so sure. Anywa=
y,<br>
this is not extremely important for now.<br></div></div></blockquote><div><=
br></div><div>Yes, not important for this patch and stdup is anyway fine as=
 long as we do not</div><div>ASSERT.=C2=A0</div><div><br></div><div>The 255=
 byte limit comes from the config file or option parser which reads the</di=
v><div>input from ccd or client-connect script output. The length of a line=
 is limited</div><div>to =C2=A0#define OPTION_LINE_SIZE 256 in options.h</d=
iv><span><div><br></div><blockquote class=3D"gmail_quote" style=3D"margin:0=
px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<span class=3D"m_-5010737242329053804m_-7953305568631425660m_-6269457561558=
969180m_-1336617319804002374gmail-"><br>
&gt;<br>
&gt;<br>
&gt;&gt; +<br>
&gt;&gt; +=C2=A0 =C2=A0 /* check if this hostname has a /bits suffix */<br>
&gt;&gt; +=C2=A0 =C2=A0 sep =3D strchr(var_host , &#39;/&#39;);<br>
&gt;&gt; +=C2=A0 =C2=A0 if (sep)<br>
&gt;&gt; +=C2=A0 =C2=A0 {<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 bits =3D strtoul(sep + 1, &amp;endp, =
10);<br>
&gt;<br>
&gt;<br>
&gt; There are a number of such type coercions in the patch<br>
&gt; (ulong to uint8_t, size_t=C2=A0 to unit8_t etc.) that some compilers (=
aka MSVC:)<br>
&gt; may warn about, but I do not personally care. All are safe and deliber=
ate<br>
&gt; except for the nitpicking below.<br>
&gt;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if ((*endp !=3D &#39;\0&#39;) || (bits &g=
t; max_bits))<br>
&gt;<br>
&gt;<br>
&gt; That (bits &gt; max_bits) check will not catch many input errors, as t=
he<br>
&gt; input is=C2=A0 already truncated to uint8_t. For example, /255 will be=
 flagged<br>
&gt; as an error, but /256 will pass as 0.<br>
&gt;<br>
<br>
</span>These are probably all copy/paste from other parts of the code. So t=
he<br>
logic here is also used in other parts of the code. If we believe this<br>
is not the proper way to handle these cases, I&#39;d suggest to take a note=
<br>
and fix these behaviors with a dedicated patch.<br></blockquote><div><br></=
div></span><div>Please bear with me: Quoting from the patch:</div><span><di=
v><br></div><div><div>- =C2=A0 =C2=A0char *sep, *endp;</div><div>- =C2=A0 =
=C2=A0int bits;</div><div>- =C2=A0 =C2=A0struct in6_addr t_network;</div></=
div><div><br></div></span><div>So, the original code had bits defined as in=
t, so why change to unit8_t?</div><div>Changing the original int to unsigne=
d int would&#39;ve made sense=C2=A0</div><div>as we are parsing using strto=
ul and returning the result in an unsigned int.</div><div>But uint8_t bring=
s in hardly any gain and causes all those regressions and</div><div>type co=
nversions I pointed out..</div><span><div><br></div><div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">&gt; Though its not possible to catch all =
input errors, keeping bits as unsigned<br>&gt; int (instead of uint8_t) may=
 be better here. That&#39;ll =C2=A0also match netbits<br>&gt; in the functi=
on signature, return value of strtoul etc..</blockquote></div><div><br></di=
v></span><div>Regards,</div><span class=3D"m_-5010737242329053804HOEnZb"><f=
ont color=3D"#888888"><div>=C2=A0</div><div>Selva</div></font></span></div>=
</div></div>
</div><br></div></div>

--001a1147603c2dd4e5055f675ae7--

