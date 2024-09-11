Content-Type: multipart/alternative;
 boundary="------------ssDWrICxGCcUNyk6KHKX5pvE"
Message-ID: <2d410289-a911-49b5-a0df-f966f405600e@...2751...>
Date: Wed, 11 Sep 2024 14:54:56 +0200
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
--------------ssDWrICxGCcUNyk6KHKX5pvE
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit

Meeting summary for 11 September 2024:

  * *Updated: OpenVPN community meetup 2024*
    /Hotel recommendation added; Hotel Santo in Karlsruhe./
    /Wiki coordination
    page:​https://community.openvpn.net/openvpn/wiki/CommunityMeetup2024
    <https://community.openvpn.net/openvpn/wiki/CommunityMeetup2024>/
    /Where: Karlsruhe, Germany.SteamWork?
    <https://community.openvpn.net/openvpn/wiki/SteamWork>, Karlsruhe./
    /When: Set to 20-22 September 2024./
    /Shirts: T-shirts are on their way, expected to arrive this week./

  * *Updated: community.openvpn.net trac wiki*
    /mattock is working on getting otterwiki working in a reasonable
    production configuration./
    /Hit a bug in otterwiki, reported it, it got fixed, moving on.../
    /Basically working on setting up postgresql, separating uwsgi. After
    that, let's see if we can copy content./

  * *Updated: DCO and Linux upstreaming, API change*/
    /Upstreaming DCO to Linux is proceeding, it is in review stage at
    the moment./
    /ordex has sent in*patchset version 6*. and v7 is on the way./
    /There will be an API change that makes it incompatible with the
    current implementation./
    /

  * *Closed: Linux arm64 buildbot workers*
    /mattock almost finished the work on this - a small fix that djpig
    requested is pending, but it's all working now./

  * *Closed: fixing openvpn3-linux builds in Buildbot*
    /Mattock has this almost working. Some platforms will have to be
    skipped because openvpn3-linux / gdbuspp dependencies (Meson in
    particular) are too old or missing./
    /As an aside, OpenVPN3 Linux v22 dev for Ubuntu 24.04 LTS and Fedora
    39 and 40 are in the release process./
    /Next step is a 'regular' OpenVPN3 Linux v23 release again./

People that are paying close attention might have noticed that in the 
past few weeks there were no meeting summaries. This was because of a 
bit of summer vacation hiatus, which should be over now.

As always you're welcome to join at #openvpn-meeting on Libera IRC 
network every Wednesday at 14:00 Central European Time.

Kind regards,
Johan Draaisma

--------------ssDWrICxGCcUNyk6KHKX5pvE
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: 8bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p> Meeting summary for 11 September 2024:</p>
    <ul
style="color: rgb(0, 0, 0); font-family: Verdana, Arial, &quot;Bitstream Vera Sans&quot;, Helvetica, sans-serif; font-size: 13px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">
      <li><strong>Updated: OpenVPN community meetup 2024</strong><br>
        <em>Hotel recommendation added; Hotel Santo in Karlsruhe.</em><br>
        <em>Wiki coordination page:<span> </span><a class="ext-link"
href="https://community.openvpn.net/openvpn/wiki/CommunityMeetup2024"
style="text-decoration: none; color: rgb(187, 0, 0); border-bottom: 1px dotted rgb(187, 187, 187);"><span
              class="icon"
style="background: url(&quot;../extlink.gif&quot;) left center no-repeat; padding-left: 15px;">​</span>https://community.openvpn.net/openvpn/wiki/CommunityMeetup2024</a></em><br>
        <em>Where: Karlsruhe, Germany.<span> </span><a
            class="missing wiki"
            href="https://community.openvpn.net/openvpn/wiki/SteamWork"
            rel="nofollow"
style="text-decoration: none; color: rgb(153, 153, 136); border-bottom: 1px dotted rgb(187, 187, 187);">SteamWork?</a>,
          Karlsruhe.</em><br>
        <em>When: Set to 20-22 September 2024.</em><br>
        <em>Shirts: T-shirts are on their way, expected to arrive this
          week.</em><br>
      </li>
    </ul>
    <p
style="color: rgb(0, 0, 0); font-family: Verdana, Arial, &quot;Bitstream Vera Sans&quot;, Helvetica, sans-serif; font-size: 13px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;"></p>
    <ul
style="color: rgb(0, 0, 0); font-family: Verdana, Arial, &quot;Bitstream Vera Sans&quot;, Helvetica, sans-serif; font-size: 13px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">
      <li><strong>Updated: community.openvpn.net trac wiki</strong><br>
        <em>mattock is working on getting otterwiki working in a
          reasonable production configuration.</em><br>
        <em>Hit a bug in otterwiki, reported it, it got fixed, moving
          on...</em><br>
        <em>Basically working on setting up postgresql, separating
          uwsgi. After that, let's see if we can copy content.</em><br>
      </li>
    </ul>
    <ul
style="color: rgb(0, 0, 0); font-family: Verdana, Arial, &quot;Bitstream Vera Sans&quot;, Helvetica, sans-serif; font-size: 13px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">
      <li><strong>Updated: DCO and Linux upstreaming, API change</strong><em><br>
        </em>Upstreaming DCO to Linux is proceeding, it is in review
        stage at the moment.<em><br>
        </em>ordex has sent in<span> </span><strong>patchset version 6</strong>.
        and v7 is on the way.<em><br>
        </em>There will be an API change that makes it incompatible with
        the current implementation.<em><br>
        </em></li>
    </ul>
    <ul
style="color: rgb(0, 0, 0); font-family: Verdana, Arial, &quot;Bitstream Vera Sans&quot;, Helvetica, sans-serif; font-size: 13px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">
      <li><strong>Closed: Linux arm64 buildbot workers</strong><br>
        <em>mattock almost finished the work on this - a small fix that
          djpig requested is pending, but it's all working now.</em><br>
      </li>
    </ul>
    <ul
style="color: rgb(0, 0, 0); font-family: Verdana, Arial, &quot;Bitstream Vera Sans&quot;, Helvetica, sans-serif; font-size: 13px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">
      <li><strong>Closed: fixing openvpn3-linux builds in Buildbot</strong><br>
        <em>Mattock has this almost working. Some platforms will have to
          be skipped because openvpn3-linux / gdbuspp dependencies
          (Meson in particular) are too old or missing.</em><br>
        <em>As an aside, OpenVPN3 Linux v22 dev for Ubuntu 24.04 LTS and
          Fedora 39 and 40 are in the release process.</em><br>
        <em>Next step is a 'regular' OpenVPN3 Linux v23 release again.</em></li>
    </ul>
    <p>People that are paying close attention might have noticed that in
      the past few weeks there were no meeting summaries. This was
      because of a bit of summer vacation hiatus, which should be over
      now.<br>
    </p>
    <p>As always you're welcome to join at #openvpn-meeting on Libera
      IRC network every Wednesday at 14:00 Central European Time.</p>
    <p>Kind regards,<br>
      Johan Draaisma<br>
    </p>
  </body>
</html>

--------------ssDWrICxGCcUNyk6KHKX5pvE--

