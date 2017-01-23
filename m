MIME-Version: 1.0
In-Reply-To: <1484428589-7882-1-git-send-email-selva.nair@...277...>
References: <1483905658-25267-1-git-send-email-selva.nair@...277...>
	<1484428589-7882-1-git-send-email-selva.nair@...277...>
From: Selva Nair <selva.nair@...277...>
Date: Mon, 23 Jan 2017 14:48:00 -0500
Message-ID: <CAKuzo_hwEqhU+xpQ6NmEr8XdD97GsDTSRUuHjMv_0efFuY2z-g@...278...>
Content-Type: multipart/alternative; boundary=001a114fb0041e342b0546c8488e
Subject: Re: [Openvpn-devel] [PATCH v2] Fix user's group membership check in
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

--001a114fb0041e342b0546c8488e
Content-Type: text/plain; charset=UTF-8

Hi,

On Sat, Jan 14, 2017 at 4:16 PM, <selva.nair@...277...> wrote:

> From: Selva Nair <selva.nair@...277...>
>
> Currently the username unqualified by the domain is used to validate
> a user which fails for domain users. Instead authorize the user
>
> (i) if the built-in admin group or ovpn_admin group is in the process token
> (ii) else if the user's SID is in the built-in admin or ovpn_admin groups
>
> The second check is needed to recognize dynamic updates to group membership
> on the local machine that will not be reflected in the token.
>
> These checks do not require connection to a domain controller and will
> work even when user is logged in with cached credentials.
>
> Resolves Trac: #810
>
> v2: include the token check as described above


Bump :) This addresses a critical issue that I would like to see fixed in
2.4.1..

Thanks,

Selva

--001a114fb0041e342b0546c8488e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra">Hi,</div><div class=3D"gmail_ex=
tra"><br><div class=3D"gmail_quote">On Sat, Jan 14, 2017 at 4:16 PM,  <span=
 dir=3D"ltr">&lt;<a href=3D"mailto:selva.nair@...277..." target=3D"_blank">=
selva.nair@...277...</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_qu=
ote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex=
"><span class=3D"">From: Selva Nair &lt;<a href=3D"mailto:selva.nair@...1482...=
...">selva.nair@...277...</a>&gt;<br>
<br>
Currently the username unqualified by the domain is used to <span class=3D"=
il">validate</span><br>
</span>a user which fails for domain users. Instead authorize the user<br>
<br>
(i) if the built-in admin group or ovpn_admin group is in the process token=
<br>
(ii) else if the user&#39;s SID is in the built-in admin or ovpn_admin grou=
ps<br>
<br>
The second check is needed to recognize dynamic updates to group membership=
<br>
on the local machine that will not be reflected in the token.<br>
<br>
These checks do not require connection to a domain controller and will<br>
<span class=3D"">work even when user is logged in with cached credentials.<=
br>
<br>
</span>Resolves Trac: #810<br>
<br>
v2: include the token check as described above</blockquote></div><br>Bump :=
) This addresses a critical issue that I would like to see fixed in 2.4.1..=
</div><div class=3D"gmail_extra"><br></div><div class=3D"gmail_extra">Thank=
s,</div><div class=3D"gmail_extra"><br></div><div class=3D"gmail_extra">Sel=
va</div></div>

--001a114fb0041e342b0546c8488e--

