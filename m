MIME-Version: 1.0
In-Reply-To: <345177b8-6ef3-b357-7fea-025b34fa0e3f@...1227...>
References: <1479677932-22078-1-git-send-email-selva.nair@...277...>
	<345177b8-6ef3-b357-7fea-025b34fa0e3f@...1227...>
From: Selva Nair <selva.nair@...277...>
Date: Sun, 20 Nov 2016 23:22:26 -0500
Message-ID: <CAKuzo_jBgo-3Wq_UR797kezfn-2SUJ-1B-aSzbwnqbCxCnja=w@...278...>
Content-Type: multipart/alternative; boundary=001a11408cb607afd80541c802a9
Subject: Re: [Openvpn-devel] [PATCH] Handle --dhcp-option DNS6 on Windows
 using netsh
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

--001a11408cb607afd80541c802a9
Content-Type: text/plain; charset=UTF-8

Hi,

On Sun, Nov 20, 2016 at 5:29 PM, Arne Schwabe <arne@...1227...> wrote:

> Am 20.11.16 um 22:38 schrieb Selva Nair:
> > TODO: set dns servers using the interactive service
> >
>
> I was playing with ANdroid/IPv6 and this. For Android, the resolver
> takes the DNS server always in the order that I give it. Since there are
> now seperate lists for DNS and DNS6 I have to prefer always DNS or DNS6
> and cannot use the order I am given from the server.
>
> I think we refactor the dns_list into a common dns list. I can also do
> this later since this is probably an Android specific problem.
>

Yeah, we'll need a single list to preserve the inter-protocol ordering
info, if that is really important. Does android support a mixed ipv4/ipv6
dns server ordering?

For windows separate lists is more natural and easier to use.

Selva

--001a11408cb607afd80541c802a9
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra">Hi,<br><br></div><div class=3D"=
gmail_extra"><div class=3D"gmail_quote">On Sun, Nov 20, 2016 at 5:29 PM, Ar=
ne Schwabe <span dir=3D"ltr">&lt;<a href=3D"mailto:arne@...1227..." target=
=3D"_blank">arne@...1227...</a>&gt;</span> wrote:<br><blockquote class=3D"g=
mail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-l=
eft:1ex"><div id=3D"m_-1766351472371240012m_5488659019163099039m_4576959971=
186177076m_1675394096954322686m_-3364861053971832780:2ao" class=3D"m_-17663=
51472371240012m_5488659019163099039m_4576959971186177076m_16753940969543226=
86m_-3364861053971832780a3s m_-1766351472371240012m_5488659019163099039m_45=
76959971186177076m_1675394096954322686m_-3364861053971832780aXjCH m_-176635=
1472371240012m_5488659019163099039m_4576959971186177076m_167539409695432268=
6m_-3364861053971832780m15883dbe25a642b2">Am <span class=3D"m_-176635147237=
1240012m_5488659019163099039m_4576959971186177076m_1675394096954322686m_-33=
64861053971832780aBn"><span class=3D"m_-1766351472371240012m_54886590191630=
99039m_4576959971186177076m_1675394096954322686m_-3364861053971832780aQJ">2=
0.11.16</span></span> um <span class=3D"m_-1766351472371240012m_54886590191=
63099039m_4576959971186177076m_1675394096954322686m_-3364861053971832780aBn=
"><span class=3D"m_-1766351472371240012m_5488659019163099039m_4576959971186=
177076m_1675394096954322686m_-3364861053971832780aQJ">22:38</span></span> s=
chrieb Selva Nair:<br>
<span>&gt; TODO: set dns servers using the interactive service<br>
&gt;<br>
<br>
</span>I was playing with ANdroid/IPv6 and this. For Android, the resolver<=
br>
takes the DNS server always in the order that I give it. Since there are<br>
now seperate lists for DNS and DNS6 I have to prefer always DNS or DNS6<br>
and cannot use the order I am given from the server.<br>
<br>
I think we refactor the dns_list into a common dns list. I can also do<br>
this later since this is probably an Android specific problem.<br></div></b=
lockquote><div><br></div><div>Yeah, we&#39;ll need a single list to preserv=
e the inter-protocol ordering info, if that is really important. Does andro=
id support a mixed ipv4/ipv6 dns server ordering?<br><br></div><div>For win=
dows separate lists is more natural and easier to use.<br><br></div><div>Se=
lva<br></div></div></div></div>

--001a11408cb607afd80541c802a9--

