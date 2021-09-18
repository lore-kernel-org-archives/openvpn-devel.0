MIME-Version: 1.0
References: <604d3782-646c-4f12-b789-2ae9ebbae069@...515...>
 <42e7467d-67b9-a6c3-6348-bb1d1e0ef21c@...515...>
 <CAKuzo_hA34XJP-uz7VgC0mkDdd+48-dOURxqjfhik6fjbsNK-Q@...278...>
 <898155c6-85f3-c9ce-145d-30673825e3f7@...1227...>
 <CAKuzo_gmS8j5KcxoRq8uR27Ocj4W4z0eKOLVUrF2WWQ8-+afgw@...278...>
 <58ade119-6398-0bac-990b-442d5819b1f9@...1227...>
 <CAKuzo_hEv7yOoLnpuxeQPTugV=NNNyBFCUKMdGe4D_H9MA9mew@...278...>
In-Reply-To: <CAKuzo_hEv7yOoLnpuxeQPTugV=NNNyBFCUKMdGe4D_H9MA9mew@...278...>
From: Selva Nair <selva.nair@...277...>
Date: Sat, 18 Sep 2021 15:01:58 -0400
Message-ID: <CAKuzo_hx1iiZx29Gzz3AG2ZA7vXwf13nMrGaQoo9FGt0roEejw@...278...>
Content-Type: multipart/alternative; boundary="000000000000e8c03105cc49b9ad"
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

--000000000000e8c03105cc49b9ad
Content-Type: text/plain; charset="UTF-8"

Hi Arne

On Sat, Sep 18, 2021 at 11:22 AM Selva Nair <selva.nair@...277...> wrote:

> Hi Arne,
>
> On Fri, Sep 17, 2021 at 7:33 PM Arne Schwabe <arne@...1227...> wrote:
>
>> >     > If Arne is adding a provider implementation for this, maybe I
>> >     > should hold off?
>> >
>> >     I am currently trying to get together a "small" provider by adapting
>> >     code from https://github.com/tpm2-software/tpm2-openssl
>> >     <https://github.com/tpm2-software/tpm2-openssl>. My provider
>> >     implmentation is already 600 lines of code since you need a lot of
>> >     boiler plate code. But the whole documentation of provider API is
>> not as
>> >     great as it could be. You get documentation of all the function but
>> you
>> >     to figure yourself how all that fits together.
>> >
>> >
>> > OpenSSL has always been like that isn't it -- one could never
>> > write anything based on docs alone.  I have seen the tpm2 code. That,
>> > along with the built-in provider implementations in OpenSSL, seems to
>> > fill some of the gaps in documentation. There were also some discussions
>> > and questions in OpenSSL repo (issues) when the tpm2 guys were
>> > developing it. But I haven't seen any code that deals with non-default
>> > providers in the SSL context, especially when one wants to mix providers
>> > (default for most things + custom for keymgmt & signature only).
>> >
>> >     I hope to have something ready at the end of the month.
>> >
>> >
>> > For a working patch I'll also take a similar amount of time. Depending
>> > on how it goes,  I'll wait, or post my feature branch for discussion.
>> > I'm totally open, and we do not have to go with my approach even if I
>> > come up with something. In any case, some discussion may be
>> > useful/required to make the basic framework re-usable for all "external
>> > key" situations.
>> >
>> If you want to have a look at my effort. I push my WIP here:
>> https://github.com/schwabe/openvpn/commits/dco
>>
>> but currently it is really only mostly boilerplate stuff to figure out
>> what OpenSSL really wants from me and what I need to do make it happy.
>> Currently it calls some methods but none of which returns an error or I
>> am missing something. I will probably need to deep dive in OpenSSL's own
>> source code and figure out what is happening but that will probably have
>> to wait till next week:
>>
>> PROVIDER INIT
>> provider init
>> extpki_get_reason_strings
>> query operation: 22
>> extpki_unquery_operation
>> extpki_object_open: STORE/OBJECT OPEN
>> STORE/OBJECT SET_PARAMS, expected type: private key (4)
>> STORE/OBJECT EOF
>> STORE/OBJECT CLOSE
>>
>> Could not read key from extpki:1234
>> extpki_teardown
>>
>
>
Here is my working branch:

