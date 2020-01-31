MIME-Version: 1.0
References: <1580388208-26594-1-git-send-email-selva.nair@...277...>
In-Reply-To: <1580388208-26594-1-git-send-email-selva.nair@...277...>
From: Lev Stipakov <lstipakov@...277...>
Date: Fri, 31 Jan 2020 12:29:30 +0200
Message-ID: <CAGyAFMX6+K_7jzPqnubjJ7oyYR5udq37ZpcR7GDVVfxFV8t_NA@...278...>
Content-Type: multipart/alternative; boundary="0000000000002d053c059d6d0da1"
Subject: Re: [Openvpn-devel] [PATCH] Swap the order of checks for validating
 interactive service user
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva <selva.nair@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--0000000000002d053c059d6d0da1
Content-Type: text/plain; charset="UTF-8"

Hi,

+    if (!ValidateOptions(pipe, sud.directory, sud.options)
> +        && !IsAuthorizedUser(ovpn_user->User.Sid, imp_token,
> settings.ovpn_admin_group)
>      {
>

Closing parenthesis is missing:

>C:\Users\lev\Projects\openvpn\src\openvpnserv\interactive.c(1586,5): error
C2143: syntax error: missing ')' before '{'

Also it is probably just me, but took me a while to figure out what that
code is doing and why.

Could you slightly improve the comment above lines you touch
("Check user is authorized or options are white-listed") and mention
something like
"Non-authorized users are allowed to use only white-listed options and
have config only in global openvpn config directory"?

When I started to debug it, I realized that I have to be authorized user
when config
is in my current user's directory (C:\Users\lev\OpenVPN\config) and not in
"global" config
directory ("C:\Program Files\OpenVPN\config"). Is this by design?

-- 
-Lev

--0000000000002d053c059d6d0da1
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi,</div><div dir=3D"ltr"><br></div><div =
class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margin:0px=
 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">+=
=C2=A0 =C2=A0 if (!ValidateOptions(pipe, sud.directory, sud.options)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;&amp; !IsAuthorizedUser(ovpn_user-&gt;Use=
r.Sid, imp_token, settings.ovpn_admin_group)<br>
=C2=A0 =C2=A0 =C2=A0{<br></blockquote><div><br></div><div>Closing parenthes=
is is missing:</div><div><br></div><div>&gt;C:\Users\lev\Projects\openvpn\s=
rc\openvpnserv\interactive.c(1586,5): error C2143: syntax error: missing &#=
39;)&#39; before &#39;{&#39;<br></div><div><br></div><div>Also it is probab=
ly just me, but took me a while to figure out what that code is doing and w=
hy.=C2=A0</div><div><br></div><div>Could you slightly improve the comment a=
bove lines you touch</div><div>(&quot;Check user is authorized or options a=
re white-listed&quot;) and mention something like</div><div>&quot;Non-autho=
rized users are allowed to use only white-listed options and</div><div>have=
 config only in global openvpn config directory&quot;?</div><div><br></div>=
<div>When I started to debug=C2=A0it, I realized that I have to be authoriz=
ed user when config</div><div>is in my current user&#39;s directory (C:\Use=
rs\lev\OpenVPN\config) and not in &quot;global&quot; config</div><div>direc=
tory (&quot;C:\Program Files\OpenVPN\config&quot;). Is this by design?</div=
><div>=C2=A0</div></div>-- <br><div dir=3D"ltr" class=3D"gmail_signature">-=
Lev</div></div>

--0000000000002d053c059d6d0da1--

