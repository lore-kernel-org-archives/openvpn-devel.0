Content-Type: multipart/alternative;
 boundary="------------3BfApqjy1UhrSH0j0oUfy5xd"
Message-ID: <8647cbdd-2b81-43d8-860c-bfc28039646e@...1227...>
Date: Sat, 16 Nov 2024 20:38:21 +0100
MIME-Version: 1.0
References: <CAC8x_z0gMKW1b33J3HGL-9pQnXgpf9O6pRu+M2=xP03JyJMm6g@...278...>
 <ZzZvEOjQ4PQ3gF-2@...1296...>
 <CAC8x_z3reFPQWPNuoB-GjqkQtEgcgGapHWKUVt=OXvMoW6NCFg@...278...>
 <7df02e11-336f-4738-8221-65d1dcde0659@...515...>
 <CAC8x_z1gynaP2NHBr8HF0asnZs_ZUmGQSaFxsnbdjCuukhrS0Q@...278...>
 <197129c7-73dd-470e-9a94-7abd1b8ae19a@...1227...>
 <CAC8x_z3CdbCPnpUis7URYbQohjBy4i0z1DD75qSWPdjbWuy3XA@...278...>
From: Arne Schwabe <arne@...1227...>
In-Reply-To: <CAC8x_z3CdbCPnpUis7URYbQohjBy4i0z1DD75qSWPdjbWuy3XA@...278...>
Subject: Re: [Openvpn-devel] Subject: OpenVPN Client Vulnerability - TLS Key
 Negotiation Timeout Leading to DoS (Black Box Pentest)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: =?UTF-8?B?16DXqteZINep15jXqNef?= <nsh531@...277...>, Openvpn-devel@lists.sourceforge.net
Cc: Antonio Quartulli <antonio@...515...>, SECURITY@...515...

This is a multi-part message in MIME format.
--------------3BfApqjy1UhrSH0j0oUfy5xd
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit


Am 16.11.2024 um 17:22 schrieb נתי שטרן:
> Hi,
> it's same on 2.6 version:
>
> Subject: Possible DoS Vulnerability - OpenVPN Server Showing Repeated 
> TLS Handshake Failures
>
> Dear OpenVPN Security Team,
>
> I am writing to report a potential vulnerability to Denial-of-Service 
> (DoS) attacks that I have observed in an OpenVPN server's logs. The 
> server is exhibiting consistent TLS handshake failures, resulting in 
> repeated process restarts. While the exact cause isn't immediately 
> apparent, the symptoms strongly suggest a vulnerability to an attack 
> vector that overwhelms the server with unsuccessful connection attempts.
>
This is too vague to on.
>
> The logs demonstrate repeated errors of the form: "TLS key negotiation 
> failed to occur within 5 seconds (check your network connectivity)" 
> and "TLS handshake failed," followed by automatic server restarts. The 
> server appears to be attempting to mitigate by increasing the restart 
> delay with each failure, but this is only a temporary workaround, and 
> the underlying issue persists.
>
Are they really server restarts are did you got confused by the logging 
message and the internal message and naming of signals that looks 
similar to a server restart? Also if you are claiming something like 
this, please have the log lines in your mail and not only your 
interpretation of them.

> The observed behavior is highly suggestive of a DoS attack, where an 
> attacker is attempting to exhaust server resources by triggering 
> multiple failed TLS handshakes. This, along with the server 
> automatically restarting in response, suggests a DoS mitigation 
> procedure is in place that can only temporarily avoid service outages.
>
The earlier mails you sent to security@...515... mentioned a OpenVPN 
2.4.x version, which is vulnerable to a similar attack. But this has 
been fixed and new versions feature a handshake cookie mechansim. See 
the https://github.com/OpenVPN/openvpn/blob/master/Changes.rst and the 
section "Cookie based handshake for UDP server".

> While I do not have direct access to the server configuration or the 
> full scope of logs, I believe the behavior described poses a 
> significant security risk. I have attached the partial log file 
> demonstrating the repeated errors.
>
Without full scope of logs or server configuration, this is again very 
circumstancial and vague.

> I would greatly appreciate it if you could investigate this potential 
> vulnerability and provide any guidance or recommendations for 
> strengthening the server's resilience against this type of attack. If 
> further information is needed, please do not hesitate to ask.
>
You have not given anything that looks like a vulnerability and I 
currently I dispute that you found a vulnerability. You have been given 
already advise that you need to test/upgrade the OpenVPN version to 
2.6.x instead of 2.4.x. Repeating your statements without providing the 
details and extra information we asked from you does not make them more 
true or gives us an extra incentive to look into them. In the opposite, 
you will more annoy the developers and maintains like me and this is 
also why this mail is already being written in a less friendly tone. The 
statement that you would provide more infomration when asked but not did 
not provide any of the extra information we asked that sentence and 
promise sound extra hallow.

Arne

--------------3BfApqjy1UhrSH0j0oUfy5xd
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: 8bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">Am 16.11.2024 um 17:22 schrieb נתי
      שטרן:<br>
    </div>
    <blockquote type="cite"
cite="mid:CAC8x_z3CdbCPnpUis7URYbQohjBy4i0z1DD75qSWPdjbWuy3XA@...278...">
      <meta http-equiv="content-type" content="text/html; charset=UTF-8">
      <div dir="rtl">
        <div dir="ltr">Hi,</div>
        <div dir="ltr">it's same on 2.6 version:</div>
        <div dir="ltr"><span
