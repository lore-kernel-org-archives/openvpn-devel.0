References: <7f72b2de-f411-c4a0-bd1e-f343543cb8e2@...2030...>
 <CAAjorqWaFY+XdD5XZ95rPyXJHd9MfPv3Xmv3M1gKfWHbnJXL9w@...278...>
 <6ad04520-6e42-51aa-bd38-b2285e7adaab@...2030...>
From: Jan Just Keijser <janjust@...1147...>
Message-ID: <5d22ace4-0fa0-857c-beef-8010edcf4350@...1147...>
Date: Sat, 6 Jan 2018 22:28:01 +0100
MIME-Version: 1.0
In-Reply-To: <6ad04520-6e42-51aa-bd38-b2285e7adaab@...2030...>
Content-Type: multipart/alternative;
 boundary="------------C4C99F25A634AAE891F93DE5"
Subject: Re: [Openvpn-devel] OVPN vs IPSec performance as a transport
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Tom Kunz <tkunz@...2030...>, "Greg Sloop <gregs@...1934...>" <gregs@...1934...>
Cc: openvpn-devel@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------C4C99F25A634AAE891F93DE5
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit

On 05/01/18 00:52, Tom Kunz wrote:
> That would explain it if it always worked that way.
> But I can get 400%+ wire speed from A to B with compressible data, and 
> 102% with incompressible data.  If I do the same test from B to A or A 
> to B, I get those results.  If I hop off of that to C, speed goes from 
> >1Gbps to sub-200Mbps.  In either case, the data has left the kernel 
> space to arrive at "nc", so just simply saying "it's kernel vs user" 
> doesn't answer it.
>
>
actually, it does answer it: I've ran similar tests a few years back and 
got similar results. See
https://homepages.staff.os3.nl/~delaat/rp/2010-2011/p09/report.pdf

for the report.
  Here's what happens:

if you run nc on the VPN endpoints themselves, then the OS can make use 
of the fact that the tun MTU is set to a very high value - thus you can 
easily achieve line speeds. However, as soon as you try to reach a 
machine beyond either VPN endpoint, then all traffic is fragmented to 
the MTU of the LAN , so normally that's 1500, possibly 6000.  On your 
host C, all packets are chopped into 1500 bytes fragments (payload = 
1472 bytes) and *THESE* packets are received by the OpenVPN endpoint, 
then compressed, encrypted, possibly fragmented and sent to the remove 
end. The tun MTU is never reached in this case, as each packet is 
handled separately.
So yes, OpenVPN *IS* capped by the number of kernel-to-userspace 
transitions. On a high clockspeed CPU (e.g. i5-6000 series or higher 
with high turbo speed) you can achieve close to line speed, although I 
have yet to find out what MELTDOWN and the fix for it will to do the 
maximum speeds.

As IPsec runs in kernel space, it does not suffer from the large number 
of transitions and it can thus achieve higher speeds going from A-B->C

Hope this clarifies things,

JJK


