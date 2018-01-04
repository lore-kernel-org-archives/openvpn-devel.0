References: <7f72b2de-f411-c4a0-bd1e-f343543cb8e2@...2030...>
 <CAAjorqWaFY+XdD5XZ95rPyXJHd9MfPv3Xmv3M1gKfWHbnJXL9w@...278...>
From: Tom Kunz <tkunz@...2030...>
Message-ID: <6ad04520-6e42-51aa-bd38-b2285e7adaab@...2030...>
Date: Thu, 4 Jan 2018 18:52:15 -0500
MIME-Version: 1.0
In-Reply-To: <CAAjorqWaFY+XdD5XZ95rPyXJHd9MfPv3Xmv3M1gKfWHbnJXL9w@...278...>
Content-Type: multipart/alternative;
 boundary="------------10C9CD3BEB74EE322F0BF1EF"
Content-Language: en-US
Subject: Re: [Openvpn-devel] OVPN vs IPSec performance as a transport
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "Greg Sloop <gregs@...1934...>" <gregs@...1934...>
Cc: openvpn-devel@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------10C9CD3BEB74EE322F0BF1EF
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

That would explain it if it always worked that way.
But I can get 400%+ wire speed from A to B with compressible data, and
102% with incompressible data.  If I do the same test from B to A or A
to B, I get those results.  If I hop off of that to C, speed goes from
>1Gbps to sub-200Mbps.  In either case, the data has left the kernel
space to arrive at "nc", so just simply saying "it's kernel vs user"
doesn't answer it.


On 01/04/2018 06:37 PM, Greg Sloop <gregs@...1934...> wrote:
> I'm sure someone else, or a Google search will get you a more detailed
> run-down - but the gist of the "problem" is this;
>
> OpenVPN is run in user-space, not kernel space. IPSec  runs in kernel
> space, and the difference is vastly diminished throughput.
>
> HTH
>
> -Greg
>
> On Jan 4, 2018 3:23 PM, "Tom Kunz" <tkunz@...2030...
> <mailto:tkunz@...2030...>> wrote:
>
>     Hi,
>
>     I have been testing OVPN 2.4.4 vs StrongSwan IPSec, to be used as
>     transport, and I have found something that I think might be a
>     performance issue.  I have 3 linux boxes, A, B, and C.  All interfaces
>     are 1Gbps.  Each has an interface to the next one downstream:
>
>     A - eth0=10.10.10.10/24 <http://10.10.10.10/24> and
>     eth1=172.16.0.10/24 <http://172.16.0.10/24>
>
>     B - eth0=172.16.0.11/24 <http://172.16.0.11/24> and
>     eth1=172.30.0.11/24 <http://172.30.0.11/24>
>
>     C - eth0=172.30.0.10/24 <http://172.30.0.10/24> and
>     eth1=192.168.168.10/24 <http://192.168.168.10/24>
>
>     Packets route as usual through this with no encryption, and throughput
>     from A to C is at wire speed.  With IPSec between A&B, from
>     172.16.0.10-172.16.0.11, I can still get wire speed from A to C. 
>     Then I
>     turn off IPSec, and I setup A as the server and B as the client, with
>     A's config being:
>
>     =====
>
>     dev tun
>
>     topology subnet
>     server 172.17.0.0 255.255.255.0
>     port 1194
>     proto udp
>     dh /etc/openvpn/keys/dh2048.pem
>     ca /etc/openvpn/keys/ca.crt
>     cert /etc/openvpn/keys/server.crt
>     key /etc/openvpn/keys/server.key
>     verb 3
>     keepalive 10 45
>     cipher aes-256-cbc
>     comp-lzo
>
>     tun-mtu 50000
>
>     mssfix 0
>
>     fragment 0
>
>     client-config-dir ccd
>
>     push "route 10.10.10.0 255.255.255.0"
>
>     =====
>
>     and the client B config file is
>
>     =====
>
>     verb 3
>     client
>     cipher AES-256-CBC
>     comp-lzo
>     tun-mtu 50000
>     mssfix 0
>     fragment 0
>     remote 172.16.0.10  1194
>
>     dev tun
>     redirect-private local
>     tls-client
>
>     ca /etc/openvpn/keys/ca.crt
>     cert /etc/openvpn/keys/client1.crt
>     key /etc/openvpn/keys/client1.key
>
>     =====
>
>     and I setup static routes on each side so that traffic is going
>     through
>     the tunnel from A to C and vice versa.
>
>     I can pass traffic over this link, however when I do tests for
>     speed, I
>     am only getting about 200Mbps instead of 1Gbps.
>
>     The funny thing is, I know that each of these machines can easily do
>     1Gbps.  If I do my performance test from A to B, over the above ovpn
>     configs, I can get just over 1Gbps because of the MTU overhead being
>     removed. But as soon as I have it make the leap downstream once
>     more, I
>     lose 80+% of the speed.  And again, both non-encrypted traffic and
>     IPSec
>     do the exact same test at wire speed or just slightly under wire
>     speed.
>
>     The way I do a speed test is on A:
>
>     # nc -l -p 5555 > /dev/null
>
>     and over on C:
>
>     # dd if=/dev/urandom of=blob.random.1G bs=10M count=100
>
>     # time cat blob.random.1G | nc 10.10.10.10 5555
>
>     tcpdumps over each interface confirm traffic is flowing in the
>     expected
>     fashion.
>
>     Over unencrypted or IPSec, I am looking at about 4s to move 1G of data
>     from one end to the other, and with ovpn, 15-22s.  The machines
>     involved
>     are 2 Dell R720's with 8+G ram and a homebrew machine with several
>     Xeons
>     and 32G RAM.  Network cards involved are a mix of BCM Tigon3 "tg3"
>     driver and IGB driver gigabit NICs.
>
>     Anyone have any suggestions or thoughts as to why the big perf
>     decrease
>     and what might be done to improve it?
>
>     Thanks, 
>
>     Tom
>
>
>
>
>     ------------------------------------------------------------------------------
>     Check out the vibrant tech community on one of the world's most
>     engaging tech sites, Slashdot.org! http://sdm.link/slashdot
>     _______________________________________________
>     Openvpn-devel mailing list
>     Openvpn-devel@lists.sourceforge.net
>     <mailto:Openvpn-devel@lists.sourceforge.net>
>     https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>     <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>
>


