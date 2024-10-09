Content-Type: multipart/alternative;
 boundary="------------Qu79MxUI0Ylr8gEoMIercDip"
Message-ID: <48287498-b9c3-4f35-9bf2-66bedc4bdad5@...2751...>
Date: Wed, 9 Oct 2024 14:40:53 +0200
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
--------------Qu79MxUI0Ylr8gEoMIercDip
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Meeting summary for 9 October 2024:

  * *Updated: DCO and Linux upstreaming, API change*
    /Upstreaming DCO to Linux is proceeding, it is in review stage at
    the moment./
    /ordex is collecting feedback on*patchset version 8*. Plan is to
    send v9 after collecting feedback./
    /During meetup it was discussed that if the patchset does not make
    it into the kernel before 2.7 we should update the out-of-tree
    module to match the new API anyway. So that 2.7 supports the new API
    and we need no or minimal further changes to work with the eventual
    in-tree version./

  * *Updated: buildbot improvements*
    /djpig reports that the first arm64 architecture buildbot agent now
    works. We can add more workers as required./
    /mattock has a patch to split the mails for different project to
    different mail addresses./
    /The idea is to split openvpn3 and openvpn3-linux out so it doesn't
    go to openvpn-builds@ ML anymore./
    /Instead we could create a openvpn3-builds@ ML. djpig will look into
    that./

  * *Updated: t_server_null improvements*
    /The tests against latest git master server against older openvpn
    client versions are almost done./

As always you're welcome to join at #openvpn-meeting on Libera IRC 
network every Wednesday at 14:00 Central European Time.

Kind regards,
Johan Draaisma

--------------Qu79MxUI0Ylr8gEoMIercDip
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: 8bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p> Meeting summary for 9 October 2024:</p>
    <ul
style="color: rgb(0, 0, 0); font-family: Verdana, Arial, &quot;Bitstream Vera Sans&quot;, Helvetica, sans-serif; font-size: 13px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">
      <li><strong>Updated: DCO and Linux upstreaming, API change</strong><br>
        <em>Upstreaming DCO to Linux is proceeding, it is in review
          stage at the moment.</em><br>
        <em>ordex is collecting feedback on<span> </span><strong>patchset
            version 8</strong>. Plan is to send v9 after collecting
          feedback.</em><br>
        <em>During meetup it was discussed that if the patchset does not
          make it into the kernel before 2.7 we should update the
          out-of-tree module to match the new API anyway. So that 2.7
          supports the new API and we need no or minimal further changes
          to work with the eventual in-tree version.</em></li>
    </ul>
    <ul
style="color: rgb(0, 0, 0); font-family: Verdana, Arial, &quot;Bitstream Vera Sans&quot;, Helvetica, sans-serif; font-size: 13px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">
      <li><strong>Updated: buildbot improvements</strong><br>
        <em>djpig reports that the first arm64 architecture buildbot
          agent now works. We can add more workers as required.</em><br>
        <em>mattock has a patch to split the mails for different project
          to different mail addresses.</em><br>
        <em>The idea is to split openvpn3 and openvpn3-linux out so it
          doesn't go to openvpn-builds@ ML anymore.</em><br>
        <em>Instead we could create a openvpn3-builds@ ML. djpig will
          look into that.</em></li>
    </ul>
    <ul
style="color: rgb(0, 0, 0); font-family: Verdana, Arial, &quot;Bitstream Vera Sans&quot;, Helvetica, sans-serif; font-size: 13px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">
      <li><strong>Updated: t_server_null improvements</strong><br>
        <em>The tests against latest git master server against older
          openvpn client versions are almost done.</em></li>
    </ul>
    As always you're welcome to join at #openvpn-meeting on Libera IRC
    network every Wednesday at 14:00 Central European Time.
    <p>Kind regards,<br>
      Johan Draaisma<br>
    </p>
  </body>
</html>

--------------Qu79MxUI0Ylr8gEoMIercDip--

