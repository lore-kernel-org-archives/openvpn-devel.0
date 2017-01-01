MIME-Version: 1.0
In-Reply-To: <20170101133509.GC78624@...1296...>
References: <1483152307-15687-1-git-send-email-selva.nair@...277...>
	<6910ed3b-4620-ec1a-0079-4bcfdf565627@...277...>
	<20170101133509.GC78624@...1296...>
From: Selva Nair <selva.nair@...277...>
Date: Sun, 1 Jan 2017 13:06:48 -0500
Message-ID: <CAKuzo_jcZ2geuJyN6afu+Qv5iNxSJHoK27E+MqJQqk8cRicEEA@...278...>
Content-Type: multipart/alternative; boundary=94eb2c07481cb4d20805450c4d66
Subject: Re: [Openvpn-devel] [PATCH] Always release dhcp address in
	close_tun()
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--94eb2c07481cb4d20805450c4d66
Content-Type: text/plain; charset=UTF-8

Hi,

On Sun, Jan 1, 2017 at 8:35 AM, Gert Doering <gert@...1296...> wrote:

>
> Now, for this particular patch, I'm a bit undecided - it fixes breakage
> for people, but there's a warning about "unexpected side effects" so
> we might try to figure out why this warning exist.  Less options and
> doing the right thing by default is obviously good :-)



I do not see any bad side-effects mentioned in the man page. Essentially
what it says is --dhcp-renew is not necessary in most setups but may be
needed in some cases (e.g., media status set to always connected -- more on
that below).
And then it says the same "caveats" apply to --dhcp-release. But none of
what is mentioned is a caveat -- its only saying these options are usually
not needed.

However, --dhcp-release appears to be required and at least is a good
practice. We do remove addresses set using netsh or ipapi on disconnect. So
why not remove the one set by dhcp? What Trac #807 shows is that if release
is not called the adapter remembers the previous address and assigning the
same address to another adapter fails. In fact 807 is not just about dhcp,
even a statically assigned ip if left behind on an disconnected adapter
cannot be applied to another. Kind of obvious when stated that way.

On further testing, I've found a way to reproduce a similar behaviour as
Trac #807 even with a single adapter and multiple remotes (assigning
different VPN IPs). But only in a special case: the media status set to
"always connected" (tried on Win10 only). In this case, if there is an
address set on the adpater, Windows does not trigger a dhcp-renew when the
new connection is made  Logically, one would think the --dhcp-renew option
should help here, but for some reason it doesn't. However, dhcp release on
closing tun does fix it.  When there no IP set on the adapter, subsequent
connection does automatically trigger a dhcp renew and all goes well.

So if the bug reported in Trac 665 is related to media status = always
connected, this patch may fix that one too.

That said, the patch should also remove the option --dhcp-release and
associated documentation as it effectively makes release non-optional. I
can do a v2 if the patch is otherwise acceptable. In the mean time I've
added --dhcp-release to all my configs.

Selva

--94eb2c07481cb4d20805450c4d66
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra">Hi,<br><br></div><div class=3D"=
gmail_extra"><div class=3D"gmail_quote">On Sun, Jan 1, 2017 at 8:35 AM, Ger=
t Doering <span dir=3D"ltr">&lt;<a href=3D"mailto:gert@...1296..." target=
=3D"_blank">gert@...1296...</a>&gt;</span> wrote:<br><blockquote class=3D"g=
mail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204=
,204,204);padding-left:1ex"><br>
Now, for this particular patch, I&#39;m a bit undecided - it fixes breakage=
<br>
for people, but there&#39;s a warning about &quot;unexpected side effects&q=
uot; so<br>
we might try to figure out why this warning exist.=C2=A0 Less options and<b=
r>
doing the right thing by default is obviously good :-)</blockquote></div><b=
r><br></div><div class=3D"gmail_extra">I do not see any bad side-effects me=
ntioned in the man page. Essentially what it says is --dhcp-renew is not ne=
cessary in most setups but may be=C2=A0 needed in some cases (e.g., media s=
tatus set to always connected -- more on that below).<br></div><div class=
=3D"gmail_extra">And then it says the same &quot;caveats&quot; apply to --d=
hcp-release. But none of what is mentioned is a caveat -- its only saying t=
hese options are usually not needed.<br><br>However, --dhcp-release appears=
 to be required and at least is a good practice. We do remove addresses set=
 using netsh or ipapi on disconnect. So why not remove the one set by dhcp?=
 What Trac #807 shows is that if release is not called=20
the adapter remembers the previous address and assigning the same address t=
o=20
another adapter fails. In fact 807 is not just about dhcp, even a staticall=
y assigned ip if left behind on an disconnected adapter cannot be applied t=
o another. Kind of obvious when stated that way.<br><br>On further testing,=
 I&#39;ve found a way to reproduce a similar behaviour as Trac #807 even wi=
th a single adapter and multiple remotes (assigning different VPN IPs). But=
 only in a special case: the media status set to &quot;always connected&quo=
t; (tried on Win10 only). In this case, if there is an address set on the a=
dpater, Windows does not trigger a dhcp-renew when the new connection is ma=
de=C2=A0 Logically, one would think the --dhcp-renew option should help her=
e, but for some reason it doesn&#39;t. However, dhcp release on closing tun=
 does fix it.=C2=A0 When there no IP set on the adapter, subsequent connect=
ion does automatically trigger a dhcp renew and all goes well.<br><br></div=
><div class=3D"gmail_extra">So if the bug reported in Trac 665 is related t=
o media status =3D always connected, this patch may fix that one too.<br><b=
r></div><div class=3D"gmail_extra">That said, the patch should also remove =
the option --dhcp-release and associated documentation as it effectively ma=
kes release non-optional. I can do a v2 if the patch is otherwise acceptabl=
e. In the mean time I&#39;ve added --dhcp-release to all my configs.<br></d=
iv><div class=3D"gmail_extra"><br></div><div class=3D"gmail_extra">Selva</d=
iv></div>

--94eb2c07481cb4d20805450c4d66--

