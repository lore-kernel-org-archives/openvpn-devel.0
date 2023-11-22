Content-Type: multipart/alternative;
 boundary="------------McDRUkYlY4nWnem0enMmUi2k"
Message-ID: <a43375a9-e598-4288-a551-ed2f038fedc6@...2751...>
Date: Wed, 22 Nov 2023 16:02:12 +0100
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
--------------McDRUkYlY4nWnem0enMmUi2k
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Meeting summary for 22 November 2023:

  * *Closed: OpenVPN 2.6.7 release*
    /2.6.7 was released, and followed up with 2.6.8./

  * *Closed: OpenVPN 2.6.8 release*
    /2.6.8 was released on Friday 17 November./

  * *Updated: Publish security assessment of OpenVPN2 on main website.*
    /Trail of Bits security audit of OpenVPN2
    published:https://openvpn.net/blog/trail-of-bits//

  * *Updated: Website release process woes*
    /Website team reports they are going to publish the new CMS for
    community downloads and security advisories next week./

  * *New: TLS 1.0 PRF problem*
    /OpenVPN has used a scheme based on the TLS 1.0 PRF with MD5+SHA1 in
    the past. Since OpenVPN 2.6.0+ and 3.6.0+ using Keying Material
    Exporters (RFC 5705) is preferrred as modern alternative to
    that.//If one or both sides are older versions of OpenVPN like 2.5
    and use the older method of making key material, there can be a
    problem./
    /For example on platforms like RHEL9 with FIPS enabled, you cannot
    use TLS 1.0 PRF with MD5+SHA1. So even for these special cases MD5
    has become impossible in this particular situation./
    /As a practical example, this means OpenVPN 2.5 on RHEL9 with FIPS
    enabled cannot work at all. But 2.6 does work because it uses TLS
    export, but only if the other side supports TLS export too./
    /We should first of all document this. But second, having a
    self-test in OpenVPN that warns of this situation can be beneficial./

  * *Updated: License amendment for OpenVPN2 to solve openssl/mbedtls
    licensing issues*
    /For new contributions the new license already applies./
    /The --tls-export-cert option needs to be removed, and
    reimplemented. dazo sent in the patch to remove it, plaisthos will
    reimplement it./
    /Then it is up to dazo to review things so we can work on finalizing
    this./
    /One of the last tasks is reviewing if remaining items are trivial
    patches, and maybe get legal advice on those if necessary./

As always you're welcome to join at #openvpn-meeting on Libera IRC 
network every Wednesday at 13:00 Central European Time.

Kind regards,
Johan Draaisma

--------------McDRUkYlY4nWnem0enMmUi2k
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: 8bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p> Meeting summary for 22 November 2023:</p>
    <ul
style="color: rgb(0, 0, 0); font-family: Verdana, Arial, &quot;Bitstream Vera Sans&quot;, Helvetica, sans-serif; font-size: 13px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">
      <li><strong>Closed: OpenVPN 2.6.7 release</strong><br>
        <em>2.6.7 was released, and followed up with 2.6.8.</em></li>
    </ul>
    <ul
style="color: rgb(0, 0, 0); font-family: Verdana, Arial, &quot;Bitstream Vera Sans&quot;, Helvetica, sans-serif; font-size: 13px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">
      <li><strong>Closed: OpenVPN 2.6.8 release</strong><br>
        <em>2.6.8 was released on Friday 17 November.</em></li>
    </ul>
    <ul
style="color: rgb(0, 0, 0); font-family: Verdana, Arial, &quot;Bitstream Vera Sans&quot;, Helvetica, sans-serif; font-size: 13px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">
      <li><strong>Updated: Publish security assessment of OpenVPN2 on
          main website.</strong><br>
        <em>Trail of Bits security audit of OpenVPN2 published:<span> </span><a
            href="https://openvpn.net/blog/trail-of-bits/"
style="text-decoration: none; color: rgb(187, 0, 0); border-bottom: 1px dotted rgb(187, 187, 187);"
            class="moz-txt-link-freetext">https://openvpn.net/blog/trail-of-bits/</a></em></li>
    </ul>
    <ul
style="color: rgb(0, 0, 0); font-family: Verdana, Arial, &quot;Bitstream Vera Sans&quot;, Helvetica, sans-serif; font-size: 13px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">
      <li><strong>Updated: Website release process woes</strong><br>
        <em>Website team reports they are going to publish the new CMS
          for community downloads and security advisories next week.</em></li>
    </ul>
    <ul
style="color: rgb(0, 0, 0); font-family: Verdana, Arial, &quot;Bitstream Vera Sans&quot;, Helvetica, sans-serif; font-size: 13px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">
      <li><strong>New: TLS 1.0 PRF problem</strong><br>
        <em>OpenVPN has used a scheme based on the TLS 1.0 PRF with
          MD5+SHA1 in the past. Since OpenVPN 2.6.0+ and 3.6.0+ using
          Keying Material Exporters (RFC 5705) is preferrred as modern
          alternative to that.</em><span> </span><em>If one or both
          sides are older versions of OpenVPN like 2.5 and use the older
          method of making key material, there can be a problem.</em><br>
        <em>For example on platforms like RHEL9 with FIPS enabled, you
          cannot use TLS 1.0 PRF with MD5+SHA1. So even for these
          special cases MD5 has become impossible in this particular
          situation.</em><br>
        <em>As a practical example, this means OpenVPN 2.5 on RHEL9 with
          FIPS enabled cannot work at all. But 2.6 does work because it
          uses TLS export, but only if the other side supports TLS
          export too.</em><br>
        <em>We should first of all document this. But second, having a
          self-test in OpenVPN that warns of this situation can be
          beneficial.</em></li>
    </ul>
    <ul
style="color: rgb(0, 0, 0); font-family: Verdana, Arial, &quot;Bitstream Vera Sans&quot;, Helvetica, sans-serif; font-size: 13px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">
      <li><strong>Updated: License amendment for OpenVPN2 to solve
          openssl/mbedtls licensing issues</strong><br>
        <em>For new contributions the new license already applies.</em><br>
        <em>The --tls-export-cert option needs to be removed, and
          reimplemented. dazo sent in the patch to remove it, plaisthos
          will reimplement it.</em><br>
        <em>Then it is up to dazo to review things so we can work on
          finalizing this.</em><br>
        <em>One of the last tasks is reviewing if remaining items are
          trivial patches, and maybe get legal advice on those if
          necessary.</em></li>
    </ul>
    <p>As always you're welcome to join at #openvpn-meeting on Libera
      IRC network every Wednesday at 13:00 Central European Time.</p>
    <p>Kind regards,<br>
      Johan Draaisma<br>
    </p>
  </body>
</html>

--------------McDRUkYlY4nWnem0enMmUi2k--

