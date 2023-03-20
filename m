MIME-Version: 1.0
References: <20230318141330.1315235-1-selva.nair@...277...>
 <202303201757.32KHvjTh071877@...2054...>
In-Reply-To: <202303201757.32KHvjTh071877@...2054...>
From: Selva Nair <selva.nair@...277...>
Date: Mon, 20 Mar 2023 14:07:14 -0400
Message-ID: <CAKuzo_hZZT=9tYmi7ZiqAnyMtjifRGuAGZUo1GSbSfQSAiPEaw@...278...>
Content-Type: multipart/alternative; boundary="000000000000de0f9005f758cc35"
Subject: Re: [Openvpn-devel] [PATCH applied] Re: Improve error message on
 short read from socks proxy
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

--000000000000de0f9005f758cc35
Content-Type: text/plain; charset="UTF-8"

>
>
>
> Thanks, this change makes sense.  I have not actively tried to provoke
> it (like, by connecting to a "fake SOCKS server" that will trigger it),
> but the change is obviously an improvement to "if it's not ==1, it
> must be a TCP error!").
>

An easy way to "provoke" this is to use openssh proxy (say, -D 1080) and
use it to proxy to a udp server. SSH will close the connection as it does
not
support udp association. Probably it should return one of the socks5 error
code instead, but doesn't. Even if it did, our recv_socks_reply() is not
capable of
handling such errors.

Selva

--000000000000de0f9005f758cc35
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_quote"><blockquote class=3D"gmail_quot=
e" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204)=
;padding-left:1ex"><br><br>
Thanks, this change makes sense.=C2=A0 I have not actively tried to provoke=
<br>
it (like, by connecting to a &quot;fake SOCKS server&quot; that will trigge=
r it),<br>
but the change is obviously an improvement to &quot;if it&#39;s not =3D=3D1=
, it <br>
must be a TCP error!&quot;).<br></blockquote><div><br></div><div>An easy wa=
y to &quot;provoke&quot; this is to use openssh proxy (say, -D 1080) and</d=
iv><div>use it to proxy to a udp server. SSH will close the connection as i=
t does not</div><div>support udp association. Probably it should return one=
 of the socks5 error</div><div>code=C2=A0instead, but doesn&#39;t. Even if =
it did, our recv_socks_reply() is not capable of</div><div>handling such er=
rors.</div><div><br></div><div>Selva</div></div></div>

--000000000000de0f9005f758cc35--

