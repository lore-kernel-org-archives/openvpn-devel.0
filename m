Content-Type: multipart/alternative;
 boundary="------------45tNz8mznJfr4Zmx1eZPUSF4"
Message-ID: <70ded73b-9c7b-49b3-abbe-5e6f85b26d65@...2722...>
Date: Thu, 27 Feb 2025 01:07:39 +0100
MIME-Version: 1.0
From: Johan Draaisma <johan@...2722...>
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
--------------45tNz8mznJfr4Zmx1eZPUSF4
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit

Meeting summary for 26 February 2025:

  * *Updated, closed: OpenSSL update severity high*
    /Even though we don't appear to be affected by the issues in this
    release, but because the Windows installers bundle a copy of
    OpenSSL, we decided to update the Windows installers to version I002./
    /This is up on the community wiki now but main website will follow
    suit shortly. novaflash will arrange that website gets updated -
    should be updated on Thursday somewhere./

  * *Updated, closed: DCO windows multi-peer*
    /This was merged, and 2 bugs discovered in iroute implementation
    were also fixed./
    /Epoch data keys implementation in Windows DCO development is now
    unblocked./

  * *Updated: new --dns option support*
    /​https://gerrit.openvpn.net/q/topic:%22dns+option%22
    <https://gerrit.openvpn.net/q/topic:%22dns+option%22>/
    /cron2 wants to discuss about a particular issue regarding DNS, and
    a documentation update is needed./

  * *Updated: data format v3 / epoch data keys*
    /Implementation in user space in OpenVPN2 and OpenVPN3 are both done
    now./
    /Developing support for epoch data keys in DCO Linux is on hold
    until upstreaming to Linux kernel is done./
    /Developing support for epoch data keys in DCO Windows is unblocked
    - to be picked up by lev when he is able./

  * *Updated: DCO Linux upstreaming
    */Upstreaming DCO to Linux is proceeding, it is in review stage at
    the moment.
    //Due to changes in RTNL kernel space we have to send an updated
    patchset (v20 i think by now)./

As always you're welcome to join at #openvpn-meeting on Libera IRC 
network every Wednesday at 14:00 Central European Time.

Kind regards,
Johan Draaisma

--------------45tNz8mznJfr4Zmx1eZPUSF4
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: 8bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p> Meeting summary for 26 February 2025:</p>
    <ul
style="color: rgb(0, 0, 0); font-family: Verdana, Arial, &quot;Bitstream Vera Sans&quot;, Helvetica, sans-serif; font-size: 13px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">
      <li><strong>Updated, closed: OpenSSL update severity high</strong><br>
        <em>Even though we don't appear to be affected by the issues in
          this release, but because the Windows installers bundle a copy
          of OpenSSL, we decided to update the Windows installers to
          version I002.</em><br>
        <em>This is up on the community wiki now but main website will
          follow suit shortly. novaflash will arrange that website gets
          updated - should be updated on Thursday somewhere.</em></li>
    </ul>
    <ul
style="color: rgb(0, 0, 0); font-family: Verdana, Arial, &quot;Bitstream Vera Sans&quot;, Helvetica, sans-serif; font-size: 13px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">
      <li><strong>Updated, closed: DCO windows multi-peer</strong><br>
        <em>This was merged, and 2 bugs discovered in iroute
          implementation were also fixed.</em><br>
        <em>Epoch data keys implementation in Windows DCO development is
          now unblocked.</em></li>
    </ul>
    <ul
style="color: rgb(0, 0, 0); font-family: Verdana, Arial, &quot;Bitstream Vera Sans&quot;, Helvetica, sans-serif; font-size: 13px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">
      <li><strong>Updated: new --dns option support</strong><br>
        <em><a class="ext-link"
            href="https://gerrit.openvpn.net/q/topic:%22dns+option%22"><span
              class="icon">​</span>https://gerrit.openvpn.net/q/topic:%22dns+option%22</a></em><br>
        <em>cron2 wants to discuss about a particular issue regarding
          DNS, and a documentation update is needed.</em></li>
    </ul>
    <ul
style="color: rgb(0, 0, 0); font-family: Verdana, Arial, &quot;Bitstream Vera Sans&quot;, Helvetica, sans-serif; font-size: 13px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">
      <li><strong>Updated: data format v3 / epoch data keys</strong><br>
        <em>Implementation in user space in OpenVPN2 and OpenVPN3 are
          both done now.</em><br>
        <em>Developing support for epoch data keys in DCO Linux is on
          hold until upstreaming to Linux kernel is done.</em><br>
        <em>Developing support for epoch data keys in DCO Windows is
          unblocked - to be picked up by lev when he is able.</em></li>
    </ul>
    <ul
style="color: rgb(0, 0, 0); font-family: Verdana, Arial, &quot;Bitstream Vera Sans&quot;, Helvetica, sans-serif; font-size: 13px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">
      <li><strong>Updated: DCO Linux upstreaming<br>
        </strong><em>Upstreaming DCO to Linux is proceeding, it is in
          review stage at the moment.<br>
        </em><em>Due to changes in RTNL kernel space we have to send an
          updated patchset (v20 i think by now).</em></li>
    </ul>
    <p>As always you're welcome to join at #openvpn-meeting on Libera
      IRC network every Wednesday at 14:00 Central European Time. </p>
    <p>Kind regards,<br>
      Johan Draaisma<br>
    </p>
  </body>
</html>

--------------45tNz8mznJfr4Zmx1eZPUSF4--

