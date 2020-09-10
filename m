Content-Type: multipart/alternative;
 boundary=Apple-Mail-163B415C-7B9D-4262-80B6-EFBB06AE42FA
Mime-Version: 1.0 (1.0)
From: Marvin Adeff <volleynbike@...277...>
In-Reply-To: <CAKuzo_gEfixxkFVz3H4myjX9tQAXgGBMpKMJH4fWF2PesHDKDA@...278...>
Date: Thu, 10 Sep 2020 00:10:25 -0700
Content-Transfer-Encoding: 7bit
Message-Id: <21A02C2A-4FB5-4E3E-9D9C-B09253C9EBD9@...277...>
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
 <CAAF3xa-fQ_m=Tow44wqf3DMqWEq9z90n+6Xgg6NvW-UdTaVjHQ@...278...>
 <CAKuzo_gEfixxkFVz3H4myjX9tQAXgGBMpKMJH4fWF2PesHDKDA@...278...>
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

--Apple-Mail-163B415C-7B9D-4262-80B6-EFBB06AE42FA
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Selva,

Please allow me to back up a moment and restate this:
1.  I installed the beta3 msi from the web site logged in as a user that ha=
s admin privileges.  But no elevation was used to install it, just double-c=
lick on the file.=20
2.  I only used the GUI as installed, with no elevation, to start OpenVPN.=
=20
3.  With TAP selected in my .ovpn config file, everything works normally.=20
4.  I am reporting that (from the same login) if I change the .ovpn to use =
wintun (all edits done through the GUI selection), it fails with the error =
I showed below.=20

Is 4. what you are saying is not supported?  In our use, as we have done fo=
r the past decade, the client boxes are used for M2M monitoring.  OpenVPN h=
as to connect on bootup (.ovpn config file contains inline certificates) re=
gardless if there is a user logged in or not as M2M monitoring occurs in th=
e background.  And if a user does login, most often it is with credentials =
that have admin privileges.  I am trying to understand if what you=E2=80=99=
re telling me is that this will no longer work, or if we will need to do so=
mething different now?  My testing used the GUI to see how things will work=
 with wintun so we can continue testing.=20

Do I need to NOT use the GUI to get wintun to work?=20=20

Marvin=20

> On Sep 9, 2020, at 9:56 PM, Selva Nair <selva.nair@...277...> wrote:
>=20
> Hi,
>=20
>> On Thu, Sep 10, 2020 at 12:19 AM Marvin <volleynbike@...277...> wrote:
>> Hi Selva,
>>=20
>>> The GUI did not have this error unless run as administrator which you s=
hould not and will never work.=20=20=20
>> So you are saying that if OpenVPN is installed by a user who has admin p=
rivileges (as our case does) that v2.5 with wintun will not work?
>=20
> You mean OpenVPN started using the GUI? If so, no, I'm not saying that. T=
he GUI just works even with beta1 or with beta3. On Windows user's processe=
s run with limited privileges even if the user is an "admin". At least that=
 is the default because of UAC.=20
>=20=20
> Installation can be done when logged in as admin or as a limited user (pr=
ovided you know admin credentials) as the installer prompts for elevation a=
s required.=20
>=20
> That qualifier I added was because: the GUI running with privileges (admi=
n) has been discouraged in 2.4 ever since we introduced the interactive ser=
vice. And that continues with 2.5. It will work for some things and not for=
 some other things. Same with running the GUI with interactive service disa=
bled. As such uses are not supported, don't complain about it :)
>=20
> Selva

--Apple-Mail-163B415C-7B9D-4262-80B6-EFBB06AE42FA
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

<html><head><meta http-equiv=3D"content-type" content=3D"text/html; charset=
=3Dutf-8"></head><body dir=3D"auto">Selva,<div><br></div><div>Please allow =
me to back up a moment and restate this:</div><div>1. &nbsp;I installed the=
 beta3 msi from the web site logged in as a user that has admin privileges.=
 &nbsp;But no elevation was used to install it, just double-click on the fi=
le.&nbsp;</div><div>2. &nbsp;I only used the GUI as installed, with no elev=
ation, to start OpenVPN.&nbsp;</div><div>3. &nbsp;With TAP selected in my .=
ovpn config file, everything works normally.&nbsp;</div><div>4. &nbsp;I am =
reporting that (from the same login) if I change the .ovpn to use wintun (a=
ll edits done through the GUI selection), it fails with the error I showed =
below.&nbsp;</div><div><br></div><div>Is 4. what you are saying is not supp=
orted? &nbsp;In our use, as we have done for the past decade, the client bo=
xes are used for M2M monitoring. &nbsp;OpenVPN has to connect on bootup (.o=
vpn config file contains inline certificates) regardless if there is a user=
 logged in or not as M2M monitoring occurs in the background. &nbsp;And if =
a user does login, most often it is with credentials that have admin privil=
eges. &nbsp;I am trying to understand if what you=E2=80=99re telling me is =
that this will no longer work, or if we will need to do something different=
 now? &nbsp;My testing used the GUI to see how things will work with wintun=
 so we can continue testing.&nbsp;</div><div><br></div><div>Do I need to NO=
T use the GUI to get wintun to work? &nbsp;<br><br><div dir=3D"ltr">Marvin&=
nbsp;</div><div dir=3D"ltr"><br>On Sep 9, 2020, at 9:56 PM, Selva Nair &lt;=
<a href=3D"mailto:selva.nair@...277...">selva.nair@...277...</a>&gt; wrote:=
<br><br></div><blockquote type=3D"cite"><div dir=3D"ltr"><div dir=3D"ltr"><=
div>Hi,</div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail=
_attr">On Thu, Sep 10, 2020 at 12:19 AM Marvin &lt;<a href=3D"mailto:volley=
nbike@...277..." target=3D"_blank">volleynbike@...277...</a>&gt; wrote:<br>=
</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;b=
order-left:1px solid rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr">Hi=
&nbsp;Selva,<div><br></div><blockquote class=3D"gmail_quote" style=3D"margi=
n:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex=
">The GUI did not have this error unless run as administrator which you sho=
uld not and will never work.&nbsp;&nbsp;&nbsp;</blockquote><div>So you are =
saying that if OpenVPN is installed by a user who has admin privileges&nbsp=
;(as our case does) that v2.5 with wintun will not work?</div></div></block=
quote><div><br></div><div>You mean OpenVPN started using the GUI? If so, no=
, I'm not saying that. The GUI just works even with beta1 or with beta3. On=
 Windows user's processes run with limited privileges even if the user is a=
n "admin". At least that is the default because of UAC.&nbsp;</div><div>&nb=
sp;</div><div>Installation can be done when logged in as admin or as a limi=
ted user (provided you know admin credentials) as the installer prompts for=
 elevation as required.&nbsp;</div><div><br></div><div>That qualifier I add=
ed was because: the GUI running with privileges (admin) has been discourage=
d in 2.4 ever since we introduced the interactive service. And that continu=
es with 2.5. It will work for some things and not for some other things. Sa=
me with running the GUI with interactive service disabled. As such uses are=
 not supported, don't complain about it :)</div><div><br></div><div>Selva</=
div></div></div>
</div></blockquote></div></body></html>=

--Apple-Mail-163B415C-7B9D-4262-80B6-EFBB06AE42FA--

