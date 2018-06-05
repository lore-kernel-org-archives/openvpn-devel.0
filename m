MIME-Version: 1.0
In-Reply-To: <49b53be0-a301-8447-2a0e-0534435e5e87@...1147...>
References: <CAJY0qZKNO_aamQfi56BG_XK2vrOCyPAQf-My1N56qqV7TsUG7A@...278...>
 <eaae68e6-e30d-f63b-59c5-64515c8f8bcd@...1147...>
 <e4a2d28a-ff8d-4797-e0af-3bcf98828cb3@...1856...>
 <CAJY0qZKw+HgQ1vS-W13nw2=gj8d-uxeOqyZia4-gEbaGNTyFLQ@...278...>
 <03a13b39-7b85-0b67-cc94-7b219e6b209f@...1147...>
 <49b53be0-a301-8447-2a0e-0534435e5e87@...1147...>
From: Derek Zimmer <derek@...2095...>
Date: Tue, 5 Jun 2018 10:23:29 -0500
Message-ID: <CAJY0qZ+_kEVS_41oOHNX=Wp47LnNhL0HKRZvR75eg7JNW3tLkQ@...278...>
Content-Type: multipart/alternative; boundary="000000000000e754ca056de6a14b"
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
To: Jan Just Keijser <janjust@...1147...>
Cc: Steffan Karger <steffan@...1856...>, openvpn-devel@lists.sourceforge.net

--000000000000e754ca056de6a14b
Content-Type: text/plain; charset="UTF-8"

JJK, this is actually quite helpful data, as I saw similar results when
doing my internal testing. The falloff rate seems to increase as the
latency increases, suggesting a fixed window or at least one that isn't
scaling properly as latency increases, which causes unusually fast
performance drops with distance increases.

The windowing reference for TCP at http://bradhedlund.com/2008/
12/19/how-to-calculate-tcp-throughput-for-long-distance-links/ is exactly
what I was suspecting was the issue, but it seems to be more complicated
than that based on everyone's feedback. OpenVPN in UDP mode is still
operating a TCP windowing layer somewhere, right? Is it possible that this
code is not windowing well for connections over 20ms? This would also
explain some of the giant performance difference between hardware and
software encryption, because it is actually reducing the latency between
the devices over the OpenVPN link, even though in software for 1Gbit on an
x86 processor you are nowhere near full CPU utilization on a single core.

The drop being asymmetrical is interesting, as I had not thought of
reversing the locations / configs to test. This adds more data to the
mystery.

Excellent data points, thank you!

-Derek

Derek Zimmer
Chief Executive Officer
Open Source Technology Improvement Fund

On Tue, Jun 5, 2018 at 7:50 AM, Jan Just Keijser <janjust@...1147...> wrote:

> Following up on myself....
>
> On 05/06/18 14:25, Jan Just Keijser wrote:
>
>
> On 01/06/18 02:50, Derek Zimmer wrote:
>
> I'm still working on this, as I think it is worthwhile for us to explore
> and get some hard data on how all of these things perform in a real world
> environment.
>
> I've been stalled by transitioning to a new job.
>
> >Same here. I guess this interacts with other properties, like the delay
> >OpenVPN itself adds.  And that is where AES-GCM, with it's blazingly
> >fast hardware acceleration, outperforms AES-CBC + HMAC-SHA in orders of
> >magnitude (at the crypto level).
>
> This might be interesting, and it also might be why my real world testing
> doesn't match what we see at https://community.openvpn.net/openvpn
> /wiki/Gigabit_Networks_Linux
>
> It looks like this experiment was conducted on machines on a LAN with
> virtually no latency / forwarding being done, so while it does show us some
> theoretical numbers they don't seem to apply to the real-world use-cases
> that we are hoping to get these types of performance figures for.
>
> As soon as we start adding latency and jitter performance seems to tank
> with these optimizations.
>
> So that I am not chasing phantoms, do we have any real-world examples of
> the claim by janjust@...1147... or are we just going off of the
> Gigabit_Networks_Linux page? If we have real world examples of
> configurations that can push more than 250Mbit (on a 1Gb controller) or
> 2.5Gbit (on a 10Gb controller) over connections with more than 10ms of
> latency then it would allow me to significantly narrow my search for
> problem areas.
>
>
> the experiment *was* conducted on a LAN with virtually no latency at that
> time. However, I've just repeated the experiment going from a university to
> my institute (~ 50 km distance) using a 1 Gbps connection. The results are
> nearly identical:
>
> [  5] local 10.200.0.2 port 34072 connected with 10.200.0.1 port 5001
> [  5]  0.0-10.0 sec   707 MBytes   592 Mbits/sec
> [  4] local 10.200.0.2 port 5001 connected with 10.200.0.1 port 51086
> [  4]  0.0-10.0 sec   874 MBytes   731 Mbits/sec
>
> (where the LAN performance is ~ 910 Mbps).
> Server:  Intel(R) Xeon(R) CPU E5-2643 0 @ 3.30GHz
> Client:  Intel(R) Core(TM) i7-4810MQ CPU @ 2.80GHz
>
> so as you see I am using 4+ year old hardware for this.
>
> I am happy to work with you to figure out what is causing the performance
> to tank. I've got access to 1 & 10 Gbps (and possible higher) internet
> links and am very curious  what is causing the jitter on your end.
>
> For higher latency links, the main option to tweak seems to be
> --txqueuelen : increase this to at least 1000 to improve performance.
>
>
> after I add an artificial latency of 20 ms on both ends using
>   tc qdisc add dev eth0 root netem delay 20ms
> I do see quite a difference:
>   outside the tunnel performance ~ 500 Mbps both ways
>   inside the tunnel:
>         client->server:  40 Mbps ;
>         server->client: ~200 Mbps
>
> It's not an iperf connection issue, if I reverse the client and server
> (i.e iperf -s and iperf -c ) then the numbers are swapped - hence it seems
> that the *tunnel itself* is slower in one direction than the other . Both
> client and server are running the same OS and the same version of OpenVPN.
>
> Ping time between hosts is now 42 ms (2+2x20)
> So for some strange reason an assymmetry is introduced; playing with
> --txqueuelen, --rcvbuf or --sndbuf did not help to remove this assymmetry.
> Also, when I read
>   http://bradhedlund.com/2008/12/19/how-to-calculate-tcp-
> throughput-for-long-distance-links/
> I am not surprised that performance drops off with a higher latency ... it
> is always worth investigating how to reduce the latency over a LAN/WAN
> before attempting to tweak a VPN connection.
>
> The assymmetry part is what puzzles me the most - I will keep looking into
> that.
>
> cheers,
>
> JJK
>
>

--000000000000e754ca056de6a14b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">JJK, this is actually quite helpful data, as I saw similar=
 results when doing my internal testing. The falloff rate seems to increase=
 as the latency increases, suggesting a fixed window or at least one that i=
sn&#39;t scaling properly as latency increases, which causes unusually fast=
 performance drops with distance increases.<div><br></div><div>The windowin=
g reference for TCP at<span style=3D"color:rgb(34,34,34);font-family:arial,=
sans-serif;font-size:12.8px;font-style:normal;font-variant-ligatures:normal=
;font-variant-caps:normal;font-weight:400;letter-spacing:normal;text-align:=
start;text-indent:0px;text-transform:none;white-space:normal;word-spacing:0=
px;background-color:rgb(255,255,255);text-decoration-style:initial;text-dec=
oration-color:initial;float:none;display:inline"><span>=C2=A0</span></span>=
<a class=3D"gmail-m_8792140109763901628moz-txt-link-freetext" href=3D"http:=
//bradhedlund.com/2008/12/19/how-to-calculate-tcp-throughput-for-long-dista=
nce-links/" target=3D"_blank" style=3D"color:rgb(17,85,204);font-family:ari=
al,sans-serif;font-size:12.8px;font-style:normal;font-variant-ligatures:nor=
mal;font-variant-caps:normal;font-weight:400;letter-spacing:normal;text-ali=
gn:start;text-indent:0px;text-transform:none;white-space:normal;word-spacin=
g:0px;background-color:rgb(255,255,255)">http://bradhedlund.com/2008/<wbr>1=
2/19/how-to-calculate-tcp-<wbr>throughput-for-long-distance-<wbr>links/</a>=
=C2=A0is exactly what I was suspecting was the issue, but it seems to be mo=
re complicated than that based on everyone&#39;s feedback. OpenVPN in UDP m=
ode is still operating a TCP windowing layer somewhere, right? Is it possib=
le that this code is not windowing well for connections over 20ms? This wou=
ld also explain some of the giant performance difference between hardware a=
nd software encryption, because it is actually reducing the latency between=
 the devices over the OpenVPN link, even though in software for 1Gbit on an=
 x86 processor you are nowhere near full CPU utilization on a single core.<=
