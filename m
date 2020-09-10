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
In-Reply-To: <CAKuzo_iTQWBA3t=to4sKdt21pxotNECVfTMFP_fhrEeQ3ejnQQ@...278...>
From: Marvin <volleynbike@...277...>
Date: Wed, 9 Sep 2020 17:30:35 -0700
Message-ID: <CAAF3xa_Jz1bjw52zBLLdXjgMymk8q+47kt9R8bP8K9Fpt8+s3g@...278...>
Content-Type: multipart/alternative; boundary="000000000000e5bb6605aeeaad8a"
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

--000000000000e5bb6605aeeaad8a
Content-Type: text/plain; charset="UTF-8"

Selva,

Sorry for the wrong thread.  I was replying to an earlier thread about this
same error on Beta1 and beta2.  So i am a bit confused by your statement
that this error did not show up in earlier betas, because that's what
started this thread.

Marvin

On Wed, Sep 9, 2020 at 5:14 PM Selva Nair <selva.nair@...277...> wrote:

> Hi Marvin,
>
> This is the wrong thread, but...
>
> On Wed, Sep 9, 2020 at 7:54 PM Marvin <volleynbike@...277...> wrote:
>
>> Hi Guys,
>>
>> I just tested beta3 on Win10.  I am getting the exact same error with
>> wintun as before.  TAP works normally.  I tried with the GUI and by cli.
>>
>
> The GUI never generated this error even before beta3, so not sure what you
> are doing wrong. Ensure that the interactive service is running (that's the
> default) and  GUI is not started with admin privileges (do not start the
> GUI from an elevated command line or using run as admin).
>
> For cli you will get this error unless you use some utility like psexec to
> elevate to SYSTEM.
>
> For connections started at boot using OpenVPNService (not the same as the
> interactive service used by the GUI) beta3 should work. There was a bug
> that affected this use case which was fixed in beta3.
>
>
>> 2020-09-09 16:23:20 us=991306 ERROR:  Wintun requires SYSTEM privileges
>> and therefore should be used with interactive service. If you want to use
>> openvpn from command line, you need to do SYSTEM elevation yourself (for
>> example with psexec).
>> 2020-09-09 16:23:20 us=991306 Exiting due to fatal error
>>
>
> If you got this error running from the command line as SYSTEM please check
> the logs to be sure its beta3.
>
> Selva
>
>

--000000000000e5bb6605aeeaad8a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Selva,<div><br></div><div>Sorry for the wrong thread.=C2=
=A0 I was replying to an earlier thread about this same error on Beta1 and =
beta2.=C2=A0 So i am a bit=C2=A0confused by your statement that this error =
did not show up in earlier betas, because that&#39;s what started this thre=
ad.</div><div><br></div><div>Marvin</div></div><br><div class=3D"gmail_quot=
e"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Sep 9, 2020 at 5:14 PM Sel=
va Nair &lt;<a href=3D"mailto:selva.nair@...277...">selva.nair@...277...</a=
>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px=
 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><di=
v dir=3D"ltr"><div dir=3D"ltr">Hi Marvin,<div><br></div><div>This is the=C2=
=A0wrong thread, but...</div><div>=C2=A0</div></div><div class=3D"gmail_quo=
te"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Sep 9, 2020 at 7:54 PM Ma=
rvin &lt;<a href=3D"mailto:volleynbike@...277..." target=3D"_blank">volleyn=
bike@...277...</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padd=
ing-left:1ex"><div dir=3D"ltr">Hi Guys,<div><br></div><div>I just tested be=
ta3 on Win10.=C2=A0 I am getting the exact same error with wintun as before=
.=C2=A0 TAP works normally.=C2=A0 I tried with the GUI and by cli.</div></d=
iv></blockquote><div><br></div><div>The GUI never generated this error even=
 before beta3, so not sure what you are doing wrong. Ensure that the intera=
ctive service is running (that&#39;s the default) and=C2=A0 GUI is not star=
ted with admin privileges (do not start the GUI from an elevated command li=
ne or using run as admin).</div><div><br></div><div>For cli you will get th=
is error unless you use some utility like psexec to elevate to SYSTEM.=C2=
=A0</div><div><br></div><div>For connections=C2=A0started at boot using Ope=
nVPNService (not the same as the interactive service used by the GUI) beta3=
 should work. There was a bug that affected this use case which was fixed i=
n beta3.<br></div><div><br></div><blockquote class=3D"gmail_quote" style=3D=
"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-le=
ft:1ex"><div dir=3D"ltr"><div><br></div><div>2020-09-09 16:23:20 us=3D99130=
6 ERROR: =C2=A0Wintun requires SYSTEM privileges and therefore should be us=
ed with interactive service. If you want to use openvpn from command line, =
you need to do SYSTEM elevation yourself (for example with psexec).<br>2020=
-09-09 16:23:20 us=3D991306 Exiting due to fatal error<br></div></div></blo=
ckquote><div><br></div><div>If you got this error running from the command =
line as SYSTEM please check the logs to be sure its beta3.</div><div><br></=
div><div>Selva</div><div><br></div></div></div>
</blockquote></div>

--000000000000e5bb6605aeeaad8a--

