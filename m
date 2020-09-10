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
 <CAAF3xa8T=mmZUQdyF3=AZMZZf46TJ85zH=WwAm7ORZiiGGWqZg@...278...>
 <CAKuzo_iTQWBA3t=to4sKdt21pxotNECVfTMFP_fhrEeQ3ejnQQ@...278...>
 <CAAF3xa_Jz1bjw52zBLLdXjgMymk8q+47kt9R8bP8K9Fpt8+s3g@...278...>
 <CAKuzo_jj0SXCVLrthzeCJddK2iKKXAAg4SGTA_pNRXYqcJfTQw@...278...>
In-Reply-To: <CAKuzo_jj0SXCVLrthzeCJddK2iKKXAAg4SGTA_pNRXYqcJfTQw@...278...>
From: Marvin <volleynbike@...277...>
Date: Wed, 9 Sep 2020 21:19:18 -0700
Message-ID: <CAAF3xa-fQ_m=Tow44wqf3DMqWEq9z90n+6Xgg6NvW-UdTaVjHQ@...278...>
Content-Type: multipart/alternative; boundary="000000000000dc34cd05aeeddf10"
Subject: Re: [Openvpn-devel] [PATCH] Fix client's poor man NCP fallback
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva Nair <selva.nair@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--000000000000dc34cd05aeeddf10
Content-Type: text/plain; charset="UTF-8"

Hi Selva,

The GUI did not have this error unless run as administrator which you
> should not and will never work.

So you are saying that if OpenVPN is installed by a user who has admin
privileges (as our case does) that v2.5 with wintun will not work?

On Wed, Sep 9, 2020 at 6:03 PM Selva Nair <selva.nair@...277...> wrote:

> Hi
>
> On Wed, Sep 9, 2020 at 8:30 PM Marvin <volleynbike@...277...> wrote:
>
>> Selva,
>>
>> Sorry for the wrong thread.  I was replying to an earlier thread about
>> this same error on Beta1 and beta2.  So i am a bit confused by your
>> statement that this error did not show up in earlier betas, because that's
>> what started this thread.
>>
>
> The GUI did not have this error unless run as administrator which you
> should not and will never work.
>
> What was fixed was the error generated even when run as SYSTEM from the
> automatic service or on command line using psexec or other tools that can
> elevate to SYSTEM.
>
> Selva
>
>>
>> Marvin
>>
>> On Wed, Sep 9, 2020 at 5:14 PM Selva Nair <selva.nair@...277...> wrote:
>>
>>> Hi Marvin,
>>>
>>> This is the wrong thread, but...
>>>
>>> On Wed, Sep 9, 2020 at 7:54 PM Marvin <volleynbike@...277...> wrote:
>>>
>>>> Hi Guys,
>>>>
>>>> I just tested beta3 on Win10.  I am getting the exact same error with
>>>> wintun as before.  TAP works normally.  I tried with the GUI and by cli.
>>>>
>>>
>>> The GUI never generated this error even before beta3, so not sure what
>>> you are doing wrong. Ensure that the interactive service is running (that's
>>> the default) and  GUI is not started with admin privileges (do not start
>>> the GUI from an elevated command line or using run as admin).
>>>
>>> For cli you will get this error unless you use some utility like psexec
>>> to elevate to SYSTEM.
>>>
>>> For connections started at boot using OpenVPNService (not the same as
>>> the interactive service used by the GUI) beta3 should work. There was a bug
>>> that affected this use case which was fixed in beta3.
>>>
>>>
>>>> 2020-09-09 16:23:20 us=991306 ERROR:  Wintun requires SYSTEM privileges
>>>> and therefore should be used with interactive service. If you want to use
>>>> openvpn from command line, you need to do SYSTEM elevation yourself (for
>>>> example with psexec).
>>>> 2020-09-09 16:23:20 us=991306 Exiting due to fatal error
>>>>
>>>
>>> If you got this error running from the command line as SYSTEM please
>>> check the logs to be sure its beta3.
>>>
>>> Selva
>>>
>>>

