Content-Type: multipart/alternative;
 boundary="------------PVsMR0NkR0C0NNj0HoQK400v"
Message-ID: <bb557c20-7bca-4b58-a6e9-67c31a419ec9@...2751...>
Date: Wed, 8 May 2024 14:00:23 +0200
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
--------------PVsMR0NkR0C0NNj0HoQK400v
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Meeting summary for 8 May 2024:

  * *Closed: Discussion related to DNS IV flag*
    /This was done with a IV_PROTO_DNS_OPTION_V2 proto flag./

  * *New, closed:TunnelVision
    <https://community.openvpn.net/openvpn/wiki/TunnelVision>vulnerability.*/
    /This looks to be basically the same as theTunnelCrack
    <https://community.openvpn.net/openvpn/wiki/TunnelCrack>vulnerability./
    /Mitigations forTunnelCrack
    <https://community.openvpn.net/openvpn/wiki/TunnelCrack>are underway
    but take time to deliver as the implementation is different on each
    platform./
    /What we'll do is add a wiki article forTunnelVision
    <https://community.openvpn.net/openvpn/wiki/TunnelVision>that
    redirects toTunnelCrack
    <https://community.openvpn.net/openvpn/wiki/TunnelCrack>statement
    already present on our wiki./
    /We'll add a section there specific to theTunnelVision
    <https://community.openvpn.net/openvpn/wiki/TunnelVision>aspect of
    this.//

  * *Updated: Tunnelcrack progressTunnelCrack community wiki article
    <https://community.openvpn.net/openvpn/wiki/TunnelCrack>*
    /Status update onTunnelCrack
    <https://community.openvpn.net/openvpn/wiki/TunnelCrack>mitigations:/
    /Windows, openvpn2: ready to merge. openvpn3: in code review./
    /Linux, openvpn2: in progress. openvpn3: in progress./
    /macOS: to be determined./
    /iOS: to be determined./
    /Android: not vulnerable./

  * *New:BlackHat?
    <https://community.openvpn.net/openvpn/wiki/BlackHat>announcement
    regarding 'OVPNX'.*/BlackHat?
    <https://community.openvpn.net/openvpn/wiki/BlackHat>announced a
    presentation about OVPNX vulnerabilities that lead to privilege
    escalation./
    /This is by the same guy, Vladimir Tokarev, that reported these
    issues to us that we then solved./
    /The problem is they are announcing it as zero-day vulnerabilities,
    which is simply not true./
    /These were responsibly disclosed and in cooperation were fixed and
    published with the OpenVPN 2.6.10 and 2.5.10 releases./
    /We did reach out to clarify things but haven't had a response yet./
    /A security advisory and a blog post will be posted in the next day
    or so on the main website, and it will be added to the company
    newsletter as well./
    /These will set the record straight that it's not zero-day, and
    furthermore point out that this is not that critical of an issue as
    you need privileges anyways to exploit it./
    /Also this only affects OpenVPN2 GUI on Windows./

  * *Updated: forums topics*
    /rob0 and novaflash volunteered to take a look at the web server
    config to make it work correctly./
    /However due to other ongoing things, didn't have time yet, but will
    be able to spend time on it soonish./
    /Plan is to soon switch URLs so new forum is on forums.openvpn.net
    and old forums is on archive address./
    /- email confirmation on registration was suggested./
    /- mod permissions, guide, hard or soft delete (chuck board?), what
    to do with GDPR, etc. (write it down and actually make it available
    to mods, maybe a hidden topic)/
    /- access for mods to logs so one can see what others did/

  * *Updated: mattock topics*
    /PR created to add t_server_null tests to buildbot./
    /There's a parallelism issue to fix between t_server_null.sh and
    t_client.sh - will work on that./

As always you're welcome to join at #openvpn-meeting on Libera IRC 
network every Wednesday at 13:00 Central European Time.

Kind regards,
Johan Draaisma

--------------PVsMR0NkR0C0NNj0HoQK400v
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: 8bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p> Meeting summary for 8 May 2024:</p>
    <ul
style="color: rgb(0, 0, 0); font-family: Verdana, Arial, &quot;Bitstream Vera Sans&quot;, Helvetica, sans-serif; font-size: 13px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">
      <li><strong>Closed: Discussion related to DNS IV flag</strong><br>
        <em>This was done with a IV_PROTO_DNS_OPTION_V2 proto flag.</em></li>
    </ul>
    <ul
style="color: rgb(0, 0, 0); font-family: Verdana, Arial, &quot;Bitstream Vera Sans&quot;, Helvetica, sans-serif; font-size: 13px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">
      <li><strong>New, closed:<span> </span><a class="wiki"
href="https://community.openvpn.net/openvpn/wiki/TunnelVision"
style="text-decoration: none; color: rgb(187, 0, 0); border-bottom: 1px dotted rgb(187, 187, 187);">TunnelVision</a><span> </span>vulnerability.</strong><em><br>
        </em>This looks to be basically the same as the<span> </span><a
          class="wiki"
          href="https://community.openvpn.net/openvpn/wiki/TunnelCrack"