/div><div><br></div><div>The drop being asymmetrical is interesting, as I h=
ad not thought of reversing the locations / configs to test. This adds more=
 data to the mystery.</div><div><br></div><div>Excellent data points, thank=
 you!</div><div><br></div><div>-Derek</div></div><div class=3D"gmail_extra"=
><br clear=3D"all"><div><div class=3D"gmail_signature" data-smartmail=3D"gm=
ail_signature">Derek Zimmer<br>Chief Executive Officer<br>Open Source Techn=
ology Improvement Fund</div></div>
<br><div class=3D"gmail_quote">On Tue, Jun 5, 2018 at 7:50 AM, Jan Just Kei=
jser <span dir=3D"ltr">&lt;<a href=3D"mailto:janjust@...1147..." target=3D"=
_blank">janjust@...1147...</a>&gt;</span> wrote:<br><blockquote class=3D"gm=
ail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-le=
ft:1ex">
=20=20
=20=20=20=20
=20=20
  <div text=3D"#000000" bgcolor=3D"#FFFFFF">
    <div class=3D"m_8792140109763901628moz-cite-prefix">Following up on mys=
elf....<span class=3D""><br>
      <br>
      On 05/06/18 14:25, Jan Just Keijser wrote:<br>
    </span></div><span class=3D"">
    <blockquote type=3D"cite">
=20=20=20=20=20=20
      <div class=3D"m_8792140109763901628moz-cite-prefix"><br>
        On 01/06/18 02:50, Derek Zimmer wrote:<br>
      </div>
      <blockquote type=3D"cite">
        <div dir=3D"ltr">
          <div>
            <div>I&#39;m still working on this, as I think it is worthwhile
              for us to explore and get some hard data on how all of
              these things perform in a real world environment.</div>
            <div><br>
            </div>
            <div>I&#39;ve been stalled by transitioning to a new job.<br>
            </div>
            <div><br>
            </div>
            <div>&gt;Same here. I guess this interacts with other
              properties, like the delay<br>
              <span style=3D"background-color:rgb(255,255,255)"><span class=
=3D"m_8792140109763901628il">&gt;OpenVPN</span></span> itself adds.=C2=A0 A=
nd
              that is where AES-GCM, with it&#39;s blazingly<br>
              &gt;fast hardware acceleration, outperforms AES-CBC +
              HMAC-SHA in orders of<br>
              &gt;magnitude (at the crypto level).<br>
              <br>
            </div>
            This might be interesting, and it also might be why my real
            world testing doesn&#39;t match what we see at <a href=3D"https=
://community.openvpn.net/openvpn/wiki/Gigabit_Networks_Linux" rel=3D"norefe=
rrer" target=3D"_blank">https://community.<span class=3D"m_8792140109763901=
628il">openvpn</span>.net/<span class=3D"m_8792140109763901628il"><wbr>open=
vpn</span>/wiki/Gigabit_Networks_<wbr>Linux<br>
            </a></div>
          <div class=3D"gmail_extra">
            <div>
              <div class=3D"m_8792140109763901628gmail_signature" data-smar=
tmail=3D"gmail_signature"><br>
              </div>
              <div class=3D"m_8792140109763901628gmail_signature" data-smar=
tmail=3D"gmail_signature">It looks like this
                experiment was conducted on machines on a LAN with
                virtually no latency / forwarding being done, so while
                it does show us some theoretical numbers they don&#39;t seem
                to apply to the real-world use-cases that we are hoping
                to get these types of performance figures for.<br>
              </div>
              <div class=3D"m_8792140109763901628gmail_signature" data-smar=
tmail=3D"gmail_signature"><br>
              </div>
              <div class=3D"m_8792140109763901628gmail_signature" data-smar=
