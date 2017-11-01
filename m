MIME-Version: 1.0
In-Reply-To: <e939db91-a2a2-5b8f-7f35-88a4868e0b9d@...1856...>
References: <1509192147.3021.6.camel@...2316...>
 <20171029152418.GF958@...1296...>
 <1509293083.3116.22.camel@...2316...>
 <CAKuzo_guDg74RXr1OssXSXLQk=xFoCFwjDkvSgkEvtGcVQR_DQ@...278...>
 <e939db91-a2a2-5b8f-7f35-88a4868e0b9d@...1856...>
From: Selva <selva.nair@...277...>
Date: Wed, 1 Nov 2017 14:53:01 -0400
Message-ID: <CAKuzo_h5H3RvDiap-F73EP1-QP9Ojoc0VvocrJgnKhFfjMWGnA@...278...>
Content-Type: multipart/alternative; boundary="94eb2c048b6ebc6480055cf06248"
Subject: Re: [Openvpn-devel] [PATCH 0/1] add engine keys keys
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan@...1856...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--94eb2c048b6ebc6480055cf06248
Content-Type: text/plain; charset="UTF-8"

Hi,

On Wed, Nov 1, 2017 at 2:18 PM, Steffan Karger <steffan@...1856...> wrote:

> Hi,
>
> On 29-10-17 22:03, Selva wrote:
> > I would like to see new features transparently supported on Windows
> > as well without the need for too much extra code and associated
> > maintenance burden. Our 'cryptoapicert' implementation is already in
> > need of a major re-write to support TLS 1.2 and newer.
>
> Fully agree.  Since cryptoapicert is windows-specific, I actually think
> it would be better to add a 'CNG'[0] implementation to the windows
> wrapper, and make that use management-external-key.  That would probably
> improve UX a lot too, showing users a drop-down to select a key, etc.
> We can then remove the whole deprecated cryptoapi implementation from
> the openvpn core.
>
> > From that point of view, instead of file-based wrapped keys, if a pkcs11
> > compatible API can be used to access TPM (that's possible isn't it?) TPM
> > could be more widely usable without the need of any additional support
> > in openssl or openvpn.
>
> Since this one is transparent, and works as long as the user loads the
> right engine, I don't see any limitations to include this patch.
>

Agreed this is a simple patch that could be used right away. Let's address
'Cryptography Next Gen'  (CNG) and general use of management-external-key
as a separate topic.

I too feel the management interface client and/or plugins is a better place
to add support for platform specific cert/key storage etc., instead of
polluting
openvpn core.

Simon was planning to add support for TLS 1.2+ in eduVPN for keys
stored in Windows certstore -- I suppose that would involve CNG.

Selva

--94eb2c048b6ebc6480055cf06248
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<br><div class=3D"gmail_extra"><br><div class=3D"gmail_=
quote">On Wed, Nov 1, 2017 at 2:18 PM, Steffan Karger <span dir=3D"ltr">&lt=
;<a href=3D"mailto:steffan@...1856..." target=3D"_blank">steffan@...1856...=
</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin=
:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">Hi,<br>
<span class=3D""><br>
On 29-10-17 22:03, Selva wrote:<br>
&gt; I would like to see new features transparently supported on Windows<br>
&gt; as well without the need for too much extra code and associated<br>
&gt; maintenance burden. Our &#39;cryptoapicert&#39; implementation is alre=
ady in<br>
&gt; need of a major re-write to support TLS 1.2 and newer.<br>
<br>
</span>Fully agree.=C2=A0 Since cryptoapicert is windows-specific, I actual=
ly think<br>
it would be better to add a &#39;CNG&#39;[0] implementation to the windows<=
br>
wrapper, and make that use management-external-key.=C2=A0 That would probab=
ly<br>
improve UX a lot too, showing users a drop-down to select a key, etc.<br>
We can then remove the whole deprecated cryptoapi implementation from<br>
the openvpn core.<br>
<span class=3D""><br>
&gt; From that point of view, instead of file-based wrapped keys, if a pkcs=
11<br>
&gt; compatible API can be used to access TPM (that&#39;s possible isn&#39;=
t it?) TPM<br>
&gt; could be more widely usable without the need of any additional support=
<br>
&gt; in openssl or openvpn.<br>
<br>
</span>Since this one is transparent, and works as long as the user loads t=
he<br>
right engine, I don&#39;t see any limitations to include this patch.<br></b=
lockquote><div><br></div><div>Agreed this is a simple patch that could be u=
sed right away. Let&#39;s address=C2=A0</div><div>&#39;Cryptography Next Ge=
n&#39; =C2=A0(CNG) and general use of management-external-key</div><div>as =
a separate topic.</div><div><br></div><div>I too feel the management interf=
ace client and/or plugins is a better place</div><div>to add support for pl=
atform specific cert/key storage etc., instead of polluting</div><div>openv=
pn core.</div><div><br></div><div>Simon was planning to add support for TLS=
 1.2+ in eduVPN for keys</div><div>stored in Windows certstore -- I suppose=
 that would involve CNG.</div><div><br></div><div>Selva</div></div></div></=
div>

--94eb2c048b6ebc6480055cf06248--

