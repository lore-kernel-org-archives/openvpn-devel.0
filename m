MIME-Version: 1.0
References: <20221023195105.31714-1-selva.nair@...277...>
 <202210270607.29R67xBm021921@...2054...>
In-Reply-To: <202210270607.29R67xBm021921@...2054...>
From: Selva Nair <selva.nair@...277...>
Date: Thu, 27 Oct 2022 11:18:07 -0400
Message-ID: <CAKuzo_ivcgZ=t=aUmhPddRNRSwV7DbtD9WncrmbPvKkM9xkqcA@...278...>
Content-Type: multipart/alternative; boundary="000000000000eb938a05ec05a6b1"
Subject: Re: [Openvpn-devel] [PATCH applied] Re: Ensure --auth-nocache is
 handled during renegotiation
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

--000000000000eb938a05ec05a6b1
Content-Type: text/plain; charset="UTF-8"

On Thu, Oct 27, 2022 at 2:08 AM Gert Doering <gert@...1296...> wrote:

> Looking at the code, I'd say your commit description makes a lot of
> sense, and explains the observed "funnies" quite well (which I could
> reproduce).  The code change looks reasonable, Arne ACKed this, and
> I could not find a way to break it.  Good :-)
>

Thanks for the laborious testing!

2.4 is also affected  as commit dfd624b52 was cherrypicked into it as well:
(commit 607dfa9)
But this patch won't apply due to some context changes.

Would you like a resolved patch or is 2.4 out of "support" now?

Selva

--000000000000eb938a05ec05a6b1
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Thu, Oct 27, 2022 at 2:08 AM Gert =
Doering &lt;<a href=3D"mailto:gert@...1296..." target=3D"_blank">gert@...1711...=
96...</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"ma=
rgin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:=
1ex">Looking at the code, I&#39;d say your commit description makes a lot o=
f<br>
sense, and explains the observed &quot;funnies&quot; quite well (which I co=
uld<br>
reproduce).=C2=A0 The code change looks reasonable, Arne ACKed this, and<br>
I could not find a way to break it.=C2=A0 Good :-)<br></blockquote><div><br=
></div><div>Thanks for the laborious testing!</div><div><br></div><div>2.4 =
is also affected=C2=A0 as commit dfd624b52 was cherrypicked=C2=A0into it as=
 well:<br></div><div>(commit=C2=A0607dfa9)</div><div>But this patch won&#39=
;t apply due to some context changes.<br></div><div><br></div><div>Would yo=
u like a resolved patch or is 2.4 out=C2=A0of &quot;support&quot; now?</div=
><div><br></div><div>Selva</div></div></div>

--000000000000eb938a05ec05a6b1--

