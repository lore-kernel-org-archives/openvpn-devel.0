MIME-Version: 1.0
Sender: emmanueldeloget53@...277...
In-Reply-To: <CAKuzo_j6Uuw8minumYHECmqtE9ocvrzGtO0_3FUcGnNy4q3Bqw@...278...>
References: <CAKh=nwFOSOCugW1JWYfiQFZLTKRBc6qoi=U9ewzjOSpaGP1-Kg@...278...>
 <6a6ede658da2e35b718a9ccb733b132a955ffefe.1515792908.git.logout@...260...>
 <183bd138-e733-042e-9cc3-c66bbf6ea9bd@...1856...>
 <CAKh=nwEeSBgkbz5-_R_eU7rK9fYpDQ=1jsY+02+vMxRJ8=wZxg@...278...>
 <CAKuzo_j6Uuw8minumYHECmqtE9ocvrzGtO0_3FUcGnNy4q3Bqw@...278...>
From: Emmanuel Deloget <logout@...260...>
Date: Tue, 16 Jan 2018 01:56:11 +0100
Message-ID: <CAKh=nwGDv2fKJ6STqYthwpH+1SkztkLj1=KH4MWJ58ifc_byog@...278...>
Content-Type: multipart/alternative; boundary="001a114a88cc6dce860562da32f4"
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
To: Selva Nair <selva.nair@...277...>
Cc: Steffan Karger <steffan@...1856...>, openvpn-devel@lists.sourceforge.net

--001a114a88cc6dce860562da32f4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Selva,

On Tue, Jan 16, 2018 at 12:10 AM, Selva Nair <selva.nair@...277...> wrote:

>
>
> On Mon, Jan 15, 2018 at 5:33 PM, Emmanuel Deloget <logout@...260...> wrot=
e:
>
>> Hello Steffan,
>>
>> On Sun, Jan 14, 2018 at 11:26 AM, Steffan Karger <steffan@...1856...>
>> wrote:
>>
>>> Hi,
>>>
>>> On 12-01-18 22:37, Emmanuel Deloget wrote:
>>> > Calling EVP_KEY_id() before EVP_PKEY_get0_*() is unnecessary as
>>> > the same check is also performed in the later.
>>> >
>>> > We also make the code a bit better by not calling the various
>>> > EVP_PKEY_get0_*() functions twice (this needs a bit or reordering to
>>> > avoid introducing yet another #ifndef OPENSSL_NO_EC in the code).
>>>
>>> Checking double is a bit silly, but we can fix that by simply removing
>>> the "EVP_PKEY_id() =3D=3D ... && " occurrences. (That still allows us to
>>> remove it from the compat wrapper.)
>>>
>>> I'm not sure that moving the variables outside the if() scope actually
>>> improves the code.  At least I think the original flow is easier to
>>> read.  Mostly due to the #ifdef noise, but still.  In a path that's not
>>> performance-critical, I prefer readability over performance.
>>>
>>
>>
>> =E2=80=8BWell, to be honest, I was definitely not trying to make any kin=
d of
>> performance gain :)=E2=80=8B
>>
>> The whole idea was to make code easier to read and to remove some now
>> weird duplication of functions (the kind of duplication that will come a=
nd
>> bites you later).
>>
>> For the variables outside the ifs, the next C standard should allow us to
>> write something like:
>>
>> if ((RSA *rsa =3D EVP_PKEY_get0_RSA(pkey)) !=3D NULL) {
>> ...
>>
>> That should be easier to read (but then, I'm not sure when this will be
>> considered as widespread ; I guess we're slated for 2025 or so :))
>>
>> Anyway, moving the variables within the if means we're going to call
>> EVP_PKEY_get0_RSA() twice which, I feel, is not a good thing to do. But
>> even if I'm not very comfortable with this, I can still propose a patch
>> that des it (it's lighter than the currently proposed change). You tell =
me
>> :)
>>
>
> Can I try one last time to convince you guys to keep EVP_PKEY_id()? If I
> was targeting only 1.1.0+ that's how most of those checks would have been
> done, isn't? Makes life easier, code simpler as I have said before..
>
> Just throwing in my 0.02c, feel free to ignore.
>
> Best,
>
> Selva
>


OpenSSL 1.1.0+ and previous versions allows you to create a typed EVP_PKEY
without any key inside. For example, you can do

  EVP_PKEY *pkey =3D EVP_PKEY_new();
  EVP_PKEY_set_type(pkey, EVP_PKEY_RSA);

This is plainly valid: the key is prepared for later use.

So testing for EVP_PKEY_id() is not sufficient to make sure that current
and future code won't mess with us. To be extra sure, one can do

if (EVP_PKEY_id() =3D=3D EVP_PKEY_RSA && EVP_PKEY_get0_RSA(pkey)) { ... }

Which is exactly what the current code does. Yet the idea (at least mine)
is to remove that to simplify code a bit.

Now, I agree, this is quite easy to read and to understand.

We have 3 solutions:

1) keep the code as is

if (EVP_PKEY_id() =3D=3D EVP_PKEY_RSA && EVP_PKEY_get0_RSA(pkey) !=3D NULL)=
 { ...
}

2) remove EVP_PKEY_id() but keep a test on EVP_PKEY_getO_RSA()

