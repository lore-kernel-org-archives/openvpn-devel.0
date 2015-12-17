MIME-Version: 1.0
In-Reply-To: <CAKuzo_gVUcS+j0jfoUjSYknd+G_wOqGttxTV60tuB=3RLakg4A@...278...>
References: <CAKuzo_gVUcS+j0jfoUjSYknd+G_wOqGttxTV60tuB=3RLakg4A@...278...>
From: Wayne Davison <wayne@...2099...>
Date: Thu, 17 Dec 2015 14:45:07 -0800
Message-ID: <CAHSx_StE=b4GB28JO46Vzrdh6CYKTEZCr_sU62VzSHX6nH0r+Q@...278...>
Content-Type: multipart/alternative; boundary=089e015370846ba70b05271fc788
Subject: Re: [Openvpn-devel] Issues with challenge-response when user/pass
 is read from a file
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva Nair <selva.nair@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--089e015370846ba70b05271fc788
Content-Type: text/plain; charset=UTF-8

On Thu, Dec 17, 2015 at 1:22 PM, Selva Nair <selva.nair@...277...> wrote:

> (a) leave as is and document that challenge-response is incompatible with
> user and pass from file
>

If people lean this way I think the code would still need to be changed to
fail instead of endlessly looping, sending bad answers back to the server.

(b) prompt for the response from console in both dynamic and static cases
>

That gets my vote, for what that's worth.

Prompting from management works fine as long as auth-user-pass file is not
> set.
>

I assume that would be something you'd fix (or make the program reject).
The current code does not prompt on the management interface for a
challenge/response if someone combines --management,
--management-query-passwords, and an auth-user-pass file.

Ultimately, though, I've switched over to a simple perl script I wrote that
runs a managed openvpn and gives me full control w/o using --auth-user-pass
(since the official release is not going to support reading the
challenge/response from a file).

..wayne..

--089e015370846ba70b05271fc788
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Thu, Dec 17, 2015 at 1:22 PM, Selva Nair <span dir=3D"ltr">&lt;<a href=
=3D"mailto:selva.nair@...277..." target=3D"_blank">selva.nair@...277...</a>=
&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0px=
 0px 0px 0.8ex;border-left-width:1px;border-left-color:rgb(204,204,204);bor=
der-left-style:solid;padding-left:1ex"><div dir=3D"ltr"><div><div><div><div=
><div><div><div>(a) leave as is and document that challenge-response is inc=
ompatible with user and pass from file<br></div></div></div></div></div></d=
iv></div></div></blockquote><div><br></div><div>If people lean this way I t=
hink the code would still need to be changed to fail instead of endlessly l=
ooping, sending bad answers back to the server.</div><div><br></div><blockq=
uote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-wi=
dth:1px;border-left-color:rgb(204,204,204);border-left-style:solid;padding-=
left:1ex"><div dir=3D"ltr"><div><div><div><div><div><div><div></div></div><=
/div></div>(b) prompt for the response from <span>console</span> in both dy=
namic and static cases</div></div></div></div></blockquote><div><br></div><=
div>That gets my vote, for what that&#39;s worth.</div><div><br></div><bloc=
kquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-=
width:1px;border-left-color:rgb(204,204,204);border-left-style:solid;paddin=
g-left:1ex"><div dir=3D"ltr"><div><div>Prompting from management works fine=
 as long as auth-user-pass file is not set.<br></div></div></div></blockquo=
te><div><br></div><div>I assume that would be something you&#39;d fix (or m=
ake the program reject).=C2=A0 The current code does not prompt on the mana=
gement interface for a challenge/response if someone combines --management,=
 --management-query-passwords, and an auth-user-pass file.</div><div><br></=
div><div>Ultimately, though, I&#39;ve switched over to a simple perl script=
 I wrote that runs a managed openvpn and gives me full control w/o using --=
auth-user-pass (since the official release is not going to support reading =
the challenge/response from a file).</div></div></div><div class=3D"gmail_e=
xtra"><br clear=3D"all"><div><div class=3D"gmail_signature">..wayne..</div>=
</div></div></div>

--089e015370846ba70b05271fc788--

