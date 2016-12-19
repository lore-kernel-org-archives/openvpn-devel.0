MIME-Version: 1.0
In-Reply-To: <9048486e-03d9-7aa1-74f8-892a9cc7c1ee@...515...>
References: <CAFHpkQEKrJqNB2ZmhAwKGebVb6SB75HpnWcrw_niSaALL_S4mA@...278...>
	<CAA1AbxJZL70qY=ivMvskeUapj0V_+z_LVnM2Zp2LxAJT4t62vA@...278...>
	<CAFHpkQEnATPgCyxsLW6bpC5Qr-Cdh=+4X4MRXxgUD+orKpq+EQ@...278...>
	<20161121174953.GM28918@...1296...>
	<CAFHpkQFZD+hYzq_FW075wQt5AopcyCP20BEDzLsTx5Vq6uko3Q@...278...>
	<d48609b7-43df-80d5-a57f-e96e85ad4389@...2080...>
	<CAFHpkQHxVWvHSFK2hS7CV8ytUnxUHi5ZfjSOiuLBfWdufzMrCQ@...278...>
	<9048486e-03d9-7aa1-74f8-892a9cc7c1ee@...515...>
From: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Date: Mon, 19 Dec 2016 14:38:20 +0500
Message-ID: <CAFHpkQHtPm2gPfHYEngJoMymUxt8iOFA7L0z+p54oVSNEmEPFQ@...278...>
Content-Type: multipart/alternative; boundary=001a114b16b823b4fc0543ffae1f
Subject: Re: [Openvpn-devel] https://travis-ci.org/OpenVPN/openvpn/builds
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: =?UTF-8?Q?Samuli_Sepp=C3=A4nen?= <samuli@...515...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--001a114b16b823b4fc0543ffae1f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2016-12-19 14:11 GMT+05:00 Samuli Sepp=C3=A4nen <samuli@...515...>:

> Il 19/12/2016 10:22, =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=D0=B8=D1=
=86=D0=B8=D0=BD ha scritto:
>
>>
>>
>> 2016-11-27 4:29 GMT+05:00 David Sommerseth
>> <openvpn@...2080...
>> <mailto:openvpn@...2080...>>:
>>
>>     On 26/11/16 12:32, =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=D0=B8=
=D1=86=D0=B8=D0=BD wrote:
>>     >
>>     >
>>     > 2016-11-21 22:49 GMT+05:00 Gert Doering <gert@...1296...
>> <mailto:gert@...1296...>
>>     > <mailto:gert@...1296... <mailto:gert@...1296...>>>:
>>     >
>>     >     Hi,
>>     >
>>     >     On Mon, Nov 21, 2016 at 10:31:45PM +0500, ????????
>> ?????????????? wrote:
>>     >     > this line
>>     >     >
>>     >     > https://github.com/OpenVPN/openvpn/blob/master/tests/unit_
>> tests/openvpn/Makefile.am#L17
>>     <https://github.com/OpenVPN/openvpn/blob/master/tests/unit_
>> tests/openvpn/Makefile.am#L17>
>>     >     <https://github.com/OpenVPN/openvpn/blob/master/tests/unit_
>> tests/openvpn/Makefile.am#L17
>>     <https://github.com/OpenVPN/openvpn/blob/master/tests/unit_
>> tests/openvpn/Makefile.am#L17>>
>>     >     >
>>     >     > causes an error
>>     >
>>     >     GNU LD manpage says this is a trick to make it link "another
>> function"
>>     >     "--wrap parse_line" would make it link __wrap_parse_line()
>> instead -
>>     >     most likely because @d12fk provided a stub function that mocks
>> the
>>     >     result (or whatever).
>>     >
>>     >     Have not looked into this in more detail.
>>     >
>>     >
>>     > http://www.mockator.com/projects/mockator/wiki/Wrap_Functions
>>     <http://www.mockator.com/projects/mockator/wiki/Wrap_Functions>
>>     >
>>     > "Alas, this feature is *only available with the GNU tool chain on
>>     > Linux*. GCC for Mac OS X does not offer the linker flag |-wrap|. "
>>     >
>>     > should we skip those tests on osx ? or someone will rewrite them ?
>>
>>     I'd hold back a little bit.  I know Arne, Heiko and some people from
>>     #cmocka on FreeNode had a discussion about this issue earlier this
>> week.
>>      I don't know what they agreed on, but there was a discussion where
>> they
>>     looked at a few alternatives at least.
>>
>>
>>
>> any news on that ?
>>
>>
> We discussed this in previous IRC meeting, and there is still no real fix:
>
> <https://www.mail-archive.com/openvpn-devel@...1483...
> e.net/msg13558.html>
>
> The easiest "fix" would be to just disable cmocka unit tests for MacOS X
> in .travis.yml. I believe the unit tests behave exactly the same on every
> platform(?), so removing MacOS X would not have any negative impact on co=
de
> quality.
>
>
ok, can you send a patch on that ?


