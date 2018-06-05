References: <CAJY0qZKNO_aamQfi56BG_XK2vrOCyPAQf-My1N56qqV7TsUG7A@...278...>
 <eaae68e6-e30d-f63b-59c5-64515c8f8bcd@...1147...>
 <e4a2d28a-ff8d-4797-e0af-3bcf98828cb3@...1856...>
 <CAJY0qZKw+HgQ1vS-W13nw2=gj8d-uxeOqyZia4-gEbaGNTyFLQ@...278...>
From: Jan Just Keijser <janjust@...1147...>
Message-ID: <03a13b39-7b85-0b67-cc94-7b219e6b209f@...1147...>
Date: Tue, 5 Jun 2018 14:25:12 +0200
MIME-Version: 1.0
In-Reply-To: <CAJY0qZKw+HgQ1vS-W13nw2=gj8d-uxeOqyZia4-gEbaGNTyFLQ@...278...>
Content-Type: multipart/alternative;
 boundary="------------20908DA062232652C26D52C4"
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
--------------20908DA062232652C26D52C4
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit

Hi,

On 01/06/18 02:50, Derek Zimmer wrote:
> I'm still working on this, as I think it is worthwhile for us to 
> explore and get some hard data on how all of these things perform in a 
> real world environment.
>
> I've been stalled by transitioning to a new job.
>
> >Same here. I guess this interacts with other properties, like the delay
> >OpenVPN itself adds.  And that is where AES-GCM, with it's blazingly
> >fast hardware acceleration, outperforms AES-CBC + HMAC-SHA in orders of
> >magnitude (at the crypto level).
>
> This might be interesting, and it also might be why my real world 
> testing doesn't match what we see at 
> https://community.openvpn.net/openvpn/wiki/Gigabit_Networks_Linux
> <https://community.openvpn.net/openvpn/wiki/Gigabit_Networks_Linux>
>
> It looks like this experiment was conducted on machines on a LAN with 
> virtually no latency / forwarding being done, so while it does show us 
> some theoretical numbers they don't seem to apply to the real-world 
> use-cases that we are hoping to get these types of performance figures 
> for.
>
> As soon as we start adding latency and jitter performance seems to 
> tank with these optimizations.
>
> So that I am not chasing phantoms, do we have any real-world examples 
> of the claim by janjust@...1147... <http://nikhef.nl> or are we just 
> going off of the Gigabit_Networks_Linux page? If we have real world 
> examples of configurations that can push more than 250Mbit (on a 1Gb 
> controller) or 2.5Gbit (on a 10Gb controller) over connections with 
> more than 10ms of latency then it would allow me to significantly 
> narrow my search for problem areas.
>

the experiment *was* conducted on a LAN with virtually no latency at 
that time. However, I've just repeated the experiment going from a 
university to my institute (~ 50 km distance) using a 1 Gbps connection. 
The results are nearly identical:

[  5] local 10.200.0.2 port 34072 connected with 10.200.0.1 port 5001
[  5]  0.0-10.0 sec   707 MBytes   592 Mbits/sec
[  4] local 10.200.0.2 port 5001 connected with 10.200.0.1 port 51086
[  4]  0.0-10.0 sec   874 MBytes   731 Mbits/sec

(where the LAN performance is ~ 910 Mbps).
Server:  Intel(R) Xeon(R) CPU E5-2643 0 @ 3.30GHz
Client:  Intel(R) Core(TM) i7-4810MQ CPU @ 2.80GHz

so as you see I am using 4+ year old hardware for this.

I am happy to work with you to figure out what is causing the 
performance to tank. I've got access to 1 & 10 Gbps (and possible 
higher) internet links and am very curious  what is causing the jitter 
on your end.

For higher latency links, the main option to tweak seems to be 
--txqueuelen : increase this to at least 1000 to improve performance.


Please contact me off-list if you want to work together on this.

HTH,