> On 01/04/2018 06:37 PM, Greg Sloop <gregs@...1934...> wrote:
>> I'm sure someone else, or a Google search will get you a more 
>> detailed run-down - but the gist of the "problem" is this;
>>
>> OpenVPN is run in user-space, not kernel space. IPSec  runs in kernel 
>> space, and the difference is vastly diminished throughput.
>>
>> HTH
>>
>> -Greg
>>
>> On Jan 4, 2018 3:23 PM, "Tom Kunz" <tkunz@...2030... 
>> <mailto:tkunz@...2030...>> wrote:
>>
>>     Hi,
>>
>>     I have been testing OVPN 2.4.4 vs StrongSwan IPSec, to be used as
>>     transport, and I have found something that I think might be a
>>     performance issue.  I have 3 linux boxes, A, B, and C. All interfaces
>>     are 1Gbps.  Each has an interface to the next one downstream:
>>
>>     A - eth0=10.10.10.10/24 <http://10.10.10.10/24> and
>>     eth1=172.16.0.10/24 <http://172.16.0.10/24>
>>
>>     B - eth0=172.16.0.11/24 <http://172.16.0.11/24> and
>>     eth1=172.30.0.11/24 <http://172.30.0.11/24>
>>
>>     C - eth0=172.30.0.10/24 <http://172.30.0.10/24> and
>>     eth1=192.168.168.10/24 <http://192.168.168.10/24>
>>
>>     Packets route as usual through this with no encryption, and
>>     throughput
>>     from A to C is at wire speed.  With IPSec between A&B, from
>>     172.16.0.10-172.16.0.11, I can still get wire speed from A to C. 
>>     Then I
>>     turn off IPSec, and I setup A as the server and B as the client, with
>>     A's config being:
>>
>>     =====
>>
>>     dev tun
>>
>>     topology subnet
>>     server 172.17.0.0 255.255.255.0
>>     port 1194
>>     proto udp
>>     dh /etc/openvpn/keys/dh2048.pem
>>     ca /etc/openvpn/keys/ca.crt
>>     cert /etc/openvpn/keys/server.crt
>>     key /etc/openvpn/keys/server.key
>>     verb 3
>>     keepalive 10 45
>>     cipher aes-256-cbc
>>     comp-lzo
>>
>>     tun-mtu 50000
>>
>>     mssfix 0
>>
>>     fragment 0
>>
>>     client-config-dir ccd
>>
>>     push "route 10.10.10.0 255.255.255.0"
>>
>>     =====
>>
>>     and the client B config file is
>>
>>     =====
>>
>>     verb 3
>>     client
>>     cipher AES-256-CBC
>>     comp-lzo
>>     tun-mtu 50000
>>     mssfix 0
>>     fragment 0
>>     remote 172.16.0.10  1194
>>
>>     dev tun
>>     redirect-private local
>>     tls-client
>>
>>     ca /etc/openvpn/keys/ca.crt
>>     cert /etc/openvpn/keys/client1.crt
>>     key /etc/openvpn/keys/client1.key
>>
>>     =====
>>
>>     and I setup static routes on each side so that traffic is going
>>     through
>>     the tunnel from A to C and vice versa.
>>
>>     I can pass traffic over this link, however when I do tests for
>>     speed, I
>>     am only getting about 200Mbps instead of 1Gbps.
>>
>>     The funny thing is, I know that each of these machines can easily do
>>     1Gbps.  If I do my performance test from A to B, over the above ovpn
>>     configs, I can get just over 1Gbps because of the MTU overhead being
>>     removed. But as soon as I have it make the leap downstream once
>>     more, I
>>     lose 80+% of the speed.  And again, both non-encrypted traffic
>>     and IPSec
>>     do the exact same test at wire speed or just slightly under wire
>>     speed.
>>
>>     The way I do a speed test is on A:
>>
>>     # nc -l -p 5555 > /dev/null
>>
>>     and over on C:
>>
>>     # dd if=/dev/urandom of=blob.random.1G bs=10M count=100
>>
>>     # time cat blob.random.1G | nc 10.10.10.10 5555
>>
>>     tcpdumps over each interface confirm traffic is flowing in the
>>     expected
>>     fashion.
>>
>>     Over unencrypted or IPSec, I am looking at about 4s to move 1G of
>>     data
>>     from one end to the other, and with ovpn, 15-22s.  The machines
>>     involved
>>     are 2 Dell R720's with 8+G ram and a homebrew machine with
>>     several Xeons
>>     and 32G RAM.  Network cards involved are a mix of BCM Tigon3 "tg3"
>>     driver and IGB driver gigabit NICs.
>>
>>     Anyone have any suggestions or thoughts as to why the big perf
>>     decrease
>>     and what might be done to improve it?
>>
>>     Thanks,
>>
>>     Tom
>>
>>
>>
>>
>>     ------------------------------------------------------------------------------
>>     Check out the vibrant tech community on one of the world's most
>>     engaging tech sites, Slashdot.org! http://sdm.link/slashdot
>>     _______________________________________________
>>     Openvpn-devel mailing list
>>     Openvpn-devel@lists.sourceforge.net
>>     <mailto:Openvpn-devel@lists.sourceforge.net>
>>     https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>>     <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>
>>
>
>
>
> ------------------------------------------------------------------------------
> Check out the vibrant tech community on one of the world's most
> engaging tech sites, Slashdot.org! http://sdm.link/slashdot
>
>
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel


