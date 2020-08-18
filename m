MIME-Version: 1.0
References: <CAAWBBYPw=TZg1wftWZL5ABKVWkp7=6hpdaumLN2D24Cgr-E4pQ@...278...>
 <20200818062335.GV75094@...1296...>
 <20200818063212.GW75094@...1296...>
In-Reply-To: <20200818063212.GW75094@...1296...>
From: Selva Nair <selva.nair@...277...>
Date: Tue, 18 Aug 2020 09:23:29 -0400
Message-ID: <CAKuzo_jEGvTnkbsgJVm5beW5SapWoy_xLk_LA+-N59oa6SbbkA@...278...>
Content-Type: multipart/alternative; boundary="0000000000000c6ec905ad26cc50"
Subject: Re: [Openvpn-devel] 2.5-beta-1 Wintun requires SYSTEM privileges
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>
Cc: Rafael Gava <gava100@...277...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--0000000000000c6ec905ad26cc50
Content-Type: text/plain; charset="UTF-8"

Hi

On Tue, Aug 18, 2020 at 2:33 AM Gert Doering <gert@...1296...> wrote:

> Hi,
>
> On Tue, Aug 18, 2020 at 08:23:35AM +0200, Gert Doering wrote:
> > This can also happen if you run the GUI with admin privs (because then
> > it will not use the iservice *but* openvpn needs *more* privs than
> > "just administrator", and wintun can not be used at all).
>
> Continueing this thought: I think we might want to abort earlier in
> the OpenVPN startup in this case, that is, "wintun and no iservice pipe".
>

+1 to that. Should be easy to add this check in the GUI.

I think we can also relax the "do not connect to iservice if admin"
restriction
as that was added to protect against some Windows Vista mis-behaviour.

An additional check in openvpn.exe whether it's started as SYSTEM could be
useful as well, but less critical, IMO.

Selva

--0000000000000c6ec905ad26cc50
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi</div><br><div class=3D"gmail_quote"><div dir=3D"lt=
r" class=3D"gmail_attr">On Tue, Aug 18, 2020 at 2:33 AM Gert Doering &lt;<a=
 href=3D"mailto:gert@...1296..." target=3D"_blank">gert@...1296...</a>&gt; =
wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0=
px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Hi,<br>
<br>
On Tue, Aug 18, 2020 at 08:23:35AM +0200, Gert Doering wrote:<br>
&gt; This can also happen if you run the GUI with admin privs (because then=
<br>
&gt; it will not use the iservice *but* openvpn needs *more* privs than<br>
&gt; &quot;just administrator&quot;, and wintun can not be used at all).<br>
<br>
Continueing this thought: I think we might want to abort earlier in<br>
the OpenVPN startup in this case, that is, &quot;wintun and no iservice pip=
e&quot;.<br></blockquote><div><br></div><div>+1 to that. Should be easy to =
add this check in the GUI.</div><div><br></div><div>I think we can also rel=
ax the &quot;do not connect=C2=A0to iservice if admin&quot; restriction</di=
v><div>as that was added to protect against some Windows Vista mis-behaviou=
r.</div><div><br></div><div>An additional check in openvpn.exe whether it&#=
39;s started as SYSTEM could be</div><div>useful as well, but less critical=
, IMO.</div><div><br></div><div>Selva</div></div></div>

--0000000000000c6ec905ad26cc50--

