References: <6cc03a83-47e6-cedb-254b-f445972788f5@...515...>
 <b9c984d6-bcde-0d0e-349d-3a586600b668@...515...>
 <6ebf219f-6a8e-6e39-893c-5610129abaef@...1147...>
 <CAGyAFMU1iS3FJjVbmBqYq6BeSt+UyxUrAUg=xd=cmiH3nVac6g@...278...>
From: Jan Just Keijser <janjust@...1147...>
Message-ID: <1c6fca9e-342d-b863-303b-9dc4a78a9e0d@...1147...>
Date: Tue, 4 Dec 2018 17:03:17 +0100
MIME-Version: 1.0
In-Reply-To: <CAGyAFMU1iS3FJjVbmBqYq6BeSt+UyxUrAUg=xd=cmiH3nVac6g@...278...>
Content-Type: multipart/alternative;
 boundary="------------BBD58E361220D441FA8DDB4B"
Content-Language: nl-NL
Subject: Re: [Openvpn-devel] Summary of the community meeting (Wed,
 28th Nov 2018)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Lev Stipakov <lstipakov@...277...>
Cc: openvpn-devel@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------BBD58E361220D441FA8DDB4B
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit

Hi Lev,

On 29/11/18 16:18, Lev Stipakov wrote:
>
> Some background information.
>
> In openvpn3 we decided not to implement fragments, because:
>
>  - this is quite a big feature which has to be supported through the 
> whole stack (client, server, kernel module)
>  - we assume that it is not used by most of users
>
> However, for those who needs --fragment, we'll implement:
>
>  - mssfix support, this should solve problems with tcp-based protocols
>  - sending icmp "packet too big" for other protocols, we assume that 
> they'll respect icmp response

I'd thoroughly test this with protocols like Google's QUIC, which uses 
UDP underneath. How does it respond to such ICMP messages? what does it 
do to throughput?

>
>     --fragment is/was very useful on a system where you do not /
>     cannot change the tun MTU size. Up to Windows XP, this was not
>     possible without rebooting the OS. Since Vista, it *is* possible
>     to change the MTU of an adapter on the fly (as explained in my
>     trusty old cookbook, of course ;))
>
>
> As James wrote a while ago (13 years ago :)
>
> https://openvpn.net/archive/openvpn-users/2005-10/msg00354.html
>
> > A lot of experience gained during the OpenVPN 1.x releases showed 
> that it's best to fix the tunnel MTU at
> > 1500 and vary the other parameters (and use --mssfix to prevent 
> fragmentation rather than a lower tunnel MTU).
> Don't know if still holds. Assuming that we can change tun-mtu on any 
> supported platforms, do you think that it is better
> to do _that_, rather than have mssfix/icmp ptb workaround?
>
>     With that, it would be possible to fix the link-mtu to 1500 (or
>     whatever is set on the outbound interface) and then subtract the
>     header size to get a meaningful tun-mtu size.
>
>
> Do you think 1500 is a safe value? Arne just mentioned today that his 
> network interface MTU is 1500 and router's MTU is 1492 due to PPPoE, 
> and openvpn2 works because it assumes that mtu is 1450.

I am not sure what a good default value is - it all depends on the 
intermittent networks. What OpenVPN needs is the ability to send a 
single UDP packet containing encapsulated data, knowing that that same 
single UDP packet arrives at the destination. How the underlying 
protocols/networks achieve this, is unknown.

Also, all of this applies only to UDP mode - in TCP mode it is best to 
not fragment at all - simply let the TCP stream take care of the 
encapsulated data, possible with TCP_NODELAY set.

