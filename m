MIME-Version: 1.0
From: Daniel Lando <daniel.sorridi@...277...>
Date: Fri, 30 Sep 2022 17:20:52 +0200
Message-ID: <CAEBHyEV1TvxTF5rPg8NaUkd8D80er-K50TYf_f42smwCgW8-Wg@...278...>
Content-Type: multipart/alternative; boundary="000000000000c7660605e9e68acc"
Subject: [Openvpn-devel] Multiple Openvpn servers using same port + Nginx
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--000000000000c7660605e9e68acc
Content-Type: text/plain; charset="UTF-8"

Hi everyone,

As described in this
<https://github.com/OpenVPN/openvpn/pull/166#issuecomment-1263600751>
comment, what I would like to know is if it's possible (and how) I could
proxy requests using nginx to multiple openvpn servers. I'm actually using
docker-compose to start the openvpn servers and also nginx is running in a
docker container.

The possible solutions I have in mind could be by using subdomains or sni
but cannot find a way to make them working as sni support is only available
on openvpn 3.

There is also a webserver that should share the same port

Any suggestions? Thanks in advance

-- 
-- 
*Daniel Lando*

--000000000000c7660605e9e68acc
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi everyone,<div><br></div><div>As described in <a href=3D=
"https://github.com/OpenVPN/openvpn/pull/166#issuecomment-1263600751">this<=
/a> comment, what I would like to know is if it&#39;s possible (and how) I =
could proxy requests using nginx to multiple openvpn servers. I&#39;m actua=
lly using docker-compose to start the openvpn servers and also nginx is run=
ning in a docker container.</div><div><br></div><div>The possible solutions=
 I have in mind could be by using subdomains or sni but cannot find a way t=
o make them working as sni support is only available on openvpn 3.</div><di=
v><br></div><div>There is also a webserver=C2=A0that should share the same =
port</div><div><br></div><div>Any suggestions? Thanks in advance</div><div>=
<div><br></div>-- <br><div dir=3D"ltr" class=3D"gmail_signature" data-smart=
mail=3D"gmail_signature"><div dir=3D"ltr"><span style=3D"font-size:13px;col=
or:rgb(0,0,0);font-family:Lato,Helvetica,Arial,sans-serif">--=C2=A0</span><=
div style=3D"font-size:13px;outline:none;color:rgb(0,0,0);font-family:Lato,=
Helvetica,Arial,sans-serif"><div dir=3D"ltr" style=3D"outline:none"><div st=
yle=3D"outline:none;font-size:12.8px"><font face=3D"Tahoma" style=3D"outlin=
e:none"><font color=3D"#999999" style=3D"outline:none"><strong style=3D"out=
line:none"><em style=3D"outline:none">Daniel Lando</em></strong></font></fo=
nt></div></div></div></div></div></div></div>

--000000000000c7660605e9e68acc--

