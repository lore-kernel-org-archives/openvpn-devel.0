Content-Type: multipart/alternative;
 boundary="------------mkQrmL9B9o51D0q6jTaecwFC"
Message-ID: <49a518d2-142b-4f45-956d-3122a580ee3b@...2751...>
Date: Wed, 17 Apr 2024 14:01:17 +0200
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
--------------mkQrmL9B9o51D0q6jTaecwFC
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit

Meeting summary for 17 April 2024:

  * *New: updated 2.6.10 with new MSI installers*
    /There is a new Windows DCO driver that should handle coming back
    from hibernation better/faster, as it doesn't wait for keepalive
    timeout after hibernation./

  * *New: --topology directive*
    /We changed the default for this to be 'subnet' as this is the most
    commonly used setup and has been for ages (used to be net30)./
    /This is however breaking things by default for peer to peer setups.
    We could limit the change to just --server mode./
    /djpig will propose a patch and it can be discussed further there./

  * *Closed: live route update feature*
    /In short, the ability to update routes, DNS, ifconfig options,
    live, without having to do a full reconnect./
    /After discussing last week seems like a path forward is clear./

  * *Updated: Security mailing list procedure can stand improvement*
    /company will improve process on picking up tasks from security
    mailing list in the next week or so./
    /The idea being that community guys will continue doing their thing
    as usual, and company guys monitor the list for company related
    items and follow up on those./
    /The idea of an NDA is also revived. But it was made clear
    internally that we need like a one-page simple NDA for community
    members, not the unnecessarily restrictive one originally suggested
    by legal guys./

  * *Updated: DCO and Linux upstreaming, API change*/
    /Upstreaming DCO to Linux is proceeding, it is in review stage at
    the moment./
    /ordex will send a patchset v3 based on feedback received today./
    /There will be an API change that makes it incompatible with the
    current implementation./
    /A graceful solution to that was already discussed and in motion.
    giaan will be working on this./
    /(in a nutshell, make OpenVPN understand old and new API, DKMS and
    kernel versions both will then use new API, then we drop old API)//

  * *Updated: donation collection*
    /From earlier exploration it is clear that setting up a legal entity
    is not worth the expense at this point. We're just starting out with
    donations./
    /What we can do is start out with an existing company that can
    collect the money and puts it to good community use. ordex
    volunteers to take this on./
    /There are some options to consider. There may be existing solutions
    that we want to consider./
    /PayPal? <https://community.openvpn.net/openvpn/wiki/PayPal>seems
    overly expensive with all their fees./
    /Stripe could be worth considering for credit card processing./
    /GitHub? <https://community.openvpn.net/openvpn/wiki/GitHub>Sponsors
    was mentioned as a possible solution, this is worth investigating./
    /Open Collective was also mentioned, that needs some investigating
    how that exactly would work for us./

  * *Updated: forums topics*
    /ecrist still working on forums. waiting on ecrist to move things
    around./
    /Plan is to soon switch URLs so new forum is on forums.openvpn.net
    and old forums is on archive address./
    /- email confirmation on registration was suggested./
    /- mod guide, hard or soft delete (chuck board?), what to do with
    GDPR, etc. (write it down and actually make it available to mods,
    maybe a hidden topic)/
    /- access for mods to logs so one can see what others did/

  * *Updated: mattock topics*
    /Managed to make tests run reliably now, the occassional failures
    seem resolved now./
    /Documentation
    here:​https://github.com/mattock/openvpn/blob/dev_null/doc/dev-null-test-suite.rst
    <https://github.com/mattock/openvpn/blob/dev_null/doc/dev-null-test-suite.rst>/
    /Will submit a patch soon./

As always you're welcome to join at #openvpn-meeting on Libera IRC 
network every Wednesday at 13:00 Central European Time.

Kind regards,
Johan Draaisma

--------------mkQrmL9B9o51D0q6jTaecwFC
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: 8bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p> Meeting summary for 17 April 2024:</p>
    <ul
style="color: rgb(0, 0, 0); font-family: Verdana, Arial, &quot;Bitstream Vera Sans&quot;, Helvetica, sans-serif; font-size: 13px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">
      <li><strong>New: updated 2.6.10 with new MSI installers</strong><br>
        <em>There is a new Windows DCO driver that should handle coming
          back from hibernation better/faster, as it doesn't wait for
          keepalive timeout after hibernation.</em></li>
    </ul>
    <ul
style="color: rgb(0, 0, 0); font-family: Verdana, Arial, &quot;Bitstream Vera Sans&quot;, Helvetica, sans-serif; font-size: 13px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">
      <li><strong>New: --topology directive</strong><br>
        <em>We changed the default for this to be 'subnet' as this is
          the most commonly used setup and has been for ages (used to be
          net30).</em><br>
        <em>This is however breaking things by default for peer to peer
          setups. We could limit the change to just --server mode.</em><br>
        <em>djpig will propose a patch and it can be discussed further
          there.</em></li>
    </ul>
    <ul
