MIME-Version: 1.0
In-Reply-To: <CAKh=nwGDv2fKJ6STqYthwpH+1SkztkLj1=KH4MWJ58ifc_byog@...278...>
References: <CAKh=nwFOSOCugW1JWYfiQFZLTKRBc6qoi=U9ewzjOSpaGP1-Kg@...278...>
 <6a6ede658da2e35b718a9ccb733b132a955ffefe.1515792908.git.logout@...260...>
 <183bd138-e733-042e-9cc3-c66bbf6ea9bd@...1856...>
 <CAKh=nwEeSBgkbz5-_R_eU7rK9fYpDQ=1jsY+02+vMxRJ8=wZxg@...278...>
 <CAKuzo_j6Uuw8minumYHECmqtE9ocvrzGtO0_3FUcGnNy4q3Bqw@...278...>
 <CAKh=nwGDv2fKJ6STqYthwpH+1SkztkLj1=KH4MWJ58ifc_byog@...278...>
From: Selva Nair <selva.nair@...277...>
Date: Mon, 15 Jan 2018 21:08:15 -0500
Message-ID: <CAKuzo_h5_3Q=PArCX3vuzGyo6UcxTMxf95b=s2=hOaSHnNWQZg@...278...>
Content-Type: multipart/alternative; boundary="001a1135a3ae59ed3d0562db3536"
Subject: Re: [Openvpn-devel] [PATCH v2 2/3] OpenSSL: remove some EVP_PKEY
 type checks
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Emmanuel Deloget <logout@...260...>
Cc: Steffan Karger <steffan@...1856...>, openvpn-devel@lists.sourceforge.net

--001a1135a3ae59ed3d0562db3536
Content-Type: text/plain; charset="UTF-8"

Hi,

On Mon, Jan 15, 2018 at 7:56 PM, Emmanuel Deloget <logout@...260...> wrote:

> Hello Selva,
>
> On Tue, Jan 16, 2018 at 12:10 AM, Selva Nair <selva.nair@...277...> wrote:
>
>>
>>
>> Can I try one last time to convince you guys to keep EVP_PKEY_id()? If I
>> was targeting only 1.1.0+ that's how most of those checks would have been
>> done, isn't? Makes life easier, code simpler as I have said before..
>>
>> Just throwing in my 0.02c, feel free to ignore.
>>
>> Best,
>>
>> Selva
>>
>
>
> OpenSSL 1.1.0+ and previous versions allows you to create a typed EVP_PKEY
> without any key inside. For example, you can do
>
>   EVP_PKEY *pkey = EVP_PKEY_new();
>   EVP_PKEY_set_type(pkey, EVP_PKEY_RSA);
>
> This is plainly valid: the key is prepared for later use.
>
> So testing for EVP_PKEY_id() is not sufficient to make sure that current
> and future code won't mess with us.
>

That was not my intent.

Use EVP_KEY_id() to determine the type and choose the code path. Then when
ready, get the key pointer and check it. Of course there may be situations
where its possible to get the pointer and check it in one line as in your
case (3) below.

Anyway, calling EVP_PKEY_get0_RSA() multiple times is lame. Now think of
cases where we may have to delegate the job to separate functions depending
on the key type. To me it looks natural to do that using a
switch(EVP_PKEY_id()) or if-else blocks to decide which function to call
and then get the key and check it inside the function. Anyway, I will leave
it at that.


> To be extra sure, one can do
>
> if (EVP_PKEY_id() == EVP_PKEY_RSA && EVP_PKEY_get0_RSA(pkey)) { ... }
>

> Which is exactly what the current code does. Yet the idea (at least mine)
> is to remove that to simplify code a bit.
>
> Now, I agree, this is quite easy to read and to understand.
>
> We have 3 solutions:
>
> 1) keep the code as is
>
> if (EVP_PKEY_id() == EVP_PKEY_RSA && EVP_PKEY_get0_RSA(pkey) != NULL) {
> ... }
>

In this case the call to EVP_PKEY_id() is redundant, isn't it? Or am I
missing something? If the latter returns non-null then its indeed an RSA
key (I'm assuming the 1.1.0 or the corrected compat layer behaviour here).


>
>
> 2) remove EVP_PKEY_id() but keep a test on EVP_PKEY_getO_RSA()
>
> if (EVP_PKEY_get0_RSA(pkey) != NULL) {
> RSA *rsa = EVP_PKEY_get0_RSA(pkey);
> ...
> }
>

This looks bad to me.


>
>
> 3) rework it as proposed in the patch
>
> RSA *rsa = NULL;
> if ((rsa = EVP_PKEY_get0_RSA(pkey)) != NULL) { ... }
>

In this particular case this may be the best approach but there are
situations where it may not be the natural choice. Hence the "if it were up
to me EVP_KEY_id() will stay" musing...:)

