MIME-Version: 1.0
In-Reply-To: <20170209030138.GD11922@...2182...>
References: <1486581944-29627-1-git-send-email-selva.nair@...277...>
	<20170209030138.GD11922@...2182...>
From: Selva Nair <selva.nair@...277...>
Date: Wed, 8 Feb 2017 23:58:32 -0500
Message-ID: <CAKuzo_goXcLY9u_ymRamQfXcAr3Cn7SV3Xv6xie5Xk=QVXFxvQ@...278...>
Content-Type: multipart/alternative; boundary=94eb2c08849078848f054811d67e
Subject: Re: [Openvpn-devel] [PATCH] Make auth-nocache cooperate with
	auth-token
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Antonio Quartulli <a@...2181...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--94eb2c08849078848f054811d67e
Content-Type: text/plain; charset=UTF-8

Hi,

On Wed, Feb 8, 2017 at 10:01 PM, Antonio Quartulli <a@...2181...> wrote:

> On Wed, Feb 08, 2017 at 02:25:44PM -0500, selva.nair@...277... wrote:
> > From: Selva Nair <selva.nair@...277...>
> >
> > - Keep the username even if auth-nocache is specified so that
> >   any auth_token pushed by the server could be utilized
>
> This means that even when using no auth-token the username will be cached.
> Can this be a security concern?
>

I would consider username as not sensitive  material although not sure
everyone would agree. Unfortunately there is no way to know in advance that
auth-token may get pushed so I can't think of a good way of avoiding this.
A not so secure approach (I considered this first) would be to delay
clearing the username/password to post pushed-options processing, but then
one has to handle cases like what if the push reply never arrives and so
on.. In general its always better to clear sensitive data at the earliest.

The way out would be to do one more purge_user_pass(.., false) after push
processing.. sigh..  will go there only if absolutely necessary.

Selva

--94eb2c08849078848f054811d67e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra">Hi,<br><br></div><div class=3D"=
gmail_extra"><div class=3D"gmail_quote">On Wed, Feb 8, 2017 at 10:01 PM, An=
tonio Quartulli <span dir=3D"ltr">&lt;<a href=3D"mailto:a@...2181..." targe=
t=3D"_blank">a@...2181...</a>&gt;</span> wrote:<br><blockquote class=3D"gma=
il_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-lef=
t:1ex"><span class=3D"">On Wed, Feb 08, 2017 at 02:25:44PM -0500, <a href=
=3D"mailto:selva.nair@...277...">selva.nair@...277...</a> wrote:<br>
&gt; From: Selva Nair &lt;<a href=3D"mailto:selva.nair@...277...">selva.nai=
r@...277...</a>&gt;<br>
&gt;<br>
&gt; - Keep the username even if auth-nocache is specified so that<br>
&gt;=C2=A0 =C2=A0any auth_token pushed by the server could be utilized<br>
<br>
</span>This means that even when using no auth-token the username will be c=
ached.<br>
Can this be a security concern?<br></blockquote><div><br></div><div>I would=
 consider username as not sensitive=C2=A0 material although not sure everyo=
ne would agree. Unfortunately there is no way to know in advance that auth-=
token may get pushed so I can&#39;t think of a good way of avoiding this. A=
 not so secure approach (I considered this first) would be to delay clearin=
g the username/password to post pushed-options processing, but then one has=
 to handle cases like what if the push reply never arrives and so on.. In g=
eneral its always better to clear sensitive data at the earliest.<br><br>Th=
e way out would be to do one more purge_user_pass(.., false) after push pro=
cessing.. sigh..=C2=A0 will go there only if absolutely necessary.<br></div=
><div><br></div><div>Selva <br></div></div></div></div>

--94eb2c08849078848f054811d67e--