JJK / Jan Just Keijser

> On Sun, May 6, 2018 at 8:04 AM, Steffan Karger <steffan@...1856... 
> <mailto:steffan@...1856...>> wrote:
>
>     Hi,
>
>     On 04-05-18 17:45, Jan Just Keijser wrote:
>     > On 04/05/18 16:41, Derek Zimmer wrote:
>     >> What conclusions can we draw from this?
>     >>
>     > My main conclusion has always been that OpenVPN is limited by
>     the number
>     > of user-to-kernel space transitions , not by anything else.
>
>     Same here. I guess this interacts with other properties, like the
>     delay
>     OpenVPN itself adds.  And that is where AES-GCM, with it's blazingly
>     fast hardware acceleration, outperforms AES-CBC + HMAC-SHA in
>     orders of
>     magnitude (at the crypto level).
>
>     Some while ago, I looked a bit into this, and started at looking to
>     improve the user/kernel interfaces.  I posted a proof-of-concept patch
>     that might be interesting to check out if you're doing performance
>     testing:
>     https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg13699.html
>     <https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg13699.html>
>
>     I'd be very interested to know if using recvmmsg() improves the
>     performance in you measurements.  (I never got to picking this up
>     again,
>     because dayjob, bug reports and life in general got in the way...)
>
>     -Steffan
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


--------------20908DA062232652C26D52C4
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <div class="moz-cite-prefix">Hi,<br>
      <br>
      On 01/06/18 02:50, Derek Zimmer wrote:<br>
    </div>
    <blockquote type="cite"
cite="mid:CAJY0qZKw+HgQ1vS-W13nw2=gj8d-uxeOqyZia4-gEbaGNTyFLQ@...278...">
      <div dir="ltr">
        <div>
          <div>I'm still working on this, as I think it is worthwhile
            for us to explore and get some hard data on how all of these
            things perform in a real world environment.</div>
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
              virtually no latency / forwarding being done, so while it
              does show us some theoretical numbers they don't seem to
              apply to the real-world use-cases that we are hoping to
              get these types of performance figures for.<br>
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
              data-smartmail="gmail_signature">So that I am not chasing
              phantoms, do we have any real-world examples of the claim
              by janjust<wbr>@<a href="http://nikhef.nl"
                moz-do-not-send="true">nikhef.nl</a> or are we just
              going off of the Gigabit_Networks_Linux page? If we have
              real world examples of configurations that can push more
              than 250Mbit (on a 1Gb controller) or 2.5Gbit (on a 10Gb
              controller) over connections with more than 10ms of
              latency then it would allow me to significantly narrow my
              search for problem areas.<br>
            </div>
            <div class="gmail_signature"
              data-smartmail="gmail_signature"><br>
            </div>
          </div>
        </div>
      </div>
    </blockquote>
    <br>
    the experiment *was* conducted on a LAN with virtually no latency at
    that time. However, I've just repeated the experiment going from a
    university to my institute (~ 50 km distance) using a 1 Gbps
    connection. The results are nearly identical:<br>
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
    possible higher) internet links and am very curious  what is causing
    the jitter on your end.<br>
    <br>
    For higher latency links, the main option to tweak seems to be
    --txqueuelen : increase this to at least 1000 to improve
    performance.<br>
    <br>
    <br>
    Please contact me off-list if you want to work together on this.<br>
    <br>
    HTH,<br>
    <br>
    JJK / Jan Just Keijser<br>
    <br>
    <blockquote type="cite"
