MIME-Version: 1.0
In-Reply-To: <CAKuzo_jvjZPk6VxwaR0_-HeSB7Segepv-1izEVgPiMe33R=YrQ@...278...>
References: <20171012072440.8704-1-simon@...2293...>
 <CAKuzo_jUnvMkHwHXZ=cAre-=z7WACU0b2qKV27FyymfBTncX=g@...278...>
 <99D61A626FDA8A4B90A270669121BE108580F7E3@...2294...>
 <CAKuzo_jPU1rubUTtbq61PB0YgJyjaw7DREEwVeRV9XwQPMykEA@...278...>
 <cc1449bf-ae57-f598-51af-2d3a59c2da1d@...515...>
 <CAFHpkQEgjmdRgMaOC-1-6vRqjYTUoC6fODtcx2yZt0DJUPGcsw@...278...>
 <CAKuzo_gHHupuSL9hLKyCUbMoFhedAFEPPuWMDsX1TV6d7=qm9A@...278...>
 <20171016165720.GL958@...1296...>
 <CAKuzo_jvjZPk6VxwaR0_-HeSB7Segepv-1izEVgPiMe33R=YrQ@...278...>
From: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Date: Mon, 16 Oct 2017 23:47:57 +0500
Message-ID: <CAFHpkQGz4KX0X-Obka=BfdXODT2uc5mDQYafYxEZhjn1ekNQMw@...278...>
Content-Type: multipart/alternative; boundary="001a114aa6d6fe85e0055bae7167"
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
Cc: Gert Doering <gert@...1296...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--001a114aa6d6fe85e0055bae7167
Content-Type: text/plain; charset="UTF-8"

2017-10-16 23:17 GMT+05:00 Selva <selva.nair@...277...>:

> Hi,
>
> On Mon, Oct 16, 2017 at 12:57 PM, Gert Doering <gert@...1296...>
> wrote:
>
>> Hi,
>>
>> On Mon, Oct 16, 2017 at 11:33:02AM -0400, Selva wrote:
>> > I did a quick test on ubuntu trusty (14.04.05 LTS),  and as you pointed
>> > out, it fails while
>> > compiling block_dns.c because of some errors in the headers for the
>> > windows filtering platform API. All the bits are there so its possible
>> to
>> > build
>> > after tweaking the installed headers (only a couple of lines) but not
>> > something
>> > one would normally want to do.
>> >
>> > It does look like targeting 14.04 is no more relevant.
>>
>> I have some sort of mixed feedback from Samuli's buildbots here - it
>> *used* to compile just fine, but since the latest patch (removing the
>> "manual" dynamic linking stuff), it fails with
>>
>> openvpnserv-interactive.o:interactive.c:(.text+0xee2): undefined
>> reference to `InitializeUnicastIpAddressEntry'
>>
>> ... so it seems 14.04 mingw does not truly expose all the Vista API bits.
>>
>
> My bad, I missed that warning when tested on a 14.04 instance (it was a
> google compute engine
> with 14.04.5 LTS image with mingw-w64 3.1.0). I do  now see that
> 'InitializeUnicastIpAddressEntry'
> is missing in there.
>
> As these buildbots used to succeed the other header issues I saw (an extra
> ifdef
> and a duplicate declaration) must be already patched in them.
>
> The function stub is there in the import library library
> (libiphlpapi.lib), so we could add
> VOID NETIOAPI_API_  InitializeUnicastIpAddressEntry
> (PMIB_UNICASTIPADDRESS_ROW Row);
> to interactive.c.
>
> But.
>
>
>> OTOH, we can just document "16.04 is what you need" - that would work
>> for me, as cross-building is really not "I have this <any breed of unix
>> OS> and want to build and run OpenVPN here!" building...   (I have much
>> stricter requirements wrt breaking platforms for "run here" builds :) )
>>
>
> I would prefer that option and and we just require 16.04 or better from
> now on.
>

based on the above, I would say that adding configure check for
"InitializeUnicastIpAddressEntry" would be nice (and making configure
gently complain like "please use Ubuntu 16.04")


>
> Selva
>
>

--001a114aa6d6fe85e0055bae7167
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">2017-10-16 23:17 GMT+05:00 Selva <span dir=3D"ltr">&lt;<a href=3D"mailt=
o:selva.nair@...277..." target=3D"_blank">selva.nair@...277...</a>&gt;</spa=
n>:<br><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;=
border-left:1px solid rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr"><=
div class=3D"gmail_extra">Hi,</div><div class=3D"gmail_extra"><br><div clas=
s=3D"gmail_quote"><span class=3D"gmail-">On Mon, Oct 16, 2017 at 12:57 PM, =
Gert Doering <span dir=3D"ltr">&lt;<a href=3D"mailto:gert@...1296..." targe=
t=3D"_blank">gert@...1296...</a>&gt;</span> wrote:<br><blockquote class=3D"=
gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(20=
4,204,204);padding-left:1ex">Hi,<br>
<span class=3D"gmail-m_-9066416347882930197m_2672371004063453133gmail-"><br>
On Mon, Oct 16, 2017 at 11:33:02AM -0400, Selva wrote:<br>
&gt; I did a quick test on ubuntu trusty (14.04.05 LTS),=C2=A0 and as you p=
ointed<br>
&gt; out, it fails while<br>
&gt; compiling block_dns.c because of some errors in the headers for the<br>
&gt; windows filtering platform API. All the bits are there so its possible=
 to<br>
&gt; build<br>
&gt; after tweaking the installed headers (only a couple of lines) but not<=
br>
&gt; something<br>
&gt; one would normally want to do.<br>
&gt;<br>
&gt; It does look like targeting 14.04 is no more relevant.<br>
<br>
</span>I have some sort of mixed feedback from Samuli&#39;s buildbots here =
- it<br>
*used* to compile just fine, but since the latest patch (removing the<br>
&quot;manual&quot; dynamic linking stuff), it fails with<br>
<br>
openvpnserv-interactive.o:inte<wbr>ractive.c:(.text+0xee2): undefined refer=
ence to `InitializeUnicastIpAddressEnt<wbr>ry&#39;<br>
<br>
... so it seems 14.04 mingw does not truly expose all the Vista API bits.<b=
r></blockquote><div><br></div></span><div>My bad, I missed that warning whe=
n tested on a 14.04 instance (it was a google compute engine</div><div>with=
 14.04.5 LTS image with mingw-w64 3.1.0). I do =C2=A0now see that &#39;Init=
