MIME-Version: 1.0
In-Reply-To: <56B32D16.9010005@...2070...>
References: <56B0ECA6.3000902@...515...>
	<CAKuzo_grryDNAqf1vSoMJUrGVYnZEg_S-GHuZARazjnP5YVsFg@...278...>
	<56B32D16.9010005@...2070...>
From: Selva Nair <selva.nair@...277...>
Date: Fri, 5 Feb 2016 00:15:37 -0500
Message-ID: <CAKuzo_gEU6OvYZXDdoWPo6pjhzD6yG5REQVWBbG9Pyjmeg8Apw@...278...>
Content-Type: multipart/alternative; boundary=001a113d5012368895052afef22c
Subject: Re: [Openvpn-devel] Test installers with the Interactive service /
	Vista-compatible block-outside-dns
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: ValdikSS <iam@...2070...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--001a113d5012368895052afef22c
Content-Type: text/plain; charset=UTF-8

Hi,

On Thu, Feb 4, 2016 at 5:51 AM, ValdikSS <iam@...2070...> wrote:

> It's not for DNS resolution (although it should work if "DNS Client"
> service is disabled), it's not to break OpenVPN servers on TCP/UDP port 53.


I missed that.. Thanks and that does work.

So back to the patch, I lost the original email, so referring to
http://article.gmane.org/gmane.network.openvpn.devel/10998

From: ValdikSS <iam <at> valdikss.org.ru>
> Subject: [PATCH] Update --block-outside-dns to work on Windows Vista
> Date: 2016-01-15 23:35:38 GMT
> Windows Vista doesn't support non-equal matching of application name, it
> is available only since Windows 7.
> This commit splits 2 filtering conditions with non-equal matching to 2
> filters each with 1 filtering
> condition: permit IPv4 (first filter) and IPv6 (second filter) port 53
> traffic from openvpn.exe
> instead of blocking all non-openvpn.exe traffic on port 53 for both
> protocols.
> ---
>  src/openvpn/win32.c | 35 +++++++++++++++++++++++++++--------
>  1 file changed, 27 insertions(+), 8 deletions(-)


Code looks fine, and tested on Win7/Win10.

Assuming this fixes the vista issue, ACK.

Selva

--001a113d5012368895052afef22c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra">Hi,</div><div class=3D"gmail_ex=
tra"><br><div class=3D"gmail_quote">On Thu, Feb 4, 2016 at 5:51 AM, ValdikS=
S <span dir=3D"ltr">&lt;<a href=3D"mailto:iam@...2070..." target=3D"_blank"=
>iam@...2070...</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" =
style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-color:r=
gb(204,204,204);border-left-style:solid;padding-left:1ex">It&#39;s not for =
DNS resolution (although it should work if &quot;DNS Client&quot; service i=
s disabled), it&#39;s not to break OpenVPN servers on TCP/UDP port 53.</blo=
ckquote></div><br>I missed that.. Thanks and that does work.=C2=A0</div><di=
v class=3D"gmail_extra"><br></div><div class=3D"gmail_extra">So back to the=
 patch, I lost the original email, so referring to=C2=A0</div><div class=3D=
"gmail_extra"><a href=3D"http://article.gmane.org/gmane.network.openvpn.dev=
el/10998" target=3D"_blank">http://article.gmane.org/gmane.network.openvpn.=
devel/10998</a><br></div><div class=3D"gmail_extra"><br></div><div class=3D=
"gmail_extra"><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px=
 0.8ex;border-left-width:1px;border-left-color:rgb(204,204,204);border-left=
-style:solid;padding-left:1ex">From: ValdikSS &lt;iam &lt;at&gt; <a href=3D=
"http://valdikss.org.ru" target=3D"_blank">valdikss.org.ru</a>&gt;<br>Subje=
ct: [PATCH] Update --block-outside-dns to work on<span style=3D"white-space=
:pre-wrap">	</span>Windows Vista<br>Date: 2016-01-15 23:35:38 GMT<br>Window=
s Vista doesn&#39;t support non-equal matching of application name, it is a=
vailable only since Windows 7.<br>This commit splits 2 filtering conditions=
 with non-equal matching to 2 filters each with 1 filtering<br>condition: p=
ermit IPv4 (first filter) and IPv6 (second filter) port 53 traffic from ope=
nvpn.exe<br>instead of blocking all non-openvpn.exe traffic on port 53 for =
both protocols.<br>---<br>=C2=A0src/openvpn/win32.c | 35 ++++++++++++++++++=
+++++++++--------<br>=C2=A01 file changed, 27 insertions(+), 8 deletions(-)=
</blockquote><div><br></div><div>Code looks fine, and tested on Win7/Win10.=
=C2=A0</div><div><br></div><div>Assuming this fixes the vista issue, ACK.<b=
r></div><div><br></div><div>Selva</div></div></div>

--001a113d5012368895052afef22c--

