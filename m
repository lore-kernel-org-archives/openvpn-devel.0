MIME-Version: 1.0
References: <CAAWBBYPw=TZg1wftWZL5ABKVWkp7=6hpdaumLN2D24Cgr-E4pQ@...278...>
 <20200818062335.GV75094@...1296...>
 <20200818063212.GW75094@...1296...>
 <CAKuzo_jEGvTnkbsgJVm5beW5SapWoy_xLk_LA+-N59oa6SbbkA@...278...>
 <81A6F618-2F74-417F-A476-BF290CCFF143@...277...>
In-Reply-To: <81A6F618-2F74-417F-A476-BF290CCFF143@...277...>
From: Selva Nair <selva.nair@...277...>
Date: Tue, 18 Aug 2020 12:05:33 -0400
Message-ID: <CAKuzo_hS5Y5Cy=h1VF6vgDEKDDwTfKqX56rLHa0F0CQ+JP=85Q@...278...>
Content-Type: multipart/alternative; boundary="0000000000009c346905ad290fb9"
Subject: Re: [Openvpn-devel] 2.5-beta-1 Wintun requires SYSTEM privileges
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Marvin Adeff <volleynbike@...277...>
Cc: Gert Doering <gert@...1296...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--0000000000009c346905ad290fb9
Content-Type: text/plain; charset="UTF-8"

>
>
>
> An additional check in openvpn.exe whether it's started as SYSTEM could be
> useful as well, but less critical, IMO.
>
> Yes Please!  We run 2500+ systems that run it this way as SYSTEM.
>

In most such cases (not using the GUI) one could use the automatic service
which runs as SYSTEM. For those running interactively from the command line
(for occasional use),  the logs should already show what's wrong, isn't it?
Anyway, I was not aware of a wide-spread use-case that doesn't rely on one
of the services.

Even with an early error-out it one will have to check the logs (or use the
GUI) to see what went wrong.

Selva

--0000000000009c346905ad290fb9
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_quote"><blockquote class=3D"gmail_quot=
e" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204)=
;padding-left:1ex"><div dir=3D"auto"><div><br><br></div><blockquote type=3D=
"cite"><div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_quote"><div><f=
ont color=3D"#000000"><span style=3D"background-color:rgba(255,255,255,0)">=
An additional check in openvpn.exe whether it&#39;s started as SYSTEM could=
 be</span></font></div><div><font color=3D"#000000"><span style=3D"backgrou=
nd-color:rgba(255,255,255,0)">useful as well, but less critical, IMO.</span=
></font></div></div></div></div></blockquote><div dir=3D"ltr"></div><div di=
r=3D"ltr">Yes Please!=C2=A0 We run 2500+ systems that run it this way as SY=
STEM. =C2=A0</div></div></blockquote><div><br></div><div>In most such cases=
 (not using the GUI) one could use the automatic service which runs as SYST=
EM. For those running interactively from the command line (for occasional u=
se),=C2=A0 the logs should already show what&#39;s wrong, isn&#39;t it? Any=
way, I was not aware of a wide-spread use-case that doesn&#39;t=C2=A0rely o=
n one of the services.</div><div><br></div><div>Even with an early error-ou=
t it one will have to check the logs (or use the GUI) to see what went wron=
g.</div><div><br></div><div>Selva</div></div></div>

--0000000000009c346905ad290fb9--

