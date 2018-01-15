MIME-Version: 1.0
In-Reply-To: <CAKh=nwEeSBgkbz5-_R_eU7rK9fYpDQ=1jsY+02+vMxRJ8=wZxg@...278...>
References: <CAKh=nwFOSOCugW1JWYfiQFZLTKRBc6qoi=U9ewzjOSpaGP1-Kg@...278...>
 <6a6ede658da2e35b718a9ccb733b132a955ffefe.1515792908.git.logout@...260...>
 <183bd138-e733-042e-9cc3-c66bbf6ea9bd@...1856...>
 <CAKh=nwEeSBgkbz5-_R_eU7rK9fYpDQ=1jsY+02+vMxRJ8=wZxg@...278...>
From: Selva Nair <selva.nair@...277...>
Date: Mon, 15 Jan 2018 18:10:50 -0500
Message-ID: <CAKuzo_j6Uuw8minumYHECmqtE9ocvrzGtO0_3FUcGnNy4q3Bqw@...278...>
Content-Type: multipart/alternative; boundary="001a1135a3aed421720562d8ba25"
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

--001a1135a3aed421720562d8ba25
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 15, 2018 at 5:33 PM, Emmanuel Deloget <logout@...260...> wrote:

> Hello Steffan,
>
> On Sun, Jan 14, 2018 at 11:26 AM, Steffan Karger <steffan@...1856...>
> wrote:
>
>> Hi,
>>
>> On 12-01-18 22:37, Emmanuel Deloget wrote:
>> > Calling EVP_KEY_id() before EVP_PKEY_get0_*() is unnecessary as
>> > the same check is also performed in the later.
>> >
>> > We also make the code a bit better by not calling the various
>> > EVP_PKEY_get0_*() functions twice (this needs a bit or reordering to
>> > avoid introducing yet another #ifndef OPENSSL_NO_EC in the code).
>>
>> Checking double is a bit silly, but we can fix that by simply removing
>> the "EVP_PKEY_id() =3D=3D ... && " occurrences. (That still allows us to
>> remove it from the compat wrapper.)
>>
>> I'm not sure that moving the variables outside the if() scope actually
>> improves the code.  At least I think the original flow is easier to
>> read.  Mostly due to the #ifdef noise, but still.  In a path that's not
>> performance-critical, I prefer readability over performance.
>>
>
>
> =E2=80=8BWell, to be honest, I was definitely not trying to make any kind=
 of
> performance gain :)=E2=80=8B
>
> The whole idea was to make code easier to read and to remove some now
> weird duplication of functions (the kind of duplication that will come and
> bites you later).
>
> For the variables outside the ifs, the next C standard should allow us to
> write something like:
>
> if ((RSA *rsa =3D EVP_PKEY_get0_RSA(pkey)) !=3D NULL) {
> ...
>
> That should be easier to read (but then, I'm not sure when this will be
> considered as widespread ; I guess we're slated for 2025 or so :))
>
> Anyway, moving the variables within the if means we're going to call
> EVP_PKEY_get0_RSA() twice which, I feel, is not a good thing to do. But
> even if I'm not very comfortable with this, I can still propose a patch
> that des it (it's lighter than the currently proposed change). You tell me
> :)
>

Can I try one last time to convince you guys to keep EVP_PKEY_id()? If I
was targeting only 1.1.0+ that's how most of those checks would have been
done, isn't? Makes life easier, code simpler as I have said before..

Just throwing in my 0.02c, feel free to ignore.

Best,

Selva

--001a1135a3aed421720562d8ba25
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">On Mon, Jan 15, 2018 at 5:33 PM, Emmanuel Deloget <span dir=3D"ltr">&lt=
;<a href=3D"mailto:logout@...260..." target=3D"_blank">logout@...260...</a>=
&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0=
 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div dir=3D"ltr"><div =
style=3D"font-family:monospace,monospace">Hello Steffan,=C2=A0</div><div cl=
ass=3D"gmail_extra"><br><div class=3D"gmail_quote"><span class=3D"">On Sun,=
 Jan 14, 2018 at 11:26 AM, Steffan Karger <span dir=3D"ltr">&lt;<a href=3D"=
mailto:steffan@...1856..." target=3D"_blank">steffan@...1856...</a>&gt;</sp=
an> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px=
 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Hi,<br>
<span class=3D"m_1484023647284146023gmail-"><br>
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
te><div><br></div><div>Can I try one last time to convince you guys to keep=
 EVP_PKEY_id()? If I was targeting only 1.1.0+ that&#39;s how most of those=
 checks would have been done, isn&#39;t? Makes life easier, code simpler as=
 I have said before..</div><div><br></div><div>Just throwing in my 0.02c, f=
eel free to ignore.</div><div><br></div><div>Best,</div><div><br></div><div=
>Selva=C2=A0</div></div></div></div>

--001a1135a3aed421720562d8ba25--

