MIME-Version: 1.0
In-Reply-To: <CAEsd45SC3aXgJYX33gFyF53A3njcbokK8ho_G7-6VDVG84zNfA@...278...>
References: <1530581086-7825-1-git-send-email-selva.nair@...277...>
 <CAEsd45SC3aXgJYX33gFyF53A3njcbokK8ho_G7-6VDVG84zNfA@...278...>
From: Selva Nair <selva.nair@...277...>
Date: Tue, 3 Jul 2018 02:49:51 -0400
Message-ID: <CAKuzo_i0rGsDOpEdoFe-SRSDVQY7raSZhjyOLh-pa34FWxtXjQ@...278...>
Content-Type: multipart/alternative; boundary="000000000000c5f40d057012b98b"
Subject: Re: [Openvpn-devel] [PATCH] Make up/down script errors not FATAL
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "Jonathan K. Bullard" <jkbullard@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--000000000000c5f40d057012b98b
Content-Type: text/plain; charset="UTF-8"

Hi Jon,

On Mon, Jul 2, 2018 at 11:13 PM, Jonathan K. Bullard <jkbullard@...277...>
wrote:
> Hi.
>
> On Mon, Jul 2, 2018 at 9:24 PM, <selva.nair@...277...> wrote:
>>
>> From: Selva Nair <selva.nair@...277...>
>>
>> Instead log only a warning.
>>
>> This helps user interfaces enforce a safer script-security setting
>> without causing a FATAL error.
>
>
> Can you expand on that? What "safer script secuity settings' do you
> have in mind? Tunnelblick (and I think all Linux) use script-security
> 2 to allow for up/down scripts that implement DNS and other settings.
>
> My initial reaction is that I'd rather a problem in the up/down
> scripts generates a fatal error, so if there's a problem in the
> Tunnelblick scripts somebody will report it. In my experience, almost
> nobody pays attention to warnings, and mostly, those who do are
> worried about warning that don't matter.

This is in reaction to

https://medium.com/tenable-techblog/reverse-shell-from-an-
openvpn-configuration-file-73fd8b1d38da

In OpenVPN Windows GUI I'm considering to enforce "--script-security 1"
(SSEC_BUILT_IN). See the discussion here:

https://github.com/OpenVPN/openvpn-gui/issues/270

Selva

--000000000000c5f40d057012b98b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Jon,<br><br>On Mon, Jul 2, 2018 at 11:13 PM, Jonathan K=
. Bullard &lt;<a href=3D"mailto:jkbullard@...277..." target=3D"_blank">jkbu=
llard@...277...</a>&gt; wrote:<br>&gt; Hi.<br>&gt;<br>&gt; On Mon, Jul 2, 2=
018 at 9:24 PM, &lt;<a href=3D"mailto:selva.nair@...277..." target=3D"_blan=
k">selva.nair@...277...</a>&gt; wrote:<br>&gt;&gt;<br>&gt;&gt; From: Selva =
Nair &lt;<a href=3D"mailto:selva.nair@...277..." target=3D"_blank">selva.na=
ir@...277...</a>&gt;<br>&gt;&gt;<br>&gt;&gt; Instead log only a warning.<br=
>&gt;&gt;<br>&gt;&gt; This helps user interfaces enforce a safer script-sec=
urity setting<br>&gt;&gt; without causing a FATAL error.<br>&gt;<br>&gt;<br=
>&gt; Can you expand on that? What &quot;safer script secuity settings&#39;=
 do you<br>&gt; have in mind? Tunnelblick (and I think all Linux) use scrip=
t-security<br>&gt; 2 to allow for up/down scripts that implement DNS and ot=
her settings.<br>&gt;<br>&gt; My initial reaction is that I&#39;d rather a =
problem in the up/down<br>&gt; scripts generates a fatal error, so if there=
&#39;s a problem in the<br>&gt; Tunnelblick scripts somebody will report it=
. In my experience, almost<br>&gt; nobody pays attention to warnings, and m=
ostly, those who do are<br>&gt; worried about warning that don&#39;t matter=
.<br><br>This is in reaction to<br><br><a href=3D"https://medium.com/tenabl=
e-techblog/reverse-shell-from-an-openvpn-configuration-file-73fd8b1d38da" t=
arget=3D"_blank">https://medium.com/tenable-tec<wbr>hblog/reverse-shell-fro=
m-an-<wbr>openvpn-configuration-file-73f<wbr>d8b1d38da</a><br><br>In OpenVP=
N Windows GUI I&#39;m considering to enforce &quot;--script-security 1&quot=
; (SSEC_BUILT_IN). See the discussion here:<br><br><a href=3D"https://githu=
b.com/OpenVPN/openvpn-gui/issues/270" target=3D"_blank">https://github.com/=
OpenVPN/ope<wbr>nvpn-gui/issues/270</a><div><br><div>Selva</div></div></div>

--000000000000c5f40d057012b98b--

