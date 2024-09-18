Content-Type: multipart/alternative;
 boundary="------------j33CWricUaB7PP0xtiAs9WqX"
Message-ID: <8f6634d8-549d-4271-b8d2-3c25d9e4034e@...2751...>
Date: Wed, 18 Sep 2024 14:40:01 +0200
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
--------------j33CWricUaB7PP0xtiAs9WqX
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit

Meeting summary for 18 September 2024:

  * *Updated: OpenVPN community meetup 2024*
    /Hotel recommendation added; Hotel Santo in Karlsruhe./
    /Wiki coordination
    page:​https://community.openvpn.net/openvpn/wiki/CommunityMeetup2024
    <https://community.openvpn.net/openvpn/wiki/CommunityMeetup2024>/
    /Where: Karlsruhe, Germany.SteamWork?
    <https://community.openvpn.net/openvpn/wiki/SteamWork>, Karlsruhe./
    /When: 20-22 September 2024./
    /Shirts: T-shirts are in d12fk's possession in Karlsruhe now./

  * *Updated: DCO and Linux upstreaming, API change*/
    /Upstreaming DCO to Linux is proceeding, it is in review stage at
    the moment./
    /ordex has sent in*patchset version 7*. Awaiting review again./
    /

  * *Updated: community.openvpn.net trac wiki*
    /Seems mattock managed to get it into a reasonable shape ready for
    production./
    /Next step is looking at migrating data from old to new./

  * *Updated: live route updates*
    /There's a PR up on github openvpn-rfc for the live route updates
    proposal./
    /So far it seems we are good with optional/mandatory options
    concept, and by default all options are mandatory./
    /Optional are prefixed with a question mark (?). The idea here is
    that if a client does not support updating that parameter live it
    can ignore it./
    /Whereas without such a prefix, it is mandatory, so if a client
    cannot update it live, it will do a normal reconnect to ensure
    changes are implemented./

This weekend the OpenVPN community meetup 2024 will take place. All 
those that will attend - see you there!

As always you're welcome to join at #openvpn-meeting on Libera IRC 
network every Wednesday at 14:00 Central European Time.

Kind regards,
Johan Draaisma

--------------j33CWricUaB7PP0xtiAs9WqX
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: 8bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p> Meeting summary for 18 September 2024:</p>
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
        <em>When: 20-22 September 2024.</em><br>
        <em>Shirts: T-shirts are in d12fk's possession in Karlsruhe now.</em><br>
      </li>
    </ul>
    <p
style="color: rgb(0, 0, 0); font-family: Verdana, Arial, &quot;Bitstream Vera Sans&quot;, Helvetica, sans-serif; font-size: 13px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;"></p>
    <ul
style="color: rgb(0, 0, 0); font-family: Verdana, Arial, &quot;Bitstream Vera Sans&quot;, Helvetica, sans-serif; font-size: 13px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">
      <li><strong>Updated: DCO and Linux upstreaming, API change</strong><em><br>
        </em>Upstreaming DCO to Linux is proceeding, it is in review
        stage at the moment.<em><br>
        </em>ordex has sent in<span> </span><strong>patchset version 7</strong>.
        Awaiting review again.<em><br>
        </em></li>
    </ul>
    <ul
style="color: rgb(0, 0, 0); font-family: Verdana, Arial, &quot;Bitstream Vera Sans&quot;, Helvetica, sans-serif; font-size: 13px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">
      <li><strong>Updated: community.openvpn.net trac wiki</strong><br>
        <em>Seems mattock managed to get it into a reasonable shape
          ready for production.</em><br>
        <em>Next step is looking at migrating data from old to new.</em><br>
      </li>
    </ul>
    <ul
style="color: rgb(0, 0, 0); font-family: Verdana, Arial, &quot;Bitstream Vera Sans&quot;, Helvetica, sans-serif; font-size: 13px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">
      <li><strong>Updated: live route updates</strong><br>
        <em>There's a PR up on github openvpn-rfc for the live route
          updates proposal.</em><br>
        <em>So far it seems we are good with optional/mandatory options
          concept, and by default all options are mandatory.</em><br>
        <em>Optional are prefixed with a question mark (?). The idea
          here is that if a client does not support updating that
          parameter live it can ignore it.</em><br>
        <em>Whereas without such a prefix, it is mandatory, so if a
          client cannot update it live, it will do a normal reconnect to
          ensure changes are implemented.</em></li>
    </ul>
    <p>This weekend the OpenVPN community meetup 2024 will take place.
      All those that will attend - see you there!<br>
    </p>
    <p>As always you're welcome to join at #openvpn-meeting on Libera
      IRC network every Wednesday at 14:00 Central European Time.</p>
    <p>Kind regards,<br>
      Johan Draaisma<br>
    </p>
  </body>
</html>

--------------j33CWricUaB7PP0xtiAs9WqX--

