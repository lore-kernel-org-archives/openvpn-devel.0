MIME-Version: 1.0
References: <20200814080619.2108-1-arne@...1227...>
 <CAAWBBYM2+4FqN-HyV9W19fJfAHKd9K4KHhnQFz2_5f3tzdvMFA@...278...>
 <20200829194728.GU75094@...1296...>
 <CAAWBBYM+8YfP9-nwAsPYM806CzQXoy_5d+9MLkfyGPatE3BTAQ@...278...>
 <20200830120703.GV75094@...1296...>
 <20200830203720.GX75094@...1296...>
 <CAAWBBYMnFOBo4pp_iZ-KnYu7pHbiLqYQJ3rKO1RF+yXcvivgYg@...278...>
 <20200831132357.GZ75094@...1296...>
 <CAAWBBYNLPWmjJ3whY6FAj2G8tT_qkPWZR-gUsKFHe1memta2Og@...278...>
In-Reply-To: <CAAWBBYNLPWmjJ3whY6FAj2G8tT_qkPWZR-gUsKFHe1memta2Og@...278...>
From: Marvin <volleynbike@...277...>
Date: Wed, 9 Sep 2020 16:53:23 -0700
Message-ID: <CAAF3xa8T=mmZUQdyF3=AZMZZf46TJ85zH=WwAm7ORZiiGGWqZg@...278...>
Content-Type: multipart/alternative; boundary="000000000000d18ccd05aeea28d1"
Subject: Re: [Openvpn-devel] [PATCH] Fix client's poor man NCP fallback
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Rafael Gava <gava100@...277...>
Cc: Gert Doering <gert@...1296...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--000000000000d18ccd05aeea28d1
Content-Type: text/plain; charset="UTF-8"

Hi Guys,

I just tested beta3 on Win10.  I am getting the exact same error with
wintun as before.  TAP works normally.  I tried with the GUI and by cli.

2020-09-09 16:23:20 us=991306 ERROR:  Wintun requires SYSTEM privileges and
therefore should be used with interactive service. If you want to use
openvpn from command line, you need to do SYSTEM elevation yourself (for
example with psexec).
2020-09-09 16:23:20 us=991306 Exiting due to fatal error

Marvin

On Mon, Aug 31, 2020 at 7:13 AM Rafael Gava <gava100@...277...> wrote:

> Hi Gert,
>
> Glad that we could help! :-)
>
> If you guys need anything else that we can help, please let us know.
>
> BR
>
> Gava
>
> On Mon, Aug 31, 2020 at 10:23 AM Gert Doering <gert@...1296...> wrote:
>
>> Hi,
>>
>> On Sun, Aug 30, 2020 at 09:26:10PM -0300, Rafael Gava wrote:
>> > Good news, it worked beautifully with tun and tap interfaces!
>> >
>> > Thank you very much!!!!
>>
>> Cool, thanks for testing.  I have just tagged 2.5_beta3, and lev/mattock
>> will go about building a beta3 .msi with it (and hopefully lots of other
>> windows specific fixes :-) ).
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
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>

--000000000000d18ccd05aeea28d1
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Guys,<div><br></div><div>I just tested beta3 on Win10.=
=C2=A0 I am getting the exact same error with wintun as before.=C2=A0 TAP w=
orks normally.=C2=A0 I tried with the GUI and by cli.</div><div><br></div><=
div>2020-09-09 16:23:20 us=3D991306 ERROR: =C2=A0Wintun requires SYSTEM pri=
vileges and therefore should be used with interactive service. If you want =
to use openvpn from command line, you need to do SYSTEM elevation yourself =
(for example with psexec).<br>2020-09-09 16:23:20 us=3D991306 Exiting due t=
o fatal error<br></div><div><br></div><div>Marvin</div></div><br><div class=
=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Aug 31, 2020=
 at 7:13 AM Rafael Gava &lt;<a href=3D"mailto:gava100@...277...">gava100@...1186...=
.277...</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"=
margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-lef=
t:1ex"><div dir=3D"ltr"><div>Hi Gert,=C2=A0</div><div><br></div><div>Glad t=
hat we could help! :-)</div><div><br></div><div>If you guys need anything e=
lse that we can help, please let us know.</div><div><br></div><div>BR</div>=
<div><br></div><div>Gava</div></div><br><div class=3D"gmail_quote"><div dir=
=3D"ltr" class=3D"gmail_attr">On Mon, Aug 31, 2020 at 10:23 AM Gert Doering=
 &lt;<a href=3D"mailto:gert@...1296..." target=3D"_blank">gert@...1296...</=
a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0p=
x 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Hi=
,<br>
<br>
On Sun, Aug 30, 2020 at 09:26:10PM -0300, Rafael Gava wrote:<br>
&gt; Good news, it worked beautifully with tun and tap interfaces!<br>
&gt; <br>
&gt; Thank you very much!!!!<br>
<br>
Cool, thanks for testing.=C2=A0 I have just tagged 2.5_beta3, and lev/matto=
ck<br>
will go about building a beta3 .msi with it (and hopefully lots of other<br>
windows specific fixes :-) ).<br>
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
</blockquote></div>
_______________________________________________<br>
Openvpn-devel mailing list<br>
<a href=3D"mailto:Openvpn-devel@lists.sourceforge.net" target=3D"_blank">Op=
envpn-devel@lists.sourceforge.net</a><br>
<a href=3D"https://lists.sourceforge.net/lists/listinfo/openvpn-devel" rel=
=3D"noreferrer" target=3D"_blank">https://lists.sourceforge.net/lists/listi=
nfo/openvpn-devel</a><br>
</blockquote></div>

--000000000000d18ccd05aeea28d1--

