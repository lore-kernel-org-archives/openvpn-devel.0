Content-Type: multipart/alternative;
 boundary="------------09HNJj6dakWYfrOMrYkNS90o"
Message-ID: <f32d4b12-6e26-46f5-8e4d-5f10af10597a@...2751...>
Date: Wed, 5 Jun 2024 14:56:18 +0200
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
--------------09HNJj6dakWYfrOMrYkNS90o
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Meeting summary for 5 June 2024:

  * *New, closed: no community meeting on 12 June 2024*
    /Due to an event that a large amount of people will attend, this
    particular day will be inconvenient to do a meeting./
    /Meetings will resume the week after on 19 June 2024./

  * *Updated: Buildbot and t_server null*
    /Builds were failing because worker containers have not been rebuilt./
    /This issue was resolved between mattock and djpig./

  * *Updated: community.openvpn.net trac wiki*
    /It turned out that outline is not really open source, it has BSL
    1.1 license. Not suitable for us./
    /Wiki.js still seems at the moment the direction we want to go. To
    be sure leoossa will present some workflows to test./
    /Based on the results of those tests we can then see where the
    limitations of wiki.js are, and then we can see if those are
    dealbreakers or not./

  * *Updated: release openvpn 2.6.11*
    /Waiting to complete review/merge process of Windows tunnelcrack
    mitigations./
    /Waiting to complete review/merge process of item reported by reynir./
    /Once those items are in we'll prepare for a release, tentatively in
    2 weeks from now./

  * *Updated: DCO and Linux upstreaming, API change*/
    //Upstreaming DCO to Linux is proceeding, it is in review stage at
    the moment.
    ordex will send a *patchset v4* based on feedback received over the
    past days.
    There will be an API change that makes it incompatible with the
    current implementation.
    A graceful solution to that was already discussed and in motion.
    giaan will be working on this.
    (in a nutshell, make OpenVPN understand old and new API, DKMS and
    kernel versions both will then use new API, then we drop old API)/

As always you're welcome to join at #openvpn-meeting on Libera IRC 
network every Wednesday at 14:00 Central European Time.

Kind regards,
Johan Draaisma

--------------09HNJj6dakWYfrOMrYkNS90o
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p> Meeting summary for 5 June 2024:</p>
    <ul
style="color: rgb(0, 0, 0); font-family: Verdana, Arial, &quot;Bitstream Vera Sans&quot;, Helvetica, sans-serif; font-size: 13px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">
      <li><strong>New, closed: no community meeting on 12 June 2024</strong><br>
        <em>Due to an event that a large amount of people will attend,
          this particular day will be inconvenient to do a meeting.</em><br>
        <em>Meetings will resume the week after on 19 June 2024.</em></li>
    </ul>
    <ul
style="color: rgb(0, 0, 0); font-family: Verdana, Arial, &quot;Bitstream Vera Sans&quot;, Helvetica, sans-serif; font-size: 13px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">
      <li><strong>Updated: Buildbot and t_server null</strong><br>
        <em>Builds were failing because worker containers have not been
          rebuilt.</em><br>
        <em>This issue was resolved between mattock and djpig.</em></li>
    </ul>
    <ul
style="color: rgb(0, 0, 0); font-family: Verdana, Arial, &quot;Bitstream Vera Sans&quot;, Helvetica, sans-serif; font-size: 13px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">
      <li><strong>Updated: community.openvpn.net trac wiki</strong><br>
        <em>It turned out that outline is not really open source, it has
          BSL 1.1 license. Not suitable for us.</em><br>
        <em>Wiki.js still seems at the moment the direction we want to
          go. To be sure leoossa will present some workflows to test.</em><br>
        <em>Based on the results of those tests we can then see where
          the limitations of wiki.js are, and then we can see if those
          are dealbreakers or not.</em></li>
    </ul>
    <ul
style="color: rgb(0, 0, 0); font-family: Verdana, Arial, &quot;Bitstream Vera Sans&quot;, Helvetica, sans-serif; font-size: 13px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">
      <li><strong>Updated: release openvpn 2.6.11</strong><br>
        <em>Waiting to complete review/merge process of Windows
          tunnelcrack mitigations.</em><br>
        <em>Waiting to complete review/merge process of item reported by
          reynir.</em><br>
        <em>Once those items are in we'll prepare for a release,
          tentatively in 2 weeks from now.</em></li>
    </ul>
    <ul
style="color: rgb(0, 0, 0); font-family: Verdana, Arial, &quot;Bitstream Vera Sans&quot;, Helvetica, sans-serif; font-size: 13px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">
      <li><strong>Updated: DCO and Linux upstreaming, API change</strong><em><br>
        </em><i>Upstreaming DCO to Linux is proceeding, it is in review
          stage at the moment.<br>
          ordex will send a <b>patchset v4</b> based on feedback
          received over the past days.<br>
          There will be an API change that makes it incompatible with
          the current implementation.<br>
          A graceful solution to that was already discussed and in
          motion. giaan will be working on this.<br>
          (in a nutshell, make OpenVPN understand old and new API, DKMS
          and kernel versions both will then use new API, then we drop
          old API)</i></li>
    </ul>
    <p>As always you're welcome to join at #openvpn-meeting on Libera
      IRC network every Wednesday at 14:00 Central European Time.</p>
    <p>Kind regards,<br>
      Johan Draaisma<br>
    </p>
  </body>
</html>

--------------09HNJj6dakWYfrOMrYkNS90o--

