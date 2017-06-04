MIME-Version: 1.0
In-Reply-To: <1a7a5efc-2de2-db0b-0aa0-4340379b84f7@...277...>
References: <d925da2c-5715-6452-1c38-097a123c0de1@...277...>
	<CAKuzo_hWtk=vpR1P4T7O6e6udL8o+yySciD7VveTYdt25c7DRA@...278...>
	<1a7a5efc-2de2-db0b-0aa0-4340379b84f7@...277...>
From: Selva Nair <selva.nair@...277...>
Date: Sun, 4 Jun 2017 00:11:50 -0400
Message-ID: <CAKuzo_iB=pNkgkKBD_N-ZPTeeDiEMp_qD7uvHst3dhPMkJ=4Jg@...278...>
Content-Type: multipart/alternative; boundary="001a113e21242b4fb605511a9747"
Subject: Re: [Openvpn-devel] block-outside-dns and persist-tun
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: ValdikSS <valdikss@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>, Pavel Zhovner <pavel@...2275...>

--001a113e21242b4fb605511a9747
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 3, 2017 at 4:13 PM, ValdikSS <valdikss@...277...> wrote:

>
> You can skip through comments on https://zaborona.help/ to see some
> screenshots and logs.
> Like this one: https://zaborona.help/faq.html#comment-3328754341


I did not find any related to failure to remove WFP filters. That specific
comment link reads

<quote>
Sun May 28 18:07:25 2017 Block_DNS: WFP engine opened
Sun May 28 18:07:25 2017 Error in add_block_dns_filters(): add_sublayer:
failed to add persistent sublayer : =D0=9E=D1=82=D0=BA=D0=B0=D0=B7=D0=B0=D0=
=BD=D0=BE =D0=B2 =D0=B4=D0=BE=D1=81=D1=82=D1=83=D0=BF=D0=B5. [status=3D0x5]
Sun May 28 18:07:25 2017 Blocking DNS failed!
Sun May 28 18:07:25 2017 Exiting due to fatal error
</quote>

Obviously "access denied" due to not running as admin and service not in
use.

Selva

--001a113e21242b4fb605511a9747
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Sat, Jun 3, 2017 at 4:13 PM, ValdikSS <span dir=3D"ltr">&lt;<a href=3D"m=
ailto:valdikss@...277..." target=3D"_blank">valdikss@...277...</a>&gt;</spa=
n> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px =
0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><br>
    You can skip through comments on <a class=3D"gmail-m_162739014374420315=
5moz-txt-link-freetext" href=3D"https://zaborona.help/" target=3D"_blank">h=
ttps://zaborona.help/</a> to see some
    screenshots and logs.<br>
    Like this one: <a class=3D"gmail-m_1627390143744203155moz-txt-link-free=
text" href=3D"https://zaborona.help/faq.html#comment-3328754341" target=3D"=
_blank">https://zaborona.help/faq.<wbr>html#comment-3328754341</a></blockqu=
ote></div><div class=3D"gmail_extra"><br></div>I did not find any related t=
o failure to remove WFP filters. That specific comment link reads</div><div=
 class=3D"gmail_extra"><span style=3D"color:rgb(42,46,46);font-family:&quot=
;Helvetica Neue&quot;,arial,sans-serif;font-size:15px"><br></span></div><di=
v class=3D"gmail_extra"><span style=3D"color:rgb(42,46,46);font-family:&quo=
t;Helvetica Neue&quot;,arial,sans-serif;font-size:15px">&lt;quote&gt;</span=
></div><div class=3D"gmail_extra"><span style=3D"color:rgb(42,46,46);font-f=
amily:&quot;Helvetica Neue&quot;,arial,sans-serif;font-size:15px">Sun May 2=
8 18:07:25 2017 Block_DNS: WFP engine opened</span><br style=3D"box-sizing:=
border-box;color:rgb(42,46,46);font-family:&quot;Helvetica Neue&quot;,arial=
,sans-serif;font-size:15px"><span style=3D"color:rgb(42,46,46);font-family:=
&quot;Helvetica Neue&quot;,arial,sans-serif;font-size:15px">Sun May 28 18:0=
7:25 2017 Error in add_block_dns_filters(): add_sublayer: failed to add per=
sistent sublayer : =D0=9E=D1=82=D0=BA=D0=B0=D0=B7=D0=B0=D0=BD=D0=BE =D0=B2 =
=D0=B4=D0=BE=D1=81=D1=82=D1=83=D0=BF=D0=B5. [status=3D0x5]</span><br style=
=3D"box-sizing:border-box;color:rgb(42,46,46);font-family:&quot;Helvetica N=
eue&quot;,arial,sans-serif;font-size:15px"><span style=3D"color:rgb(42,46,4=
6);font-family:&quot;Helvetica Neue&quot;,arial,sans-serif;font-size:15px">=
Sun May 28 18:07:25 2017 Blocking DNS failed!</span><br style=3D"box-sizing=
:border-box;color:rgb(42,46,46);font-family:&quot;Helvetica Neue&quot;,aria=
l,sans-serif;font-size:15px"><span style=3D"color:rgb(42,46,46);font-family=
:&quot;Helvetica Neue&quot;,arial,sans-serif;font-size:15px">Sun May 28 18:=
07:25 2017 Exiting due to fatal error</span><br></div><div class=3D"gmail_e=
xtra"><span style=3D"color:rgb(42,46,46);font-family:&quot;Helvetica Neue&q=
uot;,arial,sans-serif;font-size:15px">&lt;/quote&gt;</span></div><div class=
=3D"gmail_extra"><span style=3D"color:rgb(42,46,46);font-family:&quot;Helve=
tica Neue&quot;,arial,sans-serif;font-size:15px"><br></span></div><div clas=
s=3D"gmail_extra"><span style=3D"color:rgb(42,46,46);font-family:&quot;Helv=
etica Neue&quot;,arial,sans-serif;font-size:15px">Obviously &quot;access de=
nied&quot; due to not running as admin and service not in use.</span></div>=
<div class=3D"gmail_extra"><span style=3D"color:rgb(42,46,46);font-family:&=
quot;Helvetica Neue&quot;,arial,sans-serif;font-size:15px"><br></span></div=
><div class=3D"gmail_extra"><span style=3D"color:rgb(42,46,46);font-family:=
&quot;Helvetica Neue&quot;,arial,sans-serif;font-size:15px">Selva</span></d=
iv><div class=3D"gmail_extra"><br><br></div></div>

--001a113e21242b4fb605511a9747--