ializeUnicastIpAddressEnt<wbr>ry&#39;</div><div>is missing in there.</div><=
div><br></div><div>As these buildbots used to succeed the other header issu=
es I saw (an extra ifdef</div><div>and a duplicate declaration) must be alr=
eady patched in them.</div><div><br></div><div>The function stub is there i=
n the import library library (libiphlpapi.lib), so we could add</div><div>V=
OID NETIOAPI_API_ =C2=A0<wbr>InitializeUnicastIpAddressEntr<wbr>y (PMIB_UNI=
CASTIPADDRESS_ROW Row);</div><div>to interactive.c.</div><div><br></div><di=
v>But.</div><span class=3D"gmail-"><div><br></div><blockquote class=3D"gmai=
l_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,20=
4,204);padding-left:1ex">
<br>
OTOH, we can just document &quot;16.04 is what you need&quot; - that would =
work<br>
for me, as cross-building is really not &quot;I have this &lt;any breed of =
unix<br>
OS&gt; and want to build and run OpenVPN here!&quot; building...=C2=A0 =C2=
=A0(I have much<br>
stricter requirements wrt breaking platforms for &quot;run here&quot; build=
s :) )<br></blockquote><div><br></div></span><div>I would prefer that optio=
n and and we just require 16.04 or better from<br></div><div>now on.</div><=
/div></div></div></blockquote><div><br></div><div>based on the above, I wou=
ld say that adding configure check for &quot;InitializeUnicastIpAddressEntr=
<wbr>y&quot; would be nice (and making configure gently complain like &quot=
;please use Ubuntu 16.04&quot;) </div><div>=C2=A0</div><blockquote class=3D=
"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(2=
04,204,204);padding-left:1ex"><div dir=3D"ltr"><div class=3D"gmail_extra"><=
div class=3D"gmail_quote"><span class=3D"gmail-HOEnZb"><font color=3D"#8888=
88"><div><br></div><div>Selva</div></font></span></div><br></div></div>
</blockquote></div><br></div></div>

--001a114aa6d6fe85e0055bae7167--