> --
> Samuli Sepp=C3=A4nen
> Community Manager
> OpenVPN Technologies, Inc
>
> irc freenode net: mattock
>

--001a114b16b823b4fc0543ffae1f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">2016-12-19 14:11 GMT+05:00 Samuli Sepp=C3=A4nen <span dir=3D"ltr">&lt;<=
a href=3D"mailto:samuli@...515..." target=3D"_blank">samuli@...515...</a>&g=
t;</span>:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;=
border-left:1px #ccc solid;padding-left:1ex"><span class=3D"">Il 19/12/2016=
 10:22, =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=D0=B8=D1=86=D0=B8=D0=BD=
 ha scritto:<br>
</span><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-=
left:1px #ccc solid;padding-left:1ex"><span class=3D"">
<br>
<br>
2016-11-27 4:29 GMT+05:00 David Sommerseth<br>
&lt;<a href=3D"mailto:openvpn@...2080..." target=3D"_blank">openvpn@...2193...=
...<wbr>.net</a><br></span>
&lt;mailto:<a href=3D"mailto:openvpn@...2080..." target=3D"_blank">openvpn@=
...2157...<wbr>emmelig.net</a>&gt;&gt;:<span class=3D""><br>
<br>
=C2=A0 =C2=A0 On 26/11/16 12:32, =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=
=BF=D0=B8=D1=86=D0=B8=D0=BD wrote:<br>
=C2=A0 =C2=A0 &gt;<br>
=C2=A0 =C2=A0 &gt;<br>
=C2=A0 =C2=A0 &gt; 2016-11-21 22:49 GMT+05:00 Gert Doering &lt;<a href=3D"m=
ailto:gert@...1296..." target=3D"_blank">gert@...1296...</a> &lt;mailto:<a =
href=3D"mailto:gert@...1296..." target=3D"_blank">gert@...1296...</a>&gt;<b=
r></span>
=C2=A0 =C2=A0 &gt; &lt;mailto:<a href=3D"mailto:gert@...1296..." target=3D"=
_blank">gert@...1296...</a> &lt;mailto:<a href=3D"mailto:gert@...1296..." t=
arget=3D"_blank">gert@...1296...</a>&gt;&gt;&gt;<wbr>:<span class=3D""><br>
=C2=A0 =C2=A0 &gt;<br>
=C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0Hi,<br>
=C2=A0 =C2=A0 &gt;<br>
=C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0On Mon, Nov 21, 2016 at 10:31:45PM +0=
500, ???????? ?????????????? wrote:<br>
=C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0&gt; this line<br>
=C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
=C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0&gt; <a href=3D"https://github.com/Op=
enVPN/openvpn/blob/master/tests/unit_tests/openvpn/Makefile.am#L17" rel=3D"=
noreferrer" target=3D"_blank">https://github.com/OpenVPN/ope<wbr>nvpn/blob/=
master/tests/unit_<wbr>tests/openvpn/Makefile.am#L17</a><br>
=C2=A0 =C2=A0 &lt;<a href=3D"https://github.com/OpenVPN/openvpn/blob/master=
/tests/unit_tests/openvpn/Makefile.am#L17" rel=3D"noreferrer" target=3D"_bl=
ank">https://github.com/OpenVPN/op<wbr>envpn/blob/master/tests/unit_<wbr>te=
sts/openvpn/Makefile.am#L17</a>&gt;<br>
=C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0&lt;<a href=3D"https://github.com/Ope=
nVPN/openvpn/blob/master/tests/unit_tests/openvpn/Makefile.am#L17" rel=3D"n=
oreferrer" target=3D"_blank">https://github.com/OpenVPN/o<wbr>penvpn/blob/m=
aster/tests/unit_<wbr>tests/openvpn/Makefile.am#L17</a><br>
=C2=A0 =C2=A0 &lt;<a href=3D"https://github.com/OpenVPN/openvpn/blob/master=
/tests/unit_tests/openvpn/Makefile.am#L17" rel=3D"noreferrer" target=3D"_bl=
ank">https://github.com/OpenVPN/op<wbr>envpn/blob/master/tests/unit_<wbr>te=
sts/openvpn/Makefile.am#L17</a>&gt;<wbr>&gt;<br>
=C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
=C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0&gt; causes an error<br>
=C2=A0 =C2=A0 &gt;<br>
=C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0GNU LD manpage says this is a trick t=
o make it link &quot;another function&quot;<br>
=C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0&quot;--wrap parse_line&quot; would m=
ake it link __wrap_parse_line() instead -<br>
=C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0most likely because @d12fk provided a=
 stub function that mocks the<br>
