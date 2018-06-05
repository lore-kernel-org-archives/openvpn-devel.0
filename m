From: Jan Just Keijser <janjust@...1147...>
References: <CAJY0qZKNO_aamQfi56BG_XK2vrOCyPAQf-My1N56qqV7TsUG7A@...278...>
 <eaae68e6-e30d-f63b-59c5-64515c8f8bcd@...1147...>
 <e4a2d28a-ff8d-4797-e0af-3bcf98828cb3@...1856...>
 <CAJY0qZKw+HgQ1vS-W13nw2=gj8d-uxeOqyZia4-gEbaGNTyFLQ@...278...>
 <03a13b39-7b85-0b67-cc94-7b219e6b209f@...1147...>
Message-ID: <49b53be0-a301-8447-2a0e-0534435e5e87@...1147...>
Date: Tue, 5 Jun 2018 14:50:40 +0200
MIME-Version: 1.0
In-Reply-To: <03a13b39-7b85-0b67-cc94-7b219e6b209f@...1147...>
Content-Type: multipart/alternative;
 boundary="------------DEDEF04C01694EAE5AD59727"
Content-Language: nl-NL
Subject: Re: [Openvpn-devel] Does the OpenVPN protocol itself handle
 windowing?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Derek Zimmer <derek@...2095...>, Steffan Karger <steffan@...1856...>
Cc: openvpn-devel@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------DEDEF04C01694EAE5AD59727
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit

Following up on myself....

On 05/06/18 14:25, Jan Just Keijser wrote:
>
> On 01/06/18 02:50, Derek Zimmer wrote:
>> I'm still working on this, as I think it is worthwhile for us to 
>> explore and get some hard data on how all of these things perform in 
>> a real world environment.
>>
>> I've been stalled by transitioning to a new job.
>>
>> >Same here. I guess this interacts with other properties, like the delay
>> >OpenVPN itself adds.  And that is where AES-GCM, with it's blazingly
>> >fast hardware acceleration, outperforms AES-CBC + HMAC-SHA in orders of
>> >magnitude (at the crypto level).
>>
>> This might be interesting, and it also might be why my real world 
>> testing doesn't match what we see at 
>> https://community.openvpn.net/openvpn/wiki/Gigabit_Networks_Linux
>> <https://community.openvpn.net/openvpn/wiki/Gigabit_Networks_Linux>
>>
>> It looks like this experiment was conducted on machines on a LAN with 
>> virtually no latency / forwarding being done, so while it does show 
>> us some theoretical numbers they don't seem to apply to the 
>> real-world use-cases that we are hoping to get these types of 
>> performance figures for.
>>
>> As soon as we start adding latency and jitter performance seems to 
>> tank with these optimizations.
>>
>> So that I am not chasing phantoms, do we have any real-world examples 
>> of the claim by janjust@...1147... <http://nikhef.nl> or are we just 
>> going off of the Gigabit_Networks_Linux page? If we have real world 
>> examples of configurations that can push more than 250Mbit (on a 1Gb 
>> controller) or 2.5Gbit (on a 10Gb controller) over connections with 
>> more than 10ms of latency then it would allow me to significantly 
>> narrow my search for problem areas.
>>
>
> the experiment *was* conducted on a LAN with virtually no latency at 
> that time. However, I've just repeated the experiment going from a 
> university to my institute (~ 50 km distance) using a 1 Gbps 
> connection. The results are nearly identical:
>
> [  5] local 10.200.0.2 port 34072 connected with 10.200.0.1 port 5001
> [  5]  0.0-10.0 sec   707 MBytes   592 Mbits/sec
> [  4] local 10.200.0.2 port 5001 connected with 10.200.0.1 port 51086
> [  4]  0.0-10.0 sec   874 MBytes   731 Mbits/sec
>
> (where the LAN performance is ~ 910 Mbps).
> Server:  Intel(R) Xeon(R) CPU E5-2643 0 @ 3.30GHz
> Client:  Intel(R) Core(TM) i7-4810MQ CPU @ 2.80GHz
>
> so as you see I am using 4+ year old hardware for this.
>
> I am happy to work with you to figure out what is causing the 
> performance to tank. I've got access to 1 & 10 Gbps (and possible 
> higher) internet links and am very curious  what is causing the jitter 
> on your end.
>
> For higher latency links, the main option to tweak seems to be 
> --txqueuelen : increase this to at least 1000 to improve performance.
>
>
after I add an artificial latency of 20 ms on both ends using |
   tc qdisc add dev eth0 root netem delay 20ms|
