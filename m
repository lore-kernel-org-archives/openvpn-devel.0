MIME-Version: 1.0
In-Reply-To: <20170201083355.GT12187@...2182...>
References: <20170131182241.10590-1-a@...2181...>
	<CAKuzo_h69pmh=+jG=xPdprDSPLxR0Z9QhBnD_eM5bh1PUYsKYw@...278...>
	<20170201030455.GN12187@...2182...>
	<20170201083355.GT12187@...2182...>
From: Selva Nair <selva.nair@...277...>
Date: Wed, 1 Feb 2017 11:51:47 -0500
Message-ID: <CAKuzo_gNuXB+UJ_boRPLzCm+AUEaEFtVwxmu=y0UisYd3Uy9Rw@...278...>
Content-Type: multipart/alternative; boundary=001a1141481e838c3905477ade11
Subject: Re: [Openvpn-devel] [PATCH] reload HTTP proxy credentials when
 moving to the next connection profile
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

--001a1141481e838c3905477ade11
Content-Type: text/plain; charset=UTF-8

On Wed, Feb 1, 2017 at 3:33 AM, Antonio Quartulli <a@...2181...> wrote:

> On Wed, Feb 01, 2017 at 11:04:55AM +0800, Antonio Quartulli wrote:
> > > That said, there is one issue with this approach. Looks like SIGUSR1
> > > restarts will now always prompt for proxy password, which is not
> proper.
> >
> > Right! Thanks for pointing this out!
>
> Actually I'd like to understand the expected behaviour: if SIGUSR1 is
> issued,
> openvpn should re-read the file containing the HTTP proxy credentials,
> but, if
> stdin was specified, it should not ask the user for user/pass again ?
>
> So in case of stdin the only way to re-enter the user/pass is to restart
> openvpn?
>
> What's your opinion on this?


I wrote SIGUSR1 but its the same with SIGHUP. All [*] passwords are cached
by default and http-proxy password is always cached (auth-nocache or not).
So the expected behaviour is password to be read only once during the
lifetime of the process unless an auth error happens.

The source of the password does not matter (stdin, systemd, file, mgmt,
inline et..), its always read using get_user_pass which gets it afresh if
no cached copy is available.

With only one cache per password type, this expects passwords are not
remote-specific. As we support only one auth-user-pass or one private key
pass per config I think the intent was to support only one proxy password.
Allowing http-proxy in <connection/> block gives a different impression,
though..

Selva

[*] Not sure about socks password

--001a1141481e838c3905477ade11
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Wed, Feb 1, 2017 at 3:33 AM, Antonio Quartulli <span dir=3D"ltr">&lt;<a =
href=3D"mailto:a@...2181..." target=3D"_blank">a@...2181...</a>&gt;</span> =
wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bord=
er-left:1px #ccc solid;padding-left:1ex"><span>On Wed, Feb 01, 2017 at 11:0=
4:55AM +0800, Antonio Quartulli wrote:<br>
&gt; &gt; That said, there is one issue with this approach. Looks like SIGU=
SR1<br>
&gt; &gt; restarts will now always prompt for proxy password, which is not =
proper.<br>
&gt;<br>
&gt; Right! Thanks for pointing this out!<br>
<br>
</span>Actually I&#39;d like to understand the expected behaviour: if SIGUS=
R1 is issued,<br>
openvpn should re-read the file containing the HTTP proxy credentials, but,=
 if<br>
stdin was specified, it should not ask the user for user/pass again ?<br>
<br>
So in case of stdin the only way to re-enter the user/pass is to restart<br>
openvpn?<br>
<br>
What&#39;s your opinion on this?</blockquote></div><br>I wrote SIGUSR1 but =
its the same with SIGHUP. All [*] passwords are cached by default and http-=
proxy password is always cached (auth-nocache or not). So the expected beha=
viour is password to be read only once during the lifetime of the process u=
nless an auth error happens.</div><div class=3D"gmail_extra"><br></div><div=
 class=3D"gmail_extra">The source of the password does not matter (stdin, s=
ystemd, file, mgmt, inline et..), its always read using get_user_pass which=
 gets it afresh if no cached copy is available.</div><div class=3D"gmail_ex=
tra"><br></div><div class=3D"gmail_extra">With only one cache per password =
type, this expects passwords are not remote-specific. As we support only on=
e auth-user-pass or one private key pass per config I think the intent was =
to support only one proxy password. Allowing http-proxy in &lt;connection/&=
gt; block gives a different impression, though..</div><div class=3D"gmail_e=
xtra"><br></div><div class=3D"gmail_extra">Selva</div><div class=3D"gmail_e=
xtra"><br></div><div class=3D"gmail_extra">[*] Not sure about socks passwor=
d</div></div>

--001a1141481e838c3905477ade11--

