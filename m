Content-Type: multipart/alternative;
 boundary="------------N9vQ3h3QEg1CvR0xYCF9mG35"
Message-ID: <0f116f3b-9956-4efb-9270-5e7bbcef787e@...2751...>
Date: Wed, 19 Jun 2024 15:00:26 +0200
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
--------------N9vQ3h3QEg1CvR0xYCF9mG35
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit

Meeting summary for 19 June 2024:

  * *Updated: release openvpn 2.6.11*
    /There is a security issue reported by reynir that is resolved, and
    we want to get that out in 2.6.11 tomorrow./
    /The tunnelcrack mitigations for Windows are held back because we
    have had absolutely no response on the mailing lists for testing
    these and confirming that it doesn't break things./
    /If someone can contribute to testing this we can follow up with a
    2.6.12 release in a few weeks that contains the tunnelcrack
    mitigations for Windows./

  * *New: buildbot PRs need attention*
    /Getting these merged soonish would help avoid nasty merge conflicts
    down the line/
    ​Allow skipping build types
    <https://github.com/OpenVPN/openvpn-buildbot/pull/50>
    ​Add smoketest builds for openvpn3, openvpn3-linux and ovpn-dco
    <https://github.com/OpenVPN/openvpn-buildbot/pull/51>
    ​https://github.com/OpenVPN/openvpn-buildbot/pull/48
    <https://github.com/OpenVPN/openvpn-buildbot/pull/48>
    /Developers have been pinged in the meeting about these, so they'll
    take a look when they can./

  * *New: fixing openvpn3-linux builds in Buildbot*
    /Mattock has this almost working. Some platforms will have to be
    skipped because openvpn3-linux / gdbuspp dependencies (Meson in
    particular) are too old or missing./
    /As an aside, OpenVPN3 Linux v22 dev for Ubuntu 24.04 LTS and Fedora
    39 and 40 are in the release process./
    /Next step is a 'regular' OpenVPN3 Linux v23 release again./

  * *New: Linux arm64 buildbot workers*
    /Mattock has done initial research./
    /Docker seems to support (QEMU) emulated non-native containers, but
    Buildbot might be missing the glue to make it work./
    /Patching Buildbot should not be *that* difficult./
    /External (arm64) Docker host might be a more performant alternative
    option./

  * *New: how to proceed with lzo2.pc*
    /pc file suggests "all includes should be done without|lzo/|prefix"
    - which is generally not a bad idea, but needs code changes beyond
    configure (right?)/
    /There are some options to make changes here. For now we'll just
    keep working around this issue.'
    /One thing seems clear; it would be too early to rip it out, it
    would most likely affect too many people still using it despite the
    fact that they shouldn't./
    /An option we have is to use the OpenVPN3 implementation of lzo and
    port that to OpenVPN2, to solve this./
    /This is a topic that will be moved to the OpenVPN community meetup
    2024.//

  * *New: run tests of 2.x against openvpn3? how?*
    /There is a 'null client' variant of ovpncli that allows to make VPN
    connections but not fully, for testing purposes./
    /This is in the openvpn3 repository./

  * *Updated: community.openvpn.net trac wiki*
    /Wiki.js felt quite awkward and counterintuitive in practical tests
    done by mattock. It seems to focus on bling rather than usability./
    /Xwiki felt quite bulky and enterprisey (a.k.a. full of "stuff") in
    the practical tests by mattock. It seems an overkill for our simple
    use-case./
    /Mediawiki no longer feels as nasty as it once did :)/
    /Maybe some Git-based wiki-type solution would be ok?/

As always you're welcome to join at #openvpn-meeting on Libera IRC 
network every Wednesday at 14:00 Central European Time.

Kind regards,
Johan Draaisma

--------------N9vQ3h3QEg1CvR0xYCF9mG35
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: 8bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p> Meeting summary for 19 June 2024:</p>
    <ul
style="color: rgb(0, 0, 0); font-family: Verdana, Arial, &quot;Bitstream Vera Sans&quot;, Helvetica, sans-serif; font-size: 13px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">
      <li><strong>Updated: release openvpn 2.6.11</strong><br>
        <em>There is a security issue reported by reynir that is
          resolved, and we want to get that out in 2.6.11 tomorrow.</em><br>
        <em>The tunnelcrack mitigations for Windows are held back
          because we have had absolutely no response on the mailing
          lists for testing these and confirming that it doesn't break
          things.</em><br>
        <em>If someone can contribute to testing this we can follow up
          with a 2.6.12 release in a few weeks that contains the
          tunnelcrack mitigations for Windows.</em></li>
    </ul>
    <ul
style="color: rgb(0, 0, 0); font-family: Verdana, Arial, &quot;Bitstream Vera Sans&quot;, Helvetica, sans-serif; font-size: 13px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">
      <li><strong>New: buildbot PRs need attention</strong><br>
        <em>Getting these merged soonish would help avoid nasty merge
          conflicts down the line</em><br>
        <a class="ext-link"
          href="https://github.com/OpenVPN/openvpn-buildbot/pull/50"
style="text-decoration: none; color: rgb(187, 0, 0); border-bottom: 1px dotted rgb(187, 187, 187);"><span
            class="icon"
