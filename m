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
In-Reply-To: <CAAF3xa-fQ_m=Tow44wqf3DMqWEq9z90n+6Xgg6NvW-UdTaVjHQ@...278...>
From: Selva Nair <selva.nair@...277...>
Date: Thu, 10 Sep 2020 00:56:02 -0400
Message-ID: <CAKuzo_gEfixxkFVz3H4myjX9tQAXgGBMpKMJH4fWF2PesHDKDA@...278...>
Content-Type: multipart/alternative; boundary="00000000000072f9c705aeee63c5"
Subject: Re: [Openvpn-devel] [PATCH] Fix client's poor man NCP fallback
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Marvin <volleynbike@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--00000000000072f9c705aeee63c5
Content-Type: text/plain; charset="UTF-8"

Hi,

On Thu, Sep 10, 2020 at 12:19 AM Marvin <volleynbike@...277...> wrote:

> Hi Selva,
>
> The GUI did not have this error unless run as administrator which you
>> should not and will never work.
>
> So you are saying that if OpenVPN is installed by a user who has admin
> privileges (as our case does) that v2.5 with wintun will not work?
>

You mean OpenVPN started using the GUI? If so, no, I'm not saying that. The
GUI just works even with beta1 or with beta3. On Windows user's processes
run with limited privileges even if the user is an "admin". At least that
is the default because of UAC.

Installation can be done when logged in as admin or as a limited user
(provided you know admin credentials) as the installer prompts for
elevation as required.

That qualifier I added was because: the GUI running with privileges (admin)
has been discouraged in 2.4 ever since we introduced the interactive
service. And that continues with 2.5. It will work for some things and not
for some other things. Same with running the GUI with interactive service
disabled. As such uses are not supported, don't complain about it :)

Selva

--00000000000072f9c705aeee63c5
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi,</div><br><div class=3D"gmail_quote"><div dir=3D"l=
tr" class=3D"gmail_attr">On Thu, Sep 10, 2020 at 12:19 AM Marvin &lt;<a hre=
f=3D"mailto:volleynbike@...277..." target=3D"_blank">volleynbike@...277...<=
/a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0=
px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><=
div dir=3D"ltr">Hi=C2=A0Selva,<div><br></div><blockquote class=3D"gmail_quo=
te" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204=
);padding-left:1ex">The GUI did not have this error unless run as administr=
ator which you should not and will never work.=C2=A0=C2=A0=C2=A0</blockquot=
e><div>So you are saying that if OpenVPN is installed by a user who has adm=
in privileges=C2=A0(as our case does) that v2.5 with wintun will not work?<=
/div></div></blockquote><div><br></div><div>You mean OpenVPN started using =
the GUI? If so, no, I&#39;m not saying that. The GUI just works even with b=
eta1 or with beta3. On Windows user&#39;s processes run with limited privil=
eges even if the user is an &quot;admin&quot;. At least that is the default=
 because of UAC.=C2=A0</div><div>=C2=A0</div><div>Installation can be done =
when logged in as admin or as a limited user (provided you know admin crede=
ntials) as the installer prompts for elevation as required.=C2=A0</div><div=
><br></div><div>That qualifier I added was because: the GUI running with pr=
ivileges (admin) has been discouraged in 2.4 ever since we introduced the i=
nteractive service. And that continues with 2.5. It will work for some thin=
gs and not for some other things. Same with running the GUI with interactiv=
e service disabled. As such uses are not supported, don&#39;t complain abou=
t it :)</div><div><br></div><div>Selva</div></div></div>

--00000000000072f9c705aeee63c5--

