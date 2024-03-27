Content-Type: multipart/alternative;
 boundary="------------Keu4jxD0j091Js6ayT0ml6T0"
Message-ID: <5f1f5c73-379b-49a0-bdbb-f955b01551e4@...2751...>
Date: Wed, 27 Mar 2024 13:59:02 +0100
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
--------------Keu4jxD0j091Js6ayT0ml6T0
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit

Meeting summary for 27 March 2024:

  * *New: when to deprecate weak ciphers*
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

  * *Closed: OpenVPN 2.6.10 release*
    /This was released 20th of March./

  * *Closed: OpenVPN 2.5.10 release*
    /This was released 21st of March, including new Windows installers./

  * *Closed: community funding initiative*
    /ordex convinced OTF (Open Tech Fund) to let OpenVPN join the "FOSS
    sustainability funding pilot run"./
    /This allows to pay for allocated hours for mattock and cron2 to
    work on OpenVPN community tasks./
    /Some ongoing tasks are listed under 'Mattock Topics' in the meeting
    notes and have already been going on for a while./
    /This topic is therefore considered closed for now./

  * *Closed: inactive setting data counter in openvpn2 and openvpn3*
    /It looks like openvpn2 and openvpn3 handle the counting of traffic
    for this differently./
    /After some discussion it was decided illia will submit some
    suggested fixes./
    /This will now follow standard procedure for patch submission and
    review. Closing topic./

  * *Closed: tunnelblick and sophos UTM*
    /Looks like Tunnelblick implemented a fix on their end./
    /​https://github.com/OpenVPN/openvpn/issues/525
    <https://github.com/OpenVPN/openvpn/issues/525>/

  * *Updated: website release process*
    /Last week a website release was planned that would enable a new way
    for updating Community Downloads page./
    /Postponed to this week. We'll see./

  * *Updated: forums topics*
    /ecrist still working on forums. admin access issue looks resolved.
    email issue looks resolved./
    /Plan is to soon switch URLs so new forum is on forums.openvpn.net
    and old forums is on archive address./
    /- email confirmation on registration was suggested./
    /- we still need to work on having some other people with some admin
    or high mod access./
    /- mod guide, hard or soft delete (chuck board?), what to do with
    GDPR, etc. (write it down and actually make it available to mods,
    maybe a hidden topic)/
    /- access for mods to logs so one can see what others did/

  * *Updated: DCO and Linux upstreaming, API change*/
    /Upstreaming DCO to Linux is proceeding, it is in review stage at
    the moment./
    /ordex will prepare a v3 patchset soon based on feedback received./
    /There will be an API change that makes it incompatible with the
    current implementation./
    /A graceful solution to that was already discussed and in motion.
    giaan will be working on this./
    /(in a nutshell, make OpenVPN understand old and new API, DKMS and
    kernel versions both will then use new API, then we drop old API)//

  * *Updated: mattock topics*
    /Made it so --dev null tests can run arbitrary numbers of servers
    concurrently, and have arbitrary amount of clients run in parallel
    to these servers./
    /Will probably look into separating the --dev null test data (test
    cases) from the test scripts./
    /Also started on debian snapshot publishing but didn't get very far
    there yet./

As always you're welcome to join at #openvpn-meeting on Libera IRC 
network every Wednesday at 13:00 Central European Time.

Kind regards,
Johan Draaisma

--------------Keu4jxD0j091Js6ayT0ml6T0
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: 8bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p> Meeting summary for 27 March 2024:</p>
    <ul
style="color: rgb(0, 0, 0); font-family: Verdana, Arial, &quot;Bitstream Vera Sans&quot;, Helvetica, sans-serif; font-size: 13px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">
      <li><strong>New: when to deprecate weak ciphers</strong><br>
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
    <ul
style="color: rgb(0, 0, 0); font-family: Verdana, Arial, &quot;Bitstream Vera Sans&quot;, Helvetica, sans-serif; font-size: 13px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">
      <li><strong>Closed: OpenVPN 2.6.10 release</strong><br>
        <em>This was released 20th of March.</em></li>
    </ul>
    <ul