style="text-decoration: none; color: rgb(187, 0, 0); border-bottom: 1px dotted rgb(187, 187, 187);">TunnelCrack</a><span> </span>vulnerability.<em><br>
        </em>Mitigations for<span> </span><a class="wiki"
          href="https://community.openvpn.net/openvpn/wiki/TunnelCrack"
style="text-decoration: none; color: rgb(187, 0, 0); border-bottom: 1px dotted rgb(187, 187, 187);">TunnelCrack</a><span> </span>are
        underway but take time to deliver as the implementation is
        different on each platform.<em><br>
        </em>What we'll do is add a wiki article for<span> </span><a
          class="wiki"
          href="https://community.openvpn.net/openvpn/wiki/TunnelVision"
style="text-decoration: none; color: rgb(187, 0, 0); border-bottom: 1px dotted rgb(187, 187, 187);">TunnelVision</a><span> </span>that
        redirects to<span> </span><a class="wiki"
          href="https://community.openvpn.net/openvpn/wiki/TunnelCrack"
style="text-decoration: none; color: rgb(187, 0, 0); border-bottom: 1px dotted rgb(187, 187, 187);">TunnelCrack</a><span> </span>statement
        already present on our wiki.<em><br>
        </em>We'll add a section there specific to the<span> </span><a
          class="wiki"
          href="https://community.openvpn.net/openvpn/wiki/TunnelVision"
style="text-decoration: none; color: rgb(187, 0, 0); border-bottom: 1px dotted rgb(187, 187, 187);">TunnelVision</a><span> </span>aspect
        of this.<em></em></li>
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
        <em>Windows, openvpn2: ready to merge. openvpn3: in code review.</em><br>
        <em>Linux, openvpn2: in progress. openvpn3: in progress.</em><br>
        <em>macOS: to be determined.</em><br>
        <em>iOS: to be determined.</em><br>
        <em>Android: not vulnerable.</em></li>
    </ul>
    <ul
style="color: rgb(0, 0, 0); font-family: Verdana, Arial, &quot;Bitstream Vera Sans&quot;, Helvetica, sans-serif; font-size: 13px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">
      <li><strong>New:<span> </span><a class="missing wiki"
            href="https://community.openvpn.net/openvpn/wiki/BlackHat"
            rel="nofollow"
style="text-decoration: none; color: rgb(153, 153, 136); border-bottom: 1px dotted rgb(187, 187, 187);">BlackHat?</a><span> </span>announcement
          regarding 'OVPNX'.</strong><span> </span><em><a
            class="missing wiki"
            href="https://community.openvpn.net/openvpn/wiki/BlackHat"
            rel="nofollow"
style="text-decoration: none; color: rgb(153, 153, 136); border-bottom: 1px dotted rgb(187, 187, 187);">BlackHat?</a><span> </span>announced
          a presentation about OVPNX vulnerabilities that lead to
          privilege escalation.</em><br>
        <em>This is by the same guy, Vladimir Tokarev, that reported
          these issues to us that we then solved.</em><br>
        <em>The problem is they are announcing it as zero-day
          vulnerabilities, which is simply not true.</em><br>
        <em>These were responsibly disclosed and in cooperation were
          fixed and published with the OpenVPN 2.6.10 and 2.5.10
          releases.</em><br>
        <em>We did reach out to clarify things but haven't had a
          response yet.</em><br>
        <em>A security advisory and a blog post will be posted in the
          next day or so on the main website, and it will be added to
          the company newsletter as well.</em><br>
        <em>These will set the record straight that it's not zero-day,
          and furthermore point out that this is not that critical of an
          issue as you need privileges anyways to exploit it.</em><br>
        <em>Also this only affects OpenVPN2 GUI on Windows.</em></li>
    </ul>
    <ul
style="color: rgb(0, 0, 0); font-family: Verdana, Arial, &quot;Bitstream Vera Sans&quot;, Helvetica, sans-serif; font-size: 13px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">
      <li><strong>Updated: forums topics</strong><br>
        <em>rob0 and novaflash volunteered to take a look at the web
          server config to make it work correctly.</em><br>
        <em>However due to other ongoing things, didn't have time yet,
          but will be able to spend time on it soonish.</em><br>
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
        <em>PR created to add t_server_null tests to buildbot.</em><br>
        <em>There's a parallelism issue to fix between t_server_null.sh
          and t_client.sh - will work on that.</em></li>
    </ul>
    <p>As always you're welcome to join at #openvpn-meeting on Libera
      IRC network every Wednesday at 13:00 Central European Time.</p>
    <p>Kind regards,<br>
      Johan Draaisma<br>
    </p>
  </body>
</html>

--------------PVsMR0NkR0C0NNj0HoQK400v--

