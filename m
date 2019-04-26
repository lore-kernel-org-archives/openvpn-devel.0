References: <CAEYw=WoZDJap1cwCh-SAqJr8KiQEv80XmBkVbVijTbCbOCOP0g@...278...>
 <CAEYw=Wqna4PnOf+ZQV2sqkrQ6sLdCUQgwxRnrFBVuRx60uAbZA@...278...>
From: Jan Just Keijser <janjust@...1147...>
Message-ID: <bbf01b87-32bf-f234-cd95-6b5738ad463b@...1147...>
Date: Fri, 26 Apr 2019 15:57:21 +0200
MIME-Version: 1.0
In-Reply-To: <CAEYw=Wqna4PnOf+ZQV2sqkrQ6sLdCUQgwxRnrFBVuRx60uAbZA@...278...>
Content-Type: multipart/alternative;
 boundary="------------11DCD76661250BB8D1F0C7AD"
Content-Language: nl-NL
Subject: Re: [Openvpn-devel] Client reconnect issues
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Pieter Hulshoff <pieter.hulshoff@...2499...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>, Openvpn-users@lists.sourceforge.net, Gert Doering <gert@...1296...>

This is a multi-part message in MIME format.
--------------11DCD76661250BB8D1F0C7AD
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit

Hi Pieter,

On 26/04/19 15:32, Pieter Hulshoff wrote:
> Gert,
>
> Op vr 19 apr. 2019 om 13:38 schreef Pieter Hulshoff 
> <pieter.hulshoff@...2499... 
> <mailto:pieter.hulshoff@...2499...>>:
>
>     I've been looking at
>     https://community.openvpn.net/openvpn/ticket/880 for a while now,
>     and was wondering if there'd been any answers to this problem yet.
>     It appears that mbedtls (according to krzee the problem
>     disappeared when using OpenSSL, but since I use OpenVPN-NL that's
>     not an option for me) refuses to answer a PUSH request for a
>     connection it considers to already exist. As a result, a reconnect
>     (e.g. after a client reboot) will stall until the reconnect timer
>     exceeds the server's time-out, after which the server closes the
>     connection, and accepts the following reconnect attempt. Reconnect
>     from a 2.3.9 client is stalled indefinitely, since the re-connect
>     seems fixed at 2 seconds.
>
>     Using nobind will also solve the issue, since the server will see
>     it as a new connection, but I'm not sure nobind is a proper
>     solution for everyone.
>
>     Any thoughts on this matter? Is it true that this only happens
>     with mbedtls, and as such should this issue be taken up with that
>     community in stead of this one? Any idea on why the server would
>     refuse a PUSH request for an already existing connection?
>
>
> You were looking into this matter in 2017. Did you ever figure out 
> what the cause of this issue was, and if so how it could be remedied?
>
>
I'd look into the way session tickets are configured and used in 
mbedtls, e.g. read up on
https://tls.mbed.org/discussions/generic/what-is-the-correct-way-to-use-session-tickets

For OpenSSL, OpenVPN uses SSL_OP_NO_TICKET, i.e. no session tickets are 
allowed. I don't know the mbedtls code base well enough, but as a start, 
I'd make sure that mbedtls is also configured to NOT accept session tickets.

An easy way to test my hypothesis would be to
- allow session tickets in the OpenSSL version (i.e. modify one line in 
ssl_opensls.c)
- build OpenVPN using OpenSSL
- use this patched OpenVPN binary to connect to your (mbedtls) server to 
see if the problem now also occurs with an openssl-linked version of OpenVPN
If so, then you know it's a session ticket issue. If not, then you can 
(most likely) rule out session tickets as the root cause of the problem.

HTH,

JJK


--------------11DCD76661250BB8D1F0C7AD
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <div class="moz-cite-prefix">Hi Pieter,<br>
      <br>
      On 26/04/19 15:32, Pieter Hulshoff wrote:<br>
    </div>
    <blockquote type="cite"