style="color: rgb(0, 0, 0); font-family: Verdana, Arial, &quot;Bitstream Vera Sans&quot;, Helvetica, sans-serif; font-size: 13px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">
      <li><strong>Closed: OpenVPN 2.5.10 release</strong><br>
        <em>This was released 21st of March, including new Windows
          installers.</em></li>
    </ul>
    <ul
style="color: rgb(0, 0, 0); font-family: Verdana, Arial, &quot;Bitstream Vera Sans&quot;, Helvetica, sans-serif; font-size: 13px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">
      <li><strong>Closed: community funding initiative</strong><br>
        <em>ordex convinced OTF (Open Tech Fund) to let OpenVPN join the
          "FOSS sustainability funding pilot run".</em><br>
        <em>This allows to pay for allocated hours for mattock and cron2
          to work on OpenVPN community tasks.</em><br>
        <em>Some ongoing tasks are listed under 'Mattock Topics' in the
          meeting notes and have already been going on for a while.</em><br>
        <em>This topic is therefore considered closed for now.</em></li>
    </ul>
    <ul
style="color: rgb(0, 0, 0); font-family: Verdana, Arial, &quot;Bitstream Vera Sans&quot;, Helvetica, sans-serif; font-size: 13px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">
      <li><strong>Closed: inactive setting data counter in openvpn2 and
          openvpn3</strong><br>
        <em>It looks like openvpn2 and openvpn3 handle the counting of
          traffic for this differently.</em><br>
        <em>After some discussion it was decided illia will submit some
          suggested fixes.</em><br>
        <em>This will now follow standard procedure for patch submission
          and review. Closing topic.</em></li>
    </ul>
    <ul
style="color: rgb(0, 0, 0); font-family: Verdana, Arial, &quot;Bitstream Vera Sans&quot;, Helvetica, sans-serif; font-size: 13px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">
      <li><strong>Closed: tunnelblick and sophos UTM</strong><br>
        <em>Looks like Tunnelblick implemented a fix on their end.</em><br>
        <em><a class="ext-link"
            href="https://github.com/OpenVPN/openvpn/issues/525"
style="text-decoration: none; color: rgb(187, 0, 0); border-bottom: 1px dotted rgb(187, 187, 187);"><span
              class="icon"
style="background: url(&quot;../extlink.gif&quot;) left center no-repeat; padding-left: 15px;">​</span>https://github.com/OpenVPN/openvpn/issues/525</a></em></li>
    </ul>
    <ul
style="color: rgb(0, 0, 0); font-family: Verdana, Arial, &quot;Bitstream Vera Sans&quot;, Helvetica, sans-serif; font-size: 13px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">
      <li><strong>Updated: website release process</strong><br>
        <em>Last week a website release was planned that would enable a
          new way for updating Community Downloads page.</em><br>
        <em>Postponed to this week. We'll see.</em></li>
    </ul>
    <ul
style="color: rgb(0, 0, 0); font-family: Verdana, Arial, &quot;Bitstream Vera Sans&quot;, Helvetica, sans-serif; font-size: 13px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">
      <li><strong>Updated: forums topics</strong><br>
        <em>ecrist still working on forums. admin access issue looks
          resolved. email issue looks resolved.</em><br>
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
      <li><strong>Updated: DCO and Linux upstreaming, API change</strong><em><br>
        </em>Upstreaming DCO to Linux is proceeding, it is in review
        stage at the moment.<em><br>
        </em>ordex will prepare a v3 patchset soon based on feedback
        received.<em><br>
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
      <li><strong>Updated: mattock topics</strong><br>
        <em>Made it so --dev null tests can run arbitrary numbers of
          servers concurrently, and have arbitrary amount of clients run
          in parallel to these servers.</em><br>
        <em>Will probably look into separating the --dev null test data
          (test cases) from the test scripts.</em><br>
        <em>Also started on debian snapshot publishing but didn't get
          very far there yet.</em></li>
    </ul>
    <p>As always you're welcome to join at #openvpn-meeting on Libera
      IRC network every Wednesday at 13:00 Central European Time.</p>
    <p>Kind regards,<br>
      Johan Draaisma<br>
    </p>
  </body>
</html>

--------------Keu4jxD0j091Js6ayT0ml6T0--

