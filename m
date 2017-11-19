MIME-Version: 1.0
In-Reply-To: <20170505214624.11675-1-davids@...515...>
References: <20170505214624.11675-1-davids@...515...>
From: Selva <selva.nair@...277...>
Date: Sun, 19 Nov 2017 16:21:08 -0500
Message-ID: <CAKuzo_gaQexyhX9RJTZkoqpTsPFL=cjqX+p90KEdMBiU7jckjg@...278...>
Content-Type: multipart/alternative; boundary="f403043ae4f49312dc055e5c8ddd"
Subject: Re: [Openvpn-devel] [PATCH 1/2] plugin: Export base64 encode and
 decode functions
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: David Sommerseth <davids@...515...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--f403043ae4f49312dc055e5c8ddd
Content-Type: text/plain; charset="UTF-8"

Hi David,

On Fri, May 5, 2017 at 5:46 PM, David Sommerseth <davids@...515...> wrote:

> This patch builds on the "Export secure_memzero() to plug-ins" patch and
> adds export of openvpn_base64_encode() and openvpn_base64_decode()
>
> This also ships with a very simple plug-in which demonstrates how to use
> the new exported functions.
>

This has remained in a limbo mainly because of me pushing for a correction
to the plugin_v3 API. Obviously that hasn't got any traction.

If you separate this into two patches: (i) export base64 (ii) usage sample
we can get (i) merged right away and move on to patches that would benefit
from it.

Thanks,

Selva

--f403043ae4f49312dc055e5c8ddd
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi David,</div><div><br></div><div>On Fri, May 5, 201=
7 at 5:46 PM, David Sommerseth=C2=A0<span dir=3D"ltr">&lt;<a href=3D"mailto=
:davids@...515..." target=3D"_blank">davids@...515...</a>&gt;</span>=C2=A0w=
rote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8e=
x;border-left:1px solid rgb(204,204,204);padding-left:1ex">This patch build=
s on the &quot;Export secure_memzero() to plug-ins&quot; patch and<br>adds =
export of openvpn_base64_encode() and openvpn_base64_decode()<br><br>This a=
lso ships with a very simple plug-in which demonstrates how to use<br>the n=
ew exported functions.<br></blockquote><div>=C2=A0</div></div><div>This has=
 remained in a limbo mainly because of me pushing for a correction</div><di=
v>to the plugin_v3 API. Obviously that hasn&#39;t got any traction.</div><d=
iv><br></div><div>If you separate this into two patches: (i) export base64 =
(ii) usage sample</div><div>we can get (i) merged right away and move on to=
 patches that would benefit</div><div>from it.</div><div><br></div><div>Tha=
nks,</div><div><br></div><div>Selva</div></div>

--f403043ae4f49312dc055e5c8ddd--

