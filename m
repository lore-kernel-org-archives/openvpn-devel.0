MIME-Version: 1.0
In-Reply-To: <OpenVPN/openvpn-gui/issues/168/305250704@...1714...>
References: <OpenVPN/openvpn-gui/issues/168@...1714...>
	<OpenVPN/openvpn-gui/issues/168/305250704@...1714...>
From: Selva Nair <selva.nair@...277...>
Date: Wed, 31 May 2017 13:54:40 -0400
Message-ID: <CAKuzo_iMXUVZJz0U3OKLi3VvC4vv2S_5+8uTdn5o=21mA8tODA@...278...>
Content-Type: multipart/alternative; boundary="001a113d73a07c1ef20550d59e94"
Subject: Re: [Openvpn-devel] [OpenVPN/openvpn-gui] better handling of
 interactive service failure (#168)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--001a113d73a07c1ef20550d59e94
Content-Type: text/plain; charset="UTF-8"

Hi,

Copying openvpn-devel:
As this is related to openvpn best to have this discussion in the devel
list, I suppose.
(see also:
https://github.com/OpenVPN/openvpn-gui/issues/168#issuecomment-305250704)

On Wed, May 31, 2017 at 12:58 PM, Gert Doering <notifications@...1714...>
wrote:

> On Wed, May 31, 2017 at 09:43:21AM -0700, Selva Nair wrote:
> > As I said, get openvpn to report route errors in the status and then we
> can
> > add a warning to the status popup, turn the icon red etc instead of the
> > current misleading "successfully connected" behaviour.
>
> This is actually a discussion I was trying to have a long time ago
> (a few years) - "why do we ignore route addition errors?".
>
> The IPv6 code doesn't (because I think that errors are errors, not
> warnings...) and that was always some sort of weird asymmetry...
>
> I still don't know the reasoning here, but I suspect it's something along
> "you push a route that is identical to the local subnet" (192.168.1.0/24,
> for example, because the user happens to be in a bad NAT network) and
> "all of a sudden it fails"... so this might need more discussion, and
> also some code cleanups to gracefully handle situations where an error
> is "tolerated".
>

That and some route addition errors like "route already exists" are often
benign. So a fatal error is not appropriate. But, IIRC,
 openvpn_execve_check only allows printing of errors as FATAL or WARN.
Currently we do not parse the log message flags (error vs warning etc.) in
the Windows GUI, but that could be improved if openvpn can log route errors
like access denied as such.

In any case, the status reported to the management when connected with
errors should be something other than "CONNECTED,SUCCESS" -- say
"CONNECTED,ROUTE-FAILED" etc. so that  UI can intimate the user.

Selva

--001a113d73a07c1ef20550d59e94
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra">Hi,<br></div><div class=3D"gmai=
l_extra"><br></div><div class=3D"gmail_extra">Copying openvpn-devel:</div><=
div class=3D"gmail_extra">As this is related to openvpn best to have this d=
iscussion in the devel list, I suppose.=C2=A0<br><div class=3D"gmail_quote"=
>(see also:=C2=A0<a href=3D"https://github.com/OpenVPN/openvpn-gui/issues/1=
68#issuecomment-305250704">https://github.com/OpenVPN/openvpn-gui/issues/16=
8#issuecomment-305250704</a>)</div><div class=3D"gmail_quote"><br></div><di=
v class=3D"gmail_quote">On Wed, May 31, 2017 at 12:58 PM, Gert Doering <spa=
n dir=3D"ltr">&lt;<a href=3D"mailto:notifications@...1714..." target=3D"_bl=
ank">notifications@...1714...</a>&gt;</span> wrote:<br><blockquote class=3D=
"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;borde=
r-left-color:rgb(204,204,204);border-left-style:solid;padding-left:1ex"><di=
v id=3D"gmail-m_-6518952545098238565m_8520566217958298647:2n" class=3D"gmai=
l-m_-6518952545098238565m_8520566217958298647a3s gmail-m_-65189525450982385=
65m_8520566217958298647aXjCH gmail-m_-6518952545098238565m_8520566217958298=
647m15c5f719c883a87f">On Wed, May 31, 2017 at 09:43:21AM -0700, Selva Nair =
wrote:<br>
&gt; As I said, get openvpn to report route errors in the status and then w=
e can<br>
&gt; add a warning to the status popup, turn the icon red etc instead of th=
e<br>
&gt; current misleading &quot;successfully connected&quot; behaviour.<br>
<br>
This is actually a discussion I was trying to have a long time ago<br>
(a few years) - &quot;why do we ignore route addition errors?&quot;.  <br>
<br>
The IPv6 code doesn&#39;t (because I think that errors are errors, not <br>
warnings...) and that was always some sort of weird asymmetry...<br>
<br>
I still don&#39;t know the reasoning here, but I suspect it&#39;s something=
 along<br>
&quot;you push a route that is identical to the local subnet&quot; (<a href=
=3D"http://192.168.1.0/24" target=3D"_blank">192.168.1.0/24</a>,<br>
for example, because the user happens to be in a bad NAT network) and <br>
&quot;all of a sudden it fails&quot;...  so this might need more discussion=
, and<br>
also some code cleanups to gracefully handle situations where an error<br>
is &quot;tolerated&quot;.</div></blockquote></div><div class=3D"gmail_extra=
"><br></div><div class=3D"gmail_extra">That and some route addition errors =
like &quot;route already exists&quot; are often benign. So a fatal error is=
 not appropriate. But, IIRC, =C2=A0openvpn_execve_check only allows printin=
g of errors as FATAL or WARN. Currently we do not parse the log message fla=
gs (error vs warning etc.) in the Windows GUI, but that could be improved i=
f openvpn can log route errors like access denied as such.</div><div class=
=3D"gmail_extra"><br></div>In any case, the status reported to the manageme=
nt when connected with errors should be something other than &quot;CONNECTE=
D,SUCCESS&quot; -- say &quot;CONNECTED,ROUTE-FAILED&quot; etc. so that =C2=
=A0UI can intimate the user.</div><div class=3D"gmail_extra"><br></div><div=
 class=3D"gmail_extra">Selva</div></div>

--001a113d73a07c1ef20550d59e94--

