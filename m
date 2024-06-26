Content-Type: multipart/alternative;
 boundary="------------rZ05bnhD5k0RSnJcOV0vFmAl"
Message-ID: <f85f8471-8a95-42e1-9339-69d4e68423f7@...2751...>
Date: Wed, 26 Jun 2024 15:43:13 +0200
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
--------------rZ05bnhD5k0RSnJcOV0vFmAl
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit

Meeting summary for 26 June 2024:

  * *New: release openvpn 2.6.12*
    /The security issue addressed in 2.6.11 has the known issue that it
    breaks certain setups with backend scripts that produce custom
    auth_failed messages./
    /This will be addressed in the upcoming 2.6.12 release./
    /An improvement in the area of the LZO library is also in the works./

  * *Updated: release openvpn 2.6.11*
    /This release was done last week on June 20th./
    /We have a fix for a reported issue with localized versions of
    Windows and a custom installation path of OpenVPN GUI. Looks like we
    can update to I002 for the Windows installer./
    /This will likely go out today./
    /The tunnelcrack mitigations for Windows are held back because we
    have had absolutely no response on the mailing lists for testing
    these and confirming that it doesn't break things./
    /If someone can contribute to testing this we can follow up with a
    2.6.12 release in a few weeks that contains the tunnelcrack
    mitigations for Windows. Otherwise it goes to 2.7./

  * *Updated: DCO and Linux upstreaming, API change*/
    /Upstreaming DCO to Linux is proceeding, it is in review stage at
    the moment./
    /ordex has sent in*patchset version 4*./
    /There will be an API change that makes it incompatible with the
    current implementation./
    /A graceful solution to that was already discussed and in motion.
    giaan will be working on this./
    /(in a nutshell, make OpenVPN understand old and new API, DKMS and
    kernel versions both will then use new API, then we drop old API)//

  * *Updated: Tunnelcrack progressTunnelCrack community wiki article
    <https://community.openvpn.net/openvpn/wiki/TunnelCrack>*
    /Status update onTunnelCrack
    <https://community.openvpn.net/openvpn/wiki/TunnelCrack>mitigations:/
    /The tunnelcrack mitigation for Windows has gone in master, which
    will go to 2.7 release. There is the possibility for it to go to
    2.6.x if we can find testers for this./
    /Windows, openvpn2: merged to master, not to 2.6.x. openvpn3: in
    code review./
    /Linux, openvpn2: in progress. openvpn3: in progress./
    /macOS: to be determined./
    /iOS: to be determined./
    /Android: not vulnerable./

  * *Updated: OpenVPN community meetup 2024*
    /Wiki coordination
    page:​https://community.openvpn.net/openvpn/wiki/CommunityMeetup2024
    <https://community.openvpn.net/openvpn/wiki/CommunityMeetup2024>/
    /Where: Karlsruhe, Germany. Meeting room found, need to find out how
    many participants roughly./
    /When: Set to 20-22 September 2024./
    /Shirts: novaflash spoke to matt - he will get us some design in
    august./
    /We need to know how many participants will show. To that end it
    makes sense if we put together an invite mail and send it out./
    /novaflash put together a suggested
    mail;​https://cryptpad.fr/pad/#/2/pad/edit/UEzTg-cbReVteh9zR9CQD-Tt/
    <https://cryptpad.fr/pad/#/2/pad/edit/UEzTg-cbReVteh9zR9CQD-Tt/>/
    /This will be sent out as an official invite to openvpn-devel and to
    some special guests./

As always you're welcome to join at #openvpn-meeting on Libera IRC 
network every Wednesday at 14:00 Central European Time.

Kind regards,
Johan Draaisma

--------------rZ05bnhD5k0RSnJcOV0vFmAl
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: 8bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p> Meeting summary for 26 June 2024:</p>
    <ul
style="color: rgb(0, 0, 0); font-family: Verdana, Arial, &quot;Bitstream Vera Sans&quot;, Helvetica, sans-serif; font-size: 13px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">
      <li><strong>New: release openvpn 2.6.12</strong><br>
        <em>The security issue addressed in 2.6.11 has the known issue
          that it breaks certain setups with backend scripts that
          produce custom auth_failed messages.</em><br>
        <em>This will be addressed in the upcoming 2.6.12 release.</em><br>
        <em>An improvement in the area of the LZO library is also in the
          works.</em></li>
    </ul>
    <ul
style="color: rgb(0, 0, 0); font-family: Verdana, Arial, &quot;Bitstream Vera Sans&quot;, Helvetica, sans-serif; font-size: 13px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">
      <li><strong>Updated: release openvpn 2.6.11</strong><br>
        <em>This release was done last week on June 20th.</em><br>
        <em>We have a fix for a reported issue with localized versions
          of Windows and a custom installation path of OpenVPN GUI.
          Looks like we can update to I002 for the Windows installer.</em><br>
        <em>This will likely go out today.</em><br>
        <em>The tunnelcrack mitigations for Windows are held back
          because we have had absolutely no response on the mailing
          lists for testing these and confirming that it doesn't break
          things.</em><br>
        <em>If someone can contribute to testing this we can follow up
          with a 2.6.12 release in a few weeks that contains the
          tunnelcrack mitigations for Windows. Otherwise it goes to 2.7.</em></li>
    </ul>
    <ul