https://github.com/selvanair/openvpn/tree/xkey-provider-v2

It should build on linux without errors, though with lots of deprecation
warnings in old files. The executable will work and allow one to test key
loading and some of other internals by running as tls-client with a normal
key in a file -- not inlined key or external key. The key will get loaded
into the provider and treated as opaque and still pass signature etc.. This
is only for testing. See the last commit message for some details on this.

Build with --enable debug. Note that the last commit made for testing will
break signing with external keys until callbacks are connected plus some
more.

I should have a more complete version ready to hook up with
backend callbacks by the end of the weekend.

I skimmed through your branch. You need keymgmt_load to get the loading
through store to work. As for other ops, implementing signature_sign_init
and sign are not enough -- one needs digest_verify methods and digest_sign
methods as well. This is because ssl-ctx has to be created in the context
of our provider for sign to work, but then all public key ops also get
delegated to us.  It took a while for me to sort that out.

Unfortunately this provider framework makes us write a metric ton of glue
code code.

Please feel free to nit-pick or otherwise-pick on the code.

Cheers,

Selva

--000000000000e8c03105cc49b9ad
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi Arne</div><div><br></div><div dir=3D"ltr">On Sat, =
Sep 18, 2021 at 11:22 AM Selva Nair &lt;<a href=3D"mailto:selva.nair@...1482...=
...">selva.nair@...277...</a>&gt; wrote:<br></div><div class=3D"gmail_quote=
"><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;borde=
r-left:1px solid rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr"><div d=
ir=3D"ltr">Hi Arne,</div><div dir=3D"ltr"><br></div><div class=3D"gmail_quo=
te"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Sep 17, 2021 at 7:33 PM A=
rne Schwabe &lt;<a href=3D"mailto:arne@...1227..." target=3D"_blank">arne@...220...=
..1227...</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">&gt;=C2=A0 =C2=A0 =C2=A0&gt; If Arne is adding a provider implem=
entation for this, maybe I<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; should=C2=A0hold off?<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0I am currently trying to get together a &quot;small=
&quot; provider by adapting<br>
&gt;=C2=A0 =C2=A0 =C2=A0code from <a href=3D"https://github.com/tpm2-softwa=
re/tpm2-openssl" rel=3D"noreferrer" target=3D"_blank">https://github.com/tp=
m2-software/tpm2-openssl</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;<a href=3D"https://github.com/tpm2-software/tpm=
2-openssl" rel=3D"noreferrer" target=3D"_blank">https://github.com/tpm2-sof=
tware/tpm2-openssl</a>&gt;. My provider<br>
&gt;=C2=A0 =C2=A0 =C2=A0implmentation is already 600 lines of code since yo=
u need a lot of<br>
&gt;=C2=A0 =C2=A0 =C2=A0boiler plate code. But the whole documentation of p=
rovider API is not as<br>
&gt;=C2=A0 =C2=A0 =C2=A0great as it could be. You get documentation of all =
the function but you<br>
&gt;=C2=A0 =C2=A0 =C2=A0to figure yourself how all that fits together.<br>
&gt; <br>
&gt; <br>
&gt; OpenSSL has always been like that isn&#39;t it -- one could never<br>
&gt; write=C2=A0anything based on docs alone.=C2=A0 I have seen the tpm2 co=
de. That,<br>
&gt; along with the built-in provider implementations in OpenSSL, seems to<=
br>
&gt; fill some=C2=A0of the gaps in documentation. There were also some disc=
ussions<br>
&gt; and questions in OpenSSL repo (issues) when the tpm2 guys were<br>
&gt; developing it. But I haven&#39;t seen any code that deals with non-def=
ault<br>
&gt; providers in the SSL context, especially when one=C2=A0wants to mix pr=
oviders<br>
&gt; (default for most things=C2=A0+ custom for keymgmt &amp; signature onl=
y).<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0I hope to have something ready at the end of the mo=
nth.<br>
&gt; <br>
&gt; <br>
&gt; For a working patch I&#39;ll also take a similar amount of time. Depen=
ding<br>
&gt; on how it goes,=C2=A0=C2=A0I&#39;ll wait, or post my feature branch fo=
r discussion.<br>
&gt; I&#39;m totally open, and we do not have to go with my approach even i=
f I<br>
&gt; come up with=C2=A0something. In any case, some discussion may be<br>
&gt; useful/required to make the basic framework re-usable for all &quot;ex=
ternal<br>
&gt; key&quot; situations.<br>
&gt; <br>
If you want to have a look at my effort. I push my WIP here:<br>
<a href=3D"https://github.com/schwabe/openvpn/commits/dco" rel=3D"noreferre=
r" target=3D"_blank">https://github.com/schwabe/openvpn/commits/dco</a><br>
<br>
but currently it is really only mostly boilerplate stuff to figure out<br>
what OpenSSL really wants from me and what I need to do make it happy.<br>
Currently it calls some methods but none of which returns an error or I<br>
am missing something. I will probably need to deep dive in OpenSSL&#39;s ow=
n<br>
source code and figure out what is happening but that will probably have<br>
to wait till next week:<br>
<br>
PROVIDER INIT<br>
provider init<br>
extpki_get_reason_strings<br>
query operation: 22<br>
extpki_unquery_operation<br>
extpki_object_open: STORE/OBJECT OPEN<br>
STORE/OBJECT SET_PARAMS, expected type: private key (4)<br>
STORE/OBJECT EOF<br>
STORE/OBJECT CLOSE<br>
<br>
Could not read key from extpki:1234<br>
extpki_teardown<br></blockquote><div><br></div></div></div></blockquote><di=
v><br></div><div>Here is my working branch:=C2=A0</div><div><br></div><div>=
<a href=3D"https://github.com/selvanair/openvpn/tree/xkey-provider-v2">http=
s://github.com/selvanair/openvpn/tree/xkey-provider-v2</a><br></div><div><b=
r></div><div>It should=C2=A0build on linux without errors, though with lots=
 of deprecation warnings in old files. The executable will work and allow o=
