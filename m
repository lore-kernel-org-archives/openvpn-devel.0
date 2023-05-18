MIME-Version: 1.0
References: <20230517200143.216-1-chipitsine@...277...>
 <02835E0F-FA73-4722-83EB-17A33A3A8DA5@...1376...>
 <ZGXKCwNgcA2P7Hiu@...1296...>
 <CAFHpkQGmm-U2mUnsBRB-4Po8NdSo_X7mZ_aRqJ-jELjha9necw@...278...>
In-Reply-To: <CAFHpkQGmm-U2mUnsBRB-4Po8NdSo_X7mZ_aRqJ-jELjha9necw@...278...>
From: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Date: Thu, 18 May 2023 09:11:07 +0200
Message-ID: <CAFHpkQEM+arVo4YnWYcbV10GUqA9wahGYrWXx4tMKaPwDtQW3Q@...278...>
Content-Type: multipart/alternative; boundary="000000000000c6719c05fbf282df"
Subject: Re: [Openvpn-devel] [PATCH] src/openvpn/dco_freebsd.c: handle
 malloc failure
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>
Cc: Kristof Provost <kp@...1249...>, openvpn-devel@lists.sourceforge.net

--000000000000c6719c05fbf282df
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D1=87=D1=82, 18 =D0=BC=D0=B0=D1=8F 2023=E2=80=AF=D0=B3. =D0=B2 09:10, =D0=
=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=D0=B8=D1=86=D0=B8=D0=BD <chipitsin=
e@...277...>:

>
>
> =D1=87=D1=82, 18 =D0=BC=D0=B0=D1=8F 2023=E2=80=AF=D0=B3. =D0=B2 08:47, Ge=
rt Doering <gert@...1296...>:
>
>> Hi,
>>
>> On Wed, May 17, 2023 at 04:43:01PM -0400, Kristof Provost wrote:
>> > Fwiw: I usually don???t bother handling malloc failure in userspace,
>> > because modern systems all overallocate anyway, so the first thing
>> > you know about lack of memory is the out-of-memory killer terminating
>> > you. It???s a policy choice for the project, so I don???t object
>> > to handling it either.
>>
>> In OpenVPN, we do check malloc() returns :-) - and there's cases where
>> it actually hit, like running with too low ulimits and --mlock.
>>
>> If a malloc fail is not recoverable, we have check_malloc_return(p),
>> which will do
>>
>> void
>> out_of_memory(void)
>> {
>>     fprintf(stderr, PACKAGE_NAME ": Out of Memory\n");
>>     exit(1);
>> }
>> static inline void
>> check_malloc_return(const void *p)
>> {
>>     if (!p)
>>     {
>>         out_of_memory();
>>     }
>> }
>>
>> so it depends a bit on the context if "return an error upstream, and
>> wait for the next allocation to fail" or "abort right away" is the best
>> choice.  In low level functions, "return error" might lead to a better
>> error message from upstream (or not).
>>
>
> this one is recoverable.
> if malloc fails, dco fails, but openvpn still able to function
>

maybe we should add something like "data channel offload failed due to ..."


>
>
>>
>> gert
>> --
>> "If was one thing all people took for granted, was conviction that if you
>>  feed honest figures into a computer, honest figures come out. Never
>> doubted
>>  it myself till I met a computer with a sense of humor."
>>                              Robert A. Heinlein, The Moon is a Harsh
>> Mistress
>>
>> Gert Doering - Munich, Germany
>> gert@...1296...
>>
>

--000000000000c6719c05fbf282df
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">=D1=87=D1=82, 18 =D0=BC=D0=B0=D1=8F 2=
023=E2=80=AF=D0=B3. =D0=B2 09:10, =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=
=BF=D0=B8=D1=86=D0=B8=D0=BD &lt;<a href=3D"mailto:chipitsine@...277...">chi=
pitsine@...277...</a>&gt;:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex"><div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gm=
ail_quote"><div dir=3D"ltr" class=3D"gmail_attr">=D1=87=D1=82, 18 =D0=BC=D0=
=B0=D1=8F 2023=E2=80=AF=D0=B3. =D0=B2 08:47, Gert Doering &lt;<a href=3D"ma=
ilto:gert@...1296..." target=3D"_blank">gert@...1296...</a>&gt;:<br></div><=
blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-l=
eft:1px solid rgb(204,204,204);padding-left:1ex">Hi,<br>
<br>
On Wed, May 17, 2023 at 04:43:01PM -0400, Kristof Provost wrote:<br>
&gt; Fwiw: I usually don???t bother handling malloc failure in userspace,<b=
r>
&gt; because modern systems all overallocate anyway, so the first thing<br>
&gt; you know about lack of memory is the out-of-memory killer terminating<=
br>
&gt; you. It???s a policy choice for the project, so I don???t object<br>
&gt; to handling it either.<br>
<br>
In OpenVPN, we do check malloc() returns :-) - and there&#39;s cases where<=
br>
it actually hit, like running with too low ulimits and --mlock.<br>
<br>
If a malloc fail is not recoverable, we have check_malloc_return(p),<br>
which will do<br>
<br>
void<br>
out_of_memory(void)<br>
{<br>
=C2=A0 =C2=A0 fprintf(stderr, PACKAGE_NAME &quot;: Out of Memory\n&quot;);<=
br>
=C2=A0 =C2=A0 exit(1);<br>
}<br>
static inline void<br>
check_malloc_return(const void *p)<br>
{<br>
=C2=A0 =C2=A0 if (!p)<br>
=C2=A0 =C2=A0 {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 out_of_memory();<br>
=C2=A0 =C2=A0 }<br>
}<br>
<br>
so it depends a bit on the context if &quot;return an error upstream, and<b=
r>
wait for the next allocation to fail&quot; or &quot;abort right away&quot; =
is the best<br>
choice.=C2=A0 In low level functions, &quot;return error&quot; might lead t=
o a better<br>
error message from upstream (or not).<br></blockquote><div><br></div><div>t=
his one is recoverable.</div><div>if malloc fails, dco fails, but openvpn s=
till able to function</div></div></div></blockquote><div><br></div><div>may=
be we should add something like &quot;data channel offload failed due to ..=
.&quot;</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"ma=
rgin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:=
1ex"><div dir=3D"ltr"><div class=3D"gmail_quote"><div>=C2=A0</div><blockquo=
te class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px =
solid rgb(204,204,204);padding-left:1ex">
<br>
gert<br>
-- <br>
&quot;If was one thing all people took for granted, was conviction that if =
you <br>
=C2=A0feed honest figures into a computer, honest figures come out. Never d=
oubted <br>
=C2=A0it myself till I met a computer with a sense of humor.&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Robert A. Heinlein, The Moon is a Harsh Mist=
ress<br>
<br>
Gert Doering - Munich, Germany=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<a href=3D"mailt=
o:gert@...1296..." target=3D"_blank">gert@...1296...</a><br>
</blockquote></div></div>
</blockquote></div></div>

--000000000000c6719c05fbf282df--

