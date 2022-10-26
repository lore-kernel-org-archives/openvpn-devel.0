MIME-Version: 1.0
References: <20221019224642.11178-1-selva.nair@...277...>
 <Y1kr4zYWRP29K2G2@...1296...>
 <CAKuzo_iRT5SHQUq2jMnBsY6W+wmpVGS2y9d+saVX4dT7D=udiQ@...278...>
 <Y1lKC+75SJEpCYXB@...1296...>
In-Reply-To: <Y1lKC+75SJEpCYXB@...1296...>
From: Selva Nair <selva.nair@...277...>
Date: Wed, 26 Oct 2022 11:54:57 -0400
Message-ID: <CAKuzo_h0CC43=n-PydjH7qcVk5G1XjVZtSqMHmZSgqiJUPRMnA@...278...>
Content-Type: multipart/alternative; boundary="000000000000cd984005ebf20cf4"
Subject: Re: [Openvpn-devel] [PATCH for 2.5/2.6] Purge auth-token as well
 while purging passwords
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

--000000000000cd984005ebf20cf4
Content-Type: text/plain; charset="UTF-8"

Hi


>
> I'm not sure I understand what the intended use of
> --management-forget-disconnect *is* - if it's "disconnected by a button
> press", the GUI can send "forget-passwords", and we do not need this
> option in the first place.
>
> If it's "disconnected by a network hickup", why would one want to
> flush the token here, which is intended to seamlessly reconnect
> after the hickup?
>

Here "disconnect" does not mean disconnect from the server, but disconnect
the management client from the daemon. I like to refer to it as "detach"
from the management interface. When the client detaches it allows another
"client" (may be an interactive  telnet session) to connect.

So the use case I have is this: the daemon is started by automatic service
and is kept running all the time. But the connection requires interactive
password entry so the daemon is waiting for password via management i/f. A
user connects to the management i/f, say, via telnet, enters password, and
completes the connection. When done, the user can stop the tunnel using
management-hold and SIGHUP and detach from the management.

A second user can now connect to the management interface and restart the
tunnel. --management-forget-disconnect is a safety feature in such cases to
ensure the password entered by the first user was forgotten when the user
detached from the interface. Including any cached token.  Sending
"forget-passwords" would also work in this case, but then the user has to
remember each time to send it before detaching.

The actual use case is for the GUI handling persistent connections. In this
case, you are right, we can send forget-passwords whenever we detach from a
persistent or PLAP connection. If users do not want that behaviour by
default, we can make it a configurable option in the GUI. But then
--management-forget-passwords is such a "user-configurable forget-passwords
on detach".

Still not convincing?

Selva

--000000000000cd984005ebf20cf4
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi</div><br><div class=3D"gmail_quote"><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid=
 rgb(204,204,204);padding-left:1ex"><br>
<br>
I&#39;m not sure I understand what the intended use of <br>
--management-forget-disconnect *is* - if it&#39;s &quot;disconnected by a b=
utton<br>
press&quot;, the GUI can send &quot;forget-passwords&quot;, and we do not n=
eed this<br>
option in the first place.<br>
<br>
If it&#39;s &quot;disconnected by a network hickup&quot;, why would one wan=
t to <br>
flush the token here, which is intended to seamlessly reconnect <br>
after the hickup?<br></blockquote><div><br></div><div>Here &quot;disconnect=
&quot; does not mean disconnect from the server, but disconnect the managem=
ent client from the daemon. I like to refer to it as &quot;detach&quot; fro=
m the management interface. When the client detaches it allows another &quo=
t;client&quot; (may be an interactive=C2=A0 telnet session) to connect.</di=
v><div><br></div><div>So the use case I have is this: the daemon is started=
 by automatic service and is kept running=C2=A0all the time. But the connec=
tion requires interactive password entry so the daemon is waiting for passw=
ord via management=C2=A0i/f. A user connects to the management i/f, say, vi=
a telnet, enters password, and completes the connection. When done, the use=
r can stop the tunnel using management-hold and SIGHUP and detach from the =
management.</div><div><br></div><div>A second user can now connect=C2=A0to =
the management=C2=A0interface and restart the tunnel. --management-forget-d=
isconnect is a safety feature in such cases to ensure the password entered =
by the first user was forgotten when the user detached from the interface. =
Including any cached token.=C2=A0 Sending &quot;forget-passwords&quot; woul=
d also work in this case, but then the user has to remember each time to se=
nd it before detaching.</div><div><br></div><div>The actual use case is for=
 the GUI handling persistent connections. In this case, you are right, we c=
an send forget-passwords whenever we detach from a persistent or PLAP conne=
ction. If users do not want that behaviour by default, we can make it a con=
figurable option in the GUI. But then --management-forget-passwords is such=
 a &quot;user-configurable forget-passwords on detach&quot;.</div><div><br>=
</div><div>Still not convincing?</div><div><br></div><div>Selva</div></div>=
</div>

--000000000000cd984005ebf20cf4--