--000000000000dc34cd05aeeddf10
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi=C2=A0Selva,<div><br></div><blockquote class=3D"gmail_qu=
ote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,20=
4);padding-left:1ex">The GUI did not have this error unless run as administ=
rator which you should not and will never work.=C2=A0=C2=A0=C2=A0</blockquo=
te><div>So you are saying that if OpenVPN is installed by a user who has ad=
min privileges=C2=A0(as our case does) that v2.5 with wintun will not work?=
</div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_=
attr">On Wed, Sep 9, 2020 at 6:03 PM Selva Nair &lt;<a href=3D"mailto:selva=
.nair@...277...">selva.nair@...277...</a>&gt; wrote:<br></div><blockquote c=
lass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px soli=
d rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr"><div>Hi</div><br><div=
 class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Sep 9,=
 2020 at 8:30 PM Marvin &lt;<a href=3D"mailto:volleynbike@...277..." target=
=3D"_blank">volleynbike@...277...</a>&gt; wrote:<br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex"><div dir=3D"ltr">Selva,<div><br></div><div=
>Sorry for the wrong thread.=C2=A0 I was replying to an earlier thread abou=
t this same error on Beta1 and beta2.=C2=A0 So i am a bit=C2=A0confused by =
your statement that this error did not show up in earlier betas, because th=
at&#39;s what started this thread.</div></div></blockquote><div><br></div><=
div>The GUI did not have this error unless run as administrator which you s=
hould not and will never work.=C2=A0</div><div><br></div><div>What was fixe=
d was the error generated even when run as SYSTEM from the automatic servic=
e or on command line=C2=A0using psexec or other tools that can elevate to S=
YSTEM.</div><div><br></div><div>Selva=C2=A0</div><blockquote class=3D"gmail=
_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204=
,204);padding-left:1ex"><div dir=3D"ltr"><div><br></div><div>Marvin</div></=
div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On=
 Wed, Sep 9, 2020 at 5:14 PM Selva Nair &lt;<a href=3D"mailto:selva.nair@...1186...=
.277..." target=3D"_blank">selva.nair@...277...</a>&gt; wrote:<br></div><bl=
ockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-lef=
t:1px solid rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr"><div dir=3D=
"ltr">Hi Marvin,<div><br></div><div>This is the=C2=A0wrong thread, but...</=
div><div>=C2=A0</div></div><div class=3D"gmail_quote"><div dir=3D"ltr" clas=
s=3D"gmail_attr">On Wed, Sep 9, 2020 at 7:54 PM Marvin &lt;<a href=3D"mailt=
o:volleynbike@...277..." target=3D"_blank">volleynbike@...277...</a>&gt; wr=
ote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px=
 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><div dir=3D=
"ltr">Hi Guys,<div><br></div><div>I just tested beta3 on Win10.=C2=A0 I am =
getting the exact same error with wintun as before.=C2=A0 TAP works normall=
y.=C2=A0 I tried with the GUI and by cli.</div></div></blockquote><div><br>=
</div><div>The GUI never generated this error even before beta3, so not sur=
e what you are doing wrong. Ensure that the interactive service is running =
(that&#39;s the default) and=C2=A0 GUI is not started with admin privileges=
 (do not start the GUI from an elevated command line or using run as admin)=
.</div><div><br></div><div>For cli you will get this error unless you use s=
ome utility like psexec to elevate to SYSTEM.=C2=A0</div><div><br></div><di=
v>For connections=C2=A0started at boot using OpenVPNService (not the same a=
s the interactive service used by the GUI) beta3 should work. There was a b=
ug that affected this use case which was fixed in beta3.<br></div><div><br>=
</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;b=
order-left:1px solid rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr"><d=
iv><br></div><div>2020-09-09 16:23:20 us=3D991306 ERROR: =C2=A0Wintun requi=
res SYSTEM privileges and therefore should be used with interactive service=
. If you want to use openvpn from command line, you need to do SYSTEM eleva=
tion yourself (for example with psexec).<br>2020-09-09 16:23:20 us=3D991306=
 Exiting due to fatal error<br></div></div></blockquote><div><br></div><div=
>If you got this error running from the command line as SYSTEM please check=
 the logs to be sure its beta3.</div><div><br></div><div>Selva</div><div><b=
r></div></div></div>
</blockquote></div>
</blockquote></div></div>
</blockquote></div>

--000000000000dc34cd05aeeddf10--