class="gmail-router-outlet-wrapper gmail-ng-tns-c3206557060-0">
            <p class="gmail-ng-star-inserted"><span><span
                  class="gmail-ng-star-inserted">Subject: Possible DoS
                  Vulnerability - OpenVPN Server Showing Repeated TLS
                  Handshake Failures</span></span></p>
            <p class="gmail-ng-star-inserted"><span><span
                  class="gmail-ng-star-inserted">Dear OpenVPN Security
                  Team,</span></span></p>
            <p class="gmail-ng-star-inserted"><span><span
                  class="gmail-ng-star-inserted">I am writing to report
                  a potential vulnerability to Denial-of-Service (DoS)
                  attacks that I have observed in an OpenVPN server's
                  logs. The server is exhibiting consistent TLS
                  handshake failures, resulting in repeated process
                  restarts. While the exact cause isn't immediately
                  apparent, the symptoms strongly suggest a
                  vulnerability to an attack vector that overwhelms the
                  server with unsuccessful connection attempts.</span></span></p>
          </span></div>
      </div>
    </blockquote>
    This is too vague to on.<br>
    <blockquote type="cite"
cite="mid:CAC8x_z3CdbCPnpUis7URYbQohjBy4i0z1DD75qSWPdjbWuy3XA@...278...">
      <div dir="rtl">
        <div dir="ltr"><span
class="gmail-router-outlet-wrapper gmail-ng-tns-c3206557060-0">
            <p class="gmail-ng-star-inserted"><span><span
                  class="gmail-ng-star-inserted">The logs demonstrate
                  repeated errors of the form: "TLS key negotiation
                  failed to occur within 5 seconds (check your network
                  connectivity)" and "TLS handshake failed," followed by
                  automatic server restarts. The server appears to be
                  attempting to mitigate by increasing the restart delay
                  with each failure, but this is only a temporary
                  workaround, and the underlying issue persists.</span></span></p>
          </span></div>
      </div>
    </blockquote>
    <p>Are they really server restarts are did you got confused by the
      logging message and the internal message and naming of signals
      that looks similar to a server restart? Also if you are claiming
      something like this, please have the log lines in your mail and
      not only your interpretation of them.</p>
    <blockquote type="cite"
cite="mid:CAC8x_z3CdbCPnpUis7URYbQohjBy4i0z1DD75qSWPdjbWuy3XA@...278...">
      <div dir="rtl">
        <div dir="ltr"><span
class="gmail-router-outlet-wrapper gmail-ng-tns-c3206557060-0">
            <p class="gmail-ng-star-inserted"><span><span
                  class="gmail-ng-star-inserted">The observed behavior
                  is highly suggestive of a DoS attack, where an
                  attacker is attempting to exhaust server resources by
                  triggering multiple failed TLS handshakes. This, along
                  with the server automatically restarting in response,
                  suggests a DoS mitigation procedure is in place that
                  can only temporarily avoid service outages.</span></span></p>
          </span></div>
      </div>
    </blockquote>
    The earlier mails you sent to <a class="moz-txt-link-abbreviated" href="mailto:security@...515...">security@...515...</a> mentioned a
    OpenVPN 2.4.x version, which is vulnerable to a similar attack. But
    this has been fixed and new versions feature a handshake cookie
    mechansim. See the
    <a class="moz-txt-link-freetext" href="https://github.com/OpenVPN/openvpn/blob/master/Changes.rst">https://github.com/OpenVPN/openvpn/blob/master/Changes.rst</a> and the
    section "Cookie based handshake for UDP server".<dd
style="box-sizing: border-box; margin-left: 0px; padding: 0 var(--base-size-16); margin-bottom: var(--base-size-16); color: rgb(31, 35, 40); font-family: -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, &quot;Noto Sans&quot;, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;; font-size: 16px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;"><br
        class="Apple-interchange-newline">
    </dd>
    <blockquote type="cite"
cite="mid:CAC8x_z3CdbCPnpUis7URYbQohjBy4i0z1DD75qSWPdjbWuy3XA@...278...">
      <div dir="rtl">
        <div dir="ltr"><span
class="gmail-router-outlet-wrapper gmail-ng-tns-c3206557060-0">
            <p class="gmail-ng-star-inserted"><span><span
                  class="gmail-ng-star-inserted">While I do not have
                  direct access to the server configuration or the full
                  scope of logs, I believe the behavior described poses
                  a significant security risk. I have attached the
                  partial log file demonstrating the repeated errors.</span></span></p>
          </span></div>
      </div>
    </blockquote>
    <p>Without full scope of logs or server configuration, this is again
      very circumstancial and vague.<br>
    </p>
    <blockquote type="cite"
cite="mid:CAC8x_z3CdbCPnpUis7URYbQohjBy4i0z1DD75qSWPdjbWuy3XA@...278...">
      <div dir="rtl">
        <div dir="ltr"><span
class="gmail-router-outlet-wrapper gmail-ng-tns-c3206557060-0">
            <p class="gmail-ng-star-inserted"><span><span
                  class="gmail-ng-star-inserted">I would greatly
                  appreciate it if you could investigate this potential
                  vulnerability and provide any guidance or
                  recommendations for strengthening the server's
                  resilience against this type of attack. If further
                  information is needed, please do not hesitate to ask.</span></span></p>
          </span></div>
      </div>
    </blockquote>
    <p>You have not given anything that looks like a vulnerability and I
      currently I dispute that you found a vulnerability. You have been
      given already advise that you need to test/upgrade the OpenVPN
      version to 2.6.x instead of 2.4.x. Repeating your statements
      without providing the details and extra information we asked from
      you does not make them more true or gives us an extra incentive to
      look into them. In the opposite, you will more annoy the
      developers and maintains like me and this is also why this mail is
      already being written in a less friendly tone. The statement that
      you would provide more infomration when asked but not did not
      provide any of the extra information we asked that sentence and
      promise sound extra hallow.<br>
    </p>
    <p>Arne<br>
    </p>
  </body>
</html>

--------------3BfApqjy1UhrSH0j0oUfy5xd--

