MIME-Version: 1.0
In-Reply-To: <1389441036-12538-1-git-send-email-gert@...1296...>
References: <1389441036-12538-1-git-send-email-gert@...1296...>
Date: Sat, 11 Jan 2014 16:56:32 +0100
Message-ID: <CAA1AbxKd_eEV0q=-XdWPtd+GLsHKgsZAJN7A0UZWNA1=te1VpA@...278...>
From: Steffan Karger <steffan@...1856...>
Content-Type: multipart/alternative; boundary=001a11c36decf8feb204efb3e240
Subject: Re: [Openvpn-devel] [PATCH v2] Document issue with --chroot,
 /dev/urandom and PolarSSL.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--001a11c36decf8feb204efb3e240
Content-Type: text/plain; charset=ISO-8859-1

ACK

-Steffan
On 11 Jan 2014 12:51, "Gert Doering" <gert@...1296...> wrote:

> See trac#218
>
> Signed-off-by: Gert Doering <gert@...1296...>
> ---
>  doc/openvpn.8 | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/doc/openvpn.8 b/doc/openvpn.8
> index 7736c63..f694080 100644
> --- a/doc/openvpn.8
> +++ b/doc/openvpn.8
> @@ -2097,6 +2097,16 @@ In many cases, the
>  parameter can point to an empty directory, however
>  complications can result when scripts or restarts
>  are executed after the chroot operation.
> +
> +Note: if OpenVPN is built using the PolarSSL SSL
> +library,
> +.B \-\-chroot
> +will only work if a /dev/urandom device node is available
> +inside the chroot directory
> +.B dir.
> +This is due to the way PolarSSL works (it wants to open
> +/dev/urandom every time randomness is needed, not just once
> +at startup) and nothing OpenVPN can influence.
>  .\"*********************************************************
>  .TP
>  .B \-\-setcon context
> --
> 1.8.3.2
>
>
>
> ------------------------------------------------------------------------------
> CenturyLink Cloud: The Leader in Enterprise Cloud Services.
> Learn Why More Businesses Are Choosing CenturyLink Cloud For
> Critical Workloads, Development Environments & Everything In Between.
> Get a Quote or Start a Free Trial Today.
>
> http://pubads.g.doubleclick.net/gampad/clk?id=119420431&iu=/4140/ostg.clktrk
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>

--001a11c36decf8feb204efb3e240
Content-Type: text/html; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr">ACK</p>
<p dir=3D"ltr">-Steffan</p>
<div class=3D"gmail_quote">On 11 Jan 2014 12:51, &quot;Gert Doering&quot; &=
lt;<a href=3D"mailto:gert@...1296...">gert@...1296...</a>&gt; wrote:<br typ=
e=3D"attribution"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .=
8ex;border-left:1px #ccc solid;padding-left:1ex">
See trac#218<br>
<br>
Signed-off-by: Gert Doering &lt;<a href=3D"mailto:gert@...1296...">gert@...493...=
1296...</a>&gt;<br>
---<br>
=A0doc/openvpn.8 | 10 ++++++++++<br>
=A01 file changed, 10 insertions(+)<br>
<br>
diff --git a/doc/openvpn.8 b/doc/openvpn.8<br>
index 7736c63..f694080 100644<br>
--- a/doc/openvpn.8<br>
+++ b/doc/openvpn.8<br>
@@ -2097,6 +2097,16 @@ In many cases, the<br>
=A0parameter can point to an empty directory, however<br>
=A0complications can result when scripts or restarts<br>
=A0are executed after the chroot operation.<br>
+<br>
+Note: if OpenVPN is built using the PolarSSL SSL<br>
+library,<br>
+.B \-\-chroot<br>
+will only work if a /dev/urandom device node is available<br>
+inside the chroot directory<br>
+.B dir.<br>
+This is due to the way PolarSSL works (it wants to open<br>
+/dev/urandom every time randomness is needed, not just once<br>
+at startup) and nothing OpenVPN can influence.<br>
=A0.\&quot;*********************************************************<br>
=A0.TP<br>
=A0.B \-\-setcon context<br>
--<br>
1.8.3.2<br>
<br>
<br>
---------------------------------------------------------------------------=
---<br>
CenturyLink Cloud: The Leader in Enterprise Cloud Services.<br>
Learn Why More Businesses Are Choosing CenturyLink Cloud For<br>
Critical Workloads, Development Environments &amp; Everything In Between.<b=
r>
Get a Quote or Start a Free Trial Today.<br>
<a href=3D"http://pubads.g.doubleclick.net/gampad/clk?id=3D119420431&amp;iu=
=3D/4140/ostg.clktrk" target=3D"_blank">http://pubads.g.doubleclick.net/gam=
pad/clk?id=3D119420431&amp;iu=3D/4140/ostg.clktrk</a><br>
_______________________________________________<br>
Openvpn-devel mailing list<br>
<a href=3D"mailto:Openvpn-devel@lists.sourceforge.net">Openvpn-devel@...1199...=
sourceforge.net</a><br>
<a href=3D"https://lists.sourceforge.net/lists/listinfo/openvpn-devel" targ=
et=3D"_blank">https://lists.sourceforge.net/lists/listinfo/openvpn-devel</a=
><br>
</blockquote></div>

--001a11c36decf8feb204efb3e240--

