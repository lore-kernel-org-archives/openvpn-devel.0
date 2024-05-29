Content-Type: multipart/alternative;
 boundary="------------peWpXyVIil4JqiTgjPb4AHk1"
Message-ID: <2afea509-545b-452c-93cd-e14da896b2d3@...2751...>
Date: Wed, 29 May 2024 14:35:35 +0200
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
--------------peWpXyVIil4JqiTgjPb4AHk1
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit

Meeting summary for 29 May 2024:

  * *Closed: DCO-win update needed*
    /There was a responsible disclosure report made regarding DCO
    windows driver./
    /This was fixed and released in the I003 Windows installer release
    for 2.6.10./

  * *Updated: community.openvpn.net trac wiki*
    /There was some downtime here and after looking into it, the
    conclusion is that the software is out-of-date and needs love./
    /We were already planning to migrate to another wiki solution, so
    this has provided an impetus to accelerate this./
    /mattock will look into putting a PoC of wiki.js and outline after
    debian/ubuntu snapshot task is done./

  * *Updated: release openvpn 2.6.11*
    /Waiting to complete review/merge process of Windows tunnelcrack
    mitigations./
    /For the proposed Linux tunnelcrack mitigations, going for policy
    routing and such, it may need to go to 2.7 and it's quite a big change./
    /There's an item reported by reynir that we'll likely want to get
    into this release as well./

  * *Updated: OpenVPN community meetup 2024*
    /There's a wiki page up now where we can
    coordinate:​https://community.openvpn.net/openvpn/wiki/CommunityMeetup2024
    <https://community.openvpn.net/openvpn/wiki/CommunityMeetup2024>/
    /We're basically at the point where we can prepare a mailing and
    send out invites to people./
    /Where: Karlsruhe, Germany. Exact details of meeting room to be
    determined./
    /When: Set to 20-22 September 2024./
    /Shirts: novaflash will talk to matt about this./

  * *Updated: mattock topics*
    /There is code waiting for review/merging but one of the reviewers
    is on vacation./
    /Will in the meantime tackle the community.openvpn.net / wiki topic./
    /Wrapping up debian/ubuntu snapshot building. It already works but
    wants to clean things up and make a PR./

As always you're welcome to join at #openvpn-meeting on Libera IRC 
network every Wednesday at 14:00 Central European Time.

Kind regards,
Johan Draaisma

--------------peWpXyVIil4JqiTgjPb4AHk1
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: 8bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p> Meeting summary for 29 May 2024:</p>
    <ul
style="color: rgb(0, 0, 0); font-family: Verdana, Arial, &quot;Bitstream Vera Sans&quot;, Helvetica, sans-serif; font-size: 13px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">
      <li><strong>Closed: DCO-win update needed</strong><br>
        <em>There was a responsible disclosure report made regarding DCO
          windows driver.</em><br>
        <em>This was fixed and released in the I003 Windows installer
          release for 2.6.10.</em></li>
    </ul>
    <ul
style="color: rgb(0, 0, 0); font-family: Verdana, Arial, &quot;Bitstream Vera Sans&quot;, Helvetica, sans-serif; font-size: 13px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">
      <li><strong>Updated: community.openvpn.net trac wiki</strong><br>
        <em>There was some downtime here and after looking into it, the
          conclusion is that the software is out-of-date and needs love.</em><br>
        <em>We were already planning to migrate to another wiki
          solution, so this has provided an impetus to accelerate this.</em><br>
        <em>mattock will look into putting a PoC of wiki.js and outline
          after debian/ubuntu snapshot task is done.</em></li>
    </ul>
    <ul
style="color: rgb(0, 0, 0); font-family: Verdana, Arial, &quot;Bitstream Vera Sans&quot;, Helvetica, sans-serif; font-size: 13px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">
      <li><strong>Updated: release openvpn 2.6.11</strong><br>
        <em>Waiting to complete review/merge process of Windows
          tunnelcrack mitigations.</em><br>
        <em>For the proposed Linux tunnelcrack mitigations, going for
          policy routing and such, it may need to go to 2.7 and it's
          quite a big change.</em><br>
        <em>There's an item reported by reynir that we'll likely want to
          get into this release as well.</em></li>
    </ul>
    <ul
style="color: rgb(0, 0, 0); font-family: Verdana, Arial, &quot;Bitstream Vera Sans&quot;, Helvetica, sans-serif; font-size: 13px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">
      <li><strong>Updated: OpenVPN community meetup 2024</strong><br>
        <em>There's a wiki page up now where we can coordinate:<span> </span><a
            class="ext-link"
href="https://community.openvpn.net/openvpn/wiki/CommunityMeetup2024"
style="text-decoration: none; color: rgb(187, 0, 0); border-bottom: 1px dotted rgb(187, 187, 187);"><span
              class="icon"
style="background: url(&quot;../extlink.gif&quot;) left center no-repeat; padding-left: 15px;">​</span>https://community.openvpn.net/openvpn/wiki/CommunityMeetup2024</a></em><br>
        <em>We're basically at the point where we can prepare a mailing
          and send out invites to people.</em><br>
        <em>Where: Karlsruhe, Germany. Exact details of meeting room to
          be determined.</em><br>
        <em>When: Set to 20-22 September 2024.</em><br>
        <em>Shirts: novaflash will talk to matt about this.</em></li>
    </ul>
    <ul
style="color: rgb(0, 0, 0); font-family: Verdana, Arial, &quot;Bitstream Vera Sans&quot;, Helvetica, sans-serif; font-size: 13px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">
      <li><strong>Updated: mattock topics</strong><br>
        <em>There is code waiting for review/merging but one of the
          reviewers is on vacation.</em><br>
        <em>Will in the meantime tackle the community.openvpn.net / wiki
          topic.</em><br>
        <em>Wrapping up debian/ubuntu snapshot building. It already
          works but wants to clean things up and make a PR.</em></li>
    </ul>
    <p>As always you're welcome to join at #openvpn-meeting on Libera
      IRC network every Wednesday at 14:00 Central European Time.</p>
    <p>Kind regards,<br>
      Johan Draaisma<br>
    </p>
  </body>
</html>

--------------peWpXyVIil4JqiTgjPb4AHk1--

