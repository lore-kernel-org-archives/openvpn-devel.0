Content-Type: multipart/alternative;
 boundary="------------KSWy6bIzHcc0IBzF4hxmDlYY"
Message-ID: <0ea963fa-5bd7-426b-8b70-9365ca173510@...277...>
Date: Wed, 20 Nov 2024 14:51:08 +0100
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
--------------KSWy6bIzHcc0IBzF4hxmDlYY
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit

Meeting summary for 20 November 2024:

  * *Updated: DCO Linux upstreaming*
    /Upstreaming DCO to Linux is proceeding, it is in review stage at
    the moment./
    /ordex intended to send out patchset v12 but was delayed due to
    illness. Now expected this week./

  * *Updated: data format v3 / epoch data keys*
    /RFC is here:​https://github.com/OpenVPN/openvpn-rfc/pull/5
    <https://github.com/OpenVPN/openvpn-rfc/pull/5>./
    /plaisthos is working to implement it in openvpn3 first./
    /MaxF reviewed the RFC and commented that it looks good./

  * *Updated: DCO windows multi-peer*
    /Preparing patchset for the userspace implementation./

  * *Updated: t_server_null improvements*
    /The LWIP ping testing in t_server_null.sh is somewhat working./
    /It is a bit tricky to get it right but then it seems to be working./
    /mattock will prepare a patch./

  * *Updated: community.openvpn.net wiki*
    /A more suitable production deployment schema for otterwiki has been
    submitted upstream. That does not block us however./
    /mattock is ready to proceed and needs an EC2 instance in the
    community account for hosting production./
    /This instance can have some new address so we can start setting it
    up and migrating content./
    /After migrating data we can then remove the old wiki and put the
    new wiki on the address of the old one./
    /djpig or uddr35 can help to provide the instance and give mattock
    full access to it so he can then deploy the necessary otterwiki
    deployment on it./

  * *New: snapshot releases via Chocolatey software*
    /mattock contacted the Chocolate package maintainer for OpenVPN and
    aasked if he would be okay with publishing Windows MSI snapshots as
    well./
    /Seems like the maintainer is amenable to helping us achieve that goal./

  * *Updated: --dns patch review upcoming*
    /d12fk patches are being made ready for gerrit review now - should
    arrive before next meeting./

As always you're welcome to join at #openvpn-meeting on Libera IRC 
network every Wednesday at 14:00 Central European Time.

Kind regards,
Johan Draaisma

--------------KSWy6bIzHcc0IBzF4hxmDlYY
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: 8bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p> Meeting summary for 20 November 2024:</p>
    <ul
style="color: rgb(0, 0, 0); font-family: Verdana, Arial, &quot;Bitstream Vera Sans&quot;, Helvetica, sans-serif; font-size: 13px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">
      <li><strong>Updated: DCO Linux upstreaming</strong><br>
        <em>Upstreaming DCO to Linux is proceeding, it is in review
          stage at the moment.</em><br>
        <em>ordex intended to send out patchset v12 but was delayed due
          to illness. Now expected this week.</em></li>
    </ul>
    <ul
style="color: rgb(0, 0, 0); font-family: Verdana, Arial, &quot;Bitstream Vera Sans&quot;, Helvetica, sans-serif; font-size: 13px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">
      <li><strong>Updated: data format v3 / epoch data keys</strong><br>
        <em>RFC is here:<span> </span><a class="ext-link"
            href="https://github.com/OpenVPN/openvpn-rfc/pull/5"
style="text-decoration: none; color: rgb(187, 0, 0); border-bottom: 1px dotted rgb(187, 187, 187);"><span
              class="icon"
style="background: url(&quot;../extlink.gif&quot;) left center no-repeat; padding-left: 15px;">​</span>https://github.com/OpenVPN/openvpn-rfc/pull/5</a>.</em><br>
        <em>plaisthos is working to implement it in openvpn3 first.</em><br>
        <em>MaxF reviewed the RFC and commented that it looks good.</em></li>
    </ul>
    <ul
style="color: rgb(0, 0, 0); font-family: Verdana, Arial, &quot;Bitstream Vera Sans&quot;, Helvetica, sans-serif; font-size: 13px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">
      <li><strong>Updated: DCO windows multi-peer</strong><br>
        <em>Preparing patchset for the userspace implementation.</em></li>
    </ul>
    <ul
style="color: rgb(0, 0, 0); font-family: Verdana, Arial, &quot;Bitstream Vera Sans&quot;, Helvetica, sans-serif; font-size: 13px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">
      <li><strong>Updated: t_server_null improvements</strong><br>
        <em>The LWIP ping testing in t_server_null.sh is somewhat
          working.</em><br>
        <em>It is a bit tricky to get it right but then it seems to be
          working.</em><br>
        <em>mattock will prepare a patch.</em></li>
    </ul>
    <ul
style="color: rgb(0, 0, 0); font-family: Verdana, Arial, &quot;Bitstream Vera Sans&quot;, Helvetica, sans-serif; font-size: 13px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">
      <li><strong>Updated: community.openvpn.net wiki</strong><br>
        <em>A more suitable production deployment schema for otterwiki
          has been submitted upstream. That does not block us however.</em><br>
        <em>mattock is ready to proceed and needs an EC2 instance in the
          community account for hosting production.</em><br>
        <em>This instance can have some new address so we can start
          setting it up and migrating content.</em><br>
        <em>After migrating data we can then remove the old wiki and put
          the new wiki on the address of the old one.</em><br>
        <em>djpig or uddr35 can help to provide the instance and give
          mattock full access to it so he can then deploy the necessary
          otterwiki deployment on it.</em></li>
    </ul>
    <ul
style="color: rgb(0, 0, 0); font-family: Verdana, Arial, &quot;Bitstream Vera Sans&quot;, Helvetica, sans-serif; font-size: 13px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">
      <li><strong>New: snapshot releases via Chocolatey software</strong><br>
        <em>mattock contacted the Chocolate package maintainer for
          OpenVPN and aasked if he would be okay with publishing Windows
          MSI snapshots as well.</em><br>
        <em>Seems like the maintainer is amenable to helping us achieve
          that goal.</em></li>
    </ul>
    <ul
style="color: rgb(0, 0, 0); font-family: Verdana, Arial, &quot;Bitstream Vera Sans&quot;, Helvetica, sans-serif; font-size: 13px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">
      <li><strong>Updated: --dns patch review upcoming</strong><br>
        <em>d12fk patches are being made ready for gerrit review now -
          should arrive before next meeting.</em></li>
    </ul>
    As always you're welcome to join at #openvpn-meeting on Libera IRC
    network every Wednesday at 14:00 Central European Time.
    <p>Kind regards,<br>
      Johan Draaisma<br>
    </p>
  </body>
</html>

--------------KSWy6bIzHcc0IBzF4hxmDlYY--

