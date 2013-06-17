MIME-Version: 1.0
In-Reply-To: <51BE2AA0.7060908@...1227...>
References: <5C629764-6A77-4E0D-8B27-AF0AE8B29025@...1829...>
	<51BCF5D1.6070407@...1227...>
	<BC613B74-D9A7-48B9-94B3-2AFF99BF8847@...1829...>
	<51BE2AA0.7060908@...1227...>
From: "Jonathan K. Bullard" <jkbullard@...277...>
Date: Mon, 17 Jun 2013 11:33:54 -0400
Message-ID: <CAEsd45QVPywukuUO=h8f+PddGs1EPX2MCRC=ir=iBWEqdKx6zA@...278...>
Content-Type: multipart/alternative; boundary=bcaec501638b6c8ed304df5b55ed
Subject: Re: [Openvpn-devel] Native OS X tunnels
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--bcaec501638b6c8ed304df5b55ed
Content-Type: text/plain; charset=UTF-8

On Sun, Jun 16, 2013 at 5:14 PM, Arne Schwabe <arne@...1227...> wrote:

>
> I think using utun as default at least for -master and 2.4rc candidates is
> a good way to get the feature tested. I hope there is time in the next
> OpenVPN developer IRC meeting to decide if my or your patch should be
> included.


I won't be in the IRC chat, so here are my comments on Arne's patch vs.
Peter's patch from a feature perspective:

The behavior difference between the two patches seems to be that Arne's
patch defaults to using utun, whereas Peter's patch defaults to tun.

From what I understand, utun seems to work and even works in some
situations where the standard tuntaposx tun doesn't and is the
Apple-supported standard. So I think users should transition to using it.
To help them along, I think defaulting to utun is a good idea.

I intend to add 2.4rc builds to Tunnelblick when they are available and to
support utun on 10.7+ systems. (Tunnelblick lets users choose which OpenVPN
version they use; usually I allow two or three choices, so it's easy to add
new versions of OpenVPN for testing.)

Whichever patch is included, I think Tunnelblick's default will be to use
utun, and give the user a way to override that and use tun. It looks like I
can easily use tun with Arne's patch by specifying "--dev-type tun" to
revert to using tun, and easily use utun with Peter's patch by
specifying "--dev-impl-osx
utun".

I have a slight preference forArne's patch, which doesn't introduce yet
another new OpenVPN option.

I am not expressing an opinion on the code in the patches, but only on
their default behaviors.

--bcaec501638b6c8ed304df5b55ed
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">On Sun, Jun 16, 2013 at 5:14 PM, Arne Schwabe <span dir=3D=
"ltr">&lt;<a href=3D"mailto:arne@...1227..." target=3D"_blank">arne@...1830...=
...</a>&gt;</span> wrote:<br><div class=3D"gmail_extra"><div class=3D"gmail=
_quote">


<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left-width:1px;border-left-color:rgb(204,204,204);border-left-style:solid;p=
adding-left:1ex"><div><br></div>
I think using utun as default at least for -master and 2.4rc candidates is =
a good way to get the feature tested. I hope there is time in the next Open=
VPN developer IRC meeting to decide if my or your patch should be included.=
</blockquote>


<div><br></div><div style>I won&#39;t be in the IRC chat, so here are my co=
mments on Arne&#39;s patch vs. Peter&#39;s patch from a feature perspective=
:</div><div style><br></div><div style>The behavior difference between the =
two patches seems to be that Arne&#39;s patch defaults to using utun, where=
as Peter&#39;s patch defaults to tun.</div>

<div style><br></div><div style>From what I understand, utun seems to work =
and even works in some situations where the standard tuntaposx tun doesn&#3=
9;t and is the Apple-supported standard. So I think users should transition=
 to using it. To help them along, I think defaulting to utun is a good idea=
.</div>

<div><br></div><div>I intend to add 2.4rc builds to Tunnelblick when they a=
re available and to support utun on 10.7+ systems. (Tunnelblick lets users =
choose which OpenVPN version they use; usually I allow two or three choices=
, so it&#39;s easy to add new versions of OpenVPN for testing.)</div>

<div><br></div><div style>Whichever patch is included, I think Tunnelblick&=
#39;s default will be to use utun, and give the user a way to override that=
 and use tun. It looks like I can easily use tun with Arne&#39;s patch by s=
pecifying &quot;--dev-type tun&quot; to revert to using tun, and easily use=
 utun with Peter&#39;s patch by specifying &quot;<span style=3D"font-family=
:arial,sans-serif;font-size:13px">--dev-impl-osx utun&quot;.</span></div>

<div style><br></div><div>I have a slight preference forArne&#39;s patch, w=
hich doesn&#39;t introduce yet another new OpenVPN option.</div><div><br></=
div><div>I am not expressing an opinion on the code in the patches, but onl=
y on their default behaviors.<br>

</div></div></div></div>

--bcaec501638b6c8ed304df5b55ed--

