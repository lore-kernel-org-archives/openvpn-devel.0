MIME-Version: 1.0
In-Reply-To: <5669A816.70603@...1227...>
References: <1449599329-12968-1-git-send-email-wayne@...2099...>
	<1449599329-12968-2-git-send-email-wayne@...2099...>
	<5669A816.70603@...1227...>
From: Wayne Davison <wayne@...2099...>
Date: Thu, 10 Dec 2015 08:56:14 -0800
Message-ID: <CAHSx_StWk=Es9qg9TSq6yXACPhTLneeeUWNDDaKqp06S0x6R=w@...278...>
Content-Type: multipart/alternative; boundary=047d7b343a30d20a7005268e1647
Subject: Re: [Openvpn-devel] [PATCH 1/2] Fix CR prompt with --auth-user-pass
 & support reading response.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net

--047d7b343a30d20a7005268e1647
Content-Type: text/plain; charset=UTF-8

On Thu, Dec 10, 2015 at 8:28 AM, Arne Schwabe <arne@...1227...> wrote:

> The scenario read the password from file and then ask the password per
> console seems a bit strange.
>

You mean read the password from a file and then ask for the CR from the
console.  If someone combines a server that issues a challenge with the
"--auth-user-pass FILE" option, neither dynamic nor static CR prompts ever
happen, and auth always fails.  This is because those CR sections are
inside the block that is only entered if username_from_stdin ||
password_from_stdin is true, and they are false when a file supplies the
values.  I'll post a patch that separates out just this fix and make it on
the change that moves the isatty() checks out of misc.c.  It is also
improved a bit from my prior patch set in that it moves the user_prompt and
pass_prompt vars into code blocks where they are used (so they don't get
set when they aren't needed).

..wayne..

--047d7b343a30d20a7005268e1647
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Thu, Dec 10, 2015 at 8:28 AM, Arne Schwabe <span dir=3D"ltr">&lt;<a href=
=3D"mailto:arne@...1227..." target=3D"_blank">arne@...1227...</a>&gt;</span=
> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left-width:1px;border-left-color:rgb(204,204,204);border-left-s=
tyle:solid;padding-left:1ex">The scenario read the password from file and t=
hen ask the password per<br>
console seems a bit strange.<br></blockquote><div><br></div><div>You mean r=
ead the password from a file and then ask for the CR from the console.=C2=
=A0 If someone combines a server that issues a challenge with the &quot;--a=
uth-user-pass FILE&quot; option, neither dynamic nor static CR prompts ever=
 happen, and auth always fails.=C2=A0 This is because those CR sections are=
 inside the block that is only entered if username_from_stdin || password_f=
rom_stdin is true, and they are false when a file supplies the values.=C2=
=A0 I&#39;ll post a patch that separates out just this fix and make it on t=
he change that moves the isatty() checks out of misc.c.=C2=A0 It is also im=
proved a bit from my prior patch set in that it moves the user_prompt and p=
ass_prompt vars into code blocks where they are used (so they don&#39;t get=
 set when they aren&#39;t needed).</div></div></div><div class=3D"gmail_ext=
ra"><br clear=3D"all"><div><div class=3D"gmail_signature">..wayne..</div></=
div><div><br></div></div></div>

--047d7b343a30d20a7005268e1647--

