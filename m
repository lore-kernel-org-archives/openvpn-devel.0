MIME-Version: 1.0
In-Reply-To: <CABT9mj9U0ewSBH=WqJ=nWgkBFGycL4R1Pw27bkhRG6WFgnpf8w@...278...>
References: <CAOBzU4PN6qDxf39+s4noXEiW8hNbDy-hkQWGSauBd3hX0pu2hw@...278...>
	<CAOazyz1DE7Y-P9HFK3LN8-HeoGbHzYeqofX3RiEuK0C-zcxnug@...278...>
	<CAOazyz0nV8P8Age_wyFCvu1J4g1MECA7YdTAAL4of7TTVctXow@...278...>
	<1CED409804E2164C8104F9E623B08B90129350BEDF@...1436...>
	<CAOazyz0daYPAH=ooKDenavTyG1qK1=wJv8ZJ0VF+u-vXWBE2xQ@...278...>
	<4F4B456A.8010208@...515...> <4F4B542D.9090309@...1114...>
	<CAOazyz1E809DFQ7-GBvopezmELL+SuW+A5A+EKgbXTsZTNVd8w@...278...>
	<4F4E6104.2000900@...1114...>
	<CAOazyz3fg_qSWb92ftSeq3Z7qN1fhfEBnuURfxenOsBbxGWQ4g@...278...>
	<CAOazyz1=87RqYEo=ovMtGkc1n=yh5VOQcc_YdM4nMHbQ8oNTNA@...278...>
	<CAOazyz2Svm8sG3kZMiMzH2hppNpRkQn2a_8NK9sGM0o9qCJKzg@...278...>
	<4F5720D3.7060309@...515...>
	<CAOazyz0Qopk1b8VRSobuui8QBZ3GNr5zbu4moa4abJZWyzaQWQ@...278...>
	<4F606088.8030607@...1114...>
	<CAOazyz2ZrDL-kaFa+Nc-aDcyWgOVJd82scypg9vZsZghvsY7Wg@...278...>
	<4F60903E.9090506@...515...>
	<CAOazyz3hA9LPCq0sEOWbY30PwjwxPUyCkDFWWq9x4S3dxfYVXw@...278...>
	<CABT9mj-YbHc_5w_hPBo2DNQ_TA_0dP3Py9ue9JZ32UXg0A4YEg@...278...>
	<CABT9mj9U0ewSBH=WqJ=nWgkBFGycL4R1Pw27bkhRG6WFgnpf8w@...278...>
Date: Wed, 14 Mar 2012 19:01:09 +0200
Message-ID: <CABT9mj8mywqhyiwh_y6zTtxPN8EHeT-M=1er73OD9kdHm87kBQ@...278...>
From: Athanasios Douitsis <aduitsis@...277...>
Content-Type: multipart/alternative; boundary=047d7b34429e0e6d4d04bb36ec23
Subject: Re: [Openvpn-devel] [PATCH 00/35] build revolution
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Alon Bar-Lev <alon.barlev@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <Openvpn-devel@lists.sourceforge.net>

--047d7b34429e0e6d4d04bb36ec23
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

Right, works, at least for me. I managed to get an openvpn binary.

May I ask, how did you convert the previous sln file with VC express 2010?
Or it was already compatible with VC2010?

On Wed, Mar 14, 2012 at 5:13 PM, Athanasios Douitsis <aduitsis@...277...>wr=
ote:

> Alon,
>
> Thank you very much for the very quick response, sooner or later I'll let
> you know how it goes.
>
> Kind Regards,
> Athanasios
>
>
> On Wed, Mar 14, 2012 at 5:09 PM, Athanasios Douitsis <aduitsis@...277...>=
wrote:
>
>> Oh crap....I've just uninstalled VC2010 from my builder :) :) :)
>>
>>
>> 2012/3/14 Alon Bar-Lev <alon.barlev@...277...>
>>
>>> Thanks.
>>>
>>> In the mean time I upgraded the VC support for 2010 (and above?
>>> hopefully).
>>>
>>> Athanasios, you may try again.
>>>
>>> Alon.
>>>
>>> 2012/3/14 Samuli Sepp=E4nen <samuli@...515...>
>>> >
>>> > Il 14.03.2012 11:13, Alon Bar-Lev ha scritto:
>>> > > On Wed, Mar 14, 2012 at 11:10 AM, David Sommerseth
>>> > > <openvpn.list@...1114...> wrote:
>>> > >> -----BEGIN PGP SIGNED MESSAGE-----
>>> > >> Hash: SHA1
>>> > >>
>>> > >> On 14/03/12 09:33, Alon Bar-Lev wrote:
>>> > >>> As the mingw build is the formal build, there is no reason to keep
>>> > >>> supporting old visual studio configurations.
>>> > >> That's debatable.  James Yonan is using MSVC for the OpenVPN AS
>>> client,
>>> > >> and has indicated that he wanted that.  I don't know much more than
>>> > >> this,
>>> > >> but it might be related to his concerns about the old mingw32 tool
>>> > >> chain
>>> > >> not being too well maintained.  I know that's not an issue with the
>>> > >> mingw64 stuff.
>>> > >>
>>> > >> However, currently the official tool chain is MSVC for Windows
>>> builds.
>>> > >> All other platforms uses the autotools toolchain.  We can surely
>>> > >> discuss
>>> > >> if this is the right discussion, but that's a discussion where Jam=
es
>>> > >> will
>>> > >> have the final word.
>>> > >>
>>> > >> - From my perspective, the less toolchains we need to care about,
>>> the
>>> > >> better.  But we are not in a position where we can overrule James'
>>> > >> decisions, especially not without involving him in the discussion.
>>> > > So please involve.
>>> > > Again, I did not wrote to remove MSVC, just to support 2010 and
>>> above.
>>> > >
>>> > > Alon.
>>> > I'll try to involve him in this week's or next week's IRC meeting :).
>>> >
>>> > Personally, I got the feeling that the Python-based MSVC buildsystem =
he
>>> > started writing (and which I finished) was a reaction to the general
>>> > crappiness of OpenVPN Windows buildsystem(s). And that should not be =
an
>>> > argument after the new "generic" buildsystem is merged.
>>> >
>>> > --
>>> > Samuli Sepp=E4nen
>>> > Community Manager
>>> > OpenVPN Technologies, Inc
>>> >
>>> > irc freenode net: mattock
>>> >
>>>
>>
>>
>>
>> --
>> Athanasios Douitsis
>>
>>
>>
>>
>
>
> --
> Athanasios Douitsis
>
>
>
>


--=20
Athanasios Douitsis

--047d7b34429e0e6d4d04bb36ec23
Content-Type: text/html; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

Right, works, at least for me. I managed to get an openvpn binary. <br><br>=
May I ask, how did you convert the previous sln file with VC express 2010? =
Or it was already compatible with VC2010? <br><br><div class=3D"gmail_quote=
">
On Wed, Mar 14, 2012 at 5:13 PM, Athanasios Douitsis <span dir=3D"ltr">&lt;=
<a href=3D"mailto:aduitsis@...277...">aduitsis@...277...</a>&gt;</span> wro=
te:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-=
left:1px #ccc solid;padding-left:1ex">
Alon, <br><br>Thank you very much for the very quick response, sooner or la=
ter I&#39;ll let you know how it goes.<br><br>Kind Regards,<br>Athanasios<d=
iv class=3D"HOEnZb"><div class=3D"h5"><br><br><div class=3D"gmail_quote">On=
 Wed, Mar 14, 2012 at 5:09 PM, Athanasios Douitsis <span dir=3D"ltr">&lt;<a=
 href=3D"mailto:aduitsis@...277..." target=3D"_blank">aduitsis@...277...</a=
>&gt;</span> wrote:<br>

