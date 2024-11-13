Content-Type: multipart/alternative;
 boundary="------------62NNL124Fa7gXl7Ze7D0vOD5"
Message-ID: <080fc091-b7d7-4821-98cc-ffe0df188c84@...277...>
Date: Wed, 13 Nov 2024 14:51:02 +0100
MIME-Version: 1.0
From: Johan Draaisma <johandraaisma@...277...>
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
--------------62NNL124Fa7gXl7Ze7D0vOD5
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit

Meeting summary for 13 November 2024:

  * *Updated: DCO Linux upstreaming*
    /Upstreaming DCO to Linux is proceeding, it is in review stage at
    the moment./
    /ordex will send out*patchset v12*later this week./

  * *Updated: DCO windows multi-peer*
    /Kernelspace and userspace now look to be working./
    /Ran gremlin tests for 30 minutes with up to 1000 connections and it
    all worked as it should./
    /Will prepare to send in patches for review./

  * *Updated: multi-socket patch series*
    /This has been rebased and comments addressed - now in review./
    /Two minor refactoring patches handled. Continuing work on this./

  * *Updated: data format v3 / epoch data keys*
    /RFC is here:​https://github.com/OpenVPN/openvpn-rfc/pull/5
    <https://github.com/OpenVPN/openvpn-rfc/pull/5>./
    /plaisthos is working to implement it in openvpn3 first./
    /MaxF will review the RFC. And comments/questions he will pass to
    plaisthos so he can handle updating the RFC if needed./

  * *Updated: push_update / live route updates*
    /There have been some initial tests on a server implementation in PG./
    /There is a server-side bug that will be fixed in PG, and a request
    to support a few more options (keepalive options)./
    /levwill add keepalive to OpenVPN3 code./
    /mrbff and ordex will implement the openvpn2 server and client
    support for push_update./

  * *Updated: TLS-exporter in mbedtls*
    /Needed for TLS 1.3 support with openvpn and mbedtls - TLS-exporter
    currently missing in mbedtls./
    /maxf reports he's making some progress on implementing this -
    currently working to ensure all unit tests in all million billions
    of configurations work./

  * *Updated: --dns patch review upcoming*
    /d12fk patches are being made ready for gerrit review now./

As always you're welcome to join at #openvpn-meeting on Libera IRC 
network every Wednesday at 14:00 Central European Time.

Kind regards,
Johan Draaisma

--------------62NNL124Fa7gXl7Ze7D0vOD5
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: 8bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p> Meeting summary for 13 November 2024:</p>
    <ul
style="color: rgb(0, 0, 0); font-family: Verdana, Arial, &quot;Bitstream Vera Sans&quot;, Helvetica, sans-serif; font-size: 13px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">
      <li><strong>Updated: DCO Linux upstreaming</strong><br>
        <em>Upstreaming DCO to Linux is proceeding, it is in review
          stage at the moment.</em><br>
        <em>ordex will send out<span> </span><strong>patchset v12</strong><span> </span>later
          this week.</em></li>
    </ul>
    <ul
style="color: rgb(0, 0, 0); font-family: Verdana, Arial, &quot;Bitstream Vera Sans&quot;, Helvetica, sans-serif; font-size: 13px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">
      <li><strong>Updated: DCO windows multi-peer</strong><br>
        <em>Kernelspace and userspace now look to be working.</em><br>
        <em>Ran gremlin tests for 30 minutes with up to 1000 connections
          and it all worked as it should.</em><br>
        <em>Will prepare to send in patches for review.</em></li>
    </ul>
    <ul
style="color: rgb(0, 0, 0); font-family: Verdana, Arial, &quot;Bitstream Vera Sans&quot;, Helvetica, sans-serif; font-size: 13px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">
      <li><strong>Updated: multi-socket patch series</strong><br>
        <em>This has been rebased and comments addressed - now in
          review.</em><br>
        <em>Two minor refactoring patches handled. Continuing work on
          this.</em></li>
    </ul>
    <ul
style="color: rgb(0, 0, 0); font-family: Verdana, Arial, &quot;Bitstream Vera Sans&quot;, Helvetica, sans-serif; font-size: 13px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">
      <li><strong>Updated: data format v3 / epoch data keys</strong><br>
        <em>RFC is here:<span> </span><a class="ext-link"
            href="https://github.com/OpenVPN/openvpn-rfc/pull/5"
style="text-decoration: none; color: rgb(187, 0, 0); border-bottom: 1px dotted rgb(187, 187, 187);"
            moz-do-not-send="true"><span class="icon"
style="background: url(&quot;../extlink.gif&quot;) left center no-repeat; padding-left: 15px;">​</span>https://github.com/OpenVPN/openvpn-rfc/pull/5</a>.</em><br>
        <em>plaisthos is working to implement it in openvpn3 first.</em><br>
        <em>MaxF will review the RFC. And comments/questions he will
          pass to plaisthos so he can handle updating the RFC if needed.</em></li>
    </ul>
    <ul
style="color: rgb(0, 0, 0); font-family: Verdana, Arial, &quot;Bitstream Vera Sans&quot;, Helvetica, sans-serif; font-size: 13px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">
      <li><strong>Updated: push_update / live route updates</strong><br>
        <em>There have been some initial tests on a server
          implementation in PG.</em><br>
        <em>There is a server-side bug that will be fixed in PG, and a
          request to support a few more options (keepalive options).</em><br>
        <em>lev<span class="underline"
            style="text-decoration: underline;"><span> </span>will add
            keepalive to OpenVPN3 code.</span></em><span
          class="underline" style="text-decoration: underline;"><br>
          <em>mrbff and ordex will implement the openvpn2 server and
            client support for push_update.</em></span></li>
    </ul>
    <ul
style="color: rgb(0, 0, 0); font-family: Verdana, Arial, &quot;Bitstream Vera Sans&quot;, Helvetica, sans-serif; font-size: 13px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">
      <li><strong>Updated: TLS-exporter in mbedtls</strong><br>
        <em>Needed for TLS 1.3 support with openvpn and mbedtls -
          TLS-exporter currently missing in mbedtls.</em><br>
        <em>maxf reports he's making some progress on implementing this
          - currently working to ensure all unit tests in all million
          billions of configurations work.</em></li>
    </ul>
    <ul
style="color: rgb(0, 0, 0); font-family: Verdana, Arial, &quot;Bitstream Vera Sans&quot;, Helvetica, sans-serif; font-size: 13px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">
      <li><strong>Updated: --dns patch review upcoming</strong><br>
        <em>d12fk patches are being made ready for gerrit review now.</em></li>
    </ul>
    As always you're welcome to join at #openvpn-meeting on Libera IRC
    network every Wednesday at 14:00 Central European Time.
    <p>Kind regards,<br>
      Johan Draaisma<br>
    </p>
  </body>
</html>

--------------62NNL124Fa7gXl7Ze7D0vOD5--

