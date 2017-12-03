MIME-Version: 1.0
In-Reply-To: <CAKuzo_g+8=-S_i1tDjLtHQ36ext9o6zCGszwBCZmwb4AS5as+Q@...278...>
References: <CAKuzo_iOXui4WDuRqf6-NybpfeWNjKR3GLn7dsw98FoNoSHNMw@...278...>
 <20171105223714.7852-1-simon@...2293...>
 <CAKuzo_gsuMMhThtx4UvWoHP9ipT4x_KEFewBxh00z=h4xkc4ow@...278...>
 <99D61A626FDA8A4B90A270669121BE1085882F90@...2294...>
 <CAKuzo_jDTZ41vrpZYPtzkW51=2a9X90qtwYnkGGXx85QVJceZg@...278...>
 <99D61A626FDA8A4B90A270669121BE1085884910@...2294...>
 <CAKuzo_g+8=-S_i1tDjLtHQ36ext9o6zCGszwBCZmwb4AS5as+Q@...278...>
From: Selva Nair <selva.nair@...277...>
Date: Sun, 3 Dec 2017 11:15:04 -0500
Message-ID: <CAKuzo_ivgZaJ5pDkn4jtoph51KyfV3p7oTm3Mws3TAw55-vmbQ@...278...>
Content-Type: multipart/alternative; boundary="94eb2c05fc52c8d2bb055f71e887"
Subject: Re: [Openvpn-devel] [PATCH v2] openvpnserv: Add support for
 multi-instances
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Simon Rozman <simon@...2293...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--94eb2c05fc52c8d2bb055f71e887
Content-Type: text/plain; charset="UTF-8"

Hi Simon,

IIRC, this patch is waiting for a new version to take care of the static
const as
agreed below:

On Thu, Nov 9, 2017 at 11:12 AM, Selva <selva.nair@...277...> wrote:

> Hi Simon,
>
> On Thu, Nov 9, 2017 at 3:33 AM, Simon Rozman <simon@...2293...> wrote:
>
>> Hi,
>>
>> > But then making the variable static just to keep a valid pointer beyond
>> the
>> > current block local looks like a kludge. For me seeing static applied
>> to a
>> > variable scoped to a block is just confusing and unusual style. Think
>> of this: if
>> > you remove that static the code may still build and even work on some
>> > compilers depending on optimization level etc. and mysteriously fail on
>> some
>> > occasions. From that one could either conclude a static qualifier is
>> required
>> > her or the variable is wrongly scoped. I think the latter conclusion is
>> the 'right'
>> > one and static is a misuse.
>> >
>> > As for the combination 'static const ...', it has a place and that is
>> for constants
>> > defined outside functions to limit the scope of an otherwise  global
>> const to
>> > that of the compilation unit.
>> >
>> > It may be just me.
>>
>> Not necessarily. It may be just *me*. :)
>>
>> Anyway, you got me convinced and I shall move those structs from data
>> segment to stack in the next version of the patch.
>
>
>  Glad that I don't have to invent an Acked-with-reservations: tag :)
>

I suppose a v4 is coming.

Thanks,

Selva

--94eb2c05fc52c8d2bb055f71e887
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Simon,<div><br></div><div>IIRC, this patch is waiting f=
or a new version to take care of the static const as</div><div>agreed below=
:</div><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">On Thu, No=
v 9, 2017 at 11:12 AM, Selva <span dir=3D"ltr">&lt;<a href=3D"mailto:selva.=
nair@...277..." target=3D"_blank">selva.nair@...277...</a>&gt;</span> wrote=
:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-le=
ft:1px #ccc solid;padding-left:1ex"><div dir=3D"ltr">Hi Simon,<br><div clas=
s=3D"gmail_extra"><br><div class=3D"gmail_quote"><span class=3D"">On Thu, N=
ov 9, 2017 at 3:33 AM, Simon Rozman <span dir=3D"ltr">&lt;<a href=3D"mailto=
:simon@...2293..." target=3D"_blank">simon@...2293...</a>&gt;</span> wrote:=
<br><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bor=
der-left:1px solid rgb(204,204,204);padding-left:1ex">Hi,<br>
<span class=3D"m_-5862847669999624797gmail-"><br>
&gt; But then making the variable static just to keep a valid pointer beyon=
d the<br>
&gt; current block local looks like a kludge. For me seeing static applied =
to a<br>
&gt; variable scoped to a block is just confusing and unusual style. Think =
of this: if<br>
&gt; you remove that static the code may still build and even work on some<=
br>
&gt; compilers depending on optimization level etc. and mysteriously fail o=
n some<br>
&gt; occasions. From that one could either conclude a static qualifier is r=
equired<br>
&gt; her or the variable is wrongly scoped. I think the latter conclusion i=
s the &#39;right&#39;<br>
&gt; one and static is a misuse.<br>
&gt;<br>
&gt; As for the combination &#39;static const ...&#39;, it has a place and =
that is for constants<br>
&gt; defined outside functions to limit the scope of an otherwise =C2=A0glo=
bal const to<br>
&gt; that of the compilation unit.<br>
&gt;<br>
&gt; It may be just me.<br>
<br>
</span>Not necessarily. It may be just *me*. :)<br>
<br>
Anyway, you got me convinced and I shall move those structs from data segme=
nt to stack in the next version of the patch.</blockquote><div><br></div></=
span><div>=C2=A0Glad that I don&#39;t have to invent an Acked-with-reservat=
ions: tag :)=C2=A0</div></div></div></div></blockquote><div><br></div><div>=
I suppose a v4 is coming.</div><div><br></div><div>Thanks,</div><div><br></=
div><div>Selva</div></div></div></div>

--94eb2c05fc52c8d2bb055f71e887--