Thanks,

Selva

--001a1135a3ae59ed3d0562db3536
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<div><div class=3D"gmail_extra"><br><div class=3D"gmail=
_quote">On Mon, Jan 15, 2018 at 7:56 PM, Emmanuel Deloget <span dir=3D"ltr"=
>&lt;<a href=3D"mailto:logout@...260..." target=3D"_blank">logout@...260...=
</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin=
:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"=
><div dir=3D"ltr"><div style=3D"font-family:monospace,monospace">Hello Selv=
a,=C2=A0</div><div class=3D"gmail_extra"><br><div class=3D"gmail_quote"><di=
v><div class=3D"gmail-h5">On Tue, Jan 16, 2018 at 12:10 AM, Selva Nair <spa=
n dir=3D"ltr">&lt;<a href=3D"mailto:selva.nair@...277..." target=3D"_blank"=
>selva.nair@...277...</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_q=
uote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,2=
04);padding-left:1ex"><div dir=3D"ltr"><br><div class=3D"gmail_extra"><div =
class=3D"gmail_quote"><span class=3D"gmail-m_-9197147997010814971gmail-"><d=
iv><br></div></span><div>Can I try one last time to convince you guys to ke=
ep EVP_PKEY_id()? If I was targeting only 1.1.0+ that&#39;s how most of tho=
se checks would have been done, isn&#39;t? Makes life easier, code simpler =
as I have said before..</div><div><br></div><div>Just throwing in my 0.02c,=
 feel free to ignore.</div><div><br></div><div>Best,</div><div><br></div><d=
iv>Selva=C2=A0</div></div></div></div></blockquote><div><br></div></div></d=
iv><div><div style=3D"font-family:monospace,monospace"><br></div><div style=
=3D"font-family:monospace,monospace">OpenSSL 1.1.0+ and previous versions a=
llows you to create a typed EVP_PKEY without any key inside. For example, y=
ou can do<br></div></div><div style=3D"font-family:monospace,monospace"><br=
></div><div style=3D"font-family:monospace,monospace">=C2=A0 EVP_PKEY *pkey=
 =3D EVP_PKEY_new();</div><div style=3D"font-family:monospace,monospace">=
=C2=A0 EVP_PKEY_set_type(pkey,=C2=A0<span style=3D"color:rgb(36,41,46);font=
-family:SFMono-Regular,Consolas,&quot;Liberation Mono&quot;,Menlo,Courier,m=
onospace;font-size:12px;white-space:pre-wrap">EVP_<wbr>PKEY_RSA);</span></d=
iv><div style=3D"font-family:monospace,monospace"><span style=3D"color:rgb(=
36,41,46);font-family:SFMono-Regular,Consolas,&quot;Liberation Mono&quot;,M=
enlo,Courier,monospace;font-size:12px;white-space:pre-wrap"><br></span></di=
v><div style=3D"font-family:monospace,monospace"><span style=3D"color:rgb(3=
6,41,46);font-family:SFMono-Regular,Consolas,&quot;Liberation Mono&quot;,Me=
nlo,Courier,monospace;font-size:12px;white-space:pre-wrap">This is plainly =
valid: the key is prepared for later use. </span></div><div style=3D"font-f=
amily:monospace,monospace"><span style=3D"color:rgb(36,41,46);font-family:S=
FMono-Regular,Consolas,&quot;Liberation Mono&quot;,Menlo,Courier,monospace;=
font-size:12px;white-space:pre-wrap"><br></span></div><div style=3D"font-fa=
mily:monospace,monospace"><span style=3D"color:rgb(36,41,46);font-family:SF=
Mono-Regular,Consolas,&quot;Liberation Mono&quot;,Menlo,Courier,monospace;f=
ont-size:12px;white-space:pre-wrap">So testing for EVP_PKEY_id() is not suf=
ficient to make sure that current and future code won&#39;t mess with us. <=
/span></div></div></div></div></blockquote><div><br></div><div>That was not=
 my intent.</div><div><br></div><div>Use EVP_KEY_id() to determine the type=
 and choose the code path. Then when ready, get the key pointer and check i=