--------------C4C99F25A634AAE891F93DE5
Content-Type: text/html; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

<html>
  <head>
    <meta content=3D"text/html; charset=3Dwindows-1252"
      http-equiv=3D"Content-Type">
  </head>
  <body bgcolor=3D"#FFFFFF" text=3D"#000000">
    <div class=3D"moz-cite-prefix">On 05/01/18 00:52, Tom Kunz wrote:<br>
    </div>
    <blockquote
cite=3D"mid:6ad04520-6e42-51aa-bd38-b2285e7adaab@...2030..."
      type=3D"cite">
      <meta http-equiv=3D"Content-Type" content=3D"text/html;
        charset=3Dwindows-1252">
      <div class=3D"moz-cite-prefix">That would explain it if it always
        worked that way.<br>
        But I can get 400%+ wire speed from A to B with compressible
        data, and 102% with incompressible data.=A0 If I do the same test
        from B to A or A to B, I get those results.=A0 If I hop off of
        that to C, speed goes from &gt;1Gbps to sub-200Mbps.=A0 In either
        case, the data has left the kernel space to arrive at "nc", so
        just simply saying "it's kernel vs user" doesn't answer it.<br>
        <br>
        <br>
      </div>
    </blockquote>
    actually, it does answer it: I've ran similar tests a few years back
    and got similar results. See<br>
    =A0 <cite class=3D"_Rm"><a class=3D"moz-txt-link-freetext" href=3D"http=
s://homepages.staff.os3.nl/~delaat/rp/2010-2011/p09/report.pdf">https://hom=
epages.staff.os3.nl/~delaat/rp/2010-2011/p09/report.pdf</a><br>
      <br>
    </cite>for the report.<br>
    =A0Here's what happens:<br>
    <br>
    if you run nc on the VPN endpoints themselves, then the OS can make
    use of the fact that the tun MTU is set to a very high value - thus
    you can easily achieve line speeds. However, as soon as you try to
    reach a machine beyond either VPN endpoint, then all traffic is
    fragmented to the MTU of the LAN , so normally that's 1500, possibly
    6000.=A0 On your host C, all packets are chopped into 1500 bytes
    fragments (payload =3D 1472 bytes) and *THESE* packets are received by
    the OpenVPN endpoint, then compressed, encrypted, possibly
    fragmented and sent to the remove end. The tun MTU is never reached
    in this case, as each packet is handled separately.<br>
    So yes, OpenVPN *IS* capped by the number of kernel-to-userspace
    transitions. On a high clockspeed CPU (e.g. i5-6000 series or higher
    with high turbo speed) you can achieve close to line speed, although
    I have yet to find out what MELTDOWN and the fix for it will to do
    the maximum speeds.<br>
    <br>
    As IPsec runs in kernel space, it does not suffer from the large
    number of transitions and it can thus achieve higher speeds going
    from A-B-&gt;C<br>
    <br>
    Hope this clarifies things,<br>
    <br>
    JJK<br>
    <br>
    =A0<br>
    <blockquote
cite=3D"mid:6ad04520-6e42-51aa-bd38-b2285e7adaab@...2030..."
      type=3D"cite">
      <div class=3D"moz-cite-prefix"> On 01/04/2018 06:37 PM, Greg Sloop <a
          moz-do-not-send=3D"true" class=3D"moz-txt-link-rfc2396E"
          href=3D"mailto:gregs@...1934..."><a class=3D"moz-txt-link-rfc2396=
E" href=3D"mailto:gregs@...1934...">&lt;gregs@...1934...&gt;</a></a>
        wrote:<br>
      </div>
      <blockquote type=3D"cite"
