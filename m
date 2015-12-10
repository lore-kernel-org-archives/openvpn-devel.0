MIME-Version: 1.0
In-Reply-To: <1449691435-5928-1-git-send-email-gert@...1296...>
References: <1449691435-5928-1-git-send-email-gert@...1296...>
From: Selva Nair <selva.nair@...277...>
Date: Thu, 10 Dec 2015 02:43:44 -0500
Message-ID: <CAKuzo_iHtJjJRfubaBbSCn1=sTa9R_WUFR68JLj4p9as71_EDA@...278...>
Content-Type: multipart/alternative; boundary=047d7bfcefb0f618510526865ef7
Subject: Re: [Openvpn-devel] [PATCH] Fix isatty() check for good.
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

--047d7bfcefb0f618510526865ef7
Content-Type: text/plain; charset=UTF-8

Hi,

Thanks for this fix. Systemd-ask-password now works!

On Wed, Dec 9, 2015 at 3:03 PM, Gert Doering <gert@...1296...> wrote:

> +  if ( !isatty(0) && !isatty(2) )
> +    {
> +      int fd = open( "/dev/tty", O_RDWR );
> +      if ( fd < 0 )
>

This doesn't allow for reading passwords from pipes -- not relevant if
getpass doesn't fall back to a non-tty stdin if /dev/tty open fails -- does
it? Not saying pipes should be supported --- whatever is consistent with
getpass should be fine.


> +       { msg(M_FATAL, "neither stdin nor stderr are a tty device and you
> have neither a controlling tty nor systemd - can't ask for '%s'.  If you
> used --daemon, you need to use --askpass to make passphrase-protected keys
> work, and you can not use --auth-nocache.", prompt ); }
> +      close(fd);
>

The error message is still incomplete/confusing when the triggered by
auth-user-pass
without a filename (i.e stdin), and not by a passphrase-protected key. In
the former case a reference to the need for management-query or a
username-password
file is helpful.

Other than that, the patch does the right thing, and works well. Tested
using git- master with and without systemd. ACK from me.

Selva

--047d7bfcefb0f618510526865ef7
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra">Hi,<br><br></div><div class=3D"=
gmail_extra">Thanks for this fix. <span>Systemd</span>-ask-password now wor=
ks!<br><br></div><div class=3D"gmail_extra"><div class=3D"gmail_quote">On W=
ed, Dec 9, 2015 at 3:03 PM, Gert <span>Doering</span> <span dir=3D"ltr">&lt=
;<a href=3D"mailto:gert@...1296..." target=3D"_blank"><span>gert</span>@<sp=
an>greenie</span>.<span>muc</span>.<span>de</span></a>&gt;</span> wrote:<br=
><blockquote style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(20=
4,204,204);padding-left:1ex" class=3D"gmail_quote">+=C2=A0 if ( !isatty(0) =
&amp;&amp; !isatty(2) )<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 int fd =3D open( &quot;/dev/tty&quot;, O_RDWR );<br>
+=C2=A0 =C2=A0 =C2=A0 if ( fd &lt; 0 )<br></blockquote><div><br>This doesn&=
#39;t allow for reading passwords from pipes -- not relevant if <span>getpa=
ss</span> doesn&#39;t fall back to a non-<span>tty</span> <span>stdin</span=
> if /<span>dev</span>/<span>tty</span> open fails -- does it? Not saying p=
ipes should be supported --- whatever is consistent with <span>getpass</spa=
n> should be fine.<br>=C2=A0 <br></div><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padd=
ing-left:1ex"><div style=3D"overflow:hidden">+=C2=A0 =C2=A0 =C2=A0 =C2=A0{ =
msg(M_FATAL, &quot;neither stdin nor stderr are a tty device and you have n=
either a controlling tty nor systemd - can&#39;t ask for &#39;%s&#39;.=C2=
=A0 If you used --daemon, you need to use --askpass to make passphrase-prot=
ected keys work, and you can not use --auth-nocache.&quot;, prompt ); }<br>
+=C2=A0 =C2=A0 =C2=A0 close(fd);</div></blockquote></div><br></div><div cla=
ss=3D"gmail_extra">The error message is still incomplete/confusing when the=
 triggered by <span>auth</span>-user-pass without a <span>filename</span> (=
i.e <span>stdin</span>), and not by a <span>passphrase</span>-protected key=
. In the former case a reference to the need for management-query or a <spa=
n>username</span>-password file is helpful.<br><br></div><div class=3D"gmai=
l_extra">Other than that, the patch does the right thing, and works well. T=
ested using git- master with and without <span>systemd</span>. <span>ACK</s=
pan> from me.<br><br></div><div class=3D"gmail_extra"><span>Selva</span><br=
></div></div>

--047d7bfcefb0f618510526865ef7--

