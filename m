MIME-Version: 1.0
References: <20191009143422.9419-3-a@...2181...>
 <201911062041.xA6KfP8R010468@...2054...>
In-Reply-To: <201911062041.xA6KfP8R010468@...2054...>
From: Lev Stipakov <lstipakov@...277...>
Date: Thu, 7 Nov 2019 14:18:25 +0200
Message-ID: <CAGyAFMWBd2GzuZdBfTfGwROPw-hEzqSMUCUY3vrWENeqd1A46w@...278...>
Content-Type: multipart/alternative; boundary="000000000000549cdb0596c0aa6e"
Subject: Re: [Openvpn-devel] [PATCH applied] Re: VLAN: add basic VLAN
 tagging support
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>
Cc: Antonio Quartulli <a@...2181...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--000000000000549cdb0596c0aa6e
Content-Type: text/plain; charset="UTF-8"

This broke (again) Visual Studio build:

> error LNK2019: unresolved external symbol vlan_process_outgoing_tun
referenced in function multi_process_outgoing_tun

Can we please ack and merge this patch
https://patchwork.openvpn.net/patch/868/ to catch these things earlier?

ke 6. marrask. 2019 klo 22.42 Gert Doering (gert@...1296...) kirjoitti:

> Acked-by: Gert Doering <gert@...1296...>
>
> Stared at the code (twice now), run t_client and t_server tests.
>
> This patch does not really *do* much yet, but it lays the groundwork
> for future work - the "broadcast only to clients in the same vlan"
> part is there, but it's always called with "0" (= all clients).  As
> far as I can see, the only notable behavioural change we have so far
> is "if a client is assigned a pvid (!= the global pvid), it will not
> be able to communicate with the TAP interface" (check in vlan.c,
> vlan_process_outgoing_tun()), but client-to-client is still allowed,
> and there is no per-vlan MAC learning yet either.
>
> (Most notably, it only adds options and code relevant for TAP mode)
>
> Your patch has been applied to the master branch.
>
> commit 99f28081477ca325a14b13c38abec2c9b619eb01
> Author: Antonio Quartulli
> Date:   Wed Oct 9 16:34:15 2019 +0200
>
>      VLAN: add basic VLAN tagging support
>
>      Signed-off-by: Fabian Knittel <fabian.knittel@...1547...>
>      Signed-off-by: Antonio Quartulli <a@...2181...>
>      Acked-by: Gert Doering <gert@...1296...>
>      Message-Id: <20191009143422.9419-3-a@...2181...>
>      URL:
> https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg18924.html
>      Signed-off-by: Gert Doering <gert@...1296...>
>
>
> --
> kind regards,
>
> Gert Doering
>
>
>
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>


-- 
-Lev

--000000000000549cdb0596c0aa6e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">This broke (again) Visual Studio build:<div><br></div><div=
>&gt; error LNK2019: unresolved external symbol vlan_process_outgoing_tun r=
eferenced in function multi_process_outgoing_tun<br></div><div><br></div><d=
iv>Can we please ack and merge this patch=C2=A0<a href=3D"https://patchwork=
.openvpn.net/patch/868/">https://patchwork.openvpn.net/patch/868/</a>=C2=A0=
to catch these things earlier?</div></div><br><div class=3D"gmail_quote"><d=
iv dir=3D"ltr" class=3D"gmail_attr">ke 6. marrask. 2019 klo 22.42 Gert Doer=
ing (<a href=3D"mailto:gert@...1296...">gert@...1296...</a>) kirjoitti:<br>=
</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;b=
order-left:1px solid rgb(204,204,204);padding-left:1ex">Acked-by: Gert Doer=
ing &lt;<a href=3D"mailto:gert@...1296..." target=3D"_blank">gert@...2132...=
.</a>&gt;<br>
<br>
Stared at the code (twice now), run t_client and t_server tests.<br>
<br>
This patch does not really *do* much yet, but it lays the groundwork<br>
for future work - the &quot;broadcast only to clients in the same vlan&quot=
;<br>
part is there, but it&#39;s always called with &quot;0&quot; (=3D all clien=
ts).=C2=A0 As<br>
far as I can see, the only notable behavioural change we have so far <br>
is &quot;if a client is assigned a pvid (!=3D the global pvid), it will not=
 <br>
be able to communicate with the TAP interface&quot; (check in vlan.c, <br>
vlan_process_outgoing_tun()), but client-to-client is still allowed,<br>
and there is no per-vlan MAC learning yet either.<br>
<br>
(Most notably, it only adds options and code relevant for TAP mode)<br>
<br>
Your patch has been applied to the master branch.<br>
<br>
commit 99f28081477ca325a14b13c38abec2c9b619eb01<br>
Author: Antonio Quartulli<br>
Date:=C2=A0 =C2=A0Wed Oct 9 16:34:15 2019 +0200<br>
<br>
=C2=A0 =C2=A0 =C2=A0VLAN: add basic VLAN tagging support<br>
<br>
=C2=A0 =C2=A0 =C2=A0Signed-off-by: Fabian Knittel &lt;<a href=3D"mailto:fab=
ian.knittel@...1547..." target=3D"_blank">fabian.knittel@...1547...</a>&gt;=
<br>
=C2=A0 =C2=A0 =C2=A0Signed-off-by: Antonio Quartulli &lt;a@...2181...&gt;<b=
r>
=C2=A0 =C2=A0 =C2=A0Acked-by: Gert Doering &lt;<a href=3D"mailto:gert@...1711...=
96..." target=3D"_blank">gert@...1296...</a>&gt;<br>
=C2=A0 =C2=A0 =C2=A0Message-Id: &lt;20191009143422.9419-3-a@...2181...&gt;<=
br>
=C2=A0 =C2=A0 =C2=A0URL: <a href=3D"https://www.mail-archive.com/openvpn-de=
vel@lists.sourceforge.net/msg18924.html" rel=3D"noreferrer" target=3D"_blan=
k">https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg1892=
4.html</a><br>
=C2=A0 =C2=A0 =C2=A0Signed-off-by: Gert Doering &lt;<a href=3D"mailto:gert@=
...1296..." target=3D"_blank">gert@...1296...</a>&gt;<br>
<br>
<br>
--<br>
kind regards,<br>
<br>
Gert Doering<br>
<br>
<br>
<br>
_______________________________________________<br>
Openvpn-devel mailing list<br>
<a href=3D"mailto:Openvpn-devel@lists.sourceforge.net" target=3D"_blank">Op=
envpn-devel@lists.sourceforge.net</a><br>
<a href=3D"https://lists.sourceforge.net/lists/listinfo/openvpn-devel" rel=
=3D"noreferrer" target=3D"_blank">https://lists.sourceforge.net/lists/listi=
nfo/openvpn-devel</a><br>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
 class=3D"gmail_signature">-Lev</div>

--000000000000549cdb0596c0aa6e--

