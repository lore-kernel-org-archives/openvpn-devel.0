Content-Type: multipart/alternative;
 boundary="------------ZmjtmvB0TBWlqrEXuGMGFvWt"
Message-ID: <7ddb0cbb-845a-4c5c-af70-d73528b9a6e6@...2751...>
Date: Thu, 26 Oct 2023 10:33:57 +0200
MIME-Version: 1.0
From: Johan Draaisma <johan@...2751...>
Content-Language: en-US
Subject: [Openvpn-devel] IRC community meeting summary
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
--------------ZmjtmvB0TBWlqrEXuGMGFvWt
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Meeting summary for 25 October 2023:

  * *Updated: Publish security assessment of OpenVPN2 codebase on main
    website.*
    /Approvals and preparations are done for this./
    /Marketing decided to make it a larger topic (?) and include past
    security assessments./
    /Expected to be published within the next 3 weeks.
    /
  * *Updated: License amendment for OpenVPN2 to solve openssl/mbedtls
    licensing issues*
    /The OpenSSL James Bottomley stuff is resolved now./
    /The --tls-export-cert feature needs to be removed by dazo and
    reimplemented by plaisthos./
    /Then it is up to dazo to review things so we can work on finalizing
    this./
    /One of the tasks is reviewing if remaining items are trivial
    patches, and maybe get legal advice on those if necessary./
    /For new contributions the new license already applies so maxf is
    unblocked to implement mbedtls3 support on master./
    /maxf mentioned he will look into how much work it is to backport
    mbedtls3 it to 2.6.'

    /
  * *Updated: OpenVPN 2.6.7 release*
    /CMake backport is in./
    /We are working on some outstanding patches that we are working to
    get in./
    /Also there is a div-by-zero bug we want to get out soon so we're
    waiting until that is in./

As always you're welcome to join at #openvpn-meeting on Libera IRC 
network every Wednesday at 13:00 Central European Time.

Kind regards,
Johan Draaisma

--------------ZmjtmvB0TBWlqrEXuGMGFvWt
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
  </head>
  <body>
    Meeting summary for 25 October 2023:<br>
    <ul
style="color: rgb(0, 0, 0); font-family: Verdana, Arial, &quot;Bitstream Vera Sans&quot;, Helvetica, sans-serif; font-size: 13px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">
      <li><strong>Updated: Publish security assessment of OpenVPN2
          codebase on main website.</strong><br>
        <em>Approvals and preparations are done for this.</em><br>
        <em>Marketing decided to make it a larger topic (?) and include
          past security assessments.</em><br>
        <em>Expected to be published within the next 3 weeks.<br>
        </em><br>
      </li>
      <li><strong>Updated: License amendment for OpenVPN2 to solve
          openssl/mbedtls licensing issues</strong><br>
        <em>The OpenSSL James Bottomley stuff is resolved now.</em><br>
        <em>The --tls-export-cert feature needs to be removed by dazo
          and reimplemented by plaisthos.</em><br>
        <em>Then it is up to dazo to review things so we can work on
          finalizing this.</em><br>
        <em>One of the tasks is reviewing if remaining items are trivial
          patches, and maybe get legal advice on those if necessary.</em><br>
        <em>For new contributions the new license already applies so
          maxf is unblocked to implement mbedtls3 support on master.</em><br>
        <em>maxf mentioned he will look into how much work it is to
          backport mbedtls3 it to 2.6.'<br>
          <br>
        </em></li>
      <li><strong>Updated: OpenVPN 2.6.7 release</strong><br>
        <em>CMake backport is in.</em><br>
        <em>We are working on some outstanding patches that we are
          working to get in.</em><br>
        <em>Also there is a div-by-zero bug we want to get out soon so
          we're waiting until that is in.</em></li>
    </ul>
    <p>As always you're welcome to join at #openvpn-meeting on Libera
      IRC network every Wednesday at 13:00 Central European Time.</p>
    <p>Kind regards,<br>
      Johan Draaisma<br>
    </p>
  </body>
</html>

--------------ZmjtmvB0TBWlqrEXuGMGFvWt--