I do see quite a difference:
   outside the tunnel performance ~ 500 Mbps both ways
   inside the tunnel:
         client->server:  40 Mbps ;
         server->client: ~200 Mbps

It's not an iperf connection issue, if I reverse the client and server 
(i.e iperf -s and iperf -c ) then the numbers are swapped - hence it 
seems that the *tunnel itself* is slower in one direction than the other 
. Both client and server are running the same OS and the same version of 
OpenVPN.

Ping time between hosts is now 42 ms (2+2x20)
So for some strange reason an assymmetry is introduced; playing with 
--txqueuelen, --rcvbuf or --sndbuf did not help to remove this 
assymmetry. Also, when I read
http://bradhedlund.com/2008/12/19/how-to-calculate-tcp-throughput-for-long-distance-links/
I am not surprised that performance drops off with a higher latency ... 
it is always worth investigating how to reduce the latency over a 
LAN/WAN before attempting to tweak a VPN connection.

The assymmetry part is what puzzles me the most - I will keep looking 
into that.

cheers,

JJK


--------------DEDEF04C01694EAE5AD59727
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <div class="moz-cite-prefix">Following up on myself....<br>
      <br>
      On 05/06/18 14:25, Jan Just Keijser wrote:<br>
    </div>
    <blockquote type="cite"
      cite="mid:03a13b39-7b85-0b67-cc94-7b219e6b209f@...1147...">
      <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
      <div class="moz-cite-prefix"><br>
        On 01/06/18 02:50, Derek Zimmer wrote:<br>
      </div>
      <blockquote type="cite"
