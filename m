Content-Type: multipart/alternative;
 boundary="------------nkEwN5EAxqBoOmMd0tLt6Cn9"
Message-ID: <68304be6-ac91-4092-a3ed-9c286da2e265@...2751...>
Date: Wed, 23 Oct 2024 19:49:04 +0200
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
--------------nkEwN5EAxqBoOmMd0tLt6Cn9
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit

Meeting summary for 23 October 2024:

  * *Updated: data format v3 / epoch data keys*
    /plaisthos has written a new draft for new key handling for the data
    channel based on discussions in Karlsruhe./
    /See​https://github.com/OpenVPN/openvpn-rfc/pull/5
    <https://github.com/OpenVPN/openvpn-rfc/pull/5>./
    /Requesting feedback from community to review./

  * *Updated: DCO and Linux upstreaming, API change*
    /Upstreaming DCO to Linux is proceeding, it is in review stage at
    the moment./
    /ordex sent in*patchset version 9*. Got some small feedback, a v10
    will be sent in this week./

  * *Updated: buildbot improvements*
    /cron2 requests that we pretty please have a mingw build in gerrit.
    djpig indicates next week should be possible./
    /mattock has a patch to split the mails for different project to
    different mail addresses. The idea is to split openvpn3 and
    openvpn3-linux out so it doesn't go to openvpn-builds@ ML anymore./
    /Instead we could create a openvpn3-builds@ ML. djpig will look into
    that./

  * *Updated: DCO windows multi-peer*
    /Getting closer - kernel side stuff seems to be getting near to
    completion. Will look at user-space part next./

  * *Updated: multi-socket patch series*
    /There were some issues building on Windows and some buildbot
    failures pointed out by djpig when merging the preparation work
    patches./
    /These will be addressed in follow-up patches that are underway now./
    /And then we'll move on to the real patch series./

  * *Updated: push_update / live route updates*
    /There were some clarification questions which resulted in the
    decision we should add a few clarifying words to the RFC./
    /Implementation for OpenVPN v2 will be looked at by ordex and his team./

As always you're welcome to join at #openvpn-meeting on Libera IRC 
network every Wednesday at 14:00 Central European Time.

Kind regards,
Johan Draaisma

--------------nkEwN5EAxqBoOmMd0tLt6Cn9
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: 8bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p> Meeting summary for 23 October 2024:</p>
    <ul
style="color: rgb(0, 0, 0); font-family: Verdana, Arial, &quot;Bitstream Vera Sans&quot;, Helvetica, sans-serif; font-size: 13px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">
      <li><strong>Updated: data format v3 / epoch data keys</strong><br>
        <em>plaisthos has written a new draft for new key handling for
          the data channel based on discussions in Karlsruhe.</em><br>
        <em>See<span> </span><a class="ext-link"
            href="https://github.com/OpenVPN/openvpn-rfc/pull/5"
style="text-decoration: none; color: rgb(187, 0, 0); border-bottom: 1px dotted rgb(187, 187, 187);"><span
              class="icon"
style="background: url(&quot;../extlink.gif&quot;) left center no-repeat; padding-left: 15px;">​</span>https://github.com/OpenVPN/openvpn-rfc/pull/5</a>.</em><br>
        <em>Requesting feedback from community to review.</em></li>
    </ul>
    <ul
style="color: rgb(0, 0, 0); font-family: Verdana, Arial, &quot;Bitstream Vera Sans&quot;, Helvetica, sans-serif; font-size: 13px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">
      <li><strong>Updated: DCO and Linux upstreaming, API change</strong><br>
        <em>Upstreaming DCO to Linux is proceeding, it is in review
          stage at the moment.</em><br>
        <em>ordex sent in<span> </span><strong>patchset version 9</strong>.
          Got some small feedback, a v10 will be sent in this week.</em></li>
    </ul>
    <ul
style="color: rgb(0, 0, 0); font-family: Verdana, Arial, &quot;Bitstream Vera Sans&quot;, Helvetica, sans-serif; font-size: 13px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">
      <li><strong>Updated: buildbot improvements</strong><br>
        <em>cron2 requests that we pretty please have a mingw build in
          gerrit. djpig indicates next week should be possible.</em><br>
        <em>mattock has a patch to split the mails for different project
          to different mail addresses. The idea is to split openvpn3 and
          openvpn3-linux out so it doesn't go to openvpn-builds@ ML
          anymore.</em><br>
        <em>Instead we could create a openvpn3-builds@ ML. djpig will
          look into that.</em></li>
    </ul>
    <ul
style="color: rgb(0, 0, 0); font-family: Verdana, Arial, &quot;Bitstream Vera Sans&quot;, Helvetica, sans-serif; font-size: 13px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">
      <li><strong>Updated: DCO windows multi-peer</strong><br>
        <em>Getting closer - kernel side stuff seems to be getting near
          to completion. Will look at user-space part next.</em></li>
    </ul>
    <ul
style="color: rgb(0, 0, 0); font-family: Verdana, Arial, &quot;Bitstream Vera Sans&quot;, Helvetica, sans-serif; font-size: 13px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">
      <li><strong>Updated: multi-socket patch series</strong><br>
        <em>There were some issues building on Windows and some buildbot
          failures pointed out by djpig when merging the preparation
          work patches.</em><br>
        <em>These will be addressed in follow-up patches that are
          underway now.</em><br>
        <em>And then we'll move on to the real patch series.</em></li>
    </ul>
    <ul
style="color: rgb(0, 0, 0); font-family: Verdana, Arial, &quot;Bitstream Vera Sans&quot;, Helvetica, sans-serif; font-size: 13px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">
      <li><strong>Updated: push_update / live route updates</strong><br>
        <em>There were some clarification questions which resulted in
          the decision we should add a few clarifying words to the RFC.</em><br>
        <em>Implementation for OpenVPN v2 will be looked at by ordex and
          his team.</em></li>
    </ul>
    As always you're welcome to join at #openvpn-meeting on Libera IRC
    network every Wednesday at 14:00 Central European Time.
    <p>Kind regards,<br>
      Johan Draaisma<br>
    </p>
  </body>
</html>

--------------nkEwN5EAxqBoOmMd0tLt6Cn9--

