MIME-Version: 1.0
References: <20210922211254.7570-1-selva.nair@...277...>
 <ed918ec7-2301-0e66-4bbe-f9141c97b406@...1227...>
 <CAKuzo_iC46yGz+hjyZvmxyh=PeNw_UPMMyxKEXm6Yxb0dSao5w@...278...>
 <10f4cf44-bd1d-7ff2-2bb4-69e94d796576@...1227...>
In-Reply-To: <10f4cf44-bd1d-7ff2-2bb4-69e94d796576@...1227...>
From: Selva Nair <selva.nair@...277...>
Date: Thu, 23 Sep 2021 11:40:47 -0400
Message-ID: <CAKuzo_hSeay-jodbrpSTSB6jMR5kQ4g-QGHT-t4uV9opfy3kDA@...278...>
Content-Type: multipart/alternative; boundary="000000000000a23fd305ccab7fd5"
Subject: Re: [Openvpn-devel] [PATCH 0/9] A built-in OpenSSL3.0 provider for
 external-keys
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

--000000000000a23fd305ccab7fd5
Content-Type: text/plain; charset="UTF-8"

Hi

On Thu, Sep 23, 2021 at 11:27 AM Arne Schwabe <arne@...1227...> wrote:

> Am 23.09.21 um 16:02 schrieb Selva Nair:
> >
> > Hi Arne,
> >
> >
> >     So I have two options here:
> >
> >     a) I finish my own implementation of the provider for OpenVPN3 to
> not be
> >     influenced by this implementation and review this implementation
> >     after that
> >
> >     b) you agree that I can take parts of your code for the OpenVPN3
> >     implementation, then I go directly into review and then base my
> OpenVPN3
> >     implementation on your xkey provider implementation.
> >
> >
> > (b) is fine with me and preferred. I do not want to release it under
> > BSD, but can agree to  a CLA. I wrote it consulting OpenSSL sources
> > (though no copy paste) which is not GPL2, so not even sure what license
> > is most appropriate. But BSD isi not my thing.
>
> I think a statement from you that you agree to
> https://github.com/OpenVPN/openvpn3/blob/master/CLA.rst
> for this patchset would be good and I think also enough.


Okay, I will send you an email agreeing to that.

I'll also change the license header from "version 2" to
"either version 2 of the License, or (at your option) any later version."
following the FSF's wording for allowing any later version of GPL.

Selva


> Arne
>

--000000000000a23fd305ccab7fd5
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div>Hi</div><br><div class=3D"gmail_quot=
e"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Sep 23, 2021 at 11:27 AM A=
rne Schwabe &lt;<a href=3D"mailto:arne@...1227..." target=3D"_blank">arne@...220...=
..1227...</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">Am 23.09.21 um 16:02 schrieb Selva Nair:<br>
&gt; <br>
&gt; Hi Arne,<br>
&gt; <br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0So I have two options here:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0a) I finish my own implementation of the provider f=
or OpenVPN3 to not be<br>
&gt;=C2=A0 =C2=A0 =C2=A0influenced by this implementation and review this i=
mplementation<br>
&gt;=C2=A0 =C2=A0 =C2=A0after that<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0b) you agree that I can take parts of your code for=
 the OpenVPN3<br>
&gt;=C2=A0 =C2=A0 =C2=A0implementation, then I go directly into review and =
then base my OpenVPN3<br>
&gt;=C2=A0 =C2=A0 =C2=A0implementation on your xkey provider implementation=
.<br>
&gt; <br>
&gt; <br>
&gt; (b) is fine with me and preferred. I do not want to release it under<b=
r>
&gt; BSD, but can agree to=C2=A0 a CLA. I wrote=C2=A0it consulting OpenSSL =
sources<br>
&gt; (though no copy paste) which is not GPL2, so not even sure what licens=
e<br>
&gt; is most appropriate. But BSD isi not my thing. <br>
<br>
I think a statement from you that you agree to<br>
<a href=3D"https://github.com/OpenVPN/openvpn3/blob/master/CLA.rst" rel=3D"=
noreferrer" target=3D"_blank">https://github.com/OpenVPN/openvpn3/blob/mast=
er/CLA.rst</a><br>
for this patchset would be good and I think also enough.</blockquote><div>=
=C2=A0</div><div>Okay, I will send you an email=C2=A0agreeing to that.</div=
><div><br></div><div>I&#39;ll also change the license header from &quot;ver=
sion 2&quot; to</div><div>&quot;either version 2 of the License, or (at you=
r option) any later version.&quot;<br></div><div>following the FSF&#39;s wo=
rding for allowing any later version of GPL.=C2=A0</div><div><br></div><div=
>Selva</div><div><br></div><blockquote class=3D"gmail_quote" style=3D"margi=
n:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex=
">
<br>
Arne<br>
</blockquote></div></div></div>

--000000000000a23fd305ccab7fd5--

