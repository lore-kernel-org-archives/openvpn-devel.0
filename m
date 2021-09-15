MIME-Version: 1.0
References: <604d3782-646c-4f12-b789-2ae9ebbae069@...515...>
 <42e7467d-67b9-a6c3-6348-bb1d1e0ef21c@...515...>
 <CAKuzo_hA34XJP-uz7VgC0mkDdd+48-dOURxqjfhik6fjbsNK-Q@...278...>
 <898155c6-85f3-c9ce-145d-30673825e3f7@...1227...>
In-Reply-To: <898155c6-85f3-c9ce-145d-30673825e3f7@...1227...>
From: Selva Nair <selva.nair@...277...>
Date: Wed, 15 Sep 2021 12:01:08 -0400
Message-ID: <CAKuzo_gmS8j5KcxoRq8uR27Ocj4W4z0eKOLVUrF2WWQ8-+afgw@...278...>
Content-Type: multipart/alternative; boundary="000000000000a1936d05cc0ad9e0"
Subject: Re: [Openvpn-devel] Summary of the community meeting (15th
 September 2021)
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

--000000000000a1936d05cc0ad9e0
Content-Type: text/plain; charset="UTF-8"

Hi Arne,

On Wed, Sep 15, 2021 at 11:03 AM Arne Schwabe <arne@...1227...> wrote:

> Am 15.09.21 um 16:36 schrieb Selva Nair:
> > Hi,
> >
> >
> >     Plaisthos is preparing patches that drop support for the APIs that
> are
> >     deprecated in OpenSSL 3.0.
> >
> >     Agreed that the OpenSSL 3.0 patches should be master only, so only
> 2.6
> >     will have full OpenSSL 3.0 support with external key support and
> >     without
> >     compiler warnings.
> >
> >
> > Good to see some discussion on OpenSSL 3.0 support. I'm working on
> > converting "cryptoapicert" to use a custom built-in provider. In fact,
> > the provider framework could be common for all external keys
> > (cryptoapicert, management-external-key and pkcs11) with only the key
> > loading and signing ops redirected to respective backends.
>
> Depending on far you have come, you might be ahead of me. I didn't know
> that you are already working on that.
>

I started looking into the new provider interface only recently, and
cryptoapicert re-write only a week ago. It took a while to get a hang of
the provider framework.

Given that I do this during off-hours, I may take a week or two to have
something worth sharing.


>
> > If Arne is adding a provider implementation for this, maybe I
> > should hold off?
>
> I am currently trying to get together a "small" provider by adapting
> code from https://github.com/tpm2-software/tpm2-openssl. My provider
> implmentation is already 600 lines of code since you need a lot of
> boiler plate code. But the whole documentation of provider API is not as
> great as it could be. You get documentation of all the function but you
> to figure yourself how all that fits together.
>

OpenSSL has always been like that isn't it -- one could never
write anything based on docs alone.  I have seen the tpm2 code. That, along
with the built-in provider implementations in OpenSSL, seems to fill
some of the gaps in documentation. There were also some discussions and
questions in OpenSSL repo (issues) when the tpm2 guys were developing it.
But I haven't seen any code that deals with non-default providers in the
SSL context, especially when one wants to mix providers (default for most
things + custom for keymgmt & signature only).

I hope to have something ready at the end of the month.
>

For a working patch I'll also take a similar amount of time. Depending on
how it goes,  I'll wait, or post my feature branch for discussion. I'm
totally open, and we do not have to go with my approach even if I come up
with something. In any case, some discussion may be useful/required to make
the basic framework re-usable for all "external key" situations.

Cheers,

Selva

--000000000000a1936d05cc0ad9e0
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi Arne,</div><br><div class=3D"gmail_quo=
te"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Sep 15, 2021 at 11:03 AM =
Arne Schwabe &lt;<a href=3D"mailto:arne@...1227..." target=3D"_blank">arne@=
...1227...</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">Am 15.09.21 um 16:36 schrieb Selva Nair:<br>
&gt; Hi,<br>
&gt; =C2=A0<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Plaisthos is preparing patches that drop support fo=
r the APIs that are<br>
&gt;=C2=A0 =C2=A0 =C2=A0deprecated in OpenSSL 3.0.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Agreed that the OpenSSL 3.0 patches should be maste=
r only, so only 2.6<br>
&gt;=C2=A0 =C2=A0 =C2=A0will have full OpenSSL 3.0 support with external ke=
y support and<br>
&gt;=C2=A0 =C2=A0 =C2=A0without<br>
&gt;=C2=A0 =C2=A0 =C2=A0compiler warnings.=C2=A0<br>
&gt; <br>
&gt; =C2=A0<br>
&gt; Good to see some discussion on OpenSSL 3.0 support. I&#39;m working on=
<br>
&gt; converting &quot;cryptoapicert&quot; to use a custom built-in provider=
. In fact,<br>
&gt; the provider framework could be common for all external keys<br>
&gt; (cryptoapicert, management-external-key and pkcs11) with only the key<=
br>
&gt; loading and signing ops redirected to respective backends.=C2=A0<br>
<br>
Depending on far you have come, you might be ahead of me. I didn&#39;t know=
<br>
that you are already working on that.<br></blockquote><div><br></div><div>I=
 started looking into the new provider interface only recently, and cryptoa=
picert re-write only a week ago. It took a while to get a hang of the provi=
der framework.=C2=A0</div><div><br></div><div>Given that I do this during o=
ff-hours, I may take a week or two to have something worth sharing.</div><d=
iv>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0p=
x 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
&gt; If Arne is adding a provider implementation for this, maybe I<br>
&gt; should=C2=A0hold off?<br>
<br>
I am currently trying to get together a &quot;small&quot; provider by adapt=
ing<br>
code from <a href=3D"https://github.com/tpm2-software/tpm2-openssl" rel=3D"=
noreferrer" target=3D"_blank">https://github.com/tpm2-software/tpm2-openssl=
</a>. My provider<br>
implmentation is already 600 lines of code since you need a lot of<br>
boiler plate code. But the whole documentation of provider API is not as<br>
great as it could be. You get documentation of all the function but you<br>
to figure yourself how all that fits together.<br></blockquote><div><br></d=
iv><div>OpenSSL has always been like that isn&#39;t it -- one could never w=
rite=C2=A0anything based on docs alone.=C2=A0 I have seen the tpm2 code. Th=
at, along with the built-in provider implementations in OpenSSL, seems to f=
ill some=C2=A0of the gaps in documentation. There were also some discussion=
s and questions in OpenSSL repo (issues) when the tpm2 guys were developing=
 it. But I haven&#39;t seen any code that deals with non-default providers =
in the SSL context, especially when one=C2=A0wants to mix providers (defaul=
t for most things=C2=A0+ custom for keymgmt &amp; signature only).</div><di=
v><br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">I hope to hav=
e something ready at the end of the month.<br></blockquote><div><br></div><=
div>For a working patch I&#39;ll also take a similar amount of time. Depend=
ing on how it goes,=C2=A0=C2=A0I&#39;ll wait, or post my feature branch for=
 discussion. I&#39;m totally open, and we do not have to go with my approac=
h even if I come up with=C2=A0something. In any case, some discussion may b=
e useful/required to make the basic framework re-usable for all &quot;exter=
nal key&quot; situations.</div><div><br></div><div>Cheers,</div><div><br></=
div><div>Selva</div></div></div>

--000000000000a1936d05cc0ad9e0--

