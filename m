Content-Type: multipart/alternative;
 boundary="------------TD0noim470D0MRGWVVjfjSIA"
Message-ID: <a627816d-7d9d-4582-8010-06cf5596c957@...2751...>
Date: Wed, 24 Apr 2024 14:01:52 +0200
MIME-Version: 1.0
From: Johan Draaisma <johan@...2751...>
Content-Language: en-US
Subject: [Openvpn-devel]  IRC community meeting summary
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------TD0noim470D0MRGWVVjfjSIA
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit

Meeting summary for 24 April 2024:

  * *New, closed: OpenSSL 1.0.2 removal from OpenVPN 2.7*
    /Currently plaisthos is still supporting OpenSSL 1.0.2 because of
    Access Server still releasing on CentOS7/Red Hat7./
    /Since we are dropping those platforms on Access Server, there
    appears to be no reason to keep supporting it./
    /There were no objections to removing openssl 1.0.2 support from
    OpenVPN 2.7/

  * *New: Discussion related to DNS IV flag*
    /The implementation of the dns option deviates somewhat from the
    original specification./
    /d12fk wants to discuss a possible solution using another IV flag./
    /A flag such as IV_PROTO_DNS_OPTION_V2 would be acceptable, as of
    OpenVPN 2.6.11./
    /IV_PROTO_DNS_OPTION could be renamed to IV_PROTO_DNS_OPTION_OLD and
    marked as 'do not send'./

  * *Updated: forums topics*
    /ecrist still working on forums. waiting on ecrist to move things
    around./
    /ecrist requests that cloudflare be removed again. that's not really
    something that we want to do as we lose a lot of protection./
    /rob0 and novaflash would like to assist in solving this problem.
    they would need root access to the VM. perhaps djpig can arrange this?/
    /Plan is to soon switch URLs so new forum is on forums.openvpn.net
    and old forums is on archive address./
    /- email confirmation on registration was suggested./
    /- mod permissions, guide, hard or soft delete (chuck board?), what
    to do with GDPR, etc. (write it down and actually make it available
    to mods, maybe a hidden topic)/
    /- access for mods to logs so one can see what others did/

  * *Updated: mattock topics*
    /PR created for the --dev null test suite. Fixed some issues based
    on feedback in #openvpn-devel./
    /Documentation
    here:​https://github.com/mattock/openvpn/blob/dev_null/doc/dev-null-test-suite.rst
    <https://github.com/mattock/openvpn/blob/dev_null/doc/dev-null-test-suite.rst>/

As always you're welcome to join at #openvpn-meeting on Libera IRC 
network every Wednesday at 13:00 Central European Time.

Kind regards,
Johan Draaisma

--------------TD0noim470D0MRGWVVjfjSIA
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: 8bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p> Meeting summary for 24 April 2024:</p>
    <ul
style="color: rgb(0, 0, 0); font-family: Verdana, Arial, &quot;Bitstream Vera Sans&quot;, Helvetica, sans-serif; font-size: 13px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">
      <li><strong>New, closed: OpenSSL 1.0.2 removal from OpenVPN 2.7</strong><br>
        <em>Currently plaisthos is still supporting OpenSSL 1.0.2
          because of Access Server still releasing on CentOS7/Red Hat7.</em><br>
        <em>Since we are dropping those platforms on Access Server,
          there appears to be no reason to keep supporting it.</em><br>
        <em>There were no objections to removing openssl 1.0.2 support
          from OpenVPN 2.7</em></li>
    </ul>
    <ul
style="color: rgb(0, 0, 0); font-family: Verdana, Arial, &quot;Bitstream Vera Sans&quot;, Helvetica, sans-serif; font-size: 13px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">
      <li><strong>New: Discussion related to DNS IV flag</strong><br>
        <em>The implementation of the dns option deviates somewhat from
          the original specification.</em><br>
        <em>d12fk wants to discuss a possible solution using another IV
          flag.</em><br>
        <em>A flag such as IV_PROTO_DNS_OPTION_V2 would be acceptable,
          as of OpenVPN 2.6.11.</em><br>
        <em>IV_PROTO_DNS_OPTION could be renamed to
          IV_PROTO_DNS_OPTION_OLD and marked as 'do not send'.</em></li>
    </ul>
    <ul
style="color: rgb(0, 0, 0); font-family: Verdana, Arial, &quot;Bitstream Vera Sans&quot;, Helvetica, sans-serif; font-size: 13px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">
      <li><strong>Updated: forums topics</strong><br>
        <em>ecrist still working on forums. waiting on ecrist to move
          things around.</em><br>
        <em>ecrist requests that cloudflare be removed again. that's not
          really something that we want to do as we lose a lot of
          protection.</em><br>
        <em>rob0 and novaflash would like to assist in solving this
          problem. they would need root access to the VM. perhaps djpig
          can arrange this?</em><br>
        <em>Plan is to soon switch URLs so new forum is on
          forums.openvpn.net and old forums is on archive address.</em><br>
        <em>- email confirmation on registration was suggested.</em><br>
        <em>- mod permissions, guide, hard or soft delete (chuck
          board?), what to do with GDPR, etc. (write it down and
          actually make it available to mods, maybe a hidden topic)</em><br>
        <em>- access for mods to logs so one can see what others did</em></li>
    </ul>
    <ul
style="color: rgb(0, 0, 0); font-family: Verdana, Arial, &quot;Bitstream Vera Sans&quot;, Helvetica, sans-serif; font-size: 13px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">
      <li><strong>Updated: mattock topics</strong><br>
        <em>PR created for the --dev null test suite. Fixed some issues
          based on feedback in #openvpn-devel.</em><br>
        <em>Documentation here:<span> </span><a class="ext-link"
href="https://github.com/mattock/openvpn/blob/dev_null/doc/dev-null-test-suite.rst"
style="text-decoration: none; color: rgb(187, 0, 0); border-bottom: 1px dotted rgb(187, 187, 187);"><span
              class="icon"
style="background: url(&quot;../extlink.gif&quot;) left center no-repeat; padding-left: 15px;">​</span>https://github.com/mattock/openvpn/blob/dev_null/doc/dev-null-test-suite.rst</a></em></li>
    </ul>
    <p>As always you're welcome to join at #openvpn-meeting on Libera
      IRC network every Wednesday at 13:00 Central European Time.</p>
    <p>Kind regards,<br>
      Johan Draaisma<br>
    </p>
  </body>
</html>

--------------TD0noim470D0MRGWVVjfjSIA--

