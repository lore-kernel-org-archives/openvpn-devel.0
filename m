MIME-Version: 1.0
In-Reply-To: <200909302047.07444.mailinglists@...1145...>
References: <7bb795fd0909251436v2369d6d5q674e63e0621fcd56@...278...> 
	<200909301941.01923.mailinglists@...1145...>
	<7bb795fd0909301120veaf5f48gb65b081cd2cb09a3@...278...> 
	<200909302047.07444.mailinglists@...1145...>
From: JuanJo Ciarlante <jjo+ml@...410...>
Date: Wed, 30 Sep 2009 23:21:41 +0200
Message-ID: <7bb795fd0909301421i5fd974b5xbe8d352b7b7f3c9a@...278...>
Content-Type: multipart/alternative; boundary=001485f792b621d2da0474d21f4d
Subject: Re: [Openvpn-devel] [PATCH] openvpn over ipv6 support -v0.4.6
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: =?ISO-8859-1?Q?Marcel_Pennewi=DF?= <mailinglists@...1145...>
Cc: openvpn-devel@lists.sourceforge.net

--001485f792b621d2da0474d21f4d
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 30, 2009 at 8:47 PM, Marcel Pennewi=DF
<mailinglists@...1145...>wrote:

> On Wednesday 30 September 2009 20:20:40 JuanJo Ciarlante wrote:
> > Could you please copy me the the exact cmdline and context (inetd?)
> > you are using in both cases?, also if there's any extra patch applied,
> etc.
>
> /usr/sbin/openvpn --config /etc/openvpn/tcp.conf --writepid
> /var/run/openvpn.tcp.pid --daemon --setenv
> SVCNAME openvpn.tcp --cd /etc/openvpn
>
> /etc/openvpn/tcp.conf:
> port 897
> proto tcp6-server
> dev tap1
> server-bridge 192.168.42.253 255.255.255.0 192.168.42.1 192.168.42.200
>
> tls-server
> dh /etc/openvpn/files/dh2048.pem
> ca /etc/openvpn/files/ca.pem
> cert /etc/openvpn/files/cert.pem
> key /etc/openvpn/files/key.pem
> comp-lzo
> client-to-client
> client-config-dir /etc/openvpn/clients
> persist-tun
> persist-key
> keepalive 10 120
> script-security 2
> user nobody
> group nogroup
> verb 3
>
> patch applied from gentoo ebuild:
> --- socket.c~   2008-11-02 01:39:00.406009999 +0100
> +++ socket.c    2008-11-02 01:39:00.406009999 +0100
> @@ -22,6 +22,7 @@
>  *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
>  */
>
> +#define _GNU_SOURCE
>  #include "syshead.h"
>
>  #include "socket.h"
>
> thx,
>

Cool ... it's crashing for me also (yaY!) , it's something in the
multi-client path
that I hadn't handled, will work on it tomorrow.

Thanks a lot for the detailed report and info :)

Cheers,

--=20
--JuanJo ; echo jAjo@...1263... | sed 's/[SPAM]//g'

--001485f792b621d2da0474d21f4d
Content-Type: text/html; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

<br><br><div class=3D"gmail_quote">On Wed, Sep 30, 2009 at 8:47 PM, Marcel =
Pennewi=DF <span dir=3D"ltr">&lt;<a href=3D"mailto:mailinglists@...1145..."=
>mailinglists@...1145...</a>&gt;</span> wrote:<br><blockquote class=3D"gmai=
l_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left=
:1ex;">

<div class=3D"im">On Wednesday 30 September 2009 20:20:40 JuanJo Ciarlante =
wrote:<br>
&gt; Could you please copy me the the exact cmdline and context (inetd?)<br>
&gt; you are using in both cases?, also if there&#39;s any extra patch appl=
ied, etc.<br>
<br>
</div>/usr/sbin/openvpn --config /etc/openvpn/tcp.conf --writepid /var/run/=
openvpn.tcp.pid --daemon --setenv<br>
SVCNAME openvpn.tcp --cd /etc/openvpn<br>
<br>
/etc/openvpn/tcp.conf:<br>
port 897<br>
proto tcp6-server<br>
dev tap1<br>
server-bridge 192.168.42.253 255.255.255.0 192.168.42.1 192.168.42.200<br>
<br>
tls-server<br>
dh /etc/openvpn/files/dh2048.pem<br>
ca /etc/openvpn/files/ca.pem<br>
cert /etc/openvpn/files/cert.pem<br>
key /etc/openvpn/files/key.pem<br>
comp-lzo<br>
client-to-client<br>
client-config-dir /etc/openvpn/clients<br>
persist-tun<br>
persist-key<br>
keepalive 10 120<br>
script-security 2<br>
user nobody<br>
group nogroup<br>
verb 3<br>
<br>
patch applied from gentoo ebuild:<br>
--- socket.c~ =A0 2008-11-02 01:39:00.406009999 +0100<br>
+++ socket.c =A0 =A02008-11-02 01:39:00.406009999 +0100<br>
@@ -22,6 +22,7 @@<br>
 =A0* =A059 Temple Place, Suite 330, Boston, MA =A002111-1307 =A0USA<br>
 =A0*/<br>
<br>
+#define _GNU_SOURCE<br>
=A0#include &quot;syshead.h&quot;<br>
<br>
=A0#include &quot;socket.h&quot;<br>
<br>
thx,<br></blockquote><div><br></div><div><span class=3D"Apple-style-span" s=
tyle=3D"font-family: arial, sans-serif; font-size: 13px; border-collapse: c=
ollapse; ">Cool ... it&#39;s crashing for me also (yaY!) , it&#39;s somethi=
ng in the<br>

multi-client path<br>that I hadn&#39;t handled, will work on it tomorrow.<b=
r><br>Thanks a lot for the detailed report and info :)<br><br>Cheers,<br><s=
pan class=3D"Apple-style-span" style=3D"border-collapse: separate; font-siz=
e: small;"><span class=3D"Apple-style-span" style=3D"border-collapse: colla=
pse;"><br>

</span></span></span></div></div>-- <br>--JuanJo ; echo jAjo@...1263... | s=
ed &#39;s/[SPAM]//g&#39;<br>

--001485f792b621d2da0474d21f4d--