if (EVP_PKEY_get0_RSA(pkey) !=3D NULL) {
RSA *rsa =3D EVP_PKEY_get0_RSA(pkey);
...
}

3) rework it as proposed in the patch

RSA *rsa =3D NULL;
if ((rsa =3D EVP_PKEY_get0_RSA(pkey)) !=3D NULL) { ... }

While I prefer the latest, I can understand that it might not be the best
solution. I don't have a strong opinion on the subject (that's why it's a
separate patch ;)).

=E2=80=8BBest regards,

-- Emmanuel Deloget=E2=80=8B

--001a114a88cc6dce860562da32f4
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_default" style=3D"font-family:monospac=
e,monospace">Hello Selva,=C2=A0</div><div class=3D"gmail_extra"><br><div cl=
ass=3D"gmail_quote">On Tue, Jan 16, 2018 at 12:10 AM, Selva Nair <span dir=
=3D"ltr">&lt;<a href=3D"mailto:selva.nair@...277..." target=3D"_blank">selv=
a.nair@...277...</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote"=
 style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);p=
adding-left:1ex"><div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div c=
lass=3D"gmail_quote"><span class=3D"gmail-">On Mon, Jan 15, 2018 at 5:33 PM=
, Emmanuel Deloget <span dir=3D"ltr">&lt;<a href=3D"mailto:logout@...260...=
" target=3D"_blank">logout@...260...</a>&gt;</span> wrote:<br><blockquote c=
lass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px soli=
d rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr"><div style=3D"font-fa=
mily:monospace,monospace">Hello Steffan,=C2=A0</div><div class=3D"gmail_ext=
ra"><br><div class=3D"gmail_quote"><span>On Sun, Jan 14, 2018 at 11:26 AM, =
Steffan Karger <span dir=3D"ltr">&lt;<a href=3D"mailto:steffan@...1856..." =
target=3D"_blank">steffan@...1856...</a>&gt;</span> wrote:<br><blockquote c=
lass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px soli=
d rgb(204,204,204);padding-left:1ex">Hi,<br>
<span class=3D"gmail-m_5510807250704300764m_1484023647284146023gmail-"><br>
On 12-01-18 22:37, Emmanuel Deloget wrote:<br>
&gt; Calling EVP_KEY_id() before EVP_PKEY_get0_*() is unnecessary as<br>
&gt; the same check is also performed in the later.<br>
&gt;<br>
&gt; We also make the code a bit better by not calling the various<br>
&gt; EVP_PKEY_get0_*() functions twice (this needs a bit or reordering to<b=
r>
&gt; avoid introducing yet another #ifndef OPENSSL_NO_EC in the code).<br>
<br>
</span>Checking double is a bit silly, but we can fix that by simply removi=
ng<br>
the &quot;EVP_PKEY_id() =3D=3D ... &amp;&amp; &quot; occurrences. (That sti=
ll allows us to<br>
remove it from the compat wrapper.)<br>
<br>
I&#39;m not sure that moving the variables outside the if() scope actually<=
br>
improves the code.=C2=A0 At least I think the original flow is easier to<br>
read.=C2=A0 Mostly due to the #ifdef noise, but still.=C2=A0 In a path that=
&#39;s not<br>
performance-critical, I prefer readability over performance.<br></blockquot=
e><div><br></div></span><div><div style=3D"font-family:monospace,monospace"=
><br></div><div style=3D"font-family:monospace,monospace">=E2=80=8BWell, to=
 be honest, I was definitely not trying to make any kind of performance gai=
n :)=E2=80=8B</div><div style=3D"font-family:monospace,monospace"><br></div=
><div style=3D"font-family:monospace,monospace">The whole idea was to make =
code easier to read and to remove some now weird duplication of functions (=
the kind of duplication that will come and bites you later).=C2=A0</div><di=
v style=3D"font-family:monospace,monospace"><br></div><div style=3D"font-fa=
mily:monospace,monospace">For the variables outside the ifs, the next C sta=
ndard should allow us to write something like:</div><div style=3D"font-fami=
ly:monospace,monospace"><br></div><div style=3D"font-family:monospace,monos=
pace">if ((RSA *rsa =3D EVP_PKEY_get0_RSA(pkey)) !=3D NULL) {</div><div sty=
le=3D"font-family:monospace,monospace">...</div><div style=3D"font-family:m=
onospace,monospace"><br></div><div style=3D"font-family:monospace,monospace=
">That should be easier to read (but then, I&#39;m not sure when this will =
be considered as widespread ; I guess we&#39;re slated for 2025 or so :))</=
div><div style=3D"font-family:monospace,monospace"><br></div><div style=3D"=
font-family:monospace,monospace">Anyway, moving the variables within the if=
 means we&#39;re going to call EVP_PKEY_get0_RSA() twice which, I feel, is =
