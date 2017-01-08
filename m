MIME-Version: 1.0
In-Reply-To: <1483905658-25267-1-git-send-email-selva.nair@...277...>
References: <1483905658-25267-1-git-send-email-selva.nair@...277...>
From: Selva Nair <selva.nair@...277...>
Date: Sun, 8 Jan 2017 15:23:38 -0500
Message-ID: <CAKuzo_hzpA2sH=hAe-jqVv8DUUnV_BfGu3KgFHrMLoTqJoEtTg@...278...>
Content-Type: multipart/alternative; boundary=001a1149b9a8f0c78d05459b0742
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

--001a1149b9a8f0c78d05459b0742
Content-Type: text/plain; charset=UTF-8

On Sun, Jan 8, 2017 at 3:00 PM, <selva.nair@...277...> wrote:

> From: Selva Nair <selva.nair@...277...>
>
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

Tested on Windows 7 as local user and domain user.
Also tested by jiquera as described in Trac: #810

--001a1149b9a8f0c78d05459b0742
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Sun, Jan 8, 2017 at 3:00 PM,  <span dir=3D"ltr">&lt;<a href=3D"mailto:se=
lva.nair@...277..." target=3D"_blank">selva.nair@...277...</a>&gt;</span> w=
rote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;borde=
r-left:1px #ccc solid;padding-left:1ex"><div id=3D":1ba" class=3D"a3s aXjCH=
 m1597fab7f0fe2eae">From: Selva Nair &lt;<a href=3D"mailto:selva.nair@...1664...=
7...">selva.nair@...277...</a>&gt;<br>
<br>
Currently the username unqualified by the domain is used to validate<br>
a user which fails for domain users. Instead compare the user&#39;s SID<br>
with SIDs in the Administrators group and ovpn_admin_group.<br>
<br>
This has the advantage that connection to a domain controller is not<br>
required and will work even when user is logged in with cached credentials.=
<br>
<br>
Limitations:<br>
(i) Group membership is not checked recursively<br>
(ii) Domain administrators will not be recognized as members of local<br>
Administrators group.<br>
<br>
Resolves Trac: #810</div></blockquote></div><br></div><div class=3D"gmail_e=
xtra">Tested on Windows 7 as local user and domain user.<br></div><div clas=
s=3D"gmail_extra">Also tested by jiquera as described in Trac: #810<br></di=
v></div>

--001a1149b9a8f0c78d05459b0742--