>     Having said all that, I do have one gripe with the way the link or
>     tun mtu is calculated in the current codebase:
>     In the 2.3 code base, the server tun mtu size was equal to the
>     client tun-mtu size.
>     In the 2.4+ code base, the server-side tun mtu size is set to some
>     ridiculous low level (with link-mtu 1500 set) in order to
>     accomocate all possible encryption ciphers - *even if I add
>     ncp-disable* . To me, that does not make a whole lot of sense. If I
>     add '--ncp-disable' I'd expect the client and the server to behave
>     pretty much like an OpenVPN 2.3 client (with a possible 3
>     bytes difference to accomodate for the peer id).
>
>
> With 2.4 codebase I noticed that what man page says is not what 
> openvpn2 code does - it does include transport overhead, while
> man page says it doesn't (copying my mail here):
>
>               Announce to TCP sessions running over the tunnel that 
> they should limit their send packet sizes such that after OpenVPN has 
> encapsulated them, the resulting UDP packet size that OpenVPN sends to 
> its peer will not exceed max bytes. The  default  value is 1450.
>
>               The max parameter is interpreted in the same way as the 
> --link-mtu parameter, i.e. the UDP packet size after encapsulation 
> overhead has been added in, but not including the UDP header itself. 
> Resulting packet would be at most 28 bytes larger for IPv4 and 48 
> bytes for IPv6 (20/40 bytes for IP header and 8 bytes for UDP header).
>
> So it means that with "mssfix" 1300 resulting IPv4 packet size would 
> be at most 1328.
>
> This is what I see in Wireshark (server - git master, client 2.4.6):
>
> Internet Protocol Version 4, Src: 128.199.xxx.yyy, Dst: 10.0.200.20
>     0100 .... = Version: 4
>     .... 0101 = Header Length: 20 bytes (5)
>     Total Length: 1300
>     Protocol: UDP (17)
> User Datagram Protocol, Src Port: 1194, Dst Port: 1194
>     Source Port: 1194
>     Destination Port: 1194
>     Length: 1280
> OpenVPN Protocol
>     Type: 0x49 [opcode/key_id]
>     Peer ID: 0
>     Data (1268 bytes)
>
> While man page statement is technically correct - UDP packet size is 
> 1300, which is "at most 1328", I think it should say:
>
> > the resulting IP packet size that OpenVPN sends to its peer will not 
> exceed max bytes
>
> and
>
> > The max parameter is interpreted in the same way as the --link-mtu 
> parameter, i.e. the IP packet size
> after encapsulation overhead has been added in, including UDP and IP 
> headers.
>
you seem to be talking about the mssfix size, wheras I am talking about 
the tun-mtu size. When you add
   link-mtu 1500
   ncp-disable
(and no fragment or mssfix)
to a server config file, an OpenVPN 2.4 server starts up using
   openvpn 2.4.6 -> mtu = 1379
whereas an OpenVPN 2.3 server starts with
     openvpn 2.3.18 -> mtu = 1431
To me, this difference is inexplicable and annoying.

(see the mail thread titled "Overhead TUN vs TAP mode" on Openvpn-users).

When re-thinking all this, I see a large shift in the way OpenVPN 3 
approaches the underlying network vs the way OpenVPN 1/2 do:  with 
OpenVPN 2, you can try to outsmart (or tune) the underlying network by 
playing with the fragment parameter *at user level*.  In OpenVPN 3, this 
is left to the OS (by increasing/decreasing the local tun mtu size - 
which says nothing about the MTU sizes further down the network).  Most 
likely the OS can do a better job than we (or YourAverageUser) can, but 
I always like the ability to overrule what the OS is doing (esp at the 
Linux level).

Also, would it be possible to implement PMTUD? I found this link to be 
informative:
https://www.cisco.com/c/en/us/support/docs/ip/generic-routing-encapsulation-gre/25885-pmtud-ipfrag.html

That might make the underlying fragmentation process more "automagic".

JM2CW,

JJK


--------------BBD58E361220D441FA8DDB4B
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <div class="moz-cite-prefix">Hi Lev,<br>
      <br>
      On 29/11/18 16:18, Lev Stipakov wrote:<br>
    </div>
    <blockquote type="cite"
cite="mid:CAGyAFMU1iS3FJjVbmBqYq6BeSt+UyxUrAUg=xd=cmiH3nVac6g@...278...">
      <meta http-equiv="content-type" content="text/html; charset=utf-8">
      <div dir="ltr">
        <div class="gmail_quote">
          <div dir="ltr">
            <div dir="ltr">
              <div dir="ltr"><br>
                <div class="gmail_quote">
                  <div>Some background information.</div>
                  <div><br>
                  </div>
                  <div>In openvpn3 we decided not to implement
                    fragments, because:</div>
                  <div><br>
                  </div>
                  <div> - this is quite a big feature which has to be
                    supported through the whole stack (client, server,
                    kernel module)</div>
                  <div> - we assume that it is not used by most of users</div>
                  <div><br>
                  </div>
                  <div>However, for those who needs --fragment, we'll
                    implement:</div>
                  <div><br>
                  </div>
                  <div> - mssfix support, this should solve problems
                    with tcp-based protocols</div>
                  <div> - sending icmp "packet too big" for other
                    protocols, we assume that they'll respect icmp
                    response</div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </blockquote>
    <br>
    I'd thoroughly test this with protocols like Google's QUIC, which
    uses UDP underneath. How does it respond to such ICMP messages? what
    does it do to throughput?<br>
    <br>
    <blockquote type="cite"
