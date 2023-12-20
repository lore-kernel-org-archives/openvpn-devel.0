Content-Type: multipart/alternative;
 boundary="------------SoJpNOGxlEGlN0c7MC2Oai0Q"
Message-ID: <8256233e-53db-4efe-b1b7-08b048144b4a@...2751...>
Date: Wed, 20 Dec 2023 14:16:43 +0100
MIME-Version: 1.0
From: Johan Draaisma <johan@...2751...>
Content-Language: en-US
Subject: [Openvpn-devel] IRC community meeting summary
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
--------------SoJpNOGxlEGlN0c7MC2Oai0Q
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit

Meeting summary for 20 December 2023:

  * *New: no meeting on 27th december or 3 january.*
    /Normal meetings to resume on January 10 2024./

  * *Updated: OpenVPN 2.6.9 release*
    /Given that we're so close to end of year, we'll push this to next
    year./
    /The --tls-export-cert PR needs a little love first./
    /Tentative new release date is January 10./

  * *Updated: forums topics*
    /There has been a lot of spam. An antispam module had expired. We
    fixed that. But there's still the occasional bit of spam./
    /We agreed in last meeting to commit to a path to get a new VM and
    switch to vBulletin and disconnect from community LDAP logins./
    /The new VM is delivered, the license should be delivered this week
    too, so then ecrist can get to work./
    /RegardingCloudFlare?
    <https://community.openvpn.net/openvpn/wiki/CloudFlare>, currently
    not enabled on forums, but we will enable it at some point on the
    new VM./

  * *New: status of trac/wiki*
    /ordex wanted to discuss state of trac/wiki. Do we move to something
    else? Do we update existing?/
    /mattock has been volunteered to look into alternatives./
    /It must be open source. Self-hosted or hosted open-source both fine./
    /There is no hard requirement for LDAP capability./
    /Should have access controls so only approved members can edit./

  * *New: status of community LDAP sign-in solution*
    /We use it currently for forums, wiki, gerrit, patchwork. We are
    seriously considering getting rid of it./
    /The reality is that 99.99% of forums users do not interact with the
    other tools./
    /And that the small group of contributors to wiki and gerrit does
    not justify the need for an LDAP sign-in solution./
    /So we're inclined to disconnect from LDAP. For the forums we
    already intend to do that now./
    /No final decision reached at this time. Considering our options./

  * *New: packet header order*
    /plaisthos wanted to get consensus/decision on whether we do that as
    part of the rekeying improvements./
    /Generally in favor of adding a new negotiable packet format, so
    long as plaisthos and syzzer are in agreement./

  * *New: plan to improve server side testing*
    /mattock
    posted​https://community.openvpn.net/openvpn/wiki/ServerSideTestingImprovementPlan#no1
    <https://community.openvpn.net/openvpn/wiki/ServerSideTestingImprovementPlan#no1>/
    /It's a plan to improve server side testing. mattock would like to
    get eyes on this and feedback./

  * *Updated: TLS 1.0 PRF problem*
    /Patches for this have been created and are in review, have not made
    it in yet./

As always you're welcome to join at #openvpn-meeting on Libera IRC 
network every Wednesday at 13:00 Central European Time (except this 27 
december and 3 january).

Best of luck to all of you in the new year,
Johan Draaisma

--------------SoJpNOGxlEGlN0c7MC2Oai0Q
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: 8bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p> Meeting summary for 20 December 2023:</p>
    <ul
style="color: rgb(0, 0, 0); font-family: Verdana, Arial, &quot;Bitstream Vera Sans&quot;, Helvetica, sans-serif; font-size: 13px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">
      <li><strong>New: no meeting on 27th december or 3 january.</strong><br>
        <em>Normal meetings to resume on January 10 2024.</em></li>
    </ul>
    <ul
style="color: rgb(0, 0, 0); font-family: Verdana, Arial, &quot;Bitstream Vera Sans&quot;, Helvetica, sans-serif; font-size: 13px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">
      <li><strong>Updated: OpenVPN 2.6.9 release</strong><br>
        <em>Given that we're so close to end of year, we'll push this to
          next year.</em><br>
        <em>The --tls-export-cert PR needs a little love first.</em><br>
        <em>Tentative new release date is January 10.</em></li>
    </ul>
    <ul
