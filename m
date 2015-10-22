MIME-Version: 1.0
In-Reply-To: <CAKuzo_hF7VsjWmWAe3CDk0HhHHeSqoHhXUnhi_hYMp6MUBm5jw@...278...>
References: <56211F0D.2010806@...515...> <56261F0D.9020208@...515...>
	<CAKuzo_jSiw75PaTed_5DWMbM=X313b75EH6vh9erXS2Q-3fK8Q@...278...>
	<240917770.LK0kVOX9dJ@...2001...>
	<CAKuzo_hF7VsjWmWAe3CDk0HhHHeSqoHhXUnhi_hYMp6MUBm5jw@...278...>
From: Selva Nair <selva.nair@...277...>
Date: Thu, 22 Oct 2015 15:04:40 -0400
Message-ID: <CAKuzo_gi1UXPLTCYVU5Pyav4N9HUtxjq51QDasMZayBVQa4TdQ@...278...>
Content-Type: multipart/alternative; boundary=001a1133d042eedf9d0522b62b12
Subject: [Openvpn-devel] Fwd:  Creating a Windows team for OpenVPN?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--001a1133d042eedf9d0522b62b12
Content-Type: text/plain; charset=UTF-8

Hi,

On Thu, Oct 22, 2015 at 1:44 AM, Heiko Hund <heiko.hund@...1489...> wrote:

> On Tuesday 20 October 2015 22:12:06 Selva Nair wrote:
>
> > But a sever admin would not want it in the system as it can allow any
> user
> > with some VPN server account to change the routes etc using the
> > service..(please correct me if I'm mistaken).
>
> If you do not make the configuration directory writable to anyone, then
> you're
> fine. IIRC the GUI has an command line option that would need to be
> changed in
> order to disable loading of arbitrary configs. Besides that the concept is
> waterproof.


If configs can be locked down by admin, I don't see how a GUI cmd line
option can unprotect it. But, anyway, such details don't matter for this
discussion at this stage.


> Besides that the concept is waterproof.


If its posible to do privilege separation without unpleasant side effects,
that is great news and I'll take back my remarks against the interactive
service. Then one service could be made to work for both "automatic" and
interactive uses.

Selva

--001a1133d042eedf9d0522b62b12
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_quote"><div dir=3D"ltr"><div class=3D"=
gmail_extra">Hi,</div><div class=3D"gmail_extra"><br><div class=3D"gmail_qu=
ote"><span class=3D"">On Thu, Oct 22, 2015 at 1:44 AM, Heiko Hund <span dir=
=3D"ltr">&lt;<a href=3D"mailto:heiko.hund@...1489..." target=3D"_blank">hei=
ko.hund@...1489...</a>&gt;</span> wrote:<br></span><blockquote class=3D"gma=
il_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-le=
ft-color:rgb(204,204,204);border-left-style:solid;padding-left:1ex"><span c=
lass=3D""><span>On Tuesday 20 October 2015 22:12:06 Selva Nair wrote:<br></=
span></span><span class=3D""><span><br>
&gt; But a sever admin would not want it in the system as it can allow any =
user<br>
&gt; with some VPN server account to change the routes etc using the<br>
&gt; service..(please correct me if I&#39;m mistaken).<br>
<br>
</span>If you do not make the configuration directory writable to anyone, t=
hen you&#39;re<br>
fine. IIRC the GUI has an command line option that would need to be changed=
 in<br>
order to disable loading of arbitrary configs. Besides that the concept is<=
br>
waterproof.</span></blockquote><div><br></div><div>If configs can be locked=
 down by admin, I don&#39;t see how a GUI cmd line option can unprotect it.=
 But, anyway, such details don&#39;t matter for this discussion at this sta=
ge.</div><span class=3D""><div>=C2=A0=C2=A0</div><blockquote class=3D"gmail=
_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left=
-color:rgb(204,204,204);border-left-style:solid;padding-left:1ex">Besides t=
hat the concept is=C2=A0waterproof.</blockquote><div><br></div></span><div>=
If its posible to do privilege separation without unpleasant side effects, =
that is great news and I&#39;ll take back my remarks against the interactiv=
e service. Then one service could be made to work for both &quot;automatic&=
quot; and interactive uses.</div><span class=3D"HOEnZb"><font color=3D"#888=
888"><div><br></div><div>Selva</div><div><br></div><div><br></div></font></=
span></div></div></div>
</div><br></div>

--001a1133d042eedf9d0522b62b12--

