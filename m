MIME-Version: 1.0
In-Reply-To: <CAKuzo_gHHupuSL9hLKyCUbMoFhedAFEPPuWMDsX1TV6d7=qm9A@...278...>
References: <20171012072440.8704-1-simon@...2293...>
 <CAKuzo_jUnvMkHwHXZ=cAre-=z7WACU0b2qKV27FyymfBTncX=g@...278...>
 <99D61A626FDA8A4B90A270669121BE108580F7E3@...2294...>
 <CAKuzo_jPU1rubUTtbq61PB0YgJyjaw7DREEwVeRV9XwQPMykEA@...278...>
 <cc1449bf-ae57-f598-51af-2d3a59c2da1d@...515...>
 <CAFHpkQEgjmdRgMaOC-1-6vRqjYTUoC6fODtcx2yZt0DJUPGcsw@...278...>
 <CAKuzo_gHHupuSL9hLKyCUbMoFhedAFEPPuWMDsX1TV6d7=qm9A@...278...>
From: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Date: Mon, 16 Oct 2017 22:34:18 +0500
Message-ID: <CAFHpkQHQC0eacftzVAnzt4068C0_9VzBZ6CH7Cxksa-Sus-pBQ@...278...>
Content-Type: multipart/alternative; boundary="001a114a91be982a71055bad6af9"
Subject: Re: [Openvpn-devel] [PATCH] Uniform snwprintf() across MinGW and
 MSVC compilers
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva <selva.nair@...277...>
Cc: =?UTF-8?Q?Samuli_Sepp=C3=A4nen?= <samuli@...515...>, Simon Rozman <simon@...2293...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--001a114a91be982a71055bad6af9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2017-10-16 20:33 GMT+05:00 Selva <selva.nair@...277...>:

>
> Hi
>
> On Mon, Oct 16, 2017 at 4:22 AM, =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=
=BF=D0=B8=D1=86=D0=B8=D0=BD <chipitsine@...277...>
> wrote:
>
>>
>>
>> 2017-10-16 13:05 GMT+05:00 Samuli Sepp=C3=A4nen <samuli@...515...>:
>>
>>> On 13/10/2017 20:48, Selva wrote:
>>>
>>> > @samuli: Which versions of mingw-w64 should we test against to ensure
>>> > release and snapshot builds would succeed?
>>>
>>> Right now _we_ use Ubuntu 16.04 for building:
>>>
>>>   mingw-w64 4.0.4
>>>   gcc-mingw-w64 5.3.1
>>>   g++-mingw-w64 5.3.1
>>>
>>> That said, I'm pretty sure many people still build with Ubuntu 14.04. So
>>> keeping support for it would make sense if it is not horribly painful.
>>> This is what Ubuntu 14.04 comes with:
>>>
>>>   mingw-w64 3.1.0
>>>   gcc-mingw-w64 4.8.2
>>>   g++-mingw-w64 4.8.2
>>>
>>
>> I'm afraid, it's not possible to build openvpn with mingw-gcc-4.8.X due
>> to lack of firewall manipulation api
>> (that's why we use xenial repo during travis-ci build)
>>
>
> Good to know mingw-w64 from xenial is used in the travis-ci script.
>
> I did a quick test on ubuntu trusty (14.04.05 LTS),  and as you pointed
> out, it fails while
> compiling block_dns.c because of some errors in the headers for the
> windows filtering platform API. All the bits are there so its possible to
> build
> after tweaking the installed headers (only a couple of lines) but not
> something
> one would normally want to do.
>
> It does look like targeting 14.04 is no more relevant.
>

it used to work on 14.04 ... with patched debs (header issue is relatively
easy to fix)

however, it does not work now because of not supporting Vista things


yes, 16.04 is just fine


>
> Selva
>

--001a114a91be982a71055bad6af9
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">2017-10-16 20:33 GMT+05:00 Selva <span dir=3D"ltr">&lt;<a href=3D"mailt=
o:selva.nair@...277..." target=3D"_blank">selva.nair@...277...</a>&gt;</spa=
n>:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-=
left:1px #ccc solid;padding-left:1ex"><div dir=3D"ltr"><br><div class=3D"gm=
ail_extra">Hi=C2=A0</div><div class=3D"gmail_extra"><br><div class=3D"gmail=
_quote"><span class=3D"">On Mon, Oct 16, 2017 at 4:22 AM, =D0=98=D0=BB=D1=
=8C=D1=8F =D0=A8=D0=B8=D0=BF=D0=B8=D1=86=D0=B8=D0=BD <span dir=3D"ltr">&lt;=
<a href=3D"mailto:chipitsine@...277..." target=3D"_blank"><span id=3D"m_706=
9633959543461732:2cz.1">chipitsine</span>@gmail.com</a>&gt;</span> wrote:<b=
r></span><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;borde=
r-left:1px #ccc solid;padding-left:1ex"><div dir=3D"ltr"><br><div class=3D"=
gmail_extra"><br><div class=3D"gmail_quote"><div><div class=3D"m_7069633959=
543461732m_4654747034667883082h5"><span class=3D"">2017-10-16 13:05 GMT+05:=
00 Samuli Sepp=C3=A4nen <span dir=3D"ltr">&lt;<a href=3D"mailto:samuli@...1696...=
15..." target=3D"_blank">samuli@...515...</a>&gt;</span>:<br></span><blockq=
uote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc =
solid;padding-left:1ex"><span class=3D""><span>On 13/10/2017 20:48, Selva w=
rote:<br></span></span><span class=3D""><div><div class=3D"m_70696339595434=
61732m_4654747034667883082m_3741800002398384404h5"><br>
&gt; @samuli: Which versions of mingw-w64 should we test against to ensure<=
br>
&gt; release and snapshot builds would succeed?<br>
<br>
</div></div>Right now _we_ use Ubuntu 16.04 for building:<br>
<br>
=C2=A0 mingw-w64 4.0.4<br>
=C2=A0 gcc-mingw-w64 5.3.1<br>
=C2=A0 g++-mingw-w64 5.3.1<br>
<br>
That said, I&#39;m pretty sure many people still build with Ubuntu 14.04. S=
o<br>
keeping support for it would make sense if it is not horribly painful.<br>
This is what Ubuntu 14.04 comes with:<br>
<br>
=C2=A0 mingw-w64 3.1.0<br>
=C2=A0 gcc-mingw-w64 4.8.2<br>
=C2=A0 g++-mingw-w64 4.8.2<br></span></blockquote><div><br></div></div></di=
v><span class=3D""><div>I&#39;m afraid, it&#39;s not possible to build open=
vpn with mingw-gcc-4.8.X due to lack of firewall manipulation api<br></div>=
<div>(that&#39;s why we use xenial repo during travis-ci build)<br></div></=
span></div></div></div></blockquote><div><br></div><div>Good to know mingw-=
w64 from xenial is used in the travis-ci script.</div><div>=C2=A0</div><div=
>I did a quick test on <span id=3D"m_7069633959543461732:2cz.2">ubuntu</spa=
n>=C2=A0trusty (14.04.05 LTS), =C2=A0and as you pointed out, it fails while=
</div><div>compiling block_<span id=3D"m_7069633959543461732:2cz.3">dns</sp=
an>.c because of some errors in the headers for the</div><div>windows filte=
ring platform API. All the bits are there so its possible to build</div><di=
v>after tweaking the installed headers (only a couple of lines) but not som=
ething</div><div>one would normally want to do.</div><div><br></div><div>It=
 does look like targeting 14.04 is no more relevant.</div></div></div></div=
></blockquote><div><br></div><div>it used to work on 14.04 ... with patched=
 debs (header issue is relatively easy to fix)<br><br></div><div>however, i=
t does not work now because of not supporting Vista things<br><br><br></div=
><div>yes, 16.04 is just fine<br></div><div>=C2=A0</div><blockquote class=
=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padd=
ing-left:1ex"><div dir=3D"ltr"><div class=3D"gmail_extra"><div class=3D"gma=
il_quote"><span class=3D"HOEnZb"><font color=3D"#888888"><div><br></div><di=
v><span id=3D"m_7069633959543461732:2cz.6">Selva</span></div></font></span>=
</div></div></div>
</blockquote></div><br></div></div>

--001a114a91be982a71055bad6af9--

