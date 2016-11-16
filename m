MIME-Version: 1.0
In-Reply-To: <ea910160-9005-8ca6-1af5-8594113944e2@...1435...>
References: <1479163508-19435-1-git-send-email-davids@...515...>
	<c4d87247-460c-0860-5748-a62f0304653a@...1435...>
	<3ec6b9c8-7dcd-038c-6bbf-4b136a2e4507@...2080...>
	<ea910160-9005-8ca6-1af5-8594113944e2@...1435...>
From: Selva Nair <selva.nair@...277...>
Date: Wed, 16 Nov 2016 12:27:05 -0500
Message-ID: <CAKuzo_iw72bdL3hdfDkPeo6bMjA3-3z+oR0Bh40PjJQgWyTr_A@...278...>
Content-Type: multipart/alternative; boundary=94eb2c0438e0f839b305416e6244
Subject: Re: [Openvpn-devel] [PATCH] file checks: Merge
 warn_if_group_others_accessible() into check_file_access()
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan.karger@...1435...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--94eb2c0438e0f839b305416e6244
Content-Type: text/plain; charset=UTF-8

On Wed, Nov 16, 2016 at 11:07 AM, Steffan Karger <steffan.karger@...1435...>
wrote:

> > I do not have any Windows test environments, so I'll admit that's a
> > bold (and risky) move of me.  However, as you've identified,
> > S_IRWXG|S_IRWXO is not set so shouldn't cause any issues.
>
> Combined with a compile-test I just this and the fact that the worst
> thing that could happen is an incorrect warning (Windows builds never
> warned before), I feel confident enough to ACK this:
>
> ACK.


But the question is will this compile for windows? I doubt it will unless
we add some dummy defines for S_IRWXG etc..

Selva

--94eb2c0438e0f839b305416e6244
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Wed, Nov 16, 2016 at 11:07 AM, Steffan Karger <span dir=3D"ltr">&lt;<a h=
ref=3D"mailto:steffan.karger@...1435..." target=3D"_blank">steffan.karger@...220...=
..1435...</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=
=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><span>&g=
t; I do not have any Windows test environments, so I&#39;ll admit that&#39;=
s a<br>
&gt; bold (and risky) move of me.=C2=A0 However, as you&#39;ve identified,<=
br>
&gt; S_IRWXG|S_IRWXO is not set so shouldn&#39;t cause any issues.<br>
<br>
</span>Combined with a compile-test I just this and the fact that the worst=
<br>
thing that could happen is an incorrect warning (Windows builds never<br>
warned before), I feel confident enough to ACK this:<br>
<br>
ACK.</blockquote></div><br>But the question is will this compile for window=
s? I doubt it will unless we add some dummy defines for S_IRWXG etc..</div>=
<div class=3D"gmail_extra"><br></div><div class=3D"gmail_extra">Selva</div>=
<div class=3D"gmail_extra"><br></div><div class=3D"gmail_extra"><br></div><=
/div>

--94eb2c0438e0f839b305416e6244--