t. Of course there may be situations where its possible to get the pointer =
and check it in one line as in your case (3) below.=C2=A0</div><div><br></d=
iv><div>Anyway, calling EVP_PKEY_get0_RSA() multiple times is lame. Now thi=
nk of cases where we may have to delegate the job to separate functions dep=
ending on the key type. To me it looks natural to do that using a switch(EV=
P_PKEY_id()) or if-else blocks to decide which function to call and then ge=
t the key and check it inside the function. Anyway, I will leave it at that=
.</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0=
px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><=
div dir=3D"ltr"><div class=3D"gmail_extra"><div class=3D"gmail_quote"><div =
style=3D"font-family:monospace,monospace"><span style=3D"color:rgb(36,41,46=
);font-family:SFMono-Regular,Consolas,&quot;Liberation Mono&quot;,Menlo,Cou=
rier,monospace;font-size:12px;white-space:pre-wrap">To be extra sure, one c=
an do </span></div><div style=3D"font-family:monospace,monospace"><span sty=
le=3D"color:rgb(36,41,46);font-family:SFMono-Regular,Consolas,&quot;Liberat=
ion Mono&quot;,Menlo,Courier,monospace;font-size:12px;white-space:pre-wrap"=
><br></span></div><div style=3D"font-family:monospace,monospace"><span styl=
e=3D"color:rgb(36,41,46);font-family:SFMono-Regular,Consolas,&quot;Liberati=
on Mono&quot;,Menlo,Courier,monospace;font-size:12px;white-space:pre-wrap">=
  if (EVP_PKEY_id() =3D=3D EVP_PKEY_RSA &amp;&amp; EVP_PKEY_get0_RSA(pkey))=
 { ... }</span><span style=3D"font-family:arial,sans-serif">=C2=A0</span></=
div></div></div></div></blockquote><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex"><div dir=3D"ltr"><div class=3D"gmail_extra"><div class=3D"gmail_=
quote"><div style=3D"font-family:monospace,monospace"><span style=3D"color:=
rgb(36,41,46);font-family:SFMono-Regular,Consolas,&quot;Liberation Mono&quo=
t;,Menlo,Courier,monospace;font-size:12px;white-space:pre-wrap"><br></span>=
</div><div style=3D"font-family:monospace,monospace"><span style=3D"color:r=
gb(36,41,46);font-family:SFMono-Regular,Consolas,&quot;Liberation Mono&quot=
;,Menlo,Courier,monospace;font-size:12px;white-space:pre-wrap">Which is exa=
ctly what the current code does. Yet the idea (at least mine) is to remove =
that to simplify code a bit. </span></div><div style=3D"font-family:monospa=
ce,monospace"><span style=3D"color:rgb(36,41,46);font-family:SFMono-Regular=
,Consolas,&quot;Liberation Mono&quot;,Menlo,Courier,monospace;font-size:12p=
x;white-space:pre-wrap"><br></span></div><div><font color=3D"#24292e" face=
=3D"SFMono-Regular, Consolas, Liberation Mono, Menlo, Courier, monospace"><=
span style=3D"font-size:12px;white-space:pre-wrap">Now, I agree, this is qu=
ite easy to read and to understand. </span></font></div><div><font color=3D=
"#24292e" face=3D"SFMono-Regular, Consolas, Liberation Mono, Menlo, Courier=
, monospace"><span style=3D"font-size:12px;white-space:pre-wrap"><br></span=
></font></div><div><font color=3D"#24292e" face=3D"SFMono-Regular, Consolas=
, Liberation Mono, Menlo, Courier, monospace"><span style=3D"font-size:12px=
;white-space:pre-wrap">We have 3 solutions: </span></font></div><div><font =
color=3D"#24292e" face=3D"SFMono-Regular, Consolas, Liberation Mono, Menlo,=
 Courier, monospace"><span style=3D"font-size:12px;white-space:pre-wrap"><b=
r></span></font></div><div><font color=3D"#24292e" face=3D"SFMono-Regular, =
Consolas, Liberation Mono, Menlo, Courier, monospace"><span style=3D"font-s=
ize:12px;white-space:pre-wrap">1) keep the code as is</span></font></div><d=
iv><font color=3D"#24292e" face=3D"SFMono-Regular, Consolas, Liberation Mon=
o, Menlo, Courier, monospace"><span style=3D"font-size:12px;white-space:pre=
-wrap"><br></span></font></div><div><span style=3D"color:rgb(36,41,46);font=
-family:SFMono-Regular,Consolas,&quot;Liberation Mono&quot;,Menlo,Courier,m=
onospace;font-size:12px;white-space:pre-wrap">  if (EVP_PKEY_id() =3D=3D EV=
P_PKEY_RSA &amp;&amp; EVP_PKEY_get0_RSA(pkey) !=3D NULL) { ... }</span></di=
v></div></div></div></blockquote><div><br></div><div>In this case the call =
to EVP_PKEY_id() is redundant, isn&#39;t it? Or am I missing something? If =
the latter returns non-null then its indeed an RSA key (I&#39;m assuming th=
e 1.1.0 or the corrected compat layer behaviour here).</div><div>=C2=A0</di=
v><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;borde=
r-left:1px solid rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr"><div c=
lass=3D"gmail_extra"><div class=3D"gmail_quote"><div><font color=3D"#24292e=
" face=3D"SFMono-Regular, Consolas, Liberation Mono, Menlo, Courier, monosp=
ace"><span style=3D"font-size:12px;white-space:pre-wrap"><br></span></font>=
</div><div><font color=3D"#24292e" face=3D"SFMono-Regular, Consolas, Libera=
tion Mono, Menlo, Courier, monospace"><span style=3D"font-size:12px;white-s=
pace:pre-wrap"><br></span></font></div><div><font color=3D"#24292e" face=3D=
"SFMono-Regular, Consolas, Liberation Mono, Menlo, Courier, monospace"><spa=
n style=3D"font-size:12px;white-space:pre-wrap">2) remove EVP_PKEY_id() but=
 keep a test on EVP_PKEY_getO_RSA()</span></font></div><div><font color=3D"=