not a good thing to do. But even if I&#39;m not very comfortable with this,=
 I can still propose a patch that des it (it&#39;s lighter than the current=
ly proposed change). You tell me :)</div></div></div></div></div></blockquo=
te><div><br></div></span><div>Can I try one last time to convince you guys =
to keep EVP_PKEY_id()? If I was targeting only 1.1.0+ that&#39;s how most o=
f those checks would have been done, isn&#39;t? Makes life easier, code sim=
pler as I have said before..</div><div><br></div><div>Just throwing in my 0=
.02c, feel free to ignore.</div><div><br></div><div>Best,</div><div><br></d=
iv><div>Selva=C2=A0</div></div></div></div></blockquote><div><br></div><div=
><div class=3D"gmail_default" style=3D"font-family:monospace,monospace"><br=
></div><div class=3D"gmail_default" style=3D"font-family:monospace,monospac=
e">OpenSSL 1.1.0+ and previous versions allows you to create a typed EVP_PK=
EY without any key inside. For example, you can do<br></div></div><div clas=
s=3D"gmail_default" style=3D"font-family:monospace,monospace"><br></div><di=
v class=3D"gmail_default" style=3D"font-family:monospace,monospace">=C2=A0 =
EVP_PKEY *pkey =3D EVP_PKEY_new();</div><div class=3D"gmail_default" style=
=3D"font-family:monospace,monospace">=C2=A0 EVP_PKEY_set_type(pkey,=C2=A0<s=
pan style=3D"color:rgb(36,41,46);font-family:SFMono-Regular,Consolas,&quot;=
Liberation Mono&quot;,Menlo,Courier,monospace;font-size:12px;white-space:pr=
e">EVP_PKEY_RSA);</span></div><div class=3D"gmail_default" style=3D"font-fa=
mily:monospace,monospace"><span style=3D"color:rgb(36,41,46);font-family:SF=
Mono-Regular,Consolas,&quot;Liberation Mono&quot;,Menlo,Courier,monospace;f=
ont-size:12px;white-space:pre"><br></span></div><div class=3D"gmail_default=
" style=3D"font-family:monospace,monospace"><span style=3D"color:rgb(36,41,=
46);font-family:SFMono-Regular,Consolas,&quot;Liberation Mono&quot;,Menlo,C=
ourier,monospace;font-size:12px;white-space:pre">This is plainly valid: the=
 key is prepared for later use. </span></div><div class=3D"gmail_default" s=
tyle=3D"font-family:monospace,monospace"><span style=3D"color:rgb(36,41,46)=
;font-family:SFMono-Regular,Consolas,&quot;Liberation Mono&quot;,Menlo,Cour=
ier,monospace;font-size:12px;white-space:pre"><br></span></div><div class=
=3D"gmail_default" style=3D"font-family:monospace,monospace"><span style=3D=
"color:rgb(36,41,46);font-family:SFMono-Regular,Consolas,&quot;Liberation M=
ono&quot;,Menlo,Courier,monospace;font-size:12px;white-space:pre">So testin=
g for EVP_PKEY_id() is not sufficient to make sure that current and future =
code won&#39;t mess with us. To be extra sure, one can do </span></div><div=
 class=3D"gmail_default" style=3D"font-family:monospace,monospace"><span st=
yle=3D"color:rgb(36,41,46);font-family:SFMono-Regular,Consolas,&quot;Libera=
tion Mono&quot;,Menlo,Courier,monospace;font-size:12px;white-space:pre"><br=
></span></div><div class=3D"gmail_default" style=3D"font-family:monospace,m=
onospace"><span style=3D"color:rgb(36,41,46);font-family:SFMono-Regular,Con=
solas,&quot;Liberation Mono&quot;,Menlo,Courier,monospace;font-size:12px;wh=
ite-space:pre">  if (EVP_PKEY_id() =3D=3D EVP_PKEY_RSA &amp;&amp; EVP_PKEY_=
get0_RSA(pkey)) { ... }</span></div><div class=3D"gmail_default" style=3D"f=
ont-family:monospace,monospace"><span style=3D"color:rgb(36,41,46);font-fam=
ily:SFMono-Regular,Consolas,&quot;Liberation Mono&quot;,Menlo,Courier,monos=
pace;font-size:12px;white-space:pre"><br></span></div><div class=3D"gmail_d=
efault" style=3D"font-family:monospace,monospace"><span style=3D"color:rgb(=
36,41,46);font-family:SFMono-Regular,Consolas,&quot;Liberation Mono&quot;,M=
enlo,Courier,monospace;font-size:12px;white-space:pre">Which is exactly wha=
t the current code does. Yet the idea (at least mine) is to remove that to =
simplify code a bit. </span></div><div class=3D"gmail_default" style=3D"fon=
t-family:monospace,monospace"><span style=3D"color:rgb(36,41,46);font-famil=
y:SFMono-Regular,Consolas,&quot;Liberation Mono&quot;,Menlo,Courier,monospa=
ce;font-size:12px;white-space:pre"><br></span></div><div class=3D"gmail_def=
ault"><font color=3D"#24292e" face=3D"SFMono-Regular, Consolas, Liberation =
Mono, Menlo, Courier, monospace"><span style=3D"font-size:12px;white-space:=
pre">Now, I agree, this is quite easy to read and to understand. </span></f=
ont></div><div class=3D"gmail_default"><font color=3D"#24292e" face=3D"SFMo=
no-Regular, Consolas, Liberation Mono, Menlo, Courier, monospace"><span sty=
le=3D"font-size:12px;white-space:pre"><br></span></font></div><div class=3D=
"gmail_default"><font color=3D"#24292e" face=3D"SFMono-Regular, Consolas, L=
iberation Mono, Menlo, Courier, monospace"><span style=3D"font-size:12px;wh=
ite-space:pre">We have 3 solutions: </span></font></div><div class=3D"gmail=
_default"><font color=3D"#24292e" face=3D"SFMono-Regular, Consolas, Liberat=
ion Mono, Menlo, Courier, monospace"><span style=3D"font-size:12px;white-sp=
ace:pre"><br></span></font></div><div class=3D"gmail_default"><font color=
=3D"#24292e" face=3D"SFMono-Regular, Consolas, Liberation Mono, Menlo, Cour=
ier, monospace"><span style=3D"font-size:12px;white-space:pre">1) keep the =
code as is</span></font></div><div class=3D"gmail_default"><font color=3D"#=
24292e" face=3D"SFMono-Regular, Consolas, Liberation Mono, Menlo, Courier, =
monospace"><span style=3D"font-size:12px;white-space:pre"><br></span></font=
></div><div class=3D"gmail_default"><span style=3D"color:rgb(36,41,46);font=
-family:SFMono-Regular,Consolas,&quot;Liberation Mono&quot;,Menlo,Courier,m=
onospace;font-size:12px;white-space:pre">  if (EVP_PKEY_id() =3D=3D EVP_PKE=
Y_RSA &amp;&amp; EVP_PKEY_get0_RSA(pkey) !=3D NULL) { ... }</span><font col=
or=3D"#24292e" face=3D"SFMono-Regular, Consolas, Liberation Mono, Menlo, Co=
urier, monospace"><span style=3D"font-size:12px;white-space:pre"><br></span=
></font></div><div class=3D"gmail_default"><font color=3D"#24292e" face=3D"=
SFMono-Regular, Consolas, Liberation Mono, Menlo, Courier, monospace"><span=
 style=3D"font-size:12px;white-space:pre"><br></span></font></div><div clas=