cite="mid:CAEYw=Wqna4PnOf+ZQV2sqkrQ6sLdCUQgwxRnrFBVuRx60uAbZA@...278...">
      <meta http-equiv="content-type" content="text/html; charset=utf-8">
      <div dir="ltr">
        <div dir="ltr">
          <div class="gmail_default"
            style="font-family:arial,helvetica,sans-serif">Gert,</div>
          <div class="gmail_default"
            style="font-family:arial,helvetica,sans-serif"><br>
          </div>
          <div class="gmail_default"
            style="font-family:arial,helvetica,sans-serif"><span
              style="font-family:Arial,Helvetica,sans-serif">Op vr 19
              apr. 2019 om 13:38 schreef Pieter Hulshoff &lt;<a
                href="mailto:pieter.hulshoff@...2499..."
                moz-do-not-send="true">pieter.hulshoff@...2499...</a>&gt;:</span><br>
          </div>
        </div>
        <div class="gmail_quote">
          <blockquote class="gmail_quote" style="margin:0px 0px 0px
            0.8ex;border-left:1px solid
            rgb(204,204,204);padding-left:1ex">
            <div dir="ltr">
              <div style="font-family:arial,helvetica,sans-serif">I've
                been looking at <a
                  href="https://community.openvpn.net/openvpn/ticket/880"
                  target="_blank"
                  style="font-family:Arial,Helvetica,sans-serif"
                  moz-do-not-send="true">https://community.openvpn.net/openvpn/ticket/880</a> for
                a while now, and was wondering if there'd been any
                answers to this problem yet. It appears that mbedtls
                (according to krzee the problem disappeared when using
                OpenSSL, but since I use OpenVPN-NL that's not an option
                for me) refuses to answer a PUSH request for a
                connection it considers to already exist. As a result, a
                reconnect (e.g. after a client reboot) will stall until
                the reconnect timer exceeds the server's time-out, after
                which the server closes the connection, and accepts the
                following reconnect attempt. Reconnect from a 2.3.9
                client is stalled indefinitely, since the re-connect
                seems fixed at 2 seconds.<br>
              </div>
              <div style="font-family:arial,helvetica,sans-serif"><br>
              </div>
              <div style="font-family:arial,helvetica,sans-serif">Using
                nobind will also solve the issue, since the server will
                see it as a new connection, but I'm not sure nobind is a
                proper solution for everyone.</div>
              <div style="font-family:arial,helvetica,sans-serif"><br>
              </div>
              <div style="font-family:arial,helvetica,sans-serif">Any
                thoughts on this matter? Is it true that this only
                happens with mbedtls, and as such should this issue be
                taken up with that community in stead of this one? Any
                idea on why the server would refuse a PUSH request for
                an already existing connection?</div>
            </div>
          </blockquote>
          <div><br>
          </div>
          <div class="gmail_default"
            style="font-family:arial,helvetica,sans-serif">You were
            looking into this matter in 2017. Did you ever figure out
            what the cause of this issue was, and if so how it could be
            remedied?</div>
          <div class="gmail_default"
            style="font-family:arial,helvetica,sans-serif"><br>
          </div>
          <br>
        </div>
      </div>
    </blockquote>
    I'd look into the way session tickets are configured and used in
    mbedtls, e.g. read up on<br>
     
<a class="moz-txt-link-freetext" href="https://tls.mbed.org/discussions/generic/what-is-the-correct-way-to-use-session-tickets">https://tls.mbed.org/discussions/generic/what-is-the-correct-way-to-use-session-tickets</a><br>
    <br>
    For OpenSSL, OpenVPN uses SSL_OP_NO_TICKET, i.e. no session tickets
    are allowed. I don't know the mbedtls code base well enough, but as
    a start, I'd make sure that mbedtls is also configured to NOT accept
    session tickets.<br>
    <br>
    An easy way to test my hypothesis would be to<br>
    - allow session tickets in the OpenSSL version (i.e. modify one line
    in ssl_opensls.c)<br>
    - build OpenVPN using OpenSSL<br>
    - use this patched OpenVPN binary to connect to your (mbedtls)
    server to see if the problem now also occurs with an openssl-linked
    version of OpenVPN<br>
    If so, then you know it's a session ticket issue. If not, then you
    can (most likely) rule out session tickets as the root cause of the
    problem.<br>
    <br>
    HTH,<br>
    <br>
    JJK<br>
    <br>
  </body>
</html>

--------------11DCD76661250BB8D1F0C7AD--