<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">Oh crap....I&#39;ve just uninstalled VC2010 =
from my builder :) :) :)=A0 <br><div><div><br><br><div class=3D"gmail_quote=
">
2012/3/14 Alon Bar-Lev <span dir=3D"ltr">&lt;<a href=3D"mailto:alon.barlev@=
...277..." target=3D"_blank">alon.barlev@...277...</a>&gt;</span><br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">Thanks.<br>
<br>
In the mean time I upgraded the VC support for 2010 (and above? hopefully).=
<br>
<br>
Athanasios, you may try again.<br>
<span><font color=3D"#888888"><br>
Alon.<br>
</font></span><div><div><br>
2012/3/14 Samuli Sepp=E4nen &lt;<a href=3D"mailto:samuli@...515..." target=
=3D"_blank">samuli@...515...</a>&gt;<br>
&gt;<br>
&gt; Il 14.03.2012 11:13, Alon Bar-Lev ha scritto:<br>
&gt; &gt; On Wed, Mar 14, 2012 at 11:10 AM, David Sommerseth<br>
&gt; &gt; &lt;<a href=3D"mailto:openvpn.list@...1114..." target=3D"_blank">=
openvpn.list@...1114...</a>&gt; wrote:<br>
&gt; &gt;&gt; -----BEGIN PGP SIGNED MESSAGE-----<br>
&gt; &gt;&gt; Hash: SHA1<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; On 14/03/12 09:33, Alon Bar-Lev wrote:<br>
&gt; &gt;&gt;&gt; As the mingw build is the formal build, there is no reaso=
n to keep<br>
&gt; &gt;&gt;&gt; supporting old visual studio configurations.<br>
&gt; &gt;&gt; That&#39;s debatable. =A0James Yonan is using MSVC for the Op=
enVPN AS client,<br>
&gt; &gt;&gt; and has indicated that he wanted that. =A0I don&#39;t know mu=
ch more than<br>
&gt; &gt;&gt; this,<br>
&gt; &gt;&gt; but it might be related to his concerns about the old mingw32=
 tool<br>
&gt; &gt;&gt; chain<br>
&gt; &gt;&gt; not being too well maintained. =A0I know that&#39;s not an is=
sue with the<br>
&gt; &gt;&gt; mingw64 stuff.<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; However, currently the official tool chain is MSVC for Window=
s builds.<br>
&gt; &gt;&gt; All other platforms uses the autotools toolchain. =A0We can s=
urely<br>
&gt; &gt;&gt; discuss<br>
&gt; &gt;&gt; if this is the right discussion, but that&#39;s a discussion =
where James<br>
&gt; &gt;&gt; will<br>
&gt; &gt;&gt; have the final word.<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; - From my perspective, the less toolchains we need to care ab=
out, the<br>
&gt; &gt;&gt; better. =A0But we are not in a position where we can overrule=
 James&#39;<br>
&gt; &gt;&gt; decisions, especially not without involving him in the discus=
sion.<br>
&gt; &gt; So please involve.<br>
&gt; &gt; Again, I did not wrote to remove MSVC, just to support 2010 and a=
bove.<br>
&gt; &gt;<br>
&gt; &gt; Alon.<br>
&gt; I&#39;ll try to involve him in this week&#39;s or next week&#39;s IRC =
meeting :).<br>
&gt;<br>
&gt; Personally, I got the feeling that the Python-based MSVC buildsystem h=
e<br>
&gt; started writing (and which I finished) was a reaction to the general<b=
r>
&gt; crappiness of OpenVPN Windows buildsystem(s). And that should not be a=
n<br>
&gt; argument after the new &quot;generic&quot; buildsystem is merged.<br>
&gt;<br>
&gt; --<br>
&gt; Samuli Sepp=E4nen<br>
&gt; Community Manager<br>
&gt; OpenVPN Technologies, Inc<br>
&gt;<br>
&gt; irc freenode net: mattock<br>
&gt;<br>
</div></div></blockquote></div><br><br clear=3D"all"><br></div></div><span>=
<font color=3D"#888888">-- <br>Athanasios Douitsis<br><br><br><br>
</font></span></blockquote></div><br><br clear=3D"all"><br></div></div><spa=
n class=3D"HOEnZb"><font color=3D"#888888">-- <br>Athanasios Douitsis<br><b=
r><br><br>
</font></span></blockquote></div><br><br clear=3D"all"><br>-- <br>Athanasio=
s Douitsis<br><br><br><br>

--047d7b34429e0e6d4d04bb36ec23--

