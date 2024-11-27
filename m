Content-Type: multipart/alternative;
 boundary="------------P1fmAhJS7Sgtji1gJyuHomGU"
Message-ID: <6a836b82-9ae8-47d8-980d-e26896114011@...277...>
Date: Wed, 27 Nov 2024 15:00:39 +0100
MIME-Version: 1.0
From: Johan Draaisma <johandraaisma@...277...>
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
--------------P1fmAhJS7Sgtji1gJyuHomGU
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Meeting summary for 27 November 2024:

  * *New: swupdate.openvpn.net/org cleanup*
    /Basically this has become a dumping ground for just about
    everything. We're cleaning it up./
    /Need to discuss how to handle community files that are on there./
    /A priority is to ensure no interruptions to existing content/links./
    /The plan we want to propose to OpenVPN Inc. is to get all
    proprietary stuff moved off of swupdate.openvpn.net, which seems to
    already be ongoing anyhow./
    /And then keep swupdate.openvpn.net purely for community and move
    the s3 bucket to community AWS account and reduce the amount of
    caching layers to just one./
    /Will relay this plan to OpenVPN Inc. and see what they say./

  * *Updated: DCO Linux upstreaming*
    /Upstreaming DCO to Linux is proceeding, it is in review stage at
    the moment./
    /patchset v12 had 2 weeks delay, hoping to get it out this week now.
    Main reason is having to deal with someone with a lot of comments to
    make./

  * *Updated: community.openvpn.net wiki*
    /A more suitable production deployment schema for otterwiki has been
    submitted upstream. That does not block us however./
    /uddr35 has arranged a node for mattock to use and the DNS record
    for it should be ready today./
    /That means mattock will have access to a node to set things up on
    in the next few hours or so./

  * *Updated: t_server_null improvements*
    /The LWIP ping testing in t_server_null.sh is working and a PR is up./

  * *Updated: OpenVPN community meetup 2025*
    /When: september/october ish, a poll will be made soonish to gather
    people's availabilities./
    /Where: Napoli, Italy./
    /Meeting room: tbd./
    /Hotel: tbd./
    /Beer: yes./
    /T-shirts: yes./

As always you're welcome to join at #openvpn-meeting on Libera IRC 
network every Wednesday at 14:00 Central European Time.

Kind regards,
Johan Draaisma

--------------P1fmAhJS7Sgtji1gJyuHomGU
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p> Meeting summary for 27 November 2024:</p>
    <ul
style="color: rgb(0, 0, 0); font-family: Verdana, Arial, &quot;Bitstream Vera Sans&quot;, Helvetica, sans-serif; font-size: 13px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">
      <li><strong>New: swupdate.openvpn.net/org cleanup</strong><br>
        <em>Basically this has become a dumping ground for just about
          everything. We're cleaning it up.</em><br>
        <em>Need to discuss how to handle community files that are on
          there.</em><br>
        <em>A priority is to ensure no interruptions to existing
          content/links.</em><br>
        <em>The plan we want to propose to OpenVPN Inc. is to get all
          proprietary stuff moved off of swupdate.openvpn.net, which
          seems to already be ongoing anyhow.</em><br>
        <em>And then keep swupdate.openvpn.net purely for community and
          move the s3 bucket to community AWS account and reduce the
          amount of caching layers to just one.</em><br>
        <em>Will relay this plan to OpenVPN Inc. and see what they say.</em></li>
    </ul>
    <ul
style="color: rgb(0, 0, 0); font-family: Verdana, Arial, &quot;Bitstream Vera Sans&quot;, Helvetica, sans-serif; font-size: 13px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">
      <li><strong>Updated: DCO Linux upstreaming</strong><br>
        <em>Upstreaming DCO to Linux is proceeding, it is in review
          stage at the moment.</em><br>
        <em>patchset v12 had 2 weeks delay, hoping to get it out this
          week now. Main reason is having to deal with someone with a
          lot of comments to make.</em></li>
    </ul>
    <ul
style="color: rgb(0, 0, 0); font-family: Verdana, Arial, &quot;Bitstream Vera Sans&quot;, Helvetica, sans-serif; font-size: 13px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">
      <li><strong>Updated: community.openvpn.net wiki</strong><br>
        <em>A more suitable production deployment schema for otterwiki
          has been submitted upstream. That does not block us however.</em><br>
        <em>uddr35 has arranged a node for mattock to use and the DNS
          record for it should be ready today.</em><br>
        <em>That means mattock will have access to a node to set things
          up on in the next few hours or so.</em><br>
      </li>
    </ul>
    <p
style="color: rgb(0, 0, 0); font-family: Verdana, Arial, &quot;Bitstream Vera Sans&quot;, Helvetica, sans-serif; font-size: 13px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;"></p>
    <ul
style="color: rgb(0, 0, 0); font-family: Verdana, Arial, &quot;Bitstream Vera Sans&quot;, Helvetica, sans-serif; font-size: 13px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">
      <li><strong>Updated: t_server_null improvements</strong><br>
        <em>The LWIP ping testing in t_server_null.sh is working and a
          PR is up.</em><br>
      </li>
    </ul>
    <ul
style="color: rgb(0, 0, 0); font-family: Verdana, Arial, &quot;Bitstream Vera Sans&quot;, Helvetica, sans-serif; font-size: 13px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">
      <li><strong>Updated: OpenVPN community meetup 2025</strong><br>
        <em>When: september/october ish, a poll will be made soonish to
          gather people's availabilities.</em><br>
        <em>Where: Napoli, Italy.</em><br>
        <em>Meeting room: tbd.</em><br>
        <em>Hotel: tbd.</em><br>
        <em>Beer: yes.</em><br>
        <em>T-shirts: yes.</em></li>
    </ul>
    As always you're welcome to join at #openvpn-meeting on Libera IRC
    network every Wednesday at 14:00 Central European Time.
    <p>Kind regards,<br>
      Johan Draaisma<br>
    </p>
  </body>
</html>

--------------P1fmAhJS7Sgtji1gJyuHomGU--

