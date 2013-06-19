MIME-Version: 1.0
Date: Wed, 19 Jun 2013 18:00:27 +0300
Message-ID: <CABT9mj_BMkwO9rZ9T847GBaYrGbXdwCB76zyPDqnNKNr0nk5Dw@...278...>
From: Athanasios Douitsis <aduitsis@...277...>
Content-Type: multipart/alternative; boundary=047d7bd6be120fff3304df83174a
Subject: [Openvpn-devel] push route-ipv6 and metric
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--047d7bd6be120fff3304df83174a
Content-Type: text/plain; charset=ISO-8859-1

Hello,

I noticed that issuing the following command in the server config:

push "route-ipv6 ::/0 2001:648:2000:ffae::1 15"

does indeed make a windows client install that route, but it ignores the
metric:

add_route_ipv6(::/0 -> 2001:648:2000:ffae::1 metric 15) dev Local Area
Connection 3
C:\Windows\system32\netsh.exe interface ipv6 add route ::/0 Local Area
Connection 3 fe80::8 store=active

Issuing route print client-side confirms that suspicion.

 13     26    ::/0                     fe80::208:7cff:fe63:e400
 14    286   ::/0                     fe80::8

(13 is my lan, 14 is the tun device. As you can see, metric is 286)

I suppose most people on this list should be aware of the problem. If you
desire so, I'd gladly file a bug request.

Fwiw, I was able to workaround this problem by pushing two /1 routes,
exactly like def1 does for IPv4. Like this:

push "route-ipv6 ::/1 2001:648:2000:ffae::1"
push "route-ipv6 8000::/1 2001:648:2000:ffae::1"

Apologies if this has been discussed before.

Kind regards to all,
-- 
Athanasios Douitsis

--047d7bd6be120fff3304df83174a
Content-Type: text/html; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div><div><div><div>Hello,<br><br></div>I noticed tha=
t issuing the following command in the server config:<br><br>push &quot;rou=
te-ipv6 ::/0 2001:648:2000:ffae::1 15&quot;<br><br></div>does indeed make a=
 windows client install that route, but it ignores the metric: <br>
<br>add_route_ipv6(::/0 -&gt; 2001:648:2000:ffae::1 metric 15) dev Local Ar=
ea Connection 3<br>C:\Windows\system32\netsh.exe interface ipv6 add route :=
:/0 Local Area Connection 3 fe80::8 store=3Dactive<br><br></div><div>Issuin=
g route print client-side confirms that suspicion. <br>
<br>=A013=A0=A0=A0=A0 26 =A0=A0 ::/0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 fe80::208:7cff:fe63:e400<br>=A014=A0=A0=A0 286 =A0 ::=
/0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 fe80::8<br><=
br></div><div>(13 is my lan, 14 is the tun device. As you can see, metric i=
s 286)<br></div><div><br>
</div>I suppose most people on this list should be aware of the problem. If=
 you desire so, I&#39;d gladly file a bug request. <br><br></div>Fwiw, I wa=
s able to workaround this problem by pushing two /1 routes, exactly like de=
f1 does for IPv4. Like this:<br>
<br>push &quot;route-ipv6 ::/1 2001:648:2000:ffae::1&quot;<br>push &quot;ro=
ute-ipv6 8000::/1 2001:648:2000:ffae::1&quot;<br><br></div>Apologies if thi=
s has been discussed before. <br><br><div><div><div><div><div><div><div>
<div>Kind regards to all,<br></div><div>-- <br>Athanasios Douitsis<br><br><=
br>
</div></div></div></div></div></div></div></div></div>

--047d7bd6be120fff3304df83174a--

