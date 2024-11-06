Content-Type: multipart/alternative;
 boundary="------------HCXdVvCCQJsDRW0gZjwvUE49"
Message-ID: <2ac1af32-3459-4f6d-acc1-e22f64aa80c2@...2751...>
Date: Wed, 6 Nov 2024 14:35:35 +0100
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
--------------HCXdVvCCQJsDRW0gZjwvUE49
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit

Meeting summary for 6 November 2024:

  * *Updated: DCO windows multi-peer*
    /Kernelspace looks done, now working on userspace stuff. It listens
    for incoming clients and attempts handshake. Still a bit of work to do./

  * *Updated: multi-socket patch series*
    /This has been rebased and comments addressed, waiting for another
    review./

  * *Updated: data format v3 / epoch data keys*
    /Some comments from syzzer came in and were addressed on the RFC
    addition for epoch keys:/
    /See​https://github.com/OpenVPN/openvpn-rfc/pull/5
    <https://github.com/OpenVPN/openvpn-rfc/pull/5>./
    /plaisthos is working to implement it in openvpn3 first./

  * *Updated: push_update / live route updates*
    /Lev added some clarifying comments to the push_update section in
    the RFC, as per popular demand./
    /Implementation of push_update for OpenVPN v2 will be looked at by
    ordex and his team./

  * *New: TLS-exporter in mbedtls*
    /Needed for TLS 1.3 support with openvpn and mbedtls - TLS-exporter
    currently missing in mbedtls./
    /maxf reports he's making some progress on implementing this./

As always you're welcome to join at #openvpn-meeting on Libera IRC 
network every Wednesday at 14:00 Central European Time.

Kind regards,
Johan Draaisma

--------------HCXdVvCCQJsDRW0gZjwvUE49
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: 8bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p> Meeting summary for 6 November 2024:</p>
    <ul
style="color: rgb(0, 0, 0); font-family: Verdana, Arial, &quot;Bitstream Vera Sans&quot;, Helvetica, sans-serif; font-size: 13px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">
      <li><strong>Updated: DCO windows multi-peer</strong><br>
        <em>Kernelspace looks done, now working on userspace stuff. It
          listens for incoming clients and attempts handshake. Still a
          bit of work to do.</em></li>
    </ul>
    <ul
style="color: rgb(0, 0, 0); font-family: Verdana, Arial, &quot;Bitstream Vera Sans&quot;, Helvetica, sans-serif; font-size: 13px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">
      <li><strong>Updated: multi-socket patch series</strong><br>
        <em>This has been rebased and comments addressed, waiting for
          another review.</em></li>
    </ul>
    <ul
style="color: rgb(0, 0, 0); font-family: Verdana, Arial, &quot;Bitstream Vera Sans&quot;, Helvetica, sans-serif; font-size: 13px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">
      <li><strong>Updated: data format v3 / epoch data keys</strong><br>
        <em>Some comments from syzzer came in and were addressed on the
          RFC addition for epoch keys:</em><br>
        <em>See<span> </span><a class="ext-link"
            href="https://github.com/OpenVPN/openvpn-rfc/pull/5"
style="text-decoration: none; color: rgb(187, 0, 0); border-bottom: 1px dotted rgb(187, 187, 187);"><span
              class="icon"
style="background: url(&quot;../extlink.gif&quot;) left center no-repeat; padding-left: 15px;">​</span>https://github.com/OpenVPN/openvpn-rfc/pull/5</a>.</em><br>
        <em>plaisthos is working to implement it in openvpn3 first.</em></li>
    </ul>
    <ul
style="color: rgb(0, 0, 0); font-family: Verdana, Arial, &quot;Bitstream Vera Sans&quot;, Helvetica, sans-serif; font-size: 13px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">
      <li><strong>Updated: push_update / live route updates</strong><br>
        <em>Lev added some clarifying comments to the push_update
          section in the RFC, as per popular demand.</em><br>
        <em>Implementation of push_update for OpenVPN v2 will be looked
          at by ordex and his team.</em></li>
    </ul>
    <ul
style="color: rgb(0, 0, 0); font-family: Verdana, Arial, &quot;Bitstream Vera Sans&quot;, Helvetica, sans-serif; font-size: 13px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">
      <li><strong>New: TLS-exporter in mbedtls</strong><br>
        <em>Needed for TLS 1.3 support with openvpn and mbedtls -
          TLS-exporter currently missing in mbedtls.</em><br>
        <em>maxf reports he's making some progress on implementing this.</em></li>
    </ul>
    As always you're welcome to join at #openvpn-meeting on Libera IRC
    network every Wednesday at 14:00 Central European Time.
    <p>Kind regards,<br>
      Johan Draaisma<br>
    </p>
  </body>
</html>

--------------HCXdVvCCQJsDRW0gZjwvUE49--