cite="mid:CAJY0qZKw+HgQ1vS-W13nw2=gj8d-uxeOqyZia4-gEbaGNTyFLQ@...278...">
      <div dir="ltr">
        <div class="gmail_extra">
          <div class="gmail_quote">On Sun, May 6, 2018 at 8:04 AM,
            Steffan Karger <span dir="ltr">&lt;<a
                href="mailto:steffan@...1856..." target="_blank"
                moz-do-not-send="true">steffan@...1856...</a>&gt;</span>
            wrote:<br>
            <blockquote class="gmail_quote" style="margin:0 0 0
              .8ex;border-left:1px #ccc solid;padding-left:1ex">Hi,<br>
              <span class=""><br>
                On 04-05-18 17:45, Jan Just Keijser wrote:<br>
                &gt; On 04/05/18 16:41, Derek Zimmer wrote:<br>
              </span><span class="">&gt;&gt; What conclusions can we
                draw from this?<br>
                &gt;&gt;<br>
                &gt; My main conclusion has always been that OpenVPN is
                limited by the number<br>
                &gt; of user-to-kernel space transitions , not by
                anything else.<br>
                <br>
              </span>Same here. I guess this interacts with other
              properties, like the delay<br>
              OpenVPN itself adds.  And that is where AES-GCM, with it's
              blazingly<br>
              fast hardware acceleration, outperforms AES-CBC + HMAC-SHA
              in orders of<br>
              magnitude (at the crypto level).<br>
              <br>
              Some while ago, I looked a bit into this, and started at
              looking to<br>
              improve the user/kernel interfaces.  I posted a
              proof-of-concept patch<br>
              that might be interesting to check out if you're doing
              performance testing:<br>
              <a
href="https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg13699.html"
                rel="noreferrer" target="_blank" moz-do-not-send="true">https://www.mail-archive.com/<wbr>openvpn-devel@...1199...<wbr>sourceforge.net/msg13699.html</a><br>
              <br>
              I'd be very interested to know if using recvmmsg()
              improves the<br>
              performance in you measurements.  (I never got to picking
              this up again,<br>
              because dayjob, bug reports and life in general got in the
              way...)<br>
              <span class="HOEnZb"><font color="#888888"><br>
                  -Steffan<br>
                </font></span>
              <div class="HOEnZb">
                <div class="h5"><br>
                  ------------------------------<wbr>------------------------------<wbr>------------------<br>
                  Check out the vibrant tech community on one of the
                  world's most<br>
                  engaging tech sites, Slashdot.org! <a
                    href="http://sdm.link/slashdot" rel="noreferrer"
                    target="_blank" moz-do-not-send="true">http://sdm.link/slashdot</a><br>
                  ______________________________<wbr>_________________<br>
                  Openvpn-devel mailing list<br>
                  <a href="mailto:Openvpn-devel@lists.sourceforge.net"
                    moz-do-not-send="true">Openvpn-devel@...1199...<wbr>sourceforge.net</a><br>
                  <a
                    href="https://lists.sourceforge.net/lists/listinfo/openvpn-devel"
                    rel="noreferrer" target="_blank"
                    moz-do-not-send="true">https://lists.sourceforge.net/<wbr>lists/listinfo/openvpn-devel</a><br>
                </div>
              </div>
            </blockquote>
          </div>
          <br>
        </div>
      </div>
      <!--'"--><br>
      <fieldset class="mimeAttachmentHeader"></fieldset>
      <br>
      <pre wrap="">------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! <a class="moz-txt-link-freetext" href="http://sdm.link/slashdot">http://sdm.link/slashdot</a></pre>
      <!--'"--><br>
      <fieldset class="mimeAttachmentHeader"></fieldset>
      <br>
      <pre wrap="">_______________________________________________
Openvpn-devel mailing list
<a class="moz-txt-link-abbreviated" href="mailto:Openvpn-devel@lists.sourceforge.net">Openvpn-devel@lists.sourceforge.net</a>
<a class="moz-txt-link-freetext" href="https://lists.sourceforge.net/lists/listinfo/openvpn-devel">https://lists.sourceforge.net/lists/listinfo/openvpn-devel</a>
</pre>
    </blockquote>
    <br>
  </body>
</html>

--------------20908DA062232652C26D52C4--