cite="mid:CAJY0qZKw+HgQ1vS-W13nw2=gj8d-uxeOqyZia4-gEbaGNTyFLQ@...278...">
        <div dir="ltr">
          <div>
            <div>I'm still working on this, as I think it is worthwhile
              for us to explore and get some hard data on how all of
              these things perform in a real world environment.</div>
            <div><br>
            </div>
            <div>I've been stalled by transitioning to a new job.<br>
            </div>
            <div><br>
            </div>
            <div>&gt;Same here. I guess this interacts with other
              properties, like the delay<br>
              <span style="background-color:rgb(255,255,255)"><span
                  class="il">&gt;OpenVPN</span></span> itself adds.  And
              that is where AES-GCM, with it's blazingly<br>
              &gt;fast hardware acceleration, outperforms AES-CBC +
              HMAC-SHA in orders of<br>
              &gt;magnitude (at the crypto level).<br>
              <br>
            </div>
            This might be interesting, and it also might be why my real
            world testing doesn't match what we see at <a
              href="https://community.openvpn.net/openvpn/wiki/Gigabit_Networks_Linux"
              rel="noreferrer" target="_blank" moz-do-not-send="true">https://community.<span
                class="il">openvpn</span>.net/<wbr><span class="il">openvpn</span>/wiki/Gigabit_Networks_<wbr>Linux<br>
            </a></div>
          <div class="gmail_extra">
            <div>
              <div class="gmail_signature"
                data-smartmail="gmail_signature"><br>
              </div>
              <div class="gmail_signature"
                data-smartmail="gmail_signature">It looks like this
                experiment was conducted on machines on a LAN with
                virtually no latency / forwarding being done, so while
                it does show us some theoretical numbers they don't seem
                to apply to the real-world use-cases that we are hoping
                to get these types of performance figures for.<br>
              </div>
              <div class="gmail_signature"
                data-smartmail="gmail_signature"><br>
              </div>
              <div class="gmail_signature"
                data-smartmail="gmail_signature">As soon as we start
                adding latency and jitter performance seems to tank with
                these optimizations.</div>
              <div class="gmail_signature"
                data-smartmail="gmail_signature"><br>
              </div>
              <div class="gmail_signature"
                data-smartmail="gmail_signature">So that I am not
                chasing phantoms, do we have any real-world examples of
                the claim by janjust<wbr>@<a href="http://nikhef.nl"
                  moz-do-not-send="true">nikhef.nl</a> or are we just
                going off of the Gigabit_Networks_Linux page? If we have
                real world examples of configurations that can push more
                than 250Mbit (on a 1Gb controller) or 2.5Gbit (on a 10Gb
                controller) over connections with more than 10ms of
                latency then it would allow me to significantly narrow
                my search for problem areas.<br>
              </div>
              <div class="gmail_signature"
                data-smartmail="gmail_signature"><br>
              </div>
            </div>
          </div>
        </div>
      </blockquote>
      <br>
      the experiment *was* conducted on a LAN with virtually no latency
      at that time. However, I've just repeated the experiment going
      from a university to my institute (~ 50 km distance) using a 1
      Gbps connection. The results are nearly identical:<br>
      <br>
      [  5] local 10.200.0.2 port 34072 connected with 10.200.0.1 port
      5001<br>
      [  5]  0.0-10.0 sec   707 MBytes   592 Mbits/sec<br>
      [  4] local 10.200.0.2 port 5001 connected with 10.200.0.1 port
      51086<br>
      [  4]  0.0-10.0 sec   874 MBytes   731 Mbits/sec<br>
      <br>
      (where the LAN performance is ~ 910 Mbps).<br>
      Server:  Intel(R) Xeon(R) CPU E5-2643 0 @ 3.30GHz<br>
      Client:  Intel(R) Core(TM) i7-4810MQ CPU @ 2.80GHz<br>
      <br>
      so as you see I am using 4+ year old hardware for this.<br>
      <br>
      I am happy to work with you to figure out what is causing the
      performance to tank. I've got access to 1 &amp; 10 Gbps (and
      possible higher) internet links and am very curious  what is
      causing the jitter on your end.<br>
      <br>
      For higher latency links, the main option to tweak seems to be
      --txqueuelen : increase this to at least 1000 to improve
      performance.<br>
      <br>
      <br>
    </blockquote>
    after I add an artificial latency of 20 ms on both ends using <code><br>
        tc qdisc add dev eth0 root netem delay 20ms</code><br>
    I do see quite a difference:<br>
      outside the tunnel performance ~ 500 Mbps both ways<br>
      inside the tunnel:  <br>
            client-&gt;server:  40 Mbps ; <br>
            server-&gt;client: ~200 Mbps<br>
    <br>
    It's not an iperf connection issue, if I reverse the client and
    server (i.e iperf -s and iperf -c ) then the numbers are swapped -
    hence it seems that the *tunnel itself* is slower in one direction
    than the other . Both client and server are running the same OS and
    the same version of OpenVPN.<br>
    <br>
    Ping time between hosts is now 42 ms (2+2x20)<br>
    So for some strange reason an assymmetry is introduced; playing with
    --txqueuelen, --rcvbuf or --sndbuf did not help to remove this
    assymmetry. Also, when I read<br>
     
<a class="moz-txt-link-freetext" href="http://bradhedlund.com/2008/12/19/how-to-calculate-tcp-throughput-for-long-distance-links/">http://bradhedlund.com/2008/12/19/how-to-calculate-tcp-throughput-for-long-distance-links/</a><br>
    I am not surprised that performance drops off with a higher latency
    ... it is always worth investigating how to reduce the latency over
    a LAN/WAN before attempting to tweak a VPN connection.<br>
    <br>
    The assymmetry part is what puzzles me the most - I will keep
    looking into that. <br>
    <br>
    cheers,<br>
    <br>
    JJK<br>
    <br>
  </body>
</html>

--------------DEDEF04C01694EAE5AD59727--

