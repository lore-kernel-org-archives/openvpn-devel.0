MIME-Version: 1.0
References: <1544210258-8754-2-git-send-email-selva.nair@...277...>
 <1548265738-11004-1-git-send-email-selva.nair@...277...>
 <7fb244f4-674a-ce0d-ed3f-8601d75df5e5@...1227...>
In-Reply-To: <7fb244f4-674a-ce0d-ed3f-8601d75df5e5@...1227...>
From: Selva Nair <selva.nair@...277...>
Date: Wed, 30 Jan 2019 10:47:48 -0500
Message-ID: <CAKuzo_h7LL_9Os45a9-czzucqMkPBAeBc1WN2f1ubj3691Js0Q@...278...>
Content-Type: multipart/alternative; boundary="000000000000f764030580aed527"
Subject: Re: [Openvpn-devel] [PATCH 2/2 v2] Handle PSS padding in
 cryptoapicert
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--000000000000f764030580aed527
Content-Type: text/plain; charset="UTF-8"

On Wed, Jan 30, 2019 at 8:09 AM Arne Schwabe <arne@...1227...> wrote:

> Am 23.01.19 um 18:48 schrieb selva.nair@...277...:
> > From: Selva Nair <selva.nair@...277...>
> >
> > For PSS padding, CNG requires the digest to be signed
> > and the digest algorithm in use, which are not accessible
> > via the rsa_sign and rsa_priv_enc callbacks of OpenSSL.
> > This patch uses the EVP_KEY interface to hook to
> > evp_pkey_sign callback if OpenSSL version is > 1.1.0.
> >
> > To test this code path, both the server and client should
> > be built with OpenSSL 1.1.1 and use TLS version >= 1.2
> >
> > Tested on Windows 7 client against a Linux server.
> >
>
> Normally, I not always expect patches to always cleanly apply but in
> this case I cannot get git to apply this thing.
>
> git am <~/dl/Openvpn-devel-2-2-v2-Handle-PSS-padding-in-cryptoapicert.patch
> Applying: Handle PSS padding in cryptoapicert
> error: patch failed: src/openvpn/cryptoapi.c:320
> error: src/openvpn/cryptoapi.c: patch does not apply
> Patch failed at 0001 Handle PSS padding in cryptoapicert
> hint: Use 'git am --show-current-patch' to see the failed patch
> When you have resolved this problem, run "git am --continue".
> If you prefer to skip this patch, run "git am --skip" instead.
> To restore the original branch and stop patching, run "git am --abort".
>
>
> git am --3way
> Applying: Handle PSS padding in cryptoapicert
> error: sha1 information is lacking or useless (src/openvpn/cryptoapi.c).
> error: could not build fake ancestor
> Patch failed at 0001 Handle PSS padding in cryptoapicert
> hint: Use 'git am --show-current-patch' to see the failed patch
> When you have resolved this problem, run "git am --continue".
> If you prefer to skip this patch, run "git am --skip" instead.
> To restore the original branch and stop patching, run "git am --abort".
>
>
> Since Gert/David will also face the same problems later it might be
> easier to resend this patch in a form that applies to master without
> manually resolving conflicts.
>
>
It seems I had second guessed uncrustify in a context --- a space before
"?" added by uncrustify and a space in "(BYTE *) from" which is a sin in
our books, but uncrustify doesn't care.
I would have though "git am --ignore-whitespace" would have worked around
that, but it doesn't when the mismatch is in the context?

What happens twice happens thrice -- v3 is in the mail..

Selva

--000000000000f764030580aed527
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Wed, Jan 30, 2019 at 8:09 AM Arne =
Schwabe &lt;<a href=3D"mailto:arne@...1227..." target=3D"_blank">arne@...1711...=
27...</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"ma=
rgin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:=
1ex">Am 23.01.19 um 18:48 schrieb <a href=3D"mailto:selva.nair@...277..." t=
arget=3D"_blank">selva.nair@...277...</a>:<br>
&gt; From: Selva Nair &lt;<a href=3D"mailto:selva.nair@...277..." target=3D=
"_blank">selva.nair@...277...</a>&gt;<br>
&gt; <br>
&gt; For PSS padding, CNG requires the digest to be signed<br>
&gt; and the digest algorithm in use, which are not accessible<br>
&gt; via the rsa_sign and rsa_priv_enc callbacks of OpenSSL.<br>
&gt; This patch uses the EVP_KEY interface to hook to<br>
&gt; evp_pkey_sign callback if OpenSSL version is &gt; 1.1.0.<br>
&gt; <br>
&gt; To test this code path, both the server and client should<br>
&gt; be built with OpenSSL 1.1.1 and use TLS version &gt;=3D 1.2<br>
&gt; <br>
&gt; Tested on Windows 7 client against a Linux server.<br>
&gt; <br>
<br>
Normally, I not always expect patches to always cleanly apply but in<br>
this case I cannot get git to apply this thing.<br>
<br>
git am &lt;~/dl/Openvpn-devel-2-2-v2-Handle-PSS-padding-in-cryptoapicert.pa=
tch<br>
Applying: Handle PSS padding in cryptoapicert<br>
error: patch failed: src/openvpn/cryptoapi.c:320<br>
error: src/openvpn/cryptoapi.c: patch does not apply<br>
Patch failed at 0001 Handle PSS padding in cryptoapicert<br>
hint: Use &#39;git am --show-current-patch&#39; to see the failed patch<br>
When you have resolved this problem, run &quot;git am --continue&quot;.<br>
If you prefer to skip this patch, run &quot;git am --skip&quot; instead.<br>
To restore the original branch and stop patching, run &quot;git am --abort&=
quot;.<br>
<br>
<br>
git am --3way<br>
Applying: Handle PSS padding in cryptoapicert<br>
error: sha1 information is lacking or useless (src/openvpn/cryptoapi.c).<br>
error: could not build fake ancestor<br>
Patch failed at 0001 Handle PSS padding in cryptoapicert<br>
hint: Use &#39;git am --show-current-patch&#39; to see the failed patch<br>
When you have resolved this problem, run &quot;git am --continue&quot;.<br>
If you prefer to skip this patch, run &quot;git am --skip&quot; instead.<br>
To restore the original branch and stop patching, run &quot;git am --abort&=
quot;.<br>
<br>
<br>
Since Gert/David will also face the same problems later it might be<br>
easier to resend this patch in a form that applies to master without<br>
manually resolving conflicts.<br>
<br></blockquote><div><br></div><div>It seems I had second guessed uncrusti=
fy in a context --- a space before &quot;?&quot; added by uncrustify and a =
space in &quot;(BYTE *) from&quot; which is a sin in our books, but uncrust=
ify doesn&#39;t care.<br></div><div>I would have though &quot;git am --igno=
re-whitespace&quot; would have worked around that, but it doesn&#39;t when =
the mismatch is in the context?<br></div><div><br></div><div>What happens t=
wice happens thrice -- v3 is in the mail..<br></div><div>=C2=A0<br></div><d=
iv>Selva</div></div></div>

--000000000000f764030580aed527--

