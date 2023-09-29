MIME-Version: 1.0
References: <f80646d4-0fc3-4e5a-bc05-22b929452d00@...1800...>
 <CAKuzo_hqwfqgSb57fwCEx6C+HBVawt-ECZuNkacVBb4y-CYwcw@...278...>
 <850037b2-36d0-4240-8c73-04dab1a90777@...1800...>
 <68a68aa4-0c57-655c-e0c9-ff9f1e0bf040@...1227...>
 <CAKuzo_iUEcp0Au0vHTfr4fwozDccxgRXCmV+C2eWc=W4ciTxog@...278...>
 <cbde8749-f884-234b-18f9-6c86cbc065ac@...1227...>
In-Reply-To: <cbde8749-f884-234b-18f9-6c86cbc065ac@...1227...>
From: Selva Nair <selva.nair@...277...>
Date: Fri, 29 Sep 2023 10:36:47 -0400
Message-ID: <CAKuzo_i+5NVMPVKKzHdvvvkPPHpccMvgzpLvJ-UmxDTmmgojBA@...278...>
Content-Type: multipart/alternative; boundary="000000000000a53e3f0606805b9c"
Subject: Re: [Openvpn-devel] pkcs11 config changes from 2.5.4 to 2.6.6 ?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: mike tancsa <mike@...1800...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--000000000000a53e3f0606805b9c
Content-Type: text/plain; charset="UTF-8"

>
>
>
> > Good point. But, unless the config has "tls-cert-profile foo", we still
> > default to legacy and call SSL_CTX_set_security_level(ctx, 1), isn't it?
> > Wouldn't that allow SHA1 with 3.1.x ?
>
> For SHA1 you need security 0 aka tls-cert-profile insecure.
>
> But we might update OpenVPN to longer fiddle with the default security
> level in OpenSSL 3+ to avoid downgrading security from 2 to 1 on OpenSSL
> 3.1
>

Even OpenSSL 3.0 is built with -DOPENSSL_TLS_SECURITY_LEVEL=2
in Debian and Ubuntu packages (and likely other distributions). Looks like
a good idea to stop
overriding it by default.

We could also improve logging when SSL_CTX_set_certificate and similar fail
by printing OpenSSL error queue.

Selva

--000000000000a53e3f0606805b9c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_quote"><blockquote class=3D"gmail_quot=
e" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204)=
;padding-left:1ex"><br><br>
&gt; Good point. But, unless the config has &quot;tls-cert-profile foo&quot=
;, we still <br>
&gt; default to legacy and call SSL_CTX_set_security_level(ctx, 1), isn&#39=
;t it? <br>
&gt; Wouldn&#39;t that allow SHA1 with 3.1.x ?<br>
<br>
For SHA1 you need security 0 aka tls-cert-profile insecure.<br>
<br>
But we might update OpenVPN to longer fiddle with the default security <br>
level in OpenSSL 3+ to avoid downgrading security from 2 to 1 on OpenSSL 3.=
1<br></blockquote><div><br></div><div>Even OpenSSL 3.0 is built with=C2=A0-=
DOPENSSL_TLS_SECURITY_LEVEL=3D2<br></div><div>in Debian and Ubuntu packages=
 (and likely other distributions). Looks like a good idea to stop</div><div=
>overriding it by default.</div><div><br></div><div>We could also improve l=
ogging when SSL_CTX_set_certificate and similar fail by printing OpenSSL er=
ror queue.<br></div><div><br></div><div>Selva</div></div></div>

--000000000000a53e3f0606805b9c--

