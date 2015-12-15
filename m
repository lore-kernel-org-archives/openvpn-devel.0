MIME-Version: 1.0
In-Reply-To: <20151215211853.GW24952@...1296...>
References: <1450191626-24633-1-git-send-email-samuli@...515...>
	<A9F464ED000E41E49522FF9AE5BCBC84@...2089...>
	<CAKuzo_j-nHghOXSW67kmQyQVk1zOH6tij=Tdf5pD-wFYwn-yUg@...278...>
	<20151215205402.GV24952@...1296...>
	<CAKuzo_g4J=4ZYV9CiWhm5B3LCASxdRTL7jkKHcFby0WA7x88vA@...278...>
	<20151215211853.GW24952@...1296...>
From: Selva Nair <selva.nair@...277...>
Date: Tue, 15 Dec 2015 17:10:57 -0500
Message-ID: <CAKuzo_hMGML9Jrmd7OXVt5aW8CpeX2qzrXNN08rN8k+wCkkdFw@...278...>
Content-Type: multipart/alternative; boundary=047d7ba97a88956e3e0526f711d6
Subject: Re: [Openvpn-devel] [PATCH] Updates to Changes.rst
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--047d7ba97a88956e3e0526f711d6
Content-Type: text/plain; charset=UTF-8

Hi,


> > My original comment about this to an early version of valdikSS' patch
> > was on a different level -- if the user want DNS blocked, failure to
> block
> > should be FATAL. But not respecting ignore-unknown-option only on
> > some platforms doesn't look right.
>
> Well, it is not an "unknown option" on XP...  and the code doesn't really
> lend itself to "just claim it's an unknown option if it cannot be enabled"
> without being truly ugly...
>

Well,
else if (streq (p[0], "block-outside-dns") && !p[1] && win_wfp_init_funcs())
{..
}
will do it, but then one can't print a helpful error for the XP folks. The
current
"die with a nice mssage" is probbaly better ..

Sorry, I know I'm supposed to stop worrying about it :)

Selva

--047d7ba97a88956e3e0526f711d6
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_quote">Hi,<br><div>=C2=A0<br></div><bl=
ockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-lef=
t:1px solid rgb(204,204,204);padding-left:1ex"><div id=3D":4un" class=3D"" =
style=3D"overflow:hidden"><span class=3D"">
&gt; My original comment about this to an early version of valdikSS&#39; pa=
tch<br>
&gt; was on a different level -- if the user want DNS blocked, failure to b=
lock<br>
&gt; should be FATAL. But not respecting ignore-unknown-option only on<br>
&gt; some platforms doesn&#39;t look right.<br>
<br>
</span>Well, it is not an &quot;unknown option&quot; on XP...=C2=A0 and the=
 code doesn&#39;t really<br>
lend itself to &quot;just claim it&#39;s an unknown option if it cannot be =
enabled&quot;<br>
without being truly ugly...<br>
</div></blockquote></div><div class=3D"gmail_extra"><br></div><div class=3D=
"gmail_extra">Well, <br>else if (streq (p[0], &quot;block-outside-dns&quot;=
) &amp;&amp; !p[1] &amp;&amp; win_wfp_init_funcs())<br></div><div class=3D"=
gmail_extra">{..<br>}<br></div><div class=3D"gmail_extra">will do it, but t=
hen one can&#39;t print a helpful error for the XP folks. The current<br>&q=
uot;die with a nice mssage&quot; is probbaly better ..<br><br></div><div cl=
ass=3D"gmail_extra">Sorry, I know I&#39;m supposed to stop worrying about i=
t :)<br><br></div><div class=3D"gmail_extra">Selva<br></div></div>

--047d7ba97a88956e3e0526f711d6--

