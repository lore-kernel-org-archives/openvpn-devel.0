MIME-Version: 1.0
References: <201907221844.x6MIiHtw009666@...2054...>
 <1563892487-12063-1-git-send-email-lstipakov@...277...>
 <20191030103148.GO40538@...1296...>
In-Reply-To: <20191030103148.GO40538@...1296...>
From: Lev Stipakov <lstipakov@...277...>
Date: Wed, 30 Oct 2019 14:24:17 +0200
Message-ID: <CAGyAFMUW+BBYGHfY8k5w=OQKy0_uBrUtBjoVuiMZwuJEXzE+ug@...278...>
Content-Type: multipart/alternative; boundary="00000000000097261405961fd073"
Subject: Re: [Openvpn-devel] [PATCH v2 release/2.4] Fix broken
 fragment/mssfix with NCP
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--00000000000097261405961fd073
Content-Type: text/plain; charset="UTF-8"

Hi,


> with NCP:      MSS: 1460 -> 1203
> --ncp-disable: MSS: 1284 -> 1211
>
> ... and the very same numbers from master...
>


> So, I'm wondering how to proceed here...
>

As it turns out, the fix is correct but explanation is not quite clear.

The problem is not in incorrect MSS value (it is correct), but
inside openvpn's fragmentation logic, which decides
"to fragment or not to fragment".

Without this patch, fragmentation logic incorrectly uses max crypto
overhead when calculating packet size. It exceeds fragment size and
openvpn peforms fragmentation:

> sudo tcpdump port 1194
13:59:06.956394 IP server.fi.openvpn > nat2.panoulu.net.openvpn: UDP,
length 652
13:59:06.956489 IP server.fi.openvpn > nat2.panoulu.net.openvpn: UDP,
length 648

With this patch, an actual crypto overhead is used and no unnecessary
fragmentation is performed:

> sudo tcpdump port 1194
13:58:08.685915 IP server.fi.openvpn > nat2.panoulu.net.openvpn: UDP,
length 1272
13:58:08.686007 IP server.fi.openvpn > nat2.panoulu.net.openvpn: UDP,
length 1272

I will send v3 with a better explanation.

-- 
-Lev

--00000000000097261405961fd073
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi,</div><div class=3D"gmail_quote"><div>=C2=A0</div>=
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left:1px solid rgb(204,204,204);padding-left:1ex">
with NCP:=C2=A0 =C2=A0 =C2=A0 MSS: 1460 -&gt; 1203<br>
--ncp-disable: MSS: 1284 -&gt; 1211<br>
<br>
... and the very same numbers from master...<br></blockquote><div>=C2=A0</d=
iv><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bord=
er-left:1px solid rgb(204,204,204);padding-left:1ex">
So, I&#39;m wondering how to proceed here...<br></blockquote><div><br></div=
><div>As it turns out, the fix is correct but explanation is not quite clea=
r.</div><div><br></div><div>The problem is not in incorrect MSS value (it i=
s correct), but</div><div>inside openvpn&#39;s fragmentation logic, which d=
ecides</div><div>&quot;to fragment or not to fragment&quot;.</div><div><br>=
</div><div>Without this patch, fragmentation logic incorrectly uses max cry=
pto</div><div>overhead when calculating packet size. It exceeds fragment si=
ze and</div><div>openvpn peforms fragmentation:</div><div><br></div><div>&g=
t;=C2=A0sudo tcpdump port 1194</div><div>13:59:06.956394 IP server.fi.openv=
pn &gt; nat2.panoulu.net.openvpn: UDP, length 652<br>13:59:06.956489 IP=20

server.fi.openvpn &gt; nat2.panoulu.net.openvpn: UDP, length 648<br></div><=
div><br></div><div>With this patch, an actual crypto overhead is used and n=
o unnecessary</div><div>fragmentation is performed:</div><div><br></div><di=
v>&gt;=C2=A0sudo tcpdump port 1194=C2=A0=C2=A0<br></div><div>13:58:08.68591=
5 IP server.fi.openvpn &gt; nat2.panoulu.net.openvpn: UDP, length 1272<br>1=
3:58:08.686007 IP=20

server.fi.openvpn &gt; nat2.panoulu.net.openvpn: UDP, length 1272<br></div>=
<div><br></div><div>I will send v3 with a better explanation.</div><div><br=
></div></div>-- <br><div dir=3D"ltr">-Lev</div></div>

--00000000000097261405961fd073--

