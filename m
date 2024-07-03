Content-Type: multipart/alternative;
 boundary="------------tKBGA0Un9GWgLlJI0OC56oer"
Message-ID: <5a9b2e9f-cffc-40d3-bddc-89f4b086d134@...2751...>
Date: Wed, 3 Jul 2024 16:38:39 +0200
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
--------------tKBGA0Un9GWgLlJI0OC56oer
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit

Meeting summary for 3 July 2024:

  * *Updated, closed: release openvpn 2.6.11*
    /The original release was done on June 20th. A Windows installer
    update was done last week to solve an issue with localization and
    custom installation path (I002)./

  * *Updated: forums topics*
    /novaflash finally has time to look into this topic. But has no
    access. Who can get novaflash access?/
    /looks like mattock, djpig or uddr35 - will poke uddr35 about this./

  * *Updated: buildbot PRs need attention*
    /2 out of 3 PRs got merged, 3rd one is still up/
    ​Add smoketest builds for openvpn3, openvpn3-linux and ovpn-dco
    <https://github.com/OpenVPN/openvpn-buildbot/pull/51>

  * *Updated: DCO and Linux upstreaming, API change*/
    /Upstreaming DCO to Linux is proceeding, it is in review stage at
    the moment./
    /ordex has sent in*patchset version 5*./
    /There will be an API change that makes it incompatible with the
    current implementation./
    /A graceful solution to that was already discussed and in motion.
    giaan will be working on this./
    /(in a nutshell, make OpenVPN understand old and new API, DKMS and
    kernel versions both will then use new API, then we drop old API)//

  * *Updated: OpenVPN community meetup 2024*
    /Invitation was sent, waiting to gather responses./
    /Perhaps we can do a guesstimate on number of people expected./
    /Wiki coordination
    page:​https://community.openvpn.net/openvpn/wiki/CommunityMeetup2024
    <https://community.openvpn.net/openvpn/wiki/CommunityMeetup2024>/
    /Where: Karlsruhe, Germany. Meeting room found, need to find out how
    many participants roughly./
    /When: Set to 20-22 September 2024./
    /Shirts: novaflash spoke to matt - he will get us some design in
    august./

  * *Updated: community.openvpn.net trac wiki*
    /We keep running into stupid limitations and bad suckiness with wiki
    solutions./
    /So we're going back to requirements and lining up
    candidates:​https://community.openvpn.net/openvpn/wiki/NewWiki
    <https://community.openvpn.net/openvpn/wiki/NewWiki>/

As always you're welcome to join at #openvpn-meeting on Libera IRC 
network every Wednesday at 14:00 Central European Time.

Kind regards,
Johan Draaisma

--------------tKBGA0Un9GWgLlJI0OC56oer
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: 8bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p> Meeting summary for 3 July 2024:</p>
    <ul
style="color: rgb(0, 0, 0); font-family: Verdana, Arial, &quot;Bitstream Vera Sans&quot;, Helvetica, sans-serif; font-size: 13px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">
      <li><strong>Updated, closed: release openvpn 2.6.11</strong><br>
        <em>The original release was done on June 20th. A Windows
          installer update was done last week to solve an issue with
          localization and custom installation path (I002).</em></li>
    </ul>
    <ul
style="color: rgb(0, 0, 0); font-family: Verdana, Arial, &quot;Bitstream Vera Sans&quot;, Helvetica, sans-serif; font-size: 13px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">
      <li><strong>Updated: forums topics</strong><br>
        <em>novaflash finally has time to look into this topic. But has
          no access. Who can get novaflash access?</em><br>
        <em>looks like mattock, djpig or uddr35 - will poke uddr35 about
          this.</em></li>
    </ul>
    <ul
style="color: rgb(0, 0, 0); font-family: Verdana, Arial, &quot;Bitstream Vera Sans&quot;, Helvetica, sans-serif; font-size: 13px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">
      <li><strong>Updated: buildbot PRs need attention</strong><br>
        <em>2 out of 3 PRs got merged, 3rd one is still up</em><br>
        <a class="ext-link"
          href="https://github.com/OpenVPN/openvpn-buildbot/pull/51"
style="text-decoration: none; color: rgb(187, 0, 0); border-bottom: 1px dotted rgb(187, 187, 187);"><span
            class="icon"
style="background: url(&quot;../extlink.gif&quot;) left center no-repeat; padding-left: 15px;">​</span>Add
          smoketest builds for openvpn3, openvpn3-linux and ovpn-dco</a></li>
    </ul>
    <ul
style="color: rgb(0, 0, 0); font-family: Verdana, Arial, &quot;Bitstream Vera Sans&quot;, Helvetica, sans-serif; font-size: 13px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">
      <li><strong>Updated: DCO and Linux upstreaming, API change</strong><em><br>
        </em>Upstreaming DCO to Linux is proceeding, it is in review
        stage at the moment.<em><br>
        </em>ordex has sent in<span> </span><strong>patchset version 5</strong>.<em><br>
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
      <li><strong>Updated: OpenVPN community meetup 2024</strong><br>
        <em>Invitation was sent, waiting to gather responses.</em><br>
        <em>Perhaps we can do a guesstimate on number of people
          expected.</em><br>
        <em>Wiki coordination page:<span> </span><a class="ext-link"
href="https://community.openvpn.net/openvpn/wiki/CommunityMeetup2024"
style="text-decoration: none; color: rgb(187, 0, 0); border-bottom: 1px dotted rgb(187, 187, 187);"><span
              class="icon"
style="background: url(&quot;../extlink.gif&quot;) left center no-repeat; padding-left: 15px;">​</span>https://community.openvpn.net/openvpn/wiki/CommunityMeetup2024</a></em><br>
        <em>Where: Karlsruhe, Germany. Meeting room found, need to find
          out how many participants roughly.</em><br>
        <em>When: Set to 20-22 September 2024.</em><br>
        <em>Shirts: novaflash spoke to matt - he will get us some design
          in august.</em></li>
    </ul>
    <ul
style="color: rgb(0, 0, 0); font-family: Verdana, Arial, &quot;Bitstream Vera Sans&quot;, Helvetica, sans-serif; font-size: 13px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">
      <li><strong>Updated: community.openvpn.net trac wiki</strong><br>
        <em>We keep running into stupid limitations and bad suckiness
          with wiki solutions.</em><br>
        <em>So we're going back to requirements and lining up
          candidates:<span> </span><a class="ext-link"
            href="https://community.openvpn.net/openvpn/wiki/NewWiki"
style="text-decoration: none; color: rgb(187, 0, 0); border-bottom: 1px dotted rgb(187, 187, 187);"><span
              class="icon"
style="background: url(&quot;../extlink.gif&quot;) left center no-repeat; padding-left: 15px;">​</span>https://community.openvpn.net/openvpn/wiki/NewWiki</a></em></li>
    </ul>
    <p>As always you're welcome to join at #openvpn-meeting on Libera
      IRC network every Wednesday at 14:00 Central European Time.</p>
    <p>Kind regards,<br>
      Johan Draaisma<br>
    </p>
  </body>
</html>

--------------tKBGA0Un9GWgLlJI0OC56oer--