style="color: rgb(0, 0, 0); font-family: Verdana, Arial, &quot;Bitstream Vera Sans&quot;, Helvetica, sans-serif; font-size: 13px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">
      <li><strong>Updated: DCO and Linux upstreaming, API change</strong><em><br>
        </em>Upstreaming DCO to Linux is proceeding, it is in review
        stage at the moment.<em><br>
        </em>ordex has sent in<span> </span><strong>patchset version 4</strong>.<em><br>
        </em>There will be an API change that makes it incompatible with
        the current implementation.<em><br>
        </em>A graceful solution to that was already discussed and in
        motion. giaan will be working on this.<em><br>
        </em>(in a nutshell, make OpenVPN understand old and new API,
        DKMS and kernel versions both will then use new API, then we
        drop old API)<em></em></li>
    </ul>
    <ul
style="color: rgb(0, 0, 0); font-family: Verdana, Arial, &quot;Bitstream Vera Sans&quot;, Helvetica, sans-serif; font-size: 13px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">
      <li><strong>Updated: Tunnelcrack progress<span> </span><a
            class="wiki"
href="https://community.openvpn.net/openvpn/wiki/TunnelCrack"
style="text-decoration: none; color: rgb(187, 0, 0); border-bottom: 1px dotted rgb(187, 187, 187);">TunnelCrack
            community wiki article</a></strong><br>
        <em>Status update on<span> </span><a class="wiki"
href="https://community.openvpn.net/openvpn/wiki/TunnelCrack"
style="text-decoration: none; color: rgb(187, 0, 0); border-bottom: 1px dotted rgb(187, 187, 187);">TunnelCrack</a><span> </span>mitigations:</em><br>
        <em>The tunnelcrack mitigation for Windows has gone in master,
          which will go to 2.7 release. There is the possibility for it
          to go to 2.6.x if we can find testers for this.</em><br>
        <em>Windows, openvpn2: merged to master, not to 2.6.x. openvpn3:
          in code review.</em><br>
        <em>Linux, openvpn2: in progress. openvpn3: in progress.</em><br>
        <em>macOS: to be determined.</em><br>
        <em>iOS: to be determined.</em><br>
        <em>Android: not vulnerable.</em></li>
    </ul>
    <ul
style="color: rgb(0, 0, 0); font-family: Verdana, Arial, &quot;Bitstream Vera Sans&quot;, Helvetica, sans-serif; font-size: 13px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">
      <li><strong>Updated: OpenVPN community meetup 2024</strong><br>
        <em>Wiki coordination page:<span> </span><a class="ext-link"
href="https://community.openvpn.net/openvpn/wiki/CommunityMeetup2024"
style="text-decoration: none; color: rgb(187, 0, 0); border-bottom: 1px dotted rgb(187, 187, 187);"><span
              class="icon"
style="background: url(&quot;../extlink.gif&quot;) left center no-repeat; padding-left: 15px;">​</span>https://community.openvpn.net/openvpn/wiki/CommunityMeetup2024</a></em><br>
        <em>Where: Karlsruhe, Germany. Meeting room found, need to find
          out how many participants roughly.</em><br>
        <em>When: Set to 20-22 September 2024.</em><br>
        <em>Shirts: novaflash spoke to matt - he will get us some design
          in august.</em><br>
        <em>We need to know how many participants will show. To that end
          it makes sense if we put together an invite mail and send it
          out.</em><br>
        <em>novaflash put together a suggested mail;<span> </span><a
            class="ext-link"
href="https://cryptpad.fr/pad/#/2/pad/edit/UEzTg-cbReVteh9zR9CQD-Tt/"
style="text-decoration: none; color: rgb(187, 0, 0); border-bottom: 1px dotted rgb(187, 187, 187);"><span
              class="icon"
style="background: url(&quot;../extlink.gif&quot;) left center no-repeat; padding-left: 15px;">​</span>https://cryptpad.fr/pad/#/2/pad/edit/UEzTg-cbReVteh9zR9CQD-Tt/</a></em><br>
        <em>This will be sent out as an official invite to openvpn-devel
          and to some special guests.</em></li>
    </ul>
    <p>As always you're welcome to join at #openvpn-meeting on Libera
      IRC network every Wednesday at 14:00 Central European Time.</p>
    <p>Kind regards,<br>
      Johan Draaisma<br>
    </p>
  </body>
</html>

--------------rZ05bnhD5k0RSnJcOV0vFmAl--

