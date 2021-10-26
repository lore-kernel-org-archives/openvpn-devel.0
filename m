MIME-Version: 1.0
References: <20211019183127.614175-1-arne@...1227...>
 <20211019183127.614175-15-arne@...1227...>
 <1717c64a-b237-9b5f-0278-830048d0e74d@...2507...>
In-Reply-To: <1717c64a-b237-9b5f-0278-830048d0e74d@...2507...>
From: Selva Nair <selva.nair@...277...>
Date: Tue, 26 Oct 2021 14:25:54 -0400
Message-ID: <CAKuzo_jZ5w=bz5g+BOcrGaRhZEL3k17AennBAYj+Jra6FznoVQ@...278...>
Content-Type: multipart/alternative; boundary="000000000000b7ebdf05cf459c51"
Subject: Re: [Openvpn-devel] [PATCH v3 14/21] [OSSL 3.0] Use
 TYPE_do_all_provided function for listing cipher/digest
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Max Fillinger <maximilian.fillinger@...2507...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--000000000000b7ebdf05cf459c51
Content-Type: text/plain; charset="UTF-8"

On Tue, Oct 26, 2021 at 1:50 PM Max Fillinger <
maximilian.fillinger@...2507...> wrote:

> On 19/10/2021 20:31, Arne Schwabe wrote:
> > With OpenSSL 3.0 the use of nid values is deprecated and new algorithms
> > do not even have NID values anymore.
> >
> > This also works nicely with providers now:
> >
> >     openvpn --provider legacy:default --show-ciphers
> >
> > shows more ciphers (e.g. BF-CBC) than just
> >
> >     openvpn --show-ciphers
> >
> > when compiled with OpenSSL 3.0
> >
> > Signed-off-by: Arne Schwabe <arne@...1227...>
>
> Looks good, and the tests work with OpenSSL 3 and OpenSSL 1.1.1 when I
> also apply the "Do not allow CTS ciphers" patch.
>
> One nitpick:
>
> > +struct collect_ciphers {
> > +    /* If we ever exceed this, we must be more selective */
> > +    const EVP_CIPHER *list[1000];
> > +    size_t num;
> > +};
> > +
> > +static void collect_ciphers(EVP_CIPHER *cipher, void *list)
> > +{
> > +    struct collect_ciphers* cipher_list = list;
> > +    if (cipher_list->num ==
> (sizeof(cipher_list->list)/sizeof(*cipher_list->list)))
> > +    {
> > +        msg(M_WARN, "WARNING: Too many ciphers, not showing all");
> > +        return;
> > +    }
>
> I think it would be more readable to use a const (or a #define) for the
> length of the cipher list array, instead of using sizeof.
>

IIRC, we have SIZE(x) = sizeof(x)/sizeof(*x) defined in some header for
this.

Selva

--000000000000b7ebdf05cf459c51
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Tue, Oct 26, 2021 at 1:50 PM Max F=
illinger &lt;<a href=3D"mailto:maximilian.fillinger@...2507...">maximilian.=
fillinger@...2507...</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quo=
te" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204=
);padding-left:1ex">On 19/10/2021 20:31, Arne Schwabe wrote:<br>
&gt; With OpenSSL 3.0 the use of nid values is deprecated and new algorithm=
s<br>
&gt; do not even have NID values anymore.<br>
&gt; <br>
&gt; This also works nicely with providers now:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0openvpn --provider legacy:default --show-ciphers<br>
&gt; <br>
&gt; shows more ciphers (e.g. BF-CBC) than just<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0openvpn --show-ciphers<br>
&gt; <br>
&gt; when compiled with OpenSSL 3.0<br>
&gt; <br>
&gt; Signed-off-by: Arne Schwabe &lt;<a href=3D"mailto:arne@...1227..." tar=
get=3D"_blank">arne@...1227...</a>&gt;<br>
<br>
Looks good, and the tests work with OpenSSL 3 and OpenSSL 1.1.1 when I <br>
also apply the &quot;Do not allow CTS ciphers&quot; patch.<br>
<br>
One nitpick:<br>
<br>
&gt; +struct collect_ciphers {<br>
&gt; +=C2=A0 =C2=A0 /* If we ever exceed this, we must be more selective */=
<br>
&gt; +=C2=A0 =C2=A0 const EVP_CIPHER *list[1000];<br>
&gt; +=C2=A0 =C2=A0 size_t num;<br>
&gt; +};<br>
&gt; +<br>
&gt; +static void collect_ciphers(EVP_CIPHER *cipher, void *list)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 struct collect_ciphers* cipher_list =3D list;<br>
&gt; +=C2=A0 =C2=A0 if (cipher_list-&gt;num =3D=3D (sizeof(cipher_list-&gt;=
list)/sizeof(*cipher_list-&gt;list)))<br>
&gt; +=C2=A0 =C2=A0 {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 msg(M_WARN, &quot;WARNING: Too many ciphe=
rs, not showing all&quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
&gt; +=C2=A0 =C2=A0 }<br>
<br>
I think it would be more readable to use a const (or a #define) for the <br>
length of the cipher list array, instead of using sizeof.<br></blockquote><=
div><br></div><div>IIRC, we have SIZE(x) =3D sizeof(x)/sizeof(*x) defined i=
n some header for this.</div><div><br></div><div>Selva</div></div></div>

--000000000000b7ebdf05cf459c51--

