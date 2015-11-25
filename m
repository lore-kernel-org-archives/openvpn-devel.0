MIME-Version: 1.0
In-Reply-To: <565547AB.9030607@...2070...>
References: <564BA6DB.4070703@...2070...>
	<564DE8B3.9030803@...2070...>
	<20151124083944.GY24952@...1296...>
	<5654A314.3080607@...2070...>
	<20151124201135.GM24952@...1296...>
	<CAKuzo_jdcOjunyVmpT8er3HqWG7yh6pr+i8Tn8kD3omj=G_Pqw@...278...>
	<565547AB.9030607@...2070...>
From: Selva Nair <selva.nair@...277...>
Date: Wed, 25 Nov 2015 01:32:38 -0500
Message-ID: <CAKuzo_j6LMPKAkLDpJWiMLCerZ5ORhheUXNPhyRsbEqC6jZaEg@...278...>
Content-Type: multipart/alternative; boundary=001a11443d9e138c92052557a155
Subject: Re: [Openvpn-devel] [PATCH v4-master] Add Windows DNS Leak fix
 using WFP ('block-outside-dns')
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: ValdikSS <iam@...2070...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--001a11443d9e138c92052557a155
Content-Type: text/plain; charset=UTF-8

On Wed, Nov 25, 2015 at 12:31 AM, ValdikSS <iam@...2070...> wrote:

> It's cron2 who wanted clear ifdefs for master, because there's no WinXP
> support there.


If WinXP support is really going away in 2.4, agreed, ifdef WIN32 is
cleaner. That apart, the patch doesn't apply to 2.3, please send in if you
have an updated one.

For the build issue, may be Samuli can help. I built only for Vista+, but
will try building on XP.

Selva

--001a11443d9e138c92052557a155
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Wed, Nov 25, 2015 at 12:31 AM, ValdikSS <span dir=3D"ltr">&lt;<a href=3D=
"mailto:iam@...2070..." target=3D"_blank">iam@...2070...</a>&gt;</span> wro=
te:<br><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;=
border-left:1px solid rgb(204,204,204);padding-left:1ex">It&#39;s cron2 who=
 wanted clear ifdefs for master, because there&#39;s no
    WinXP support there.</blockquote></div><br><div class=3D"gmail_extra">I=
f WinXP support is really going away in 2.4,=20
agreed, ifdef WIN32 is cleaner. That apart, the patch doesn&#39;t apply to=
=20
2.3, please send in if you have an updated one.<br><br></div>For the build =
issue, may be Samuli can help. I built only for Vista+, but will try buildi=
ng on XP.<br><br></div><div class=3D"gmail_extra">Selva<br></div></div>

--001a11443d9e138c92052557a155--

