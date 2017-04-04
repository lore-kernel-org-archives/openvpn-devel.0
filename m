MIME-Version: 1.0
In-Reply-To: <CAA1AbxKDk40-RF68g-OadXtQxToH3oZ8C5B7Q7h27E1BEu-Opg@...278...>
References: <61a238ea-3a52-da19-9a21-a127540e2b5e@...515...>
	<CAFHpkQG3GOm-GKj24pccyn84pZaA=KsvMgfqYLVjs9DxEo6Y5w@...278...>
	<0a77ede7-0374-ed7a-a10e-20d0ac9e31b9@...2080...>
	<95c70c5e-22ac-81ab-0fca-b9195f426f7a@...1856...>
	<a0821983-407a-dd9f-dbac-47f94a18c4dd@...515...>
	<ea1e3d78-2534-e918-5b46-ac510822415d@...1147...>
	<b0dbe975-53c0-65e0-27f3-788c3156dc11@...2080...>
	<CAKuzo_j1hHgnDuFjTt4jYZg5q1QL5U15=iiLsYT-Uao++sYACQ@...278...>
	<CAA1AbxKDk40-RF68g-OadXtQxToH3oZ8C5B7Q7h27E1BEu-Opg@...278...>
From: Selva Nair <selva.nair@...277...>
Date: Tue, 4 Apr 2017 10:43:18 -0400
Message-ID: <CAKuzo_hFhDFK5F-w6fZ22wPpMN7caXLSDBwYevTzmmy2gNHTxA@...278...>
Content-Type: multipart/alternative; boundary=001a1141b2ec2a1476054c584d7a
Subject: Re: [Openvpn-devel] Upgrading EasyRSA 2's defaults
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan@...1856...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--001a1141b2ec2a1476054c584d7a
Content-Type: text/plain; charset=UTF-8

Hi,

On Tue, Apr 4, 2017 at 3:48 AM, Steffan Karger <steffan@...1856...> wrote:

> From the openssl man page:
>
> "Beware that with such DSA-style DH parameters, a fresh DH key should
> be created for each use to avoid small-subgroup attacks that may be
> possible otherwise."
>
> This means that if for some reason a non-ephemeral diffie-hellman
> cipher suite is selected, you are at risk of these attacks.
>

Thanks for the clarification.

Selva

--001a1141b2ec2a1476054c584d7a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra">Hi,</div><div class=3D"gmail_ex=
tra"><br><div class=3D"gmail_quote">On Tue, Apr 4, 2017 at 3:48 AM, Steffan=
 Karger <span dir=3D"ltr">&lt;<a href=3D"mailto:steffan@...1856..." target=
=3D"_blank">steffan@...1856...</a>&gt;</span> wrote:<br><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;bo=
rder-left-color:rgb(204,204,204);border-left-style:solid;padding-left:1ex">=
<div id=3D"m_-6120193760695807519gmail-:3jo" class=3D"m_-612019376069580751=
9gmail-a3s m_-6120193760695807519gmail-aXjCH m_-6120193760695807519gmail-m1=
5b37efee0ab5803">From the openssl man page:<br>
<br>
&quot;Beware that with such DSA-style DH parameters, a fresh DH key should<=
br>
be created for each use to avoid small-subgroup attacks that may be<br>
possible otherwise.&quot;<br>
<br>
This means that if for some reason a non-ephemeral diffie-hellman<br>
cipher suite is selected, you are at risk of these attacks.<br></div></bloc=
kquote></div><br>Thanks for the clarification.</div><div class=3D"gmail_ext=
ra"><div class=3D"gmail_extra"><br></div></div><div class=3D"gmail_extra">S=
elva</div></div>

--001a1141b2ec2a1476054c584d7a--