style="color: rgb(0, 0, 0); font-family: Verdana, Arial, &quot;Bitstream Vera Sans&quot;, Helvetica, sans-serif; font-size: 13px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">
      <li><strong>Updated: forums topics</strong><br>
        <em>There has been a lot of spam. An antispam module had
          expired. We fixed that. But there's still the occasional bit
          of spam.</em><br>
        <em>We agreed in last meeting to commit to a path to get a new
          VM and switch to vBulletin and disconnect from community LDAP
          logins.</em><br>
        <em>The new VM is delivered, the license should be delivered
          this week too, so then ecrist can get to work.</em><br>
        <em>Regarding<span> </span><a class="missing wiki"
            href="https://community.openvpn.net/openvpn/wiki/CloudFlare"
            rel="nofollow"
style="text-decoration: none; color: rgb(153, 153, 136); border-bottom: 1px dotted rgb(187, 187, 187);">CloudFlare?</a>,
          currently not enabled on forums, but we will enable it at some
          point on the new VM.</em><br>
      </li>
    </ul>
    <p
style="color: rgb(0, 0, 0); font-family: Verdana, Arial, &quot;Bitstream Vera Sans&quot;, Helvetica, sans-serif; font-size: 13px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;"></p>
    <ul
style="color: rgb(0, 0, 0); font-family: Verdana, Arial, &quot;Bitstream Vera Sans&quot;, Helvetica, sans-serif; font-size: 13px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">
      <li><strong>New: status of trac/wiki</strong><br>
        <em>ordex wanted to discuss state of trac/wiki. Do we move to
          something else? Do we update existing?</em><br>
        <em>mattock has been volunteered to look into alternatives.</em><br>
        <em>It must be open source. Self-hosted or hosted open-source
          both fine.</em><br>
        <em>There is no hard requirement for LDAP capability.</em><br>
        <em>Should have access controls so only approved members can
          edit.</em><br>
      </li>
    </ul>
    <ul
style="color: rgb(0, 0, 0); font-family: Verdana, Arial, &quot;Bitstream Vera Sans&quot;, Helvetica, sans-serif; font-size: 13px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">
      <li><strong>New: status of community LDAP sign-in solution</strong><br>
        <em>We use it currently for forums, wiki, gerrit, patchwork. We
          are seriously considering getting rid of it.</em><br>
        <em>The reality is that 99.99% of forums users do not interact
          with the other tools.</em><br>
        <em>And that the small group of contributors to wiki and gerrit
          does not justify the need for an LDAP sign-in solution.</em><br>
        <em>So we're inclined to disconnect from LDAP. For the forums we
          already intend to do that now.</em><br>
        <em>No final decision reached at this time. Considering our
          options.</em><br>
      </li>
    </ul>
    <ul
style="color: rgb(0, 0, 0); font-family: Verdana, Arial, &quot;Bitstream Vera Sans&quot;, Helvetica, sans-serif; font-size: 13px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">
      <li><strong>New: packet header order</strong><br>
        <em>plaisthos wanted to get consensus/decision on whether we do
          that as part of the rekeying improvements.</em><br>
        <em>Generally in favor of adding a new negotiable packet format,
          so long as plaisthos and syzzer are in agreement.</em><br>
      </li>
    </ul>
    <ul
style="color: rgb(0, 0, 0); font-family: Verdana, Arial, &quot;Bitstream Vera Sans&quot;, Helvetica, sans-serif; font-size: 13px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">
      <li><strong>New: plan to improve server side testing</strong><br>
        <em>mattock posted<span> </span><a class="ext-link"
href="https://community.openvpn.net/openvpn/wiki/ServerSideTestingImprovementPlan#no1"
style="text-decoration: none; color: rgb(187, 0, 0); border-bottom: 1px dotted rgb(187, 187, 187);"><span
              class="icon"
style="background: url(&quot;../extlink.gif&quot;) left center no-repeat; padding-left: 15px;">​</span>https://community.openvpn.net/openvpn/wiki/ServerSideTestingImprovementPlan#no1</a></em><br>
        <em>It's a plan to improve server side testing. mattock would
          like to get eyes on this and feedback.</em><br>
      </li>
    </ul>
    <ul
style="color: rgb(0, 0, 0); font-family: Verdana, Arial, &quot;Bitstream Vera Sans&quot;, Helvetica, sans-serif; font-size: 13px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">
      <li><strong>Updated: TLS 1.0 PRF problem</strong><br>
        <em>Patches for this have been created and are in review, have
          not made it in yet.</em></li>
    </ul>
    <p>As always you're welcome to join at #openvpn-meeting on Libera
      IRC network every Wednesday at 13:00 Central European Time (except
      this 27 december and 3 january).<br>
    </p>
    <p>Best of luck to all of you in the new year,<br>
      Johan Draaisma<br>
    </p>
  </body>
</html>

--------------SoJpNOGxlEGlN0c7MC2Oai0Q--