cite="mid:CAGyAFMU1iS3FJjVbmBqYq6BeSt+UyxUrAUg=xd=cmiH3nVac6g@...278...">
      <div dir="ltr">
        <div class="gmail_quote">
          <div dir="ltr">
            <div dir="ltr">
              <div dir="ltr">
                <div class="gmail_quote">
                  <div><br>
                  </div>
                  <blockquote class="gmail_quote" style="margin:0px 0px
                    0px 0.8ex;border-left:1px solid
                    rgb(204,204,204);padding-left:1ex">--fragment is/was
                    very useful on a system where you do not / cannot
                    change the tun MTU size. Up to Windows XP, this was
                    not <br>
                    possible without rebooting the OS. Since Vista, it
                    *is* possible to change the MTU of an adapter on the
                    fly (as explained in my <br>
                    trusty old cookbook, of course ;))<br>
                  </blockquote>
                  <div><br>
                  </div>
                  <div>As James wrote a while ago (13 years ago :)</div>
                  <div><br>
                  </div>
                  <div><a
                      href="https://openvpn.net/archive/openvpn-users/2005-10/msg00354.html"
                      target="_blank" moz-do-not-send="true">https://openvpn.net/archive/openvpn-users/2005-10/msg00354.html</a><br>
                  </div>
                  <div><br>
                  </div>
                  <div>&gt; A lot of experience gained during the
                    OpenVPN 1.x releases showed that it's best to fix
                    the tunnel MTU at</div>
                  <div>&gt; 1500 and vary the other parameters (and use
                    --mssfix to prevent fragmentation rather than a
                    lower tunnel MTU).</div>
                  <div> </div>
                  <div>Don't know if still holds. Assuming that we can
                    change tun-mtu on any supported platforms, do you
                    think that it is better </div>
                  <div>to do _that_, rather than have mssfix/icmp ptb
                    workaround?</div>
                  <div>  </div>
                  <blockquote class="gmail_quote" style="margin:0px 0px
                    0px 0.8ex;border-left:1px solid
                    rgb(204,204,204);padding-left:1ex">With that, it
                    would be possible to fix the link-mtu to 1500 (or <br>
                    whatever is set on the outbound interface) and then
                    subtract the header size to get a meaningful tun-mtu
                    size.<br>
                  </blockquote>
                  <div><br>
                  </div>
                  <div>Do you think 1500 is a safe value? Arne just
                    mentioned today that his network interface MTU is
                    1500 and router's MTU is 1492 due to PPPoE, and
                    openvpn2 works because it assumes that mtu is 1450.
                    <br>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </blockquote>
    <br>
    I am not sure what a good default value is - it all depends on the
    intermittent networks. What OpenVPN needs is the ability to send a
    single UDP packet containing encapsulated data, knowing that that
    same single UDP packet arrives at the destination. How the
    underlying protocols/networks achieve this, is unknown.<br>
    <br>
    Also, all of this applies only to UDP mode - in TCP mode it is best
    to not fragment at all - simply let the TCP stream take care of the
    encapsulated data, possible with TCP_NODELAY set.<br>
    <br>
    <blockquote type="cite"
