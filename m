Content-Type: multipart/alternative;
 boundary="------------b5voTyuivIeyIMXA0TgVyDWD"
Message-ID: <8ba925a1-85c9-4274-a512-32dcec35b147@...1227...>
Date: Fri, 23 May 2025 02:26:42 +0200
MIME-Version: 1.0
References: <1e8ccfd451cbf9e6d090bd6a6886e366.squirrel@...2890...>
 <20250507074438.1326755-1-walter.openvpn@...2889...>
 <eedcf175305a088df0eb7ec146dbe441.squirrel@...2890...>
 <f60dbf91-c2f8-495b-ba14-967e70629d1b@...1227...>
 <ef2598a79cf3efe9d343b514ab6c9e5c.squirrel@...2890...>
From: Arne Schwabe <arne@...1227...>
In-Reply-To: <ef2598a79cf3efe9d343b514ab6c9e5c.squirrel@...2890...>
Subject: Re: [Openvpn-devel] [PATCH] multi.c: Allow floating to a new IP
 right after connection setup
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Walter Doekes <walter.openvpn@...2889...>, openvpn-devel@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------b5voTyuivIeyIMXA0TgVyDWD
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit

> Totally fair that you don't want to apply a patch that you don't
> understand. I on the other hand do not see why you're unable to reproduce.
>
> The scenario is not at all complicated:
>
> - Two vpn servers;
> - first vpn server pushes a default gateway;
> - second vpn server pushes its external IP as net_gateway (*);
> - second vpn server immediately sees the client float from one IP to another.

What I understand so far:

- so you connect to vpn 1 first and that is a normal VPN with a default 
gateway and you get VPN1 IP

- Then via that VPN, you connect a 2nd VPN and you have as source the 
VPN IP, so the 2nd VPN server only see the VPN1 IP.

- after connection is established, you  do the host route directly to 
the server.

- 2nd VPN server sees a float from VPN1 IP to extern IP (EXTIP) of client

- Server refuses the float since there is already a not fully 
established connection on EXTIP

What I don't understand where the this not fully established connection 
should be coming from. That would mean that the server would have need 
to have received a valid connection attempt from EXTIP that was never 
established. And I do not understand from you explaination where that 
happens.

> If you're unable to reproduce that, then:
>
> - Either you're using a vastly different version and it has been fixed
> since then (but not something that landed in debian/bookworm or
> ubuntu/noble, and I _think_ I did try latest 2.6 as well);
> - or you're using different settings (udp; auth/tls-auth; dev-tun;
> subnet-topology);
> - or there is some unknown factor involved that neither of us can think or
> right now.
>
> I will create a reproducer config so you can see the exact settings (apart
> from the IP addresses).
>
> In the mean time, can you confirm that you understand the scenario or ask
> for additional clarification?

I wrote again down what you basically told me and there is still this 
mystery connection that blocks you. And there is no explaination why 
this connection exist in the first place. You are fixing the sympton of 
this ghost connection that blocks your float but from my perspective we 
have not really established why it exists in the first place.

Arne

--------------b5voTyuivIeyIMXA0TgVyDWD
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: 8bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <blockquote type="cite"
      cite="mid:ef2598a79cf3efe9d343b514ab6c9e5c.squirrel@...2890...">
      <pre wrap="" class="moz-quote-pre">
Totally fair that you don't want to apply a patch that you don't
understand. I on the other hand do not see why you're unable to reproduce.

The scenario is not at all complicated:

- Two vpn servers;
- first vpn server pushes a default gateway;
- second vpn server pushes its external IP as net_gateway (*);
- second vpn server immediately sees the client float from one IP to another.
</pre>
    </blockquote>
    <p>What I understand so far:<br>
    </p>
    <p>- so you connect to vpn 1 first and that is a normal VPN with a
      default gateway and you get VPN1 IP<br>
    </p>
    <p>- Then via that VPN, you connect a 2nd VPN and you have as source
      the VPN IP, so the 2nd VPN server only see the VPN1 IP.<br>
    </p>
    <p>- after connection is established, you  do the host route
      directly to the server. <br>
    </p>
    <p>- 2nd VPN server sees a float from VPN1 IP to extern IP (EXTIP)
      of client</p>
    <p>- Server refuses the float since there is already a not fully
      established connection on EXTIP</p>
    <p>What I don't understand where the this not fully established
      connection should be coming from. That would mean that the server
      would have need to have received a valid connection attempt from
      EXTIP that was never established. And I do not understand from you
      explaination where that happens.<br>
    </p>
    <blockquote type="cite"
      cite="mid:ef2598a79cf3efe9d343b514ab6c9e5c.squirrel@...2890...">
      <pre wrap="" class="moz-quote-pre">
If you're unable to reproduce that, then:

- Either you're using a vastly different version and it has been fixed
since then (but not something that landed in debian/bookworm or
ubuntu/noble, and I _think_ I did try latest 2.6 as well);
- or you're using different settings (udp; auth/tls-auth; dev-tun;
subnet-topology);
- or there is some unknown factor involved that neither of us can think or
right now.

I will create a reproducer config so you can see the exact settings (apart
from the IP addresses).

In the mean time, can you confirm that you understand the scenario or ask
for additional clarification?
</pre>
    </blockquote>
    <p><span style="white-space: pre-wrap">
</span></p>
    <p><span style="white-space: pre-wrap">I wrote again down what you basically told me and there is still this mystery connection that blocks you. And there is no explaination why this connection exist in the first place. You are fixing the sympton of this ghost connection that blocks your float but from my perspective we have not really established why it exists in the first place.</span></p>
    <p><span style="white-space: pre-wrap">Arne
</span></p>
  </body>
</html>

--------------b5voTyuivIeyIMXA0TgVyDWD--