--------------10C9CD3BEB74EE322F0BF1EF
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <div class="moz-cite-prefix">That would explain it if it always
      worked that way.<br>
      But I can get 400%+ wire speed from A to B with compressible data,
      and 102% with incompressible data.  If I do the same test from B
      to A or A to B, I get those results.  If I hop off of that to C,
      speed goes from &gt;1Gbps to sub-200Mbps.  In either case, the
      data has left the kernel space to arrive at "nc", so just simply
      saying "it's kernel vs user" doesn't answer it.<br>
      <br>
      <br>
      On 01/04/2018 06:37 PM, Greg Sloop <a class="moz-txt-link-rfc2396E" href="mailto:gregs@...1934...">&lt;gregs@...1934...&gt;</a> wrote:<br>
    </div>
    <blockquote type="cite"
cite="mid:CAAjorqWaFY+XdD5XZ95rPyXJHd9MfPv3Xmv3M1gKfWHbnJXL9w@...278...">
      <div dir="auto">I'm sure someone else, or a Google search will get
        you a more detailed run-down - but the gist of the "problem" is
        this;
        <div dir="auto"><br>
        </div>
        <div dir="auto">OpenVPN is run in user-space, not kernel space.
          IPSec  runs in kernel space, and the difference is vastly
          diminished throughput.</div>
        <div dir="auto"><br>
        </div>
        <div dir="auto">HTH</div>
        <div dir="auto"><br>
        </div>
        <div dir="auto">-Greg</div>
      </div>
      <div class="gmail_extra"><br>
        <div class="gmail_quote">On Jan 4, 2018 3:23 PM, "Tom Kunz" &lt;<a
            href="mailto:tkunz@...2030..."
            moz-do-not-send="true">tkunz@...2030...</a>&gt;
          wrote:<br type="attribution">
          <blockquote class="gmail_quote" style="margin:0 0 0
            .8ex;border-left:1px #ccc solid;padding-left:1ex">Hi,<br>
            <br>
            I have been testing OVPN 2.4.4 vs StrongSwan IPSec, to be
            used as<br>
            transport, and I have found something that I think might be
            a<br>
            performance issue.  I have 3 linux boxes, A, B, and C.  All
            interfaces<br>
            are 1Gbps.  Each has an interface to the next one
            downstream:<br>
            <br>
            A - eth0=<a href="http://10.10.10.10/24" rel="noreferrer"
              target="_blank" moz-do-not-send="true">10.10.10.10/24</a>
            and eth1=<a href="http://172.16.0.10/24" rel="noreferrer"
              target="_blank" moz-do-not-send="true">172.16.0.10/24</a><br>
            <br>
            B - eth0=<a href="http://172.16.0.11/24" rel="noreferrer"
              target="_blank" moz-do-not-send="true">172.16.0.11/24</a>
            and eth1=<a href="http://172.30.0.11/24" rel="noreferrer"
              target="_blank" moz-do-not-send="true">172.30.0.11/24</a><br>
            <br>
            C - eth0=<a href="http://172.30.0.10/24" rel="noreferrer"
              target="_blank" moz-do-not-send="true">172.30.0.10/24</a>
            and eth1=<a href="http://192.168.168.10/24" rel="noreferrer"
              target="_blank" moz-do-not-send="true">192.168.168.10/24</a><br>
            <br>
            Packets route as usual through this with no encryption, and
            throughput<br>
            from A to C is at wire speed.  With IPSec between A&amp;B,
            from<br>
            172.16.0.10-172.16.0.11, I can still get wire speed from A
            to C.  Then I<br>
            turn off IPSec, and I setup A as the server and B as the
            client, with<br>
            A's config being:<br>
            <br>
            =====<br>
            <br>
            dev tun<br>
            <br>
            topology subnet<br>
            server 172.17.0.0 255.255.255.0<br>
            port 1194<br>
            proto udp<br>
            dh /etc/openvpn/keys/dh2048.pem<br>
            ca /etc/openvpn/keys/ca.crt<br>
            cert /etc/openvpn/keys/server.crt<br>
            key /etc/openvpn/keys/server.key<br>
            verb 3<br>
            keepalive 10 45<br>
            cipher aes-256-cbc<br>
            comp-lzo<br>
            <br>
            tun-mtu 50000<br>
            <br>
            mssfix 0<br>
            <br>
            fragment 0<br>
            <br>
            client-config-dir ccd<br>
            <br>
            push "route 10.10.10.0 255.255.255.0"<br>
            <br>
            =====<br>
            <br>
            and the client B config file is<br>
            <br>
            =====<br>
            <br>
            verb 3<br>
            client<br>
            cipher AES-256-CBC<br>
            comp-lzo<br>
            tun-mtu 50000<br>
            mssfix 0<br>
            fragment 0<br>
            remote 172.16.0.10  1194<br>
            <br>
            dev tun<br>
            redirect-private local<br>
            tls-client<br>
            <br>
            ca /etc/openvpn/keys/ca.crt<br>
            cert /etc/openvpn/keys/client1.crt<br>
            key /etc/openvpn/keys/client1.key<br>
            <br>
            =====<br>
            <br>
            and I setup static routes on each side so that traffic is
            going through<br>
            the tunnel from A to C and vice versa.<br>
            <br>
            I can pass traffic over this link, however when I do tests
            for speed, I<br>
            am only getting about 200Mbps instead of 1Gbps.<br>
            <br>
            The funny thing is, I know that each of these machines can
            easily do<br>
            1Gbps.  If I do my performance test from A to B, over the
            above ovpn<br>
            configs, I can get just over 1Gbps because of the MTU
            overhead being<br>
            removed. But as soon as I have it make the leap downstream
            once more, I<br>
            lose 80+% of the speed.  And again, both non-encrypted
            traffic and IPSec<br>
            do the exact same test at wire speed or just slightly under
            wire speed.<br>
            <br>
            The way I do a speed test is on A:<br>
            <br>
            # nc -l -p 5555 &gt; /dev/null<br>
            <br>
            and over on C:<br>
            <br>
            # dd if=/dev/urandom of=blob.random.1G bs=10M count=100<br>
            <br>
            # time cat blob.random.1G | nc 10.10.10.10 5555<br>
            <br>
            tcpdumps over each interface confirm traffic is flowing in
            the expected<br>
            fashion.<br>
            <br>
            Over unencrypted or IPSec, I am looking at about 4s to move
            1G of data<br>
            from one end to the other, and with ovpn, 15-22s.  The
            machines involved<br>
            are 2 Dell R720's with 8+G ram and a homebrew machine with
            several Xeons<br>
            and 32G RAM.  Network cards involved are a mix of BCM Tigon3
            "tg3"<br>
            driver and IGB driver gigabit NICs.<br>
            <br>
            Anyone have any suggestions or thoughts as to why the big
            perf decrease<br>
            and what might be done to improve it?<br>
            <br>
            Thanks, <br>
            <br>
            Tom<br>
            <br>
            <br>
            <br>
            <br>
            ------------------------------<wbr>------------------------------<wbr>------------------<br>
            Check out the vibrant tech community on one of the world's
            most<br>
            engaging tech sites, Slashdot.org! <a
              href="http://sdm.link/slashdot" rel="noreferrer"
              target="_blank" moz-do-not-send="true">http://sdm.link/slashdot</a><br>
            ______________________________<wbr>_________________<br>
            Openvpn-devel mailing list<br>
            <a href="mailto:Openvpn-devel@lists.sourceforge.net"
              moz-do-not-send="true">Openvpn-devel@...1199...<wbr>sourceforge.net</a><br>
            <a
              href="https://lists.sourceforge.net/lists/listinfo/openvpn-devel"
              rel="noreferrer" target="_blank" moz-do-not-send="true">https://lists.sourceforge.net/<wbr>lists/listinfo/openvpn-devel</a><br>
          </blockquote>
        </div>
      </div>
    </blockquote>
    <p><br>
    </p>
  </body>
</html>

--------------10C9CD3BEB74EE322F0BF1EF--