ne to test key loading and some of other internals by running as tls-client=
 with a normal key in a file -- not inlined key or external key. The key wi=
ll get loaded into the provider and treated as opaque and still pass signat=
ure etc.. This is only for testing. See the last commit message for some de=
tails on this.</div><div><br></div><div>Build with --enable debug. Note tha=
t the last commit made for testing will break signing=C2=A0with external ke=
ys until callbacks are connected plus some more.</div><div><br></div><div>I=
 should have a more complete version ready to hook up with backend=C2=A0cal=
lbacks by the end of the weekend.</div><div><br></div><div>I skimmed throug=
h your branch. You need keymgmt_load to get the loading through store to wo=
rk. As for other=C2=A0ops, implementing signature_sign_init and sign are no=
t enough -- one needs digest_verify methods and digest_sign methods as well=
. This is because=C2=A0ssl-ctx has to be created in the context of our prov=
ider for sign to work, but then all public key ops also get delegated to us=
.=C2=A0 It took a while for me to sort that out.</div><div><br></div><div>U=
nfortunately this provider framework makes us write a metric ton of glue co=
de code.</div><div><br></div><div>Please feel free to nit-pick or otherwise=
-pick on the code.</div><div><br></div><div>Cheers,</div><div><br></div><di=
v>Selva</div><div><br></div><blockquote class=3D"gmail_quote" style=3D"marg=
in:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1e=
x">
</blockquote></div></div>

--000000000000e8c03105cc49b9ad--