cite="mid:CAGyAFMU1iS3FJjVbmBqYq6BeSt+UyxUrAUg=xd=cmiH3nVac6g@...278...">
      <div dir="ltr">
        <div class="gmail_quote">
          <div dir="ltr">
            <div dir="ltr">
              <div dir="ltr">
                <div class="gmail_quote">
                  <div> </div>
                  <blockquote class="gmail_quote" style="margin:0px 0px
                    0px 0.8ex;border-left:1px solid
                    rgb(204,204,204);padding-left:1ex">Having said all
                    that, I do have one gripe with the way the link or
                    tun mtu is calculated in the current codebase:<br>
                    In the 2.3 code base, the server tun mtu size was
                    equal to the client tun-mtu size.<br>
                    In the 2.4+ code base, the server-side tun mtu size
                    is set to some ridiculous low level (with link-mtu
                    1500 set) in order to <br>
                    accomocate all possible encryption ciphers - *even
                    if I add ncp-disable* . To me, that does not make a
                    whole lot of sense. If I <br>
                    add '--ncp-disable' I'd expect the client and the
                    server to behave pretty much like an OpenVPN 2.3
                    client (with a possible 3 <br>
                    bytes difference to accomodate for the peer id).<br>
                  </blockquote>
                  <div><br>
                  </div>
                  <div>With 2.4 codebase I noticed that what man page
                    says is not what openvpn2 code does - it does
                    include transport overhead, while</div>
                  <div>man page says it doesn't (copying my mail here):</div>
                  <div><br>
                  </div>
                  <div>              Announce to TCP sessions running
                    over the tunnel that they should limit their send
                    packet sizes such that after OpenVPN has
                    encapsulated them, the resulting UDP packet size
                    that OpenVPN sends to its peer will not exceed max
                    bytes. The  default  value is 1450.<br>
                    <br>
                                  The max parameter is interpreted in
                    the same way as the --link-mtu parameter, i.e. the
                    UDP packet size after encapsulation overhead has
                    been added in, but not including the UDP header
                    itself. Resulting packet would be at most 28 bytes
                    larger for IPv4 and 48 bytes for IPv6 (20/40 bytes
                    for IP header and 8 bytes for UDP header).<br>
                    <br>
                    So it means that with "mssfix" 1300 resulting IPv4
                    packet size would be at most 1328.  <br>
                  </div>
                  <div><br>
                  </div>
                  <div>This is what I see in Wireshark (server - git
                    master, client 2.4.6):<br>
                    <br>
                    Internet Protocol Version 4, Src: 128.199.xxx.yyy,
                    Dst: 10.0.200.20<br>
                        0100 .... = Version: 4<br>
                        .... 0101 = Header Length: 20 bytes (5)<br>
                        Total Length: 1300<br>
                        Protocol: UDP (17)<br>
                    User Datagram Protocol, Src Port: 1194, Dst Port:
                    1194<br>
                        Source Port: 1194<br>
                        Destination Port: 1194<br>
                        Length: 1280<br>
                    OpenVPN Protocol<br>
                        Type: 0x49 [opcode/key_id]<br>
                        Peer ID: 0<br>
                        Data (1268 bytes)<br>
                    <br>
                    While man page statement is technically correct -
                    UDP packet size is 1300, which is "at most 1328", I
                    think it should say:
                    <div><br>
                    </div>
                    <div>&gt; the resulting IP packet size that OpenVPN
                      sends to its peer will not exceed max bytes  </div>
                    <div><br>
                    </div>
                    <div>and</div>
                    <div><br>
                    </div>
                    <div>&gt; The max parameter is interpreted in the
                      same way as the --link-mtu parameter, i.e. the IP
                      packet size</div>
                    <div>after encapsulation overhead has been added in,
                      including UDP and IP headers.</div>
                  </div>
                  <br>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </blockquote>
    you seem to be talking about the mssfix size, wheras I am talking
    about the tun-mtu size. When you add<br>
      link-mtu 1500<br>
      ncp-disable<br>
    (and no fragment or mssfix)<br>
    to a server config file, an OpenVPN 2.4 server starts up using<br>
      openvpn 2.4.6 -&gt; mtu = 1379
    <br>
    whereas an OpenVPN 2.3 server starts with<br>
        openvpn 2.3.18 -&gt; mtu = 1431
    <br>
    To me, this difference is inexplicable and annoying.<br>
    <br>
    (see the mail thread titled "Overhead TUN vs TAP mode" on
    Openvpn-users).<br>
    <br>
    When re-thinking all this, I see a large shift in the way OpenVPN 3
    approaches the underlying network vs the way OpenVPN 1/2 do:  with
    OpenVPN 2, you can try to outsmart (or tune) the underlying network
    by playing with the fragment parameter *at user level*.  In OpenVPN
    3, this is left to the OS (by increasing/decreasing the local tun
    mtu size - which says nothing about the MTU sizes further down the
    network).  Most likely the OS can do a better job than we (or
    YourAverageUser) can, but I always like the ability to overrule what
    the OS is doing (esp at the Linux level). <br>
    <br>
    Also, would it be possible to implement PMTUD? I found this link to
    be informative:<br>
     
<a class="moz-txt-link-freetext" href="https://www.cisco.com/c/en/us/support/docs/ip/generic-routing-encapsulation-gre/25885-pmtud-ipfrag.html">https://www.cisco.com/c/en/us/support/docs/ip/generic-routing-encapsulation-gre/25885-pmtud-ipfrag.html</a><br>
    <br>
    That might make the underlying fragmentation process more
    "automagic".<br>
    <br>
    JM2CW,<br>
    <br>
    JJK<br>
    <br>
  </body>
</html>

--------------BBD58E361220D441FA8DDB4B--

