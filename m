MIME-Version: 1.0
In-Reply-To: <20140225082237.GN16637@...1296...>
References: <5302AADC.80801@...277...> <20140218085500.GU16637@...1296...>
	<530340C4.5060702@...277...>
	<20140218115015.GW16637@...1296...>
	<5304AFE4.2050702@...277...> <530917A4.4050905@...1528...>
	<53093043.9080808@...277...> <5309B31C.50208@...1856...>
	<530A9219.8050809@...277...>
	<530BE62F.4090709@...1856...> <20140225082237.GN16637@...1296...>
From: Steffan Karger <steffan@...1856...>
Date: Tue, 25 Feb 2014 09:48:28 +0100
Message-ID: <CAA1AbxJAmvsPUQwiW7p4qP0fXMwwsiDjarp0nPjhwQj5d6PcPA@...278...>
Content-Type: multipart/alternative; boundary=001a11334c3823681c04f3372849
Subject: Re: [Openvpn-devel] [Patch] ECDH support
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

--001a11334c3823681c04f3372849
Content-Type: text/plain; charset=ISO-8859-1

Hi,

On Tue, Feb 25, 2014 at 9:22 AM, Gert Doering <gert@...1296...> wrote:

> > Although there is apparently more work to do to get more cipher suites
> > working, this does give us a start on working with EC-crypto. Maybe this
> > part can go in (once ACK'ed) as 'the start of EC-support', so more
> > people can help improve the code. Any other opinions on this?
>
> - easy to understand and a bit more detailed README
> - ACK from a "trusted contributor" (read: someone who has worked on the
>   OpenVPN crypto code before and knows the pitfalls)
>
> then I'm fine with it
>

As for the README part, I can probably cook up something 'tonight' (CEST).
The ACK can obviously not come from me, but I'll try to make the patch as
easy as possible to review.

- PolarSSL...?


ECDH and ECDSA will work upon upgrade to PolarSSL 1.3, for which I'll send
patches soon.

-Steffan

--001a11334c3823681c04f3372849
Content-Type: text/html; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<br><div><div class=3D"gmail_extra"><br><div class=3D"g=
mail_quote">On Tue, Feb 25, 2014 at 9:22 AM, Gert Doering <span dir=3D"ltr"=
>&lt;<a href=3D"mailto:gert@...1296..." target=3D"_blank">gert@...1296...</=
a>&gt;</span> wrote:<br>


<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">&gt; Although there is apparently more work =
to do to get more cipher suites<br><div>
&gt; working, this does give us a start on working with EC-crypto. Maybe th=
is<br>
&gt; part can go in (once ACK&#39;ed) as &#39;the start of EC-support&#39;,=
 so more<br>
&gt; people can help improve the code. Any other opinions on this?<br>
<br>
</div>- easy to understand and a bit more detailed README<br>
- ACK from a &quot;trusted contributor&quot; (read: someone who has worked =
on the<br>
=A0 OpenVPN crypto code before and knows the pitfalls)<br>
<br>
then I&#39;m fine with it<br></blockquote><div><br></div><div>As for the RE=
ADME part, I can probably cook up something &#39;tonight&#39; (CEST). The A=
CK can obviously not come from me, but I&#39;ll try to make the patch as ea=
sy as possible to review.<br>


</div><div><br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 =
0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
- PolarSSL...?</blockquote><div><br></div><div>ECDH and ECDSA will work upo=
n upgrade to PolarSSL 1.3, for which I&#39;ll send patches soon.<br><br></d=
iv><div>-Steffan<br></div></div></div></div></div>

--001a11334c3823681c04f3372849--

