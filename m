Content-Type: multipart/alternative;
 boundary="------------639tMmgEHmDuBf3j9lZRX059"
Message-ID: <e5d5b789-3ec2-4d14-b06a-fd6303f627dc@...2751...>
Date: Thu, 14 Mar 2024 10:37:45 +0100
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
--------------639tMmgEHmDuBf3j9lZRX059
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Meeting summary for 13 March 2024:

  * *New: topic from an openvpn inc contributor to community (illia)*
    /Would like to discuss about --inactive option that disconnects a
    VPN when it is not sending/receiving more than the set seconds timeout./
    /One part of it is that openvpn2 only counts outgoing packets and
    openvpn3 counts incoming and outgoing. Which is correct?/
    /Another part is type of packets to count - this is all not so clear./
    /For now we counting any packets and ICMP spam from router resets
    inactive timeout very often for openvpn3 so it disconnects later than 2/
    /Current proposal: count also incoming packets for openvpn2 and do
    not reset inactive timeout on ICMP packets for both ovpn3 and 2/
    /There was argument made that "this is how it has been in openvpn2
    forever and we had no complaints" but oddly the documentation claims
    incoming and outgoing is counted./
    /after looking into this a bit some screwiness was found with
    tracking the data in openvpn2 that could use fixing, and illia will
    work on it./
    /and there is some voodoo happening in openvpn2 that skips inactive
    reset packets and similar magic is missing in ovpn3, so illia will
    work on that too./

  * *New: breaking DCO changes, how to approach?*
    /During the upstreaming process to the Linux kernel some alterations
    had to be made./
    /This made the updated implementation different enough from
    ovpn-dco-v2 that OpenVPN 2.6 won't work with it anymore./
    /The plan is to adjust OpenVPN 2.6 so it can support the ovpn-dco-v2
    delivered as out-of-tree kernel module, and the in-tree new kernel
    module./
    /We can then update the out-of-tree kernel module to work in the new
    way and have a graceful transition period./
    /So when it goes upstream and is in the Linux kernel, or DCO is
    installed out-of-tree, it will work the same./
    /We can later decide on when to drop the support for ovpn-dco-v2 old
    methods./

  * *Updated: openvpn 2.6.10 release*
    /There are some Windows related issues to be resolved in this release./
    /Was planned for this week - pushed to begin next week./

  * *Updated: website release process*
    /Next week a website release is planned that will enable a new way
    for updating Community Downloads page./
    /The new way has a much faster release method separate from the rest
    of the website's release schedule./

As always you're welcome to join at #openvpn-meeting on Libera IRC 
network every Wednesday at 13:00 Central European Time.

Kind regards,
Johan Draaisma

--------------639tMmgEHmDuBf3j9lZRX059
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p> Meeting summary for 13 March 2024:</p>
    <ul
style="color: rgb(0, 0, 0); font-family: Verdana, Arial, &quot;Bitstream Vera Sans&quot;, Helvetica, sans-serif; font-size: 13px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">
      <li><strong>New: topic from an openvpn inc contributor to
          community (illia)</strong><br>
        <em>Would like to discuss about --inactive option that
          disconnects a VPN when it is not sending/receiving more than
          the set seconds timeout.</em><br>
        <em>One part of it is that openvpn2 only counts outgoing packets
          and openvpn3 counts incoming and outgoing. Which is correct?</em><br>
        <em>Another part is type of packets to count - this is all not
          so clear.</em><br>
        <em>For now we counting any packets and ICMP spam from router
          resets inactive timeout very often for openvpn3 so it
          disconnects later than 2</em><br>
        <em>Current proposal: count also incoming packets for openvpn2
          and do not reset inactive timeout on ICMP packets for both
          ovpn3 and 2</em><br>
        <em>There was argument made that "this is how it has been in
          openvpn2 forever and we had no complaints" but oddly the
          documentation claims incoming and outgoing is counted.</em><br>
        <em>after looking into this a bit some screwiness was found with
          tracking the data in openvpn2 that could use fixing, and illia
          will work on it.</em><br>
        <em>and there is some voodoo happening in openvpn2 that skips
          inactive reset packets and similar magic is missing in ovpn3,
          so illia will work on that too.</em></li>
    </ul>
    <ul
style="color: rgb(0, 0, 0); font-family: Verdana, Arial, &quot;Bitstream Vera Sans&quot;, Helvetica, sans-serif; font-size: 13px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">
      <li><strong>New: breaking DCO changes, how to approach?</strong><br>
        <em>During the upstreaming process to the Linux kernel some
          alterations had to be made.</em><br>
        <em>This made the updated implementation different enough from
          ovpn-dco-v2 that OpenVPN 2.6 won't work with it anymore.</em><br>
        <em>The plan is to adjust OpenVPN 2.6 so it can support the
          ovpn-dco-v2 delivered as out-of-tree kernel module, and the
          in-tree new kernel module.</em><br>
        <em>We can then update the out-of-tree kernel module to work in
          the new way and have a graceful transition period.</em><br>
        <em>So when it goes upstream and is in the Linux kernel, or DCO
          is installed out-of-tree, it will work the same.</em><br>
        <em>We can later decide on when to drop the support for
          ovpn-dco-v2 old methods.</em></li>
    </ul>
    <ul
style="color: rgb(0, 0, 0); font-family: Verdana, Arial, &quot;Bitstream Vera Sans&quot;, Helvetica, sans-serif; font-size: 13px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">
      <li><strong>Updated: openvpn 2.6.10 release</strong><br>
        <em>There are some Windows related issues to be resolved in this
          release.</em><br>
        <em>Was planned for this week - pushed to begin next week.</em></li>
    </ul>
    <ul
style="color: rgb(0, 0, 0); font-family: Verdana, Arial, &quot;Bitstream Vera Sans&quot;, Helvetica, sans-serif; font-size: 13px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">
      <li><strong>Updated: website release process</strong><br>
        <em>Next week a website release is planned that will enable a
          new way for updating Community Downloads page.</em><br>
        <em>The new way has a much faster release method separate from
          the rest of the website's release schedule.</em><br>
      </li>
    </ul>
    <p>As always you're welcome to join at #openvpn-meeting on Libera
      IRC network every Wednesday at 13:00 Central European Time.</p>
    <p>Kind regards,<br>
      Johan Draaisma<br>
    </p>
  </body>
</html>

--------------639tMmgEHmDuBf3j9lZRX059--