style="color: rgb(0, 0, 0); font-family: Verdana, Arial, &quot;Bitstream Vera Sans&quot;, Helvetica, sans-serif; font-size: 13px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">
      <li><strong>Closed: live route update feature</strong><br>
        <em>In short, the ability to update routes, DNS, ifconfig
          options, live, without having to do a full reconnect.</em><br>
        <em>After discussing last week seems like a path forward is
          clear.</em></li>
    </ul>
    <ul
style="color: rgb(0, 0, 0); font-family: Verdana, Arial, &quot;Bitstream Vera Sans&quot;, Helvetica, sans-serif; font-size: 13px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">
      <li><strong>Updated: Security mailing list procedure can stand
          improvement</strong><br>
        <em>company will improve process on picking up tasks from
          security mailing list in the next week or so.</em><br>
        <em>The idea being that community guys will continue doing their
          thing as usual, and company guys monitor the list for company
          related items and follow up on those.</em><br>
        <em>The idea of an NDA is also revived. But it was made clear
          internally that we need like a one-page simple NDA for
          community members, not the unnecessarily restrictive one
          originally suggested by legal guys.</em></li>
    </ul>
    <ul
style="color: rgb(0, 0, 0); font-family: Verdana, Arial, &quot;Bitstream Vera Sans&quot;, Helvetica, sans-serif; font-size: 13px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">
      <li><strong>Updated: DCO and Linux upstreaming, API change</strong><em><br>
        </em>Upstreaming DCO to Linux is proceeding, it is in review
        stage at the moment.<em><br>
        </em>ordex will send a patchset v3 based on feedback received
        today.<em><br>
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
      <li><strong>Updated: donation collection</strong><br>
        <em>From earlier exploration it is clear that setting up a legal
          entity is not worth the expense at this point. We're just
          starting out with donations.</em><br>
        <em>What we can do is start out with an existing company that
          can collect the money and puts it to good community use. ordex
          volunteers to take this on.</em><br>
        <em>There are some options to consider. There may be existing
          solutions that we want to consider.</em><br>
        <em><a class="missing wiki"
            href="https://community.openvpn.net/openvpn/wiki/PayPal"
            rel="nofollow"
style="text-decoration: none; color: rgb(153, 153, 136); border-bottom: 1px dotted rgb(187, 187, 187);">PayPal?</a><span> </span>seems
          overly expensive with all their fees.</em><br>
        <em>Stripe could be worth considering for credit card
          processing.</em><br>
        <em><a class="missing wiki"
            href="https://community.openvpn.net/openvpn/wiki/GitHub"
            rel="nofollow"
style="text-decoration: none; color: rgb(153, 153, 136); border-bottom: 1px dotted rgb(187, 187, 187);">GitHub?</a><span> </span>Sponsors
          was mentioned as a possible solution, this is worth
          investigating.</em><br>
        <em>Open Collective was also mentioned, that needs some
          investigating how that exactly would work for us.</em></li>
    </ul>
    <ul
style="color: rgb(0, 0, 0); font-family: Verdana, Arial, &quot;Bitstream Vera Sans&quot;, Helvetica, sans-serif; font-size: 13px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">
      <li><strong>Updated: forums topics</strong><br>
        <em>ecrist still working on forums. waiting on ecrist to move
          things around.</em><br>
        <em>Plan is to soon switch URLs so new forum is on
          forums.openvpn.net and old forums is on archive address.</em><br>
        <em>- email confirmation on registration was suggested.</em><br>
        <em>- mod guide, hard or soft delete (chuck board?), what to do
          with GDPR, etc. (write it down and actually make it available
          to mods, maybe a hidden topic)</em><br>
        <em>- access for mods to logs so one can see what others did</em></li>
    </ul>
    <ul
style="color: rgb(0, 0, 0); font-family: Verdana, Arial, &quot;Bitstream Vera Sans&quot;, Helvetica, sans-serif; font-size: 13px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">
      <li><strong>Updated: mattock topics</strong><br>
        <em>Managed to make tests run reliably now, the occassional
          failures seem resolved now.</em><br>
        <em>Documentation here:<span> </span><a class="ext-link"
href="https://github.com/mattock/openvpn/blob/dev_null/doc/dev-null-test-suite.rst"
style="text-decoration: none; color: rgb(187, 0, 0); border-bottom: 1px dotted rgb(187, 187, 187);"><span
              class="icon"
style="background: url(&quot;../extlink.gif&quot;) left center no-repeat; padding-left: 15px;">​</span>https://github.com/mattock/openvpn/blob/dev_null/doc/dev-null-test-suite.rst</a></em><br>
        <em>Will submit a patch soon.</em></li>
    </ul>
    <p>As always you're welcome to join at #openvpn-meeting on Libera
      IRC network every Wednesday at 13:00 Central European Time.</p>
    <p>Kind regards,<br>
      Johan Draaisma<br>
    </p>
  </body>
</html>

--------------mkQrmL9B9o51D0q6jTaecwFC--

