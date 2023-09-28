MIME-Version: 1.0
References: <f80646d4-0fc3-4e5a-bc05-22b929452d00@...1800...>
In-Reply-To: <f80646d4-0fc3-4e5a-bc05-22b929452d00@...1800...>
From: Selva Nair <selva.nair@...277...>
Date: Thu, 28 Sep 2023 18:50:09 -0400
Message-ID: <CAKuzo_hqwfqgSb57fwCEx6C+HBVawt-ECZuNkacVBb4y-CYwcw@...278...>
Content-Type: multipart/alternative; boundary="00000000000040318506067322d1"
Subject: Re: [Openvpn-devel] pkcs11 config changes from 2.5.4 to 2.6.6 ?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: mike tancsa <mike@...1800...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--00000000000040318506067322d1
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Mike,

On Thu, Sep 28, 2023 at 5:28=E2=80=AFPM mike tancsa <mike@...1800...> wrote:

> I am starting to test out 2.6.6 with a config that worked in 2.5.4 but
> am getting a failure con connect.  I did have a look through the
> Changes.rst file but didnt see anything different ? The only pkcs11 bits
> I have in the config are
>
> pkcs11-providers eTpkcs11.dll
> pkcs11-id 'pkcs11:model=3DeToken;token=3D....'
>
> and the same config works with the older version. Are there new
> directives I need to add ?  This is an Gemalto/Thales etoken. Again, it
> works fine in this environment with the only change being the version of
> OpenVPN.
>

The main change is upgrade to OpenSSL 3.x which seems
not to like the certificate or key. Normally it should just work with no
changes
to the config.


>
> 2023-09-28 17:05:12 us=3D578000 PKCS#11: Failed to set cert and private
> key for OpenSSL
>

This implies the call to OpenSSL's "SSL_CTX_set_cert_and_key()" failed.
The certificate and private key handle from the token are acquired before
this
and set in  xkey-provider --- both of those tasks have completed without
errors.
Very unusual and rare to error out at this point.

Unfortunately we do not log the reason for this failure. Instead
we clear OpenSSL's error queue and print a generic error saying private
key password verification failed. A retry is triggered if "auth-retry" is
set to "interact",
else we exit as happened in your case.


> 2023-09-28 17:05:12 us=3D578000 Error: private key password verification
> failed
>

Not a very useful error message.

My guess is that something in the certificate or private key is not to
OpenSSL 3.1's liking and it rejects it. Is there any way for you to check
the
contents of the token independently using a tool linked against OpenSSL 3.1
?

Selva

--00000000000040318506067322d1
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi Mike,</div><div><br></div><div class=3D"gmail_quot=
e"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Sep 28, 2023 at 5:28=E2=80=
=AFPM mike tancsa &lt;<a href=3D"mailto:mike@...1800...">mike@...1800...</a=
>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px=
 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">I a=
m starting to test out 2.6.6 with a config that worked in 2.5.4 but <br>
am getting a failure con connect.=C2=A0 I did have a look through the <br>
Changes.rst file but didnt see anything different ? The only pkcs11 bits <b=
r>
I have in the config are<br>
<br>
pkcs11-providers eTpkcs11.dll<br>
pkcs11-id &#39;pkcs11:model=3DeToken;token=3D....&#39;<br>
<br>
and the same config works with the older version. Are there new <br>
directives I need to add ?=C2=A0 This is an Gemalto/Thales etoken. Again, i=
t <br>
works fine in this environment with the only change being the version of <b=
r>
OpenVPN.<br></blockquote><div><br></div><div>The main change is upgrade to =
OpenSSL 3.x which seems</div><div>not to like the certificate or key. Norma=
lly it should just work with no changes</div><div>to the config.</div><div>=
=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><br>
2023-09-28 17:05:12 us=3D578000 PKCS#11: Failed to set cert and private <br>
key for OpenSSL<br></blockquote><div><br></div><div>This implies the call t=
o OpenSSL&#39;s &quot;SSL_CTX_set_cert_and_key()&quot; failed.</div><div>Th=
e certificate and private key handle from the token are acquired before thi=
s</div><div>and set in=C2=A0 xkey-provider --- both of those tasks have com=
pleted without errors.</div><div>Very unusual and rare to error out at this=
 point.</div><div><br></div><div>Unfortunately we do not log the reason for=
 this failure. Instead</div><div>we clear OpenSSL&#39;s error queue and pri=
nt a generic error saying private=C2=A0</div><div>key password verification=
 failed. A retry is triggered if &quot;auth-retry&quot; is set to &quot;int=
eract&quot;,</div><div>else we exit as happened in your case.</div><div>=C2=
=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8e=
x;border-left:1px solid rgb(204,204,204);padding-left:1ex">
2023-09-28 17:05:12 us=3D578000 Error: private key password verification <b=
r>
failed<br></blockquote><div><br></div><div>Not a very useful error message.=
</div><div><br></div><div>My guess is that something in the certificate or =
private key is not to</div><div>OpenSSL 3.1&#39;s liking and it rejects it.=
 Is there any way for you to check the</div><div>contents of the token inde=
pendently using a tool linked against OpenSSL 3.1 ?</div><div><br></div><di=
v>Selva</div></div></div>

--00000000000040318506067322d1--

