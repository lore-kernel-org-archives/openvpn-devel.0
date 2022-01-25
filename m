MIME-Version: 1.0
References: <20210510013239.18087-1-selva.nair@...277...>
 <20210815222558.22502-1-selva.nair@...277...>
In-Reply-To: <20210815222558.22502-1-selva.nair@...277...>
From: Selva Nair <selva.nair@...277...>
Date: Tue, 25 Jan 2022 12:02:44 -0500
Message-ID: <CAKuzo_jVEFRzXUAM5FXkXJMauBE50Fx+=LMpVusN87bpopg3rQ@...278...>
Content-Type: multipart/alternative; boundary="000000000000c0e38a05d66b0ee4"
Subject: Re: [Openvpn-devel] [PATCH v3] Allow PKCS#11 uri to be used as
 --cert and --key file names
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--000000000000c0e38a05d66b0ee4
Content-Type: text/plain; charset="UTF-8"

On Sun, Aug 15, 2021 at 6:26 PM <selva.nair@...277...> wrote:

> From: Selva Nair <selva.nair@...277...>
>
> v2 changes
>   - do not allow so-path embedded in cert and key uri
>   - add --pkcs11-engine option to optionally specify the
>         engine and provider module to use
> v3: rebase to master
>
> If either --cert or --key is specified as a PKCS#11 uri, try to
> load the certificate and key from any accessible PKCS#11 device.
> This does not require linking with any pkcs11 library, but needs
> pkcs11 engine to be available on the target machine.
>
> In its simplest form, just have
>
> --cert 'pkcs11:id=%01'
>

I'm withdrawing this patch as it has no prospects going forward with
engines on their way out in
OpenSSL 3.0 and beyond. Withdrawing is also an honourable way out when no
one seems to care :)

That said, in the spirit of this patch, I think we should consider reusing
"--cert" and, optionally, "--key" options when newer ways of specifying the
certificate are introduced: like "--cert <uri>" instead of a new option
"--cryptoapi-cert <foo>" etc.

Selva

--000000000000c0e38a05d66b0ee4
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><div class=3D"gmail_quote"><div=
 dir=3D"ltr" class=3D"gmail_attr">On Sun, Aug 15, 2021 at 6:26 PM &lt;<a hr=
ef=3D"mailto:selva.nair@...277..." target=3D"_blank">selva.nair@...277...</=
a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0p=
x 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Fr=
om: Selva Nair &lt;<a href=3D"mailto:selva.nair@...277..." target=3D"_blank=
">selva.nair@...277...</a>&gt;<br>
<br>
v2 changes<br>
=C2=A0 - do not allow so-path embedded in cert and key uri<br>
=C2=A0 - add --pkcs11-engine option to optionally specify the<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 engine and provider module to use<br>
v3: rebase to master<br>
<br>
If either --cert or --key is specified as a PKCS#11 uri, try to<br>
load the certificate and key from any accessible PKCS#11 device.<br>
This does not require linking with any pkcs11 library, but needs<br>
pkcs11 engine to be available on the target machine.<br>
<br>
In its simplest form, just have<br>
<br>
--cert &#39;pkcs11:id=3D%01&#39;<br></blockquote><div><br></div><div>I&#39;=
m withdrawing this patch as it has no prospects going forward with engines =
on their way out in=C2=A0</div><div>OpenSSL 3.0 and beyond. Withdrawing=C2=
=A0is also an honourable way out when no one seems to care :)</div><div><br=
></div><div>That said, in the spirit of this patch, I think we should consi=
der reusing &quot;--cert&quot; and, optionally, &quot;--key&quot; options w=
hen newer ways of specifying the certificate are introduced: like &quot;--c=
ert &lt;uri&gt;&quot; instead of a new option &quot;--cryptoapi-cert &lt;fo=
o&gt;&quot; etc.</div><div><br></div><div>Selva</div></div></div>

--000000000000c0e38a05d66b0ee4--