#24292e" face=3D"SFMono-Regular, Consolas, Liberation Mono, Menlo, Courier,=
 monospace"><span style=3D"font-size:12px;white-space:pre-wrap"><br></span>=
</font></div><div><span style=3D"color:rgb(36,41,46);font-family:SFMono-Reg=
ular,Consolas,&quot;Liberation Mono&quot;,Menlo,Courier,monospace;font-size=
:12px;white-space:pre-wrap">  if (EVP_PKEY_get0_RSA(pkey) !=3D NULL) { </sp=
an></div><div><span style=3D"color:rgb(36,41,46);font-family:SFMono-Regular=
,Consolas,&quot;Liberation Mono&quot;,Menlo,Courier,monospace;font-size:12p=
x;white-space:pre-wrap">    RSA *rsa =3D </span><span style=3D"color:rgb(36=
,41,46);font-family:SFMono-Regular,Consolas,&quot;Liberation Mono&quot;,Men=
lo,Courier,monospace;font-size:12px;white-space:pre-wrap">EVP_PKEY_get0_RSA=
(pkey);</span></div><div><span style=3D"color:rgb(36,41,46);font-family:SFM=
ono-Regular,Consolas,&quot;Liberation Mono&quot;,Menlo,Courier,monospace;fo=
nt-size:12px;white-space:pre-wrap">    ...</span></div><div><span style=3D"=
color:rgb(36,41,46);font-family:SFMono-Regular,Consolas,&quot;Liberation Mo=
no&quot;,Menlo,Courier,monospace;font-size:12px;white-space:pre-wrap">  }</=
span></div></div></div></div></blockquote><div><br></div><div>This looks ba=
d to me.</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"m=
argin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left=
:1ex"><div dir=3D"ltr"><div class=3D"gmail_extra"><div class=3D"gmail_quote=
"><div><font color=3D"#24292e" face=3D"SFMono-Regular, Consolas, Liberation=
 Mono, Menlo, Courier, monospace"><span style=3D"font-size:12px;white-space=
:pre-wrap"><br></span></font></div><div><span style=3D"color:rgb(36,41,46);=
font-family:SFMono-Regular,Consolas,&quot;Liberation Mono&quot;,Menlo,Couri=
er,monospace;font-size:12px;white-space:pre-wrap"><br></span></div><div><sp=
an style=3D"color:rgb(36,41,46);font-family:SFMono-Regular,Consolas,&quot;L=
iberation Mono&quot;,Menlo,Courier,monospace;font-size:12px;white-space:pre=
-wrap">3) rework it as proposed in the patch</span></div><div><span style=
=3D"color:rgb(36,41,46);font-family:SFMono-Regular,Consolas,&quot;Liberatio=
n Mono&quot;,Menlo,Courier,monospace;font-size:12px;white-space:pre-wrap"><=
br></span></div><div><span style=3D"color:rgb(36,41,46);font-family:SFMono-=
Regular,Consolas,&quot;Liberation Mono&quot;,Menlo,Courier,monospace;font-s=
ize:12px;white-space:pre-wrap">  RSA *rsa =3D NULL;</span></div><div><span =
style=3D"color:rgb(36,41,46);font-family:SFMono-Regular,Consolas,&quot;Libe=
ration Mono&quot;,Menlo,Courier,monospace;font-size:12px;white-space:pre-wr=
ap">  if ((rsa =3D </span><span style=3D"color:rgb(36,41,46);font-family:SF=
Mono-Regular,Consolas,&quot;Liberation Mono&quot;,Menlo,Courier,monospace;f=
ont-size:12px;white-space:pre-wrap">EVP_PKEY_get0_RSA(pkey)) !=3D NULL) { .=
.. }</span></div></div></div></div></blockquote><div><br></div><div>In this=
 particular case this may be the best approach but there are situations whe=
re it may not be the natural choice. Hence the &quot;if it were up to me EV=
P_KEY_id() will stay&quot; musing...:)</div><div><br></div><div>Thanks,</di=
v><div><br></div><div>Selva</div></div></div></div></div>

--001a1135a3ae59ed3d0562db3536--

