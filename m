MIME-Version: 1.0
In-Reply-To: <1483905658-25267-1-git-send-email-selva.nair@...277...>
References: <1483905658-25267-1-git-send-email-selva.nair@...277...>
From: Selva Nair <selva.nair@...277...>
Date: Fri, 13 Jan 2017 10:19:09 -0500
Message-ID: <CAKuzo_j-TJhKM4YaTpjotDU+i06pVqdU__eM9DB-DOks_gmCgw@...278...>
Content-Type: multipart/alternative; boundary=001a1149b0a43bcede0545fb5c91
Subject: Re: [Openvpn-devel] [PATCH] Fix user's group membership check in
 interactive service to work with domains
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--001a1149b0a43bcede0545fb5c91
Content-Type: text/plain; charset=UTF-8

Hi,

This is like talking to myself, but here goes:

On Sun, Jan 8, 2017 at 3:00 PM, <selva.nair@...277...> wrote:

> Currently the username unqualified by the domain is used to validate
> a user which fails for domain users. Instead compare the user's SID
> with SIDs in the Administrators group and ovpn_admin_group.
>
> This has the advantage that connection to a domain controller is not
> required and will work even when user is logged in with cached credentials.
>
> Limitations:
> (i) Group membership is not checked recursively
> (ii) Domain administrators will not be recognized as members of local
> Administrators group.
>
> Resolves Trac: #810
>

Based on further discussions on Trac: #810, domain admins are
understandably not pleased with those limitations. I'll submit a v2.

Selva

--001a1149b0a43bcede0545fb5c91
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra">Hi,<br><br></div><div class=3D"=
gmail_extra">This is like talking to myself, but here goes:<br><br></div><d=
iv class=3D"gmail_extra"><div class=3D"gmail_quote">On Sun, Jan 8, 2017 at =
3:00 PM,  <span dir=3D"ltr">&lt;<a href=3D"mailto:selva.nair@...277..." tar=
get=3D"_blank">selva.nair@...277...</a>&gt;</span> wrote:<br><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;p=
adding-left:1ex"><div id=3D":2eu" class=3D"a3s aXjCH m1597fab7f0fe2eae">Cur=
rently the username unqualified by the <span class=3D"il">domain</span> is =
used to validate<br>
a user which fails for <span class=3D"il">domain</span> users. Instead comp=
are the user&#39;s SID<br>
with SIDs in the Administrators group and ovpn_admin_group.<br>
<br>
This has the advantage that connection to a <span class=3D"il">domain</span=
> controller is not<br>
required and will work even when user is logged in with cached credentials.=
<br>
<br>
Limitations:<br>
(i) Group membership is not checked recursively<br>
(ii) <span class=3D"il">Domain</span> administrators will not be recognized=
 as members of local<br>
Administrators group.<br>
<br>
Resolves Trac: #810</div></blockquote></div><br></div><div class=3D"gmail_e=
xtra">Based on further discussions on Trac: #810, domain admins are underst=
andably not pleased with those limitations. I&#39;ll submit a v2.<br><br></=
div><div class=3D"gmail_extra">Selva<br></div></div>

--001a1149b0a43bcede0545fb5c91--

