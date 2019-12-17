MIME-Version: 1.0
References: <20191213191634.250-1-lstipakov@...277...>
 <20191213191901.300-1-lstipakov@...277...>
 <CAKuzo_jNn9NG-chJHx62H2CTiB64dCrq3S3_oW7oR8Tngf4F9w@...278...>
 <CAGyAFMVReSwJsYAKo5S4pV4POV31g0roxz4P2Ajvr+8hoEYbeA@...278...>
 <CAKuzo_hMws66xJsN69qa6WmgXNdrSKioHQrpE9VZ89-J2O7+KA@...278...>
 <162696E1-8F58-4B9A-A591-2622E3ADE746@...2293...>
 <CAKuzo_jFzECCsOk=OvrN0+S0dx4WmGOm7qL8L2sGYUTRd+qxXw@...278...>
 <CAGyAFMUgY+dj0TD75dsKL1pQqPP4CRcEObijyCHB7wUbehpEtw@...278...>
 <99D61A626FDA8A4B90A270669121BE10D05C6F28@...2294...>
In-Reply-To: <99D61A626FDA8A4B90A270669121BE10D05C6F28@...2294...>
From: Lev Stipakov <lstipakov@...277...>
Date: Tue, 17 Dec 2019 14:21:43 +0200
Message-ID: <CAGyAFMU9VUSnmLnpmfiN_X-mMyNkWZnxULinjQvjduBhty+g3A@...278...>
Content-Type: multipart/alternative; boundary="000000000000a0d19b0599e55fe4"
Subject: Re: [Openvpn-devel] [PATCH v6 4/7] wintun: ring buffers based I/O
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Simon Rozman <simon@...2293...>
Cc: Selva Nair <selva.nair@...277...>, Lev Stipakov <lev@...515...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--000000000000a0d19b0599e55fe4
Content-Type: text/plain; charset="UTF-8"

I don't want to give up :)