cite=3D"mid:CAAjorqWaFY+XdD5XZ95rPyXJHd9MfPv3Xmv3M1gKfWHbnJXL9w@...278...">
        <div dir=3D"auto">I'm sure someone else, or a Google search will
          get you a more detailed run-down - but the gist of the
          "problem" is this;
          <div dir=3D"auto"><br>
          </div>
          <div dir=3D"auto">OpenVPN is run in user-space, not kernel
            space. IPSec =A0runs in kernel space, and the difference is
            vastly diminished throughput.</div>
          <div dir=3D"auto"><br>
          </div>
          <div dir=3D"auto">HTH</div>
          <div dir=3D"auto"><br>
          </div>
          <div dir=3D"auto">-Greg</div>
        </div>
        <div class=3D"gmail_extra"><br>
          <div class=3D"gmail_quote">On Jan 4, 2018 3:23 PM, "Tom Kunz"
            &lt;<a href=3D"mailto:tkunz@...2030..."
              moz-do-not-send=3D"true">tkunz@...2030...</a>&gt;
            wrote:<br type=3D"attribution">
            <blockquote class=3D"gmail_quote" style=3D"margin:0 0 0
              .8ex;border-left:1px #ccc solid;padding-left:1ex">Hi,<br>
              <br>
              I have been testing OVPN 2.4.4 vs StrongSwan IPSec, to be
              used as<br>
              transport, and I have found something that I think might
              be a<br>
              performance issue.=A0 I have 3 linux boxes, A, B, and C.=A0
              All interfaces<br>
              are 1Gbps.=A0 Each has an interface to the next one
              downstream:<br>
              <br>
              A - eth0=3D<a href=3D"http://10.10.10.10/24" rel=3D"noreferre=
r"
                target=3D"_blank" moz-do-not-send=3D"true">10.10.10.10/24</=
a>
              and eth1=3D<a href=3D"http://172.16.0.10/24" rel=3D"noreferre=
r"
                target=3D"_blank" moz-do-not-send=3D"true">172.16.0.10/24</=
a><br>
              <br>
              B - eth0=3D<a href=3D"http://172.16.0.11/24" rel=3D"noreferre=
r"
                target=3D"_blank" moz-do-not-send=3D"true">172.16.0.11/24</=
a>
              and eth1=3D<a href=3D"http://172.30.0.11/24" rel=3D"noreferre=
r"
                target=3D"_blank" moz-do-not-send=3D"true">172.30.0.11/24</=
a><br>
              <br>
              C - eth0=3D<a href=3D"http://172.30.0.10/24" rel=3D"noreferre=
r"
                target=3D"_blank" moz-do-not-send=3D"true">172.30.0.10/24</=
a>
              and eth1=3D<a href=3D"http://192.168.168.10/24"
                rel=3D"noreferrer" target=3D"_blank" moz-do-not-send=3D"tru=
e">192.168.168.10/24</a><br>
              <br>
              Packets route as usual through this with no encryption,
              and throughput<br>
              from A to C is at wire speed.=A0 With IPSec between A&amp;B,
              from<br>
              172.16.0.10-172.16.0.11, I can still get wire speed from A
              to C.=A0 Then I<br>
              turn off IPSec, and I setup A as the server and B as the
              client, with<br>
              A's config being:<br>
              <br>
              =3D=3D=3D=3D=3D<br>
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
              =3D=3D=3D=3D=3D<br>
              <br>
              and the client B config file is<br>
              <br>
              =3D=3D=3D=3D=3D<br>
              <br>
              verb 3<br>
              client<br>
              cipher AES-256-CBC<br>
              comp-lzo<br>
              tun-mtu 50000<br>
              mssfix 0<br>
              fragment 0<br>
              remote 172.16.0.10=A0 1194<br>
              <br>
              dev tun<br>
              redirect-private local<br>
              tls-client<br>
              <br>
              ca /etc/openvpn/keys/ca.crt<br>
              cert /etc/openvpn/keys/client1.crt<br>
              key /etc/openvpn/keys/client1.key<br>
              <br>
              =3D=3D=3D=3D=3D<br>
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
              1Gbps.=A0 If I do my performance test from A to B, over the
              above ovpn<br>
              configs, I can get just over 1Gbps because of the MTU
              overhead being<br>
              removed. But as soon as I have it make the leap downstream
              once more, I<br>
              lose 80+% of the speed.=A0 And again, both non-encrypted
              traffic and IPSec<br>
              do the exact same test at wire speed or just slightly
              under wire speed.<br>
              <br>
              The way I do a speed test is on A:<br>
              <br>
              # nc -l -p 5555 &gt; /dev/null<br>
              <br>
              and over on C:<br>
              <br>
              # dd if=3D/dev/urandom of=3Dblob.random.1G bs=3D10M count=3D1=