=C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0result (or whatever).<br>
=C2=A0 =C2=A0 &gt;<br>
=C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0Have not looked into this in more det=
ail.<br>
=C2=A0 =C2=A0 &gt;<br>
=C2=A0 =C2=A0 &gt;<br>
=C2=A0 =C2=A0 &gt; <a href=3D"http://www.mockator.com/projects/mockator/wik=
i/Wrap_Functions" rel=3D"noreferrer" target=3D"_blank">http://www.mockator.=
com/projec<wbr>ts/mockator/wiki/Wrap_Function<wbr>s</a><br>
=C2=A0 =C2=A0 &lt;<a href=3D"http://www.mockator.com/projects/mockator/wiki=
/Wrap_Functions" rel=3D"noreferrer" target=3D"_blank">http://www.mockator.c=
om/proje<wbr>cts/mockator/wiki/Wrap_Functio<wbr>ns</a>&gt;<br>
=C2=A0 =C2=A0 &gt;<br>
=C2=A0 =C2=A0 &gt; &quot;Alas, this feature is *only available with the GNU=
 tool chain on<br>
=C2=A0 =C2=A0 &gt; Linux*. GCC for Mac OS X does not offer the linker flag =
|-wrap|. &quot;<br>
=C2=A0 =C2=A0 &gt;<br>
=C2=A0 =C2=A0 &gt; should we skip those tests on osx ? or someone will rewr=
ite them ?<br>
<br>
=C2=A0 =C2=A0 I&#39;d hold back a little bit.=C2=A0 I know Arne, Heiko and =
some people from<br>
=C2=A0 =C2=A0 #cmocka on FreeNode had a discussion about this issue earlier=
 this week.<br>
=C2=A0 =C2=A0 =C2=A0I don&#39;t know what they agreed on, but there was a d=
iscussion where they<br>
=C2=A0 =C2=A0 looked at a few alternatives at least.<br>
<br>
<br>
<br>
any news on that ?<br>
<br>
</span></blockquote>
<br>
We discussed this in previous IRC meeting, and there is still no real fix:<=
br>
<br>
&lt;<a href=3D"https://www.mail-archive.com/openvpn-devel@...282...=
.net/msg13558.html" rel=3D"noreferrer" target=3D"_blank">https://www.mail-a=
rchive.com/<wbr>openvpn-devel@...1483...<wbr>e.net/msg13558.html</a>&gt;<br>
<br>
The easiest &quot;fix&quot; would be to just disable cmocka unit tests for =
MacOS X in .travis.yml. I believe the unit tests behave exactly the same on=
 every platform(?), so removing MacOS X would not have any negative impact =
on code quality.<span class=3D"HOEnZb"><font color=3D"#888888"><br>
<br></font></span></blockquote><div><br></div><div>ok, can you send a patch=
 on that ?<br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" styl=
e=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><span c=
lass=3D"HOEnZb"><font color=3D"#888888">
-- <br>
Samuli Sepp=C3=A4nen<br>
Community Manager<br>
OpenVPN Technologies, Inc<br>
<br>
irc freenode net: mattock<br>
</font></span></blockquote></div><br></div></div>

--001a114b16b823b4fc0543ffae1f--

