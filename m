MIME-Version: 1.0
References: <1530633509-4959-1-git-send-email-selva.nair@...277...>
 <1531491395-29049-1-git-send-email-selva.nair@...277...>
 <4e0e285a-482a-700a-e359-fc8cf8c1613c@...1856...>
In-Reply-To: <4e0e285a-482a-700a-e359-fc8cf8c1613c@...1856...>
From: Selva Nair <selva.nair@...277...>
Date: Fri, 5 Oct 2018 11:30:29 -0400
Message-ID: <CAKuzo_iXRkuzeVG0ec2mDA8a-arQe-J9seo1R+ZdRA7ktWbt=w@...278...>
Content-Type: multipart/alternative; boundary="000000000000a3551005777cf49d"
Subject: Re: [Openvpn-devel] [PATCH v3] Make up/down script errors not FATAL
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan@...1856...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--000000000000a3551005777cf49d
Content-Type: text/plain; charset="UTF-8"

Hi,

On Fri, Oct 5, 2018 at 5:44 AM Steffan Karger <steffan@...1856...> wrote:

> Hi,
>
> On 13-07-18 16:16, selva.nair@...277... wrote:
> > From: Selva Nair <selva.nair@...277...>
> >
> > The error is treated as a warning only if its triggered due
> > to script_security < SSEC_SCRIPTS.
> >
> > This helps user interfaces enforce a safer script-security setting
> > without causing a FATAL error.
>
> But does it make sense at all to accept configs that have a --up script
> without a sufficiently-high script-security set?
>

This came out of a proposed patch for the GUI to protect lay users from
malicious
scripts embedded in config files.

Recall the ado about exploiting scripts using unsuspecting "inline"
commands.
To defeat such exploits we want to enforce a safer script security setting
from
the GUI but do not want to cause a FATAL error as that would be counter
productive.

Please see GUI PR #271 https://github.com/OpenVPN/openvpn-gui/pull/271 and
my comment dated Jul 3 under it.

The discussion that led to this is here:
https://github.com/OpenVPN/openvpn-gui/issues/270

Thanks,

Selva

--000000000000a3551005777cf49d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr">Hi,<br><div><br><div cla=
ss=3D"gmail_quote"><div dir=3D"ltr">On Fri, Oct 5, 2018 at 5:44 AM Steffan =
Karger &lt;<a href=3D"mailto:steffan@...1856..." target=3D"_blank">steffan@=
...1856...</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">Hi,<br>
<br>
On 13-07-18 16:16, <a href=3D"mailto:selva.nair@...277..." target=3D"_blank=
">selva.nair@...277...</a> wrote:<br>
&gt; From: Selva Nair &lt;<a href=3D"mailto:selva.nair@...277..." target=3D=
"_blank">selva.nair@...277...</a>&gt;<br>
&gt; <br>
&gt; The error is treated as a warning only if its triggered due<br>
&gt; to script_security &lt; SSEC_SCRIPTS.<br>
&gt; <br>
&gt; This helps user interfaces enforce a safer script-security setting<br>
&gt; without causing a FATAL error.<br>
<br>
But does it make sense at all to accept configs that have a --up script<br>
without a sufficiently-high script-security set?<br></blockquote><div><br>T=
his came out of a proposed patch for the GUI to protect lay users from mali=
cious<br></div><div>scripts embedded in config files.<br></div><div><br>Rec=
all the ado about exploiting scripts using unsuspecting &quot;inline&quot; =
commands.<br>To defeat such exploits we want to enforce a safer script secu=
rity setting from<br>the GUI but do not want to cause a FATAL error as that=
 would be counter productive.<br><br></div><div>Please see GUI PR #271 <a h=
ref=3D"https://github.com/OpenVPN/openvpn-gui/pull/271" target=3D"_blank">h=
ttps://github.com/OpenVPN/openvpn-gui/pull/271</a> and <br>my comment dated=
 Jul 3 under it.<br></div><div><br></div><div>The discussion that led to th=
is is here:<br><a href=3D"https://github.com/OpenVPN/openvpn-gui/issues/270=
">https://github.com/OpenVPN/openvpn-gui/issues/270</a><br><br></div><div>T=
hanks,<br></div><br></div><div class=3D"gmail_quote">Selva<br></div></div><=
/div></div></div>

--000000000000a3551005777cf49d--