00<br>
              <br>
              # time cat blob.random.1G | nc 10.10.10.10 5555<br>
              <br>
              tcpdumps over each interface confirm traffic is flowing in
              the expected<br>
              fashion.<br>
              <br>
              Over unencrypted or IPSec, I am looking at about 4s to
              move 1G of data<br>
              from one end to the other, and with ovpn, 15-22s.=A0 The
              machines involved<br>
              are 2 Dell R720's with 8+G ram and a homebrew machine with
              several Xeons<br>
              and 32G RAM.=A0 Network cards involved are a mix of BCM
              Tigon3 "tg3"<br>
              driver and IGB driver gigabit NICs.<br>
              <br>
              Anyone have any suggestions or thoughts as to why the big
              perf decrease<br>
              and what might be done to improve it?<br>
              <br>
              Thanks,=A0<br>
              <br>
              Tom<br>
              <br>
              <br>
              <br>
              <br>
              ------------------------------<wbr>--------------------------=
----<wbr>------------------<br>
              Check out the vibrant tech community on one of the world's
              most<br>
              engaging tech sites, Slashdot.org! <a
                href=3D"http://sdm.link/slashdot" rel=3D"noreferrer"
                target=3D"_blank" moz-do-not-send=3D"true"><a class=3D"moz-=
txt-link-freetext" href=3D"http://sdm.link/slashdot">http://sdm.link/slashd=
ot</a></a><br>
              ______________________________<wbr>_________________<br>
              Openvpn-devel mailing list<br>
              <a href=3D"mailto:Openvpn-devel@lists.sourceforge.net"
                moz-do-not-send=3D"true">Openvpn-devel@...1199...<wbr>sourc=
eforge.net</a><br>
              <a
                href=3D"https://lists.sourceforge.net/lists/listinfo/openvp=
n-devel"
                rel=3D"noreferrer" target=3D"_blank" moz-do-not-send=3D"tru=
e"><a class=3D"moz-txt-link-freetext" href=3D"https://lists.sourceforge.net=
/">https://lists.sourceforge.net/</a><wbr>lists/listinfo/openvpn-devel</a><=
br>
            </blockquote>
          </div>
        </div>
      </blockquote>
      <p><br>
      </p>
      <br>
      <fieldset class=3D"mimeAttachmentHeader"></fieldset>
      <br>
      <pre wrap=3D"">------------------------------------------------------=
------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! <a class=3D"moz-txt-link-freetext" href=
=3D"http://sdm.link/slashdot">http://sdm.link/slashdot</a></pre>
      <br>
      <fieldset class=3D"mimeAttachmentHeader"></fieldset>
      <br>
      <pre wrap=3D"">_______________________________________________
Openvpn-devel mailing list
<a class=3D"moz-txt-link-abbreviated" href=3D"mailto:Openvpn-devel@lists.so=
urceforge.net">Openvpn-devel@lists.sourceforge.net</a>
<a class=3D"moz-txt-link-freetext" href=3D"https://lists.sourceforge.net/li=
sts/listinfo/openvpn-devel">https://lists.sourceforge.net/lists/listinfo/op=
envpn-devel</a>
</pre>
    </blockquote>
    <br>
  </body>
</html>

--------------C4C99F25A634AAE891F93DE5--

