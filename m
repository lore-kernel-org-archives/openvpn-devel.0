References: <DB8PR05MB58656572C58F306B5084368F8A240@...2505...>
From: Jan Just Keijser <janjust@...1147...>
Message-ID: <785f88aa-4372-8573-15de-e9218ddc34a4@...1147...>
Date: Wed, 17 Apr 2019 12:17:22 +0200
MIME-Version: 1.0
In-Reply-To: <DB8PR05MB58656572C58F306B5084368F8A240@...2505...>
Content-Type: multipart/alternative;
 boundary="------------56C2F3ED703D9A5FC6CA4CFD"
Content-Language: nl-NL
Subject: Re: [Openvpn-devel] Why does the tun-mtu default to 1500 bytes?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Marcus Wichelmann <marcus.wichelmann@...2504...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This is a multi-part message in MIME format.
--------------56C2F3ED703D9A5FC6CA4CFD
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit

Hi Marcus,

On 17/04/19 00:11, Marcus Wichelmann wrote:
> Hello,
>
> I'm wondering what the reason is that OpenVPN Community sets the 
> default TUN-MTU to 1500 bytes, as seen here: 
> https://github.com/OpenVPN/openvpn/blob/ed31cf2ab718d879615dea81e6a17d26537ab43a/src/openvpn/mtu.h#L70
> In my understanding, because of the additional overhead that the VPN 
> tunnel adds to the transmitted packages, the resulting packages on the 
> link interface can be larger than 1500 bytes and willl not fit through 
> a regular link. This should result in fragmentation which hurts the 
> tunnel throughput.
this is why OpenVPN 2 by default uses fragmentation - encrypted packets 
are fragmented by OpenVPN itself before sent over the link. The default 
fragment value is 1450 bytes, ensuring that the underlying network does 
not do extra fragmentation in most cases.

>
> So do the default settings assume that the VPN tunnel is built using a 
> link that supports jumbo-frames? How does it make sense to expect a 
> link with jumbo-frame-support when probably most OpenVPN connections 
> will be made over the internet?
>
> Could somebody please explain to me, what the idea behind this 
> decision was? I'm very interested in if I've overlooked something.
> Wouldn't it be more helpful to most OpenVPN users when the TUN-MTU is 
> dynamically calculated based on the LINK-MTU which could default to 
> 1500 (or even 1492 to support DSL/PPPoE internet connections)?
>
there's been discussion on this, esp since OpenVPN 3 does not currently 
support the 'fragment' option. However, in a real life (remote) network 
setup there is no guarantee that the local MTU value is the lowest MTU 
along the link to the remote endpoint - thus even if OpenVPN would do 
something like
   tun-mtu = local link-mtu - offset
then there is no guarantee that the packets will go through. For that 
we'd need path mtu discovery. There is some code in OpenVPN to handle 
this, but it does not cover all corner cases, so we'll still have to 
support some method to overrule any automagically determined values.

The main reason for keeping the tun-mtu at 1500 was Windows support: in 
the past, the Windows TUN driver would install with a default MTU value 
of 1500 bytes. This value could be changed, but a restart was required 
for the new value to take effect. In other words, it was not possible to 
change the tun-mtu value on the fly.  Since Windows Vista/7 we can now 
change the MTU value on the fly, and there are some checkins in the 2.5 
branch for this. I expect that in the future we'll be changing the 
tun-mtu in favor of using --fragment.

HTH,

JJK


--------------56C2F3ED703D9A5FC6CA4CFD
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <div class="moz-cite-prefix">Hi Marcus,<br>
      <br>
      On 17/04/19 00:11, Marcus Wichelmann wrote:<br>
    </div>
    <blockquote type="cite"
cite="mid:DB8PR05MB58656572C58F306B5084368F8A240@...2505...">
      <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
      <font size="-2">Hello,<br>
        <br>
        I'm wondering what the reason is that OpenVPN Community sets the
        default TUN-MTU to 1500 bytes, as seen here:
        <a
href="https://github.com/OpenVPN/openvpn/blob/ed31cf2ab718d879615dea81e6a17d26537ab43a/src/openvpn/mtu.h#L70"
          moz-do-not-send="true">
https://github.com/OpenVPN/openvpn/blob/ed31cf2ab718d879615dea81e6a17d26537ab43a/src/openvpn/mtu.h#L70</a><br>
        In my understanding, because of the additional overhead that the
        VPN tunnel adds to the transmitted packages, the resulting
        packages on the link interface can be larger than 1500 bytes and
        willl not fit through a regular link. This should result in
        fragmentation which hurts the tunnel throughput.<br>
      </font></blockquote>
    <font size="-2">this is why OpenVPN 2 by default uses fragmentation
      - encrypted packets are fragmented by OpenVPN itself before sent
      over the link. The default fragment value is 1450 bytes, ensuring
      that the underlying network does not do extra fragmentation in
      most cases.<br>
      <br>
    </font>
    <blockquote type="cite"
cite="mid:DB8PR05MB58656572C58F306B5084368F8A240@...2505..."><font
        size="-2">
        <br>
        So do the default settings assume that the VPN tunnel is built
        using a link that supports jumbo-frames? How does it make sense
        to expect a link with jumbo-frame-support when probably most
        OpenVPN connections will be made over the internet?<br>
        <br>
        Could somebody please explain to me, what the idea behind this
        decision was? I'm very interested in if I've overlooked
        something.<br>
        Wouldn't it be more helpful to most OpenVPN users when the
        TUN-MTU is dynamically calculated based on the LINK-MTU which
        could default to 1500 (or even 1492 to support DSL/PPPoE
        internet connections)?<br>
      </font><br>
    </blockquote>
    there's been discussion on this, esp since OpenVPN 3 does not
    currently support the 'fragment' option. However, in a real life
    (remote) network setup there is no guarantee that the local MTU
    value is the lowest MTU along the link to the remote endpoint - thus
    even if OpenVPN would do something like  <br>
      tun-mtu = local link-mtu - offset<br>
    then there is no guarantee that the packets will go through. For
    that we'd need path mtu discovery. There is some code in OpenVPN to
    handle this, but it does not cover all corner cases, so we'll still
    have to support some method to overrule any automagically determined
    values.<br>
    <br>
    The main reason for keeping the tun-mtu at 1500 was Windows support:
    in the past, the Windows TUN driver would install with a default MTU
    value of 1500 bytes. This value could be changed, but a restart was
    required for the new value to take effect. In other words, it was
    not possible to change the tun-mtu value on the fly.  Since Windows
    Vista/7 we can now change the MTU value on the fly, and there are
    some checkins in the 2.5 branch for this. I expect that in the
    future we'll be changing the tun-mtu in favor of using --fragment.<br>
    <br>
    HTH,<br>
    <br>
    JJK<br>
    <br>
  </body>
</html>

--------------56C2F3ED703D9A5FC6CA4CFD--