style="background: url(&quot;../extlink.gif&quot;) left center no-repeat; padding-left: 15px;">​</span>Allow
          skipping build types</a><br>
        <a class="ext-link"
          href="https://github.com/OpenVPN/openvpn-buildbot/pull/51"
style="text-decoration: none; color: rgb(187, 0, 0); border-bottom: 1px dotted rgb(187, 187, 187);"><span
            class="icon"
style="background: url(&quot;../extlink.gif&quot;) left center no-repeat; padding-left: 15px;">​</span>Add
          smoketest builds for openvpn3, openvpn3-linux and ovpn-dco</a><br>
        <a class="ext-link"
          href="https://github.com/OpenVPN/openvpn-buildbot/pull/48"
style="text-decoration: none; color: rgb(187, 0, 0); border-bottom: 1px dotted rgb(187, 187, 187);"><span
            class="icon"
style="background: url(&quot;../extlink.gif&quot;) left center no-repeat; padding-left: 15px;">​</span>https://github.com/OpenVPN/openvpn-buildbot/pull/48</a><br>
        <em>Developers have been pinged in the meeting about these, so
          they'll take a look when they can.</em></li>
    </ul>
    <ul
style="color: rgb(0, 0, 0); font-family: Verdana, Arial, &quot;Bitstream Vera Sans&quot;, Helvetica, sans-serif; font-size: 13px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">
      <li><strong>New: fixing openvpn3-linux builds in Buildbot</strong><br>
        <em>Mattock has this almost working. Some platforms will have to
          be skipped because openvpn3-linux / gdbuspp dependencies
          (Meson in particular) are too old or missing.</em><br>
        <em>As an aside, OpenVPN3 Linux v22 dev for Ubuntu 24.04 LTS and
          Fedora 39 and 40 are in the release process.</em><br>
        <em>Next step is a 'regular' OpenVPN3 Linux v23 release again.</em></li>
    </ul>
    <ul
style="color: rgb(0, 0, 0); font-family: Verdana, Arial, &quot;Bitstream Vera Sans&quot;, Helvetica, sans-serif; font-size: 13px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">
      <li><strong>New: Linux arm64 buildbot workers</strong><br>
        <em>Mattock has done initial research.</em><br>
        <em>Docker seems to support (QEMU) emulated non-native
          containers, but Buildbot might be missing the glue to make it
          work.</em><br>
        <em>Patching Buildbot should not be *that* difficult.</em><br>
        <em>External (arm64) Docker host might be a more performant
          alternative option.</em></li>
    </ul>
    <ul
style="color: rgb(0, 0, 0); font-family: Verdana, Arial, &quot;Bitstream Vera Sans&quot;, Helvetica, sans-serif; font-size: 13px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">
      <li><strong>New: how to proceed with lzo2.pc</strong><br>
        <em>pc file suggests "all includes should be done without<span> </span><code
style="color: rgb(102, 0, 0); border: 1px solid rgb(238, 221, 204); border-radius: 0.25em; padding: 0px 0.3em; background: rgb(250, 250, 250);">lzo/</code><span> </span>prefix"
          - which is generally not a bad idea, but needs code changes
          beyond configure (right?)</em><br>
        <em>There are some options to make changes here. For now we'll
          just keep working around this issue.'<br>
        </em>One thing seems clear; it would be too early to rip it out,
        it would most likely affect too many people still using it
        despite the fact that they shouldn't.<em><br>
        </em>An option we have is to use the OpenVPN3 implementation of
        lzo and port that to OpenVPN2, to solve this.<em><br>
        </em>This is a topic that will be moved to the OpenVPN community
        meetup 2024.<em></em></li>
    </ul>
    <ul
style="color: rgb(0, 0, 0); font-family: Verdana, Arial, &quot;Bitstream Vera Sans&quot;, Helvetica, sans-serif; font-size: 13px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">
      <li><strong>New: run tests of 2.x against openvpn3? how?</strong><br>
        <em>There is a 'null client' variant of ovpncli that allows to
          make VPN connections but not fully, for testing purposes.</em><br>
        <em>This is in the openvpn3 repository.</em></li>
    </ul>
    <ul
style="color: rgb(0, 0, 0); font-family: Verdana, Arial, &quot;Bitstream Vera Sans&quot;, Helvetica, sans-serif; font-size: 13px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">
      <li><strong>Updated: community.openvpn.net trac wiki</strong><br>
        <em>Wiki.js felt quite awkward and counterintuitive in practical
          tests done by mattock. It seems to focus on bling rather than
          usability.</em><br>
        <em>Xwiki felt quite bulky and enterprisey (a.k.a. full of
          "stuff") in the practical tests by mattock. It seems an
          overkill for our simple use-case.</em><br>
        <em>Mediawiki no longer feels as nasty as it once did :)</em><br>
        <em>Maybe some Git-based wiki-type solution would be ok?</em></li>
    </ul>
    <p>As always you're welcome to join at #openvpn-meeting on Libera
      IRC network every Wednesday at 14:00 Central European Time.</p>
    <p>Kind regards,<br>
      Johan Draaisma<br>
    </p>
  </body>
</html>

--------------N9vQ3h3QEg1CvR0xYCF9mG35--

