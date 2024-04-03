Content-Type: multipart/alternative;
 boundary="------------kPzTG6QQ3bCD0gK5VB1oD9sv"
Message-ID: <a1d22bde-2aab-4031-9824-96d84cf3549a@...2751...>
Date: Wed, 3 Apr 2024 13:40:37 +0200
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
--------------kPzTG6QQ3bCD0gK5VB1oD9sv
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Meeting summary for 3 April 2024:

  * *New: live route update feature*
    /A client implementation will be added to OpenVPN3 core soonish./
    /Obviously we'll need a spec that can be agreed on for this feature./
    /And ideally also an openvpn2 implementation (client+server)./
    /lev will put together a spec proposal for next meeting./

  * *Updated: website release process*
    /Waiting for faster way to update community downloads and security
    advisories on main site./
    /Again postponed due to issues. Now planned for this week. We'll see./

  * *Updated: forums topics*
    /ecrist still working on forums. a DNS record for the future archive
    address will be added, rob0 is doing this./
    /Plan is to soon switch URLs so new forum is on forums.openvpn.net
    and old forums is on archive address./
    /- email confirmation on registration was suggested./
    /- we still need to work on having some other people with some admin
    or high mod access./
    /- mod guide, hard or soft delete (chuck board?), what to do with
    GDPR, etc. (write it down and actually make it available to mods,
    maybe a hidden topic)/
    /- access for mods to logs so one can see what others did/

  * *Updated: mattock topics*
    /Separated test data from code in --dev null tests./
    /Also started on debian snapshot publishing but didn't get very far
    there yet./
    /Will next look at remove sudo root requirement from --dev null
    server-side./
    /Figure out if reliability can be increased further (i.e. why did it
    fail 4 out of 500 times)./

  * *Closed: when to deprecate weak ciphers*
    /Weak ciphers like 3DES and BF-CBC - what to do with them and when?/
    /Originally it looks like it was planned to remove in 2.7 but that
    may be too soon./
    /For example OpenVPN Inc. still sees customers with 10+ year old
    installations fairly regularly./
    /A proposal to consider may be to deprecate it when crypto libraries
    deprecate it./
    /Weighing the expected complaints versus the low cost of just
    maintaining weak ciphers until crypto libraries deprecate them - the
    choice seems obvious./
    /For now we'll stick with letting weak ciphers stay in unless there
    is some convincing reason to remove it./

As always you're welcome to join at #openvpn-meeting on Libera IRC 
network every Wednesday at 13:00 Central European Time.

Kind regards,
Johan Draaisma

--------------kPzTG6QQ3bCD0gK5VB1oD9sv
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p> Meeting summary for 3 April 2024:</p>
    <ul
style="color: rgb(0, 0, 0); font-family: Verdana, Arial, &quot;Bitstream Vera Sans&quot;, Helvetica, sans-serif; font-size: 13px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">
      <li><strong>New: live route update feature</strong><br>
        <em>A client implementation will be added to OpenVPN3 core
          soonish.</em><br>
        <em>Obviously we'll need a spec that can be agreed on for this
          feature.</em><br>
        <em>And ideally also an openvpn2 implementation (client+server).</em><br>
        <em>lev will put together a spec proposal for next meeting.</em></li>
    </ul>
    <ul
style="color: rgb(0, 0, 0); font-family: Verdana, Arial, &quot;Bitstream Vera Sans&quot;, Helvetica, sans-serif; font-size: 13px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">
      <li><strong>Updated: website release process</strong><br>
        <em>Waiting for faster way to update community downloads and
          security advisories on main site.</em><br>
        <em>Again postponed due to issues. Now planned for this week.
          We'll see.</em></li>
    </ul>
    <ul
style="color: rgb(0, 0, 0); font-family: Verdana, Arial, &quot;Bitstream Vera Sans&quot;, Helvetica, sans-serif; font-size: 13px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">
      <li><strong>Updated: forums topics</strong><br>
        <em>ecrist still working on forums. a DNS record for the future
          archive address will be added, rob0 is doing this.</em><br>
        <em>Plan is to soon switch URLs so new forum is on
          forums.openvpn.net and old forums is on archive address.</em><br>
        <em>- email confirmation on registration was suggested.</em><br>
        <em>- we still need to work on having some other people with
          some admin or high mod access.</em><br>
        <em>- mod guide, hard or soft delete (chuck board?), what to do
          with GDPR, etc. (write it down and actually make it available
          to mods, maybe a hidden topic)</em><br>
        <em>- access for mods to logs so one can see what others did</em></li>
    </ul>
    <ul
style="color: rgb(0, 0, 0); font-family: Verdana, Arial, &quot;Bitstream Vera Sans&quot;, Helvetica, sans-serif; font-size: 13px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">
      <li><strong>Updated: mattock topics</strong><br>
        <em>Separated test data from code in --dev null tests.</em><br>
        <em>Also started on debian snapshot publishing but didn't get
          very far there yet.</em><br>
        <em>Will next look at remove sudo root requirement from --dev
          null server-side.</em><br>
        <em>Figure out if reliability can be increased further (i.e. why
          did it fail 4 out of 500 times).</em></li>
    </ul>
    <ul
style="color: rgb(0, 0, 0); font-family: Verdana, Arial, &quot;Bitstream Vera Sans&quot;, Helvetica, sans-serif; font-size: 13px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">
      <li><strong>Closed: when to deprecate weak ciphers</strong><br>
        <em>Weak ciphers like 3DES and BF-CBC - what to do with them and
          when?</em><br>
        <em>Originally it looks like it was planned to remove in 2.7 but
          that may be too soon.</em><br>
        <em>For example OpenVPN Inc. still sees customers with 10+ year
          old installations fairly regularly.</em><br>
        <em>A proposal to consider may be to deprecate it when crypto
          libraries deprecate it.</em><br>
        <em>Weighing the expected complaints versus the low cost of just
          maintaining weak ciphers until crypto libraries deprecate them
          - the choice seems obvious.</em><br>
        <em>For now we'll stick with letting weak ciphers stay in unless
          there is some convincing reason to remove it.</em></li>
    </ul>
    <p>As always you're welcome to join at #openvpn-meeting on Libera
      IRC network every Wednesday at 13:00 Central European Time.</p>
    <p>Kind regards,<br>
      Johan Draaisma<br>
    </p>
  </body>
</html>

--------------kPzTG6QQ3bCD0gK5VB1oD9sv--