s=3D"gmail_default"><font color=3D"#24292e" face=3D"SFMono-Regular, Consola=
s, Liberation Mono, Menlo, Courier, monospace"><span style=3D"font-size:12p=
x;white-space:pre">2) remove EVP_PKEY_id() but keep a test on EVP_PKEY_getO=
_RSA()</span></font></div><div class=3D"gmail_default"><font color=3D"#2429=
2e" face=3D"SFMono-Regular, Consolas, Liberation Mono, Menlo, Courier, mono=
space"><span style=3D"font-size:12px;white-space:pre"><br></span></font></d=
iv><div class=3D"gmail_default"><span style=3D"color:rgb(36,41,46);font-fam=
ily:SFMono-Regular,Consolas,&quot;Liberation Mono&quot;,Menlo,Courier,monos=
pace;font-size:12px;white-space:pre">  if (EVP_PKEY_get0_RSA(pkey) !=3D NUL=
L) { </span></div><div class=3D"gmail_default"><span style=3D"color:rgb(36,=
41,46);font-family:SFMono-Regular,Consolas,&quot;Liberation Mono&quot;,Menl=
o,Courier,monospace;font-size:12px;white-space:pre">    RSA *rsa =3D </span=
><span style=3D"color:rgb(36,41,46);font-family:SFMono-Regular,Consolas,&qu=
ot;Liberation Mono&quot;,Menlo,Courier,monospace;font-size:12px;white-space=
:pre">EVP_PKEY_get0_RSA(pkey);</span></div><div class=3D"gmail_default"><sp=
an style=3D"color:rgb(36,41,46);font-family:SFMono-Regular,Consolas,&quot;L=
iberation Mono&quot;,Menlo,Courier,monospace;font-size:12px;white-space:pre=
">    ...</span></div><div class=3D"gmail_default"><span style=3D"color:rgb=
(36,41,46);font-family:SFMono-Regular,Consolas,&quot;Liberation Mono&quot;,=
Menlo,Courier,monospace;font-size:12px;white-space:pre">  }</span><font col=
or=3D"#24292e" face=3D"SFMono-Regular, Consolas, Liberation Mono, Menlo, Co=
urier, monospace"><span style=3D"font-size:12px;white-space:pre"><br></span=
></font></div><div class=3D"gmail_default"><span style=3D"color:rgb(36,41,4=
6);font-family:SFMono-Regular,Consolas,&quot;Liberation Mono&quot;,Menlo,Co=
urier,monospace;font-size:12px;white-space:pre"><br></span></div><div class=
=3D"gmail_default"><span style=3D"color:rgb(36,41,46);font-family:SFMono-Re=
gular,Consolas,&quot;Liberation Mono&quot;,Menlo,Courier,monospace;font-siz=
e:12px;white-space:pre">3) rework it as proposed in the patch</span></div><=
div class=3D"gmail_default"><span style=3D"color:rgb(36,41,46);font-family:=
SFMono-Regular,Consolas,&quot;Liberation Mono&quot;,Menlo,Courier,monospace=
;font-size:12px;white-space:pre"><br></span></div><div class=3D"gmail_defau=
lt"><span style=3D"color:rgb(36,41,46);font-family:SFMono-Regular,Consolas,=
&quot;Liberation Mono&quot;,Menlo,Courier,monospace;font-size:12px;white-sp=
ace:pre">  RSA *rsa =3D NULL;</span></div><div class=3D"gmail_default"><spa=
n style=3D"color:rgb(36,41,46);font-family:SFMono-Regular,Consolas,&quot;Li=
beration Mono&quot;,Menlo,Courier,monospace;font-size:12px;white-space:pre"=
>  if ((rsa =3D </span><span style=3D"color:rgb(36,41,46);font-family:SFMon=
o-Regular,Consolas,&quot;Liberation Mono&quot;,Menlo,Courier,monospace;font=
-size:12px;white-space:pre">EVP_PKEY_get0_RSA(pkey)) !=3D NULL) { ... }</sp=
an><br></div><div class=3D"gmail_default"><span style=3D"color:rgb(36,41,46=
);font-family:SFMono-Regular,Consolas,&quot;Liberation Mono&quot;,Menlo,Cou=
rier,monospace;font-size:12px;white-space:pre"><br></span></div><div class=
=3D"gmail_default"><span style=3D"color:rgb(36,41,46);font-family:SFMono-Re=
gular,Consolas,&quot;Liberation Mono&quot;,Menlo,Courier,monospace;font-siz=
e:12px;white-space:pre">While I prefer the latest, I can understand that it=
 might not be the best solution. I don&#39;t have a strong opinion on the s=
ubject (that&#39;s why it&#39;s a separate patch ;)).</span></div></div><br=
></div><div class=3D"gmail_extra"><div class=3D"gmail_default" style=3D"fon=
t-family:monospace,monospace">=E2=80=8BBest regards,=C2=A0</div><div class=
=3D"gmail_default" style=3D"font-family:monospace,monospace"><br></div><div=
 class=3D"gmail_default" style=3D"font-family:monospace,monospace">-- Emman=
uel Deloget=E2=80=8B</div><br></div></div>

--001a114a88cc6dce860562da32f4--

