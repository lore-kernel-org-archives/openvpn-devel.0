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
 <CAAF3xa-fQ_m=Tow44wqf3DMqWEq9z90n+6Xgg6NvW-UdTaVjHQ@...278...>
 <CAKuzo_gEfixxkFVz3H4myjX9tQAXgGBMpKMJH4fWF2PesHDKDA@...278...>
 <21A02C2A-4FB5-4E3E-9D9C-B09253C9EBD9@...277...>
In-Reply-To: <21A02C2A-4FB5-4E3E-9D9C-B09253C9EBD9@...277...>
From: Selva Nair <selva.nair@...277...>
Date: Thu, 10 Sep 2020 10:56:42 -0400
Message-ID: <CAKuzo_jdwacxOWrT-Q2=dq2u+-hq0muT87vB04_ghun0YdKrSQ@...278...>
Content-Type: multipart/alternative; boundary="000000000000a85b0505aef6c799"
Subject: Re: [Openvpn-devel] [PATCH] Fix client's poor man NCP fallback
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Marvin Adeff <volleynbike@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--000000000000a85b0505aef6c799
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Thu, Sep 10, 2020 at 3:10 AM Marvin Adeff <volleynbike@...277...> wrote:

> Selva,
>
> Please allow me to back up a moment and restate this:
> 1.  I installed the beta3 msi from the web site logged in as a user that
> has admin privileges.  But no elevation was used to install it, just
> double-click on the file.
> 2.  I only used the GUI as installed, with no elevation, to start OpenVPN.
> 3.  With TAP selected in my .ovpn config file, everything works normally.
> 4.  I am reporting that (from the same login) if I change the .ovpn to use
> wintun (all edits done through the GUI selection), it fails with the error
> I showed below.
>
> Is 4. what you are saying is not supported?
>

This use case is fully supported and should work. If it's not working, as
lev said, something is not right. Please share the full connection log with
verb=3D4 and we may spot something.


> In our use, as we have done for the past decade, the client boxes are used
> for M2M monitoring.  OpenVPN has to connect on bootup (.ovpn config file
> contains inline certificates) regardless if there is a user logged in or
> not as M2M monitoring occurs in the background.  And if a user does login,
> most often it is with credentials that have admin privileges.  I am trying
> to understand if what you=E2=80=99re telling me is that this will no long=
er work,
> or if we will need to do something different now?  My testing used the GUI
> to see how things will work with wintun so we can continue testing.
>

> Do I need to NOT use the GUI to get wintun to work?
>

Connections started at boot using OpenVPNService will also work with wintun
(2.5_beta3 and newer). You do not have to  use the GUI.

When an admin user logs in to Windows the elevated privileges in the token
are disabled by default , so the user starting any process including
OpenVPN-GUI will run in the *correct* unprivileged mode. Privileges are
acquired only when/if a UAC prompt appears and the user consents to it, or
when explicitly using run-as-admin. So, OpenVPN-GUi will run without
enabling privileges for all users and that is the right way to run the GUI.
So does a million other programs. This is the default behaviour of Windows
since Vista and is a good thing.

Selva

--000000000000a85b0505aef6c799
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div>Hi<div><br><div class=3D"gmail_=
quote"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Sep 10, 2020 at 3:10 A=
M Marvin Adeff &lt;<a href=3D"mailto:volleynbike@...277...">volleynbike@...493...=
277...</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"m=
argin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left=
:1ex"><div dir=3D"auto">Selva,<div><br></div><div>Please allow me to back u=
p a moment and restate this:</div><div>1.=C2=A0 I installed the beta3 msi f=
rom the web site logged in as a user that has admin privileges.=C2=A0 But n=
o elevation was used to install it, just double-click on the file.=C2=A0</d=
iv><div>2.=C2=A0 I only used the GUI as installed, with no elevation, to st=
art OpenVPN.=C2=A0</div><div>3.=C2=A0 With TAP selected in my .ovpn config =
file, everything works normally.=C2=A0</div><div>4.=C2=A0 I am reporting th=
at (from the same login) if I change the .ovpn to use wintun (all edits don=
e through the GUI selection), it fails with the error I showed below.=C2=A0=
</div><div><br></div><div>Is 4. what you are saying is not supported? =C2=
=A0</div></div></blockquote><div><br></div><div>This use case is fully supp=
orted and should work. If it&#39;s not working, as lev said, something is n=
ot right. Please share the full connection log with verb=3D4 and we may spo=
t something.</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex"><div dir=3D"auto"><div>In our use, as we have done for the past =
decade, the client boxes are used for M2M monitoring.=C2=A0 OpenVPN has to =
connect on bootup (.ovpn config file contains inline certificates) regardle=
ss if there is a user logged in or not as M2M monitoring occurs in the back=
ground.=C2=A0 And if a user does login, most often it is with credentials t=
hat have admin privileges.=C2=A0 I am trying to understand if what you=E2=
=80=99re telling me is that this will no longer work, or if we will need to=
 do something different now?=C2=A0 My testing used the GUI to see how thing=
s will work with wintun so we can continue testing.=C2=A0</div></div></bloc=
kquote><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;=
border-left:1px solid rgb(204,204,204);padding-left:1ex"><div dir=3D"auto">=
<div><br></div><div>Do I need to NOT use the GUI to get wintun to work? =C2=
=A0<br></div></div></blockquote><div><br></div><div>Connections started at =
boot using OpenVPNService will also work with wintun (2.5_beta3 and newer).=
 You do not have to=C2=A0 use the GUI.</div><div><br></div><div>When an adm=
in user logs in to Windows the elevated privileges in the token are disable=
d by default=C2=A0, so the user starting any process including OpenVPN-GUI =
will run in the *correct* unprivileged mode. Privileges are acquired only w=
hen/if a UAC prompt appears and the user consents to it, or when explicitly=
 using=C2=A0run-as-admin. So, OpenVPN-GUi will run without enabling privile=
ges for all users and that is the right way to run the GUI. So does=C2=A0a =
million other programs. This is the default behaviour of Windows since Vist=
a and is a good thing.</div><div><br></div><div>Selva</div></div></div></di=
v>

--000000000000a85b0505aef6c799--

