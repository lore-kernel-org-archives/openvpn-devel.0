Message-ID: <50851A9A.5090902@...1227...>
Date: Mon, 22 Oct 2012 12:06:18 +0200
From: Arne Schwabe <arne@...1227...>
MIME-Version: 1.0
References: <CAEsd45Q6PbNZoutzKMXVP7xPSEmb0C3A3jQEQYidcTRGJaXTmQ@...278...>
In-Reply-To: <CAEsd45Q6PbNZoutzKMXVP7xPSEmb0C3A3jQEQYidcTRGJaXTmQ@...278...>
Content-Type: multipart/alternative;
	boundary="------------020000050701030105050409"
Subject: Re: [Openvpn-devel] Bug in program, bug in documentation,
 or something else?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "Jonathan K. Bullard" <jkbullard@...277...>
Cc: openvpn-devel@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------020000050701030105050409
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Am 22.10.12 00:40, schrieb Jonathan K. Bullard:
> A Tunnelblick user has reported odd behavior with name resolution
> failures. I can't tell if it is a bug in OpenVPN, a bug in the
> documentation, or something else. The behavior is apparently the same
> in OpenVPN 2.2.1 and 2.3alpha1.
>
> The 2.3 man page says:
>
>     --resolv-retry n
>          If hostname resolve fails for --remote, retry resolve for n
>     seconds before failing.
>          Set n to "infinite" to retry indefinitely.
>          By default, --resolv-retry infinite is enabled.  You can
>     disable by setting n=0.
>
>
> But the behavior seems very different:
>
> If a name resolution failure (caused, for example, by losing the
> network connection) occurs
> and --resolv-retry is:
>
>     1, the first resolution failure terminates the connection;
>     5, resolution attempts are made dozens of times per second,
>     seemingly forever; or
>     10, resolution attempts are made every five seconds, seemingly
>     forever.
>
>
> Any ideas if this is a program bug, a documentation bug, or something
> else, for example, a problem that only occurs on OS X?
I guess a programming bug.

The number of retries for a resolv is defined as (fail_wait_interval is
fixed to 5):
      int resolve_retries = (flags & GETADDR_TRY_ONCE) ? 1 :
(resolve_retry_seconds / fail_wait_interval);

so if resolv-retry < 5 resolve_retries is set to 0 giving you a direct
failure. Without trying you should then see a USR1 and openvpn will
directly do the next connection attempt without waiting the 5s delay.

On a quick glance I cannot see a way to tell openvpn to have a fixed
number of connection retries after it quits.

Arne

--------------020000050701030105050409
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<html>
  <head>
    <meta content="text/html; charset=ISO-8859-1"
      http-equiv="Content-Type">
  </head>
  <body bgcolor="#FFFFFF" text="#000000">
    <div class="moz-cite-prefix">Am 22.10.12 00:40, schrieb Jonathan K.
      Bullard:<br>
    </div>
    <blockquote
cite="mid:CAEsd45Q6PbNZoutzKMXVP7xPSEmb0C3A3jQEQYidcTRGJaXTmQ@...278..."
      type="cite">A Tunnelblick user has reported odd behavior with name
      resolution failures. I can't tell if it is a bug in OpenVPN, a bug
      in the documentation, or something else. The behavior is
      apparently the same in OpenVPN 2.2.1 and 2.3alpha1.
      <div> <br>
      </div>
      <div>The 2.3 man page says:</div>
      <div>
        <blockquote class="gmail_quote" style="margin:0px 0px 0px
0.8ex;border-left-width:1px;border-left-color:rgb(204,204,204);border-left-style:solid;padding-left:1ex">--resolv-retry

          n<br>
          &nbsp; &nbsp; &nbsp;If hostname resolve fails for --remote, retry resolve for
          n seconds before failing.<br>
          &nbsp; &nbsp; &nbsp;Set n to "infinite" to retry indefinitely.<br>
          &nbsp; &nbsp; &nbsp;By default, --resolv-retry infinite is enabled. &nbsp;You can
          disable by setting n=0.</blockquote>
      </div>
      <div><br>
      </div>
      <div>But the behavior seems very different:</div>
      <div><br>
      </div>
      <div>If a name resolution failure (caused, for example, by losing
        the network connection) occurs</div>
      <div>and --resolv-retry is:</div>
      <div>
        <blockquote style="margin:0px 0px 0px
          40px;border:none;padding:0px">1, the first resolution failure
          terminates the connection;<br>
          5, resolution attempts are made dozens of times per second,
          seemingly forever; or<br>
          10, resolution attempts are made every five seconds, seemingly
          forever.<br>
        </blockquote>
        <div><br>
        </div>
        <div>Any ideas if this is a program bug, a documentation bug, or
          something else, for example, a problem that only occurs on OS
          X?</div>
      </div>
    </blockquote>
    I guess a programming bug.<br>
    <br>
    The number of retries for a resolv is defined as (fail_wait_interval
    is fixed to 5):<br>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int resolve_retries = (flags &amp; GETADDR_TRY_ONCE) ? 1 :
    (resolve_retry_seconds / fail_wait_interval);<br>
    <br>
    so if resolv-retry &lt; 5 resolve_retries is set to 0 giving you a
    direct failure. Without trying you should then see a USR1 and
    openvpn will directly do the next connection attempt without waiting
    the 5s delay.<br>
    <br>
    On a quick glance I cannot see a way to tell openvpn to have a fixed
    number of connection retries after it quits.<br>
    <br>
    Arne<br>
  </body>
</html>

--------------020000050701030105050409--