Let's at least wrap that code inside #define ENABLE_SYSTEM_ELEVATION
(because we don't have enough defines) to not to complicate development /
debugging.

ti 17. jouluk. 2019 klo 13.18 Simon Rozman (simon@...2293...) kirjoitti:

> Hi,
>
>
>
> Lev, unfortunately, the openvpn.exe binary will still contain this hack's
> machine code and might really rise some eyebrows with anti-virus software.
>
>
>
> Before the final release the entire SYSTEM token hack should be removed
> from the OpenVPN source.
>
>
>
> I think it's okay to make a note in README that "--windows-driver wintun"
> works with iservice only. (Or, if user is responsible to run openvpn.exe as
> SYSTEM user himself somehow.)
>
>
>
> Regards,
>
> Simon
>
>
>
> *From:* Lev Stipakov <lstipakov@...277...>
> *Sent:* Tuesday, December 17, 2019 10:35 AM
> *To:* Selva Nair <selva.nair@...277...>
> *Cc:* Simon Rozman <simon@...2293...>; Lev Stipakov <lev@...515...>;
> openvpn-devel <openvpn-devel@lists.sourceforge.net>
> *Subject:* Re: [Openvpn-devel] [PATCH v6 4/7] wintun: ring buffers based
> I/O
>
>
>
> How about compromise - let's add  "--enable-system-elevation" windows
> specific option.
>
>
>
>  - When it is set, we print warning and elevate to SYSTEM for the single
> DeviceIOControl call
>
>
>
>  - When it is not set and wintun is used, we run openvpn from command line
> via iservice
>
>
>
>  - If service is missing, we print error "either use iservice or
> --enable-system-elevation (experts only)"
>
>
>
> The ones who want to run openvpn from command line with wintun still could
> do it via psexec and it is
>
> assumed that they know what they are doing. So why not make it simpler and
> add a option
>
> "yes I know what I am doing and I am willing to take risks"? Also, it is
> safer to use system privilege
>
> just for single call rather than run whole process with it.
>
>
>
> This also will make debugging / development easier.
>


-- 
-Lev

--000000000000a0d19b0599e55fe4
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>I don&#39;t want to give up :)</div><div><br></div><d=
iv>Let&#39;s at least wrap that code inside #define ENABLE_SYSTEM_ELEVATION=
 (because we don&#39;t have enough defines) to not to complicate developmen=
t / debugging.</div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=
=3D"gmail_attr">ti 17. jouluk. 2019 klo 13.18 Simon Rozman (<a href=3D"mail=
to:simon@...2293...">simon@...2293...</a>) kirjoitti:<br></div><blockquote =
class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px sol=
id rgb(204,204,204);padding-left:1ex"><div lang=3D"SL"><div class=3D"gmail-=
m_1595668283730340349WordSection1"><p class=3D"MsoNormal"><span lang=3D"EN-=
GB">Hi,<u></u><u></u></span></p><p class=3D"MsoNormal"><span lang=3D"EN-GB"=
><u></u>=C2=A0<u></u></span></p><p class=3D"MsoNormal"><span lang=3D"EN-GB"=
>Lev, unfortunately, the openvpn.exe binary will still contain this hack&#3=
9;s machine code and might really rise some eyebrows with anti-virus softwa=
re.<u></u><u></u></span></p><p class=3D"MsoNormal"><span lang=3D"EN-GB"><u>=
</u>=C2=A0<u></u></span></p><p class=3D"MsoNormal"><span lang=3D"EN-GB">Bef=
ore the final release the entire SYSTEM token hack should be removed from t=
he OpenVPN source.<u></u><u></u></span></p><p class=3D"MsoNormal"><span lan=
g=3D"EN-GB"><u></u>=C2=A0<u></u></span></p><p class=3D"MsoNormal"><span lan=
g=3D"EN-GB">I think it&#39;s okay to make a note in README that &quot;--win=
dows-driver wintun&quot; works with iservice only. (Or, if user is responsi=
ble to run openvpn.exe as SYSTEM user himself somehow.)<u></u><u></u></span=
></p><p class=3D"MsoNormal"><span lang=3D"EN-GB"><u></u>=C2=A0<u></u></span=
></p><p class=3D"MsoNormal"><span lang=3D"EN-GB">Regards,<u></u><u></u></sp=
an></p><p class=3D"MsoNormal"><span lang=3D"EN-GB">Simon<u></u><u></u></spa=
n></p><p class=3D"MsoNormal"><span lang=3D"EN-GB"><u></u>=C2=A0<u></u></spa=
n></p><div style=3D"border-top:none;border-right:none;border-bottom:none;bo=
rder-left:1.5pt solid blue;padding:0cm 0cm 0cm 4pt"><div><div style=3D"bord=
er-right:none;border-bottom:none;border-left:none;border-top:1pt solid rgb(=
225,225,225);padding:3pt 0cm 0cm"><p class=3D"MsoNormal"><b><span lang=3D"E=
N-GB">From:</span></b><span lang=3D"EN-GB"> Lev Stipakov &lt;<a href=3D"mai=
lto:lstipakov@...277..." target=3D"_blank">lstipakov@...277...</a>&gt; <br>=
<b>Sent:</b> Tuesday, December 17, 2019 10:35 AM<br><b>To:</b> Selva Nair &=
lt;<a href=3D"mailto:selva.nair@...277..." target=3D"_blank">selva.nair@...493...=
277...</a>&gt;<br><b>Cc:</b> Simon Rozman &lt;<a href=3D"mailto:simon@...2313...=
93..." target=3D"_blank">simon@...2293...</a>&gt;; Lev Stipakov &lt;<a href=
=3D"mailto:lev@...515..." target=3D"_blank">lev@...515...</a>&gt;; openvpn-=
devel &lt;<a href=3D"mailto:openvpn-devel@lists.sourceforge.net" target=3D"=
_blank">openvpn-devel@lists.sourceforge.net</a>&gt;<br><b>Subject:</b> Re: =
[Openvpn-devel] [PATCH v6 4/7] wintun: ring buffers based I/O<u></u><u></u>=
</span></p></div></div><p class=3D"MsoNormal"><span lang=3D"EN-GB"><u></u>=
=C2=A0<u></u></span></p><div><p class=3D"MsoNormal"><span lang=3D"EN-GB">Ho=
w about compromise - let&#39;s add=C2=A0 &quot;--enable-system-elevation&qu=
ot; windows specific option.<u></u><u></u></span></p><div><p class=3D"MsoNo=
rmal"><span lang=3D"EN-GB"><u></u>=C2=A0<u></u></span></p></div><div><p cla=
ss=3D"MsoNormal"><span lang=3D"EN-GB">=C2=A0- When it is set, we print warn=
ing and elevate to SYSTEM for the single DeviceIOControl call<u></u><u></u>=
</span></p></div><div><p class=3D"MsoNormal"><span lang=3D"EN-GB"><u></u>=
=C2=A0<u></u></span></p></div><div><p class=3D"MsoNormal"><span lang=3D"EN-=
GB">=C2=A0- When it is not set and wintun is used, we run openvpn from comm=
and line via iservice<u></u><u></u></span></p></div><div><p class=3D"MsoNor=
mal"><span lang=3D"EN-GB"><u></u>=C2=A0<u></u></span></p></div><div><p clas=
s=3D"MsoNormal"><span lang=3D"EN-GB">=C2=A0- If service is missing, we prin=
t error &quot;either use iservice or --enable-system-elevation (experts onl=
y)&quot;<u></u><u></u></span></p></div><div><p class=3D"MsoNormal"><span la=
ng=3D"EN-GB"><u></u>=C2=A0<u></u></span></p></div><div><p class=3D"MsoNorma=
l"><span lang=3D"EN-GB">The ones who want to run openvpn from command line =
with wintun still could do it via psexec and it is<u></u><u></u></span></p>=
</div><div><p class=3D"MsoNormal"><span lang=3D"EN-GB">assumed that they kn=
ow what they are doing. So why not make it simpler and add a option<u></u><=
u></u></span></p></div><div><p class=3D"MsoNormal"><span lang=3D"EN-GB">&qu=
ot;yes I know what I am doing and I am willing to take risks&quot;? Also, i=
t is safer to use system privilege<u></u><u></u></span></p></div><div><p cl=
ass=3D"MsoNormal"><span lang=3D"EN-GB">just for single call rather than run=
 whole process with it.<u></u><u></u></span></p></div><div><p class=3D"MsoN=
ormal"><span lang=3D"EN-GB"><u></u>=C2=A0<u></u></span></p></div><div><p cl=
ass=3D"MsoNormal"><span lang=3D"EN-GB">This also will make debugging / deve=
lopment easier.<u></u><u></u></span></p></div></div></div></div></div></blo=
ckquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr" clas=
s=3D"gmail_signature">-Lev</div></div>

--000000000000a0d19b0599e55fe4--

