Content-Type: multipart/alternative;
 boundary="------------mtVzMzjocnZVpKK88PSuoqJP"
Message-ID: <9aa21212-efc1-4d7e-b1b8-e9735437ef07@...2722...>
Date: Wed, 16 Apr 2025 18:24:46 +0200
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
--------------mtVzMzjocnZVpKK88PSuoqJP
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit

Meeting summary for 16 April 2025:

  * *Closed: Release 2.6.14*
    /This was released on April 2nd 2025 and addressesCVE-2025-2704
    <https://community.openvpn.net/openvpn/wiki/CVE-2025-2704>./
    /Access Server 2.14.3 was released April 14th that has this version
    and fix in it./

  * *Updated: DCO Linux upstreaming*
    /Upstreaming DCO to Linux is proceeding, it is still in review phase
    but very close to being merge ready./
    /Sabrina has extensively reviewed and all items are now resolved and
    her reviewed-by blessing given./
    /Jakub is now reviewing and had a few comments and a patchset v26
    was sent in yesterday to address these./
    /The tentative expectation is that once finally Jakub okays it, it
    may get merged./

  * *Updated: Release 2.7*
    /Unfortunately our initial goal to get 2.7 ready for the next Debian
    13 release is not feasible./
    /Current estimates are to have all major code items in by May 1st
    and then a release on July 1st./
    /For DCO the plan is to take the DCO code that is being worked on to
    upstream to Linux kernel, and make it like a backport to go together
    with 2.7./
    /For changes to Windows service handling for 2.7, those changes have
    been made so openvpn can run nicely under a limited privileges account./
    /There is a party interested in doing a security audit of OpenVPN
    2.7, there are some questions to be clarified about it being a code
    audit and/or testing./
    /SRLabs.de was the party chosen to do the audit./

  * *Updated: forums situation*
    /Situation in a nutshell; old forums got flooded with spam. attempt
    was made to make new forums to fix it. this was aborted. now we're
    in limbo./
    /We now have someone from OpenVPN Inc to help us fix it up, so we'll
    let him try./

  * *Updated: new --dns option support*
    /​https://gerrit.openvpn.net/q/topic:%22dns+option%22
    <https://gerrit.openvpn.net/q/topic:%22dns+option%22>/
    /Implementation for unix-like has needed approvals but needs to go
    in. Windows implementation is done and in./
    /Currently work is being done on expanding the test framework to
    test the new DNS options - server-side of that is done, client side
    needs to comply./

As always you're welcome to join at #openvpn-meeting on Libera IRC 
network every Wednesday at 14:00 Central European Time.

Kind regards,
Johan Draaisma

--------------mtVzMzjocnZVpKK88PSuoqJP
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: 8bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p> Meeting summary for 16 April 2025:</p>
    <ul
style="color: rgb(0, 0, 0); font-family: Verdana, Arial, &quot;Bitstream Vera Sans&quot;, Helvetica, sans-serif; font-size: 13px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">
      <li><strong>Closed: Release 2.6.14</strong><br>
        <em>This was released on April 2nd 2025 and addresses<span> </span><a
            class="wiki"
href="https://community.openvpn.net/openvpn/wiki/CVE-2025-2704"
style="text-decoration: none; color: rgb(187, 0, 0); border-bottom: 1px dotted rgb(187, 187, 187);">CVE-2025-2704</a>.</em><br>
        <em>Access Server 2.14.3 was released April 14th that has this
          version and fix in it.</em></li>
    </ul>
    <ul
style="color: rgb(0, 0, 0); font-family: Verdana, Arial, &quot;Bitstream Vera Sans&quot;, Helvetica, sans-serif; font-size: 13px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">
      <li><strong>Updated: DCO Linux upstreaming</strong><br>
        <em>Upstreaming DCO to Linux is proceeding, it is still in
          review phase but very close to being merge ready.</em><br>
        <em>Sabrina has extensively reviewed and all items are now
          resolved and her reviewed-by blessing given.</em><br>
        <em>Jakub is now reviewing and had a few comments and a patchset
          v26 was sent in yesterday to address these.</em><br>
        <em>The tentative expectation is that once finally Jakub okays
          it, it may get merged.</em></li>
    </ul>
    <ul
style="color: rgb(0, 0, 0); font-family: Verdana, Arial, &quot;Bitstream Vera Sans&quot;, Helvetica, sans-serif; font-size: 13px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">
      <li><strong>Updated: Release 2.7</strong><br>
        <em>Unfortunately our initial goal to get 2.7 ready for the next
          Debian 13 release is not feasible.</em><br>
        <em>Current estimates are to have all major code items in by May
          1st and then a release on July 1st.</em><br>
        <em>For DCO the plan is to take the DCO code that is being
          worked on to upstream to Linux kernel, and make it like a
          backport to go together with 2.7.</em><br>
        <em>For changes to Windows service handling for 2.7, those
          changes have been made so openvpn can run nicely under a
          limited privileges account.</em><br>
        <em>There is a party interested in doing a security audit of
          OpenVPN 2.7, there are some questions to be clarified about it
          being a code audit and/or testing.</em><br>
        <em>SRLabs.de was the party chosen to do the audit.</em></li>
    </ul>
    <ul
style="color: rgb(0, 0, 0); font-family: Verdana, Arial, &quot;Bitstream Vera Sans&quot;, Helvetica, sans-serif; font-size: 13px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">
      <li><strong>Updated: forums situation</strong><br>
        <em>Situation in a nutshell; old forums got flooded with spam.
          attempt was made to make new forums to fix it. this was
          aborted. now we're in limbo.</em><br>
        <em>We now have someone from OpenVPN Inc to help us fix it up,
          so we'll let him try.</em></li>
    </ul>
    <ul
style="color: rgb(0, 0, 0); font-family: Verdana, Arial, &quot;Bitstream Vera Sans&quot;, Helvetica, sans-serif; font-size: 13px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">
      <li><strong>Updated: new --dns option support</strong><br>
        <em><a class="ext-link"
            href="https://gerrit.openvpn.net/q/topic:%22dns+option%22"
style="text-decoration: none; color: rgb(187, 0, 0); border-bottom: 1px dotted rgb(187, 187, 187);"><span
              class="icon"
style="background: url(&quot;../extlink.gif&quot;) left center no-repeat; padding-left: 15px;">​</span>https://gerrit.openvpn.net/q/topic:%22dns+option%22</a></em><br>
        <em>Implementation for unix-like has needed approvals but needs
          to go in. Windows implementation is done and in.</em><br>
        <em>Currently work is being done on expanding the test framework
          to test the new DNS options - server-side of that is done,
          client side needs to comply.</em></li>
    </ul>
    <p>As always you're welcome to join at #openvpn-meeting on Libera
      IRC network every Wednesday at 14:00 Central European Time. </p>
    <p>Kind regards,<br>
      Johan Draaisma<br>
    </p>
  </body>
</html>

--------------mtVzMzjocnZVpKK88PSuoqJP--

