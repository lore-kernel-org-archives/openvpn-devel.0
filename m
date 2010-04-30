Message-ID: <688788.40960.qm@...1364...>
Date: Fri, 30 Apr 2010 05:09:42 -0700 (PDT)
From: ja nein <reg9009@...360...>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-82364949-1272629382=:40960"
Subject: [Openvpn-devel] Suggestion / Routing problem/feature
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--0-82364949-1272629382=:40960
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hello list,

I have a suggestion for further development which I don't know if it is tec=
hnically achievable. Anyway, here's our problem:

We run a network which consists of multiple routers behind eachother. Route=
rs login via OpenVPN to other routers, get fixed IP addresses based on thei=
r certificate and get individual settings pushed (ccd). Imagine the followi=
ng simple situation:

Network1---->Router A----->Router B---->Router C---->Network2

in ccd file for Router B on Router C an iroute entry exists for network 1 (=
which is propagated to Router C via BGP) to properly route packets from net=
work 2 -> network1 ("iroute network1").

Now we add a network 3 behind Router A

network1 \
                  --->   Router A ----> Router B ----> Router C ---> Networ=
k2
network3 /


Routes get propagated via BGP to Router C (network3 appears in routing tabl=
e of Router C). But, packets from network 2 don't make it to network 3. We =
have to add "iroute network 3" on ccd config for Router B on Router C and r=
econnect Router B to Router C to get packets routed to network 3.
--0-82364949-1272629382=:40960--