tmail=3D"gmail_signature">As soon as we start
                adding latency and jitter performance seems to tank with
                these optimizations.</div>
              <div class=3D"m_8792140109763901628gmail_signature" data-smar=
tmail=3D"gmail_signature"><br>
              </div>
              <div class=3D"m_8792140109763901628gmail_signature" data-smar=
tmail=3D"gmail_signature">So that I am not
                chasing phantoms, do we have any real-world examples of
                the claim by janjust@<a href=3D"http://nikhef.nl" target=3D=
"_blank">nikhef.nl</a> or are we just
                going off of the Gigabit_Networks_Linux page? If we have
                real world examples of configurations that can push more
                than 250Mbit (on a 1Gb controller) or 2.5Gbit (on a 10Gb
                controller) over connections with more than 10ms of
                latency then it would allow me to significantly narrow
                my search for problem areas.<br>
              </div>
              <div class=3D"m_8792140109763901628gmail_signature" data-smar=
tmail=3D"gmail_signature"><br>
              </div>
            </div>
          </div>
        </div>
      </blockquote>
      <br>
      the experiment *was* conducted on a LAN with virtually no latency
      at that time. However, I&#39;ve just repeated the experiment going
      from a university to my institute (~ 50 km distance) using a 1
      Gbps connection. The results are nearly identical:<br>
      <br>
      [=C2=A0 5] local 10.200.0.2 port 34072 connected with 10.200.0.1 port
      5001<br>
      [=C2=A0 5]=C2=A0 0.0-10.0 sec=C2=A0=C2=A0 707 MBytes=C2=A0=C2=A0 592 =
Mbits/sec<br>
      [=C2=A0 4] local 10.200.0.2 port 5001 connected with 10.200.0.1 port
      51086<br>
      [=C2=A0 4]=C2=A0 0.0-10.0 sec=C2=A0=C2=A0 874 MBytes=C2=A0=C2=A0 731 =
Mbits/sec<br>
      <br>
      (where the LAN performance is ~ 910 Mbps).<br>
      Server:=C2=A0 Intel(R) Xeon(R) CPU E5-2643 0 @ 3.30GHz<br>
      Client:=C2=A0 Intel(R) Core(TM) i7-4810MQ CPU @ 2.80GHz<br>
      <br>
      so as you see I am using 4+ year old hardware for this.<br>
      <br>
      I am happy to work with you to figure out what is causing the
      performance to tank. I&#39;ve got access to 1 &amp; 10 Gbps (and
      possible higher) internet links and am very curious=C2=A0 what is
      causing the jitter on your end.<br>
      <br>
      For higher latency links, the main option to tweak seems to be
      --txqueuelen : increase this to at least 1000 to improve
      performance.<br>
      <br>
      <br>
    </blockquote></span>
    after I add an artificial latency of 20 ms on both ends using <code><br>
      =C2=A0 tc qdisc add dev eth0 root netem delay 20ms</code><br>
    I do see quite a difference:<br>
    =C2=A0 outside the tunnel performance ~ 500 Mbps both ways<br>
    =C2=A0 inside the tunnel:=C2=A0 <br>
    =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 client-&gt;server:=C2=A0 40 Mbps =
; <br>
    =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 server-&gt;client: ~200 Mbps<br>
    <br>
    It&#39;s not an iperf connection issue, if I reverse the client and
    server (i.e iperf -s and iperf -c ) then the numbers are swapped -
    hence it seems that the *tunnel itself* is slower in one direction
    than the other . Both client and server are running the same OS and
    the same version of OpenVPN.<br>
    <br>
    Ping time between hosts is now 42 ms (2+2x20)<br>
    So for some strange reason an assymmetry is introduced; playing with
    --txqueuelen, --rcvbuf or --sndbuf did not help to remove this
    assymmetry. Also, when I read<br>
    =C2=A0
<a class=3D"m_8792140109763901628moz-txt-link-freetext" href=3D"http://brad=
hedlund.com/2008/12/19/how-to-calculate-tcp-throughput-for-long-distance-li=
nks/" target=3D"_blank">http://bradhedlund.com/2008/<wbr>12/19/how-to-calcu=
late-tcp-<wbr>throughput-for-long-distance-<wbr>links/</a><br>
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
  </div>

</blockquote></div><br></div>

--000000000000e754ca056de6a14b--

