MIME-Version: 1.0
In-Reply-To: <1505501175-9016-1-git-send-email-selva.nair@...277...>
References: <1505450463-459-1-git-send-email-selva.nair@...277...>
 <1505501175-9016-1-git-send-email-selva.nair@...277...>
From: Selva <selva.nair@...277...>
Date: Wed, 20 Sep 2017 11:34:03 -0400
Message-ID: <CAKuzo_iN6kzukk7ZETjwb6A8pXTkAgXUuQs3E1cf_enYbh-uCA@...278...>
Content-Type: multipart/alternative; boundary="001a113d5a6ed8db2a0559a0b5a6"
Subject: Re: [Openvpn-devel] [PATCH v2] Check whether in pull_mode before
 warning about previous connection blocks
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>, Gert Doering <gert@...1296...>

--001a113d5a6ed8db2a0559a0b5a6
Content-Type: text/plain; charset="UTF-8"

Hi,

On Fri, Sep 15, 2017 at 2:46 PM, <selva.nair@...277...> wrote:

> From: Selva Nair <selva.nair@...277...>
>
> In particular, this eliminates the message that says "explicit-exit-notify
> is ignored by previous <connection> blocks" when the option is pushed.
>
> Note: pull_mode is identified as "allowed & OPT_P_PULL_MODE" matching with
> the
> definition in add_options().
>
> Reported by: Eike Lohmann e.lohmann@...1294...
> https://www.mail-archive.com/openvpn-users@...1199...
> sourceforge.net/msg04052.html
>
> v2: move the check to verify_permissions() as suggested by
> Gert <gert@...1296...>
>
> Signed-off-by: Selva Nair <selva.nair@...277...>
> ---
>  src/openvpn/options.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>


Does this look good now?

Selva

--001a113d5a6ed8db2a0559a0b5a6
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<br><div class=3D"gmail_extra"><br><div class=3D"gmail_=
quote">On Fri, Sep 15, 2017 at 2:46 PM,  <span dir=3D"ltr">&lt;<a href=3D"m=
ailto:selva.nair@...277..." target=3D"_blank">selva.nair@...277...</a>&gt;<=
/span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8=
ex;border-left:1px #ccc solid;padding-left:1ex">From: Selva Nair &lt;<a hre=
f=3D"mailto:selva.nair@...277...">selva.nair@...277...</a>&gt;<br>
<br>
In particular, this eliminates the message that says &quot;explicit-exit-no=
tify<br>
<span class=3D"">is ignored by previous &lt;connection&gt; blocks&quot; whe=
n the option is pushed.<br>
<br>
</span>Note: pull_mode is identified as &quot;allowed &amp; OPT_P_PULL_MODE=
&quot; matching with the<br>
definition in add_options().<br>
<span class=3D""><br>
Reported by: Eike Lohmann <a href=3D"mailto:e.lohmann@...1294...">e.lohmann=
@...1294...</a><br>
<a href=3D"https://www.mail-archive.com/openvpn-users@lists.sourceforge.net=
/msg04052.html" rel=3D"noreferrer" target=3D"_blank">https://www.mail-archi=
ve.com/<wbr>openvpn-users@...1199...<wbr>sourceforge.net/msg04052.html</a><=
br>
<br>
</span>v2: move the check to verify_permissions() as suggested by<br>
Gert &lt;<a href=3D"mailto:gert@...1296...">gert@...1296...</a>&gt;<br>
<span class=3D""><br>
Signed-off-by: Selva Nair &lt;<a href=3D"mailto:selva.nair@...277...">selva=
.nair@...277...</a>&gt;<br>
---<br>
</span>=C2=A0src/openvpn/options.c | 4 +++-<br>
=C2=A01 file changed, 3 insertions(+), 1 deletion(-)<br></blockquote><div><=
br></div><div><br></div><div>Does this look good now?</div><div><br></div><=
div>Selva</div></div></div></div>

--001a113d5a6ed8db2a0559a0b5a6--

