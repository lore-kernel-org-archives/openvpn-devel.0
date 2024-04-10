Content-Type: multipart/alternative;
 boundary="------------NgY8JXpLXuPKPThVunscDwVp"
Message-ID: <60d61bf8-785e-4a9b-bb06-74b5f9cb431b@...2751...>
Date: Wed, 10 Apr 2024 14:22:42 +0200
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
--------------NgY8JXpLXuPKPThVunscDwVp
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit

Meeting summary for 10 April 2024:

  * *Updated: live route update feature*
    /In short, the ability to update routes, DNS, ifconfig options,
    live, without having to do a full reconnect./
    /One example where this solves an issue is when 1000 users are
    connected to a server, and you change a route that applies to all.
    You'd end up temporarily almost DDoS-ing yourself./
    /As discussed last week, Lev has put together a proposal from which
    we can build a specification./
    /The plan is to get approval for the specification first.
    ThenCloudConnexa?
    <https://community.openvpn.net/openvpn/wiki/CloudConnexa>/openvpn3
    will get this implemented./
    /In discussion with ordex it seems he and giaan can take on creating
    the OpenVPN2 server and client implementations./
    /Proposal
    here:​https://cryptpad.fr/pad/#/2/pad/edit/w1SE-ttFQphTrgZALaG8o8YE/
    <https://cryptpad.fr/pad/#/2/pad/edit/w1SE-ttFQphTrgZALaG8o8YE/>/
    /DYNAMIC_ROUTES message name is too limited to just routes, we
    instead prefer PUSH_UPDATE./
    /Initially PUSH_UPDATE will support routes, DNS, and ifconfig
    options, to update network related settings on the client. This
    could be expanded in the future./

  * *Updated: forums topics*
    /ecrist still working on forums. DNS record for archive of old
    forums was finally correctly created./
    /Plan is to soon switch URLs so new forum is on forums.openvpn.net
    and old forums is on archive address./
    /- email confirmation on registration was suggested./
    /- we still need to work on having some other people with some admin
    or high mod access./
    /- mod guide, hard or soft delete (chuck board?), what to do with
    GDPR, etc. (write it down and actually make it available to mods,
    maybe a hidden topic)/
    /- access for mods to logs so one can see what others did/

  * *Updated: OpenVPN community meetup 2024*
    /Naming: We decided to rename from 'Hackathon' to 'OpenVPN community
    meetup'. This has a more open spirit to it./
    /Where: Karlsruhe, Germany. Meeting room location to be determined./
    /When: At the moment tentatively set to 20-22 September 2024./
    /Who: We'll do an open invitation to openvpn-devel mailing list, but
    also CC: specifically past attendees and people of interest./
    /Shirts: There is plenty of time still to prepare a shirt design./
    /There's a wiki page up now where we can
    coordinate:​https://community.openvpn.net/openvpn/wiki/CommunityMeetup2024
    <https://community.openvpn.net/openvpn/wiki/CommunityMeetup2024>/

As always you're welcome to join at #openvpn-meeting on Libera IRC 
network every Wednesday at 13:00 Central European Time.

Kind regards,
Johan Draaisma

--------------NgY8JXpLXuPKPThVunscDwVp
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: 8bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p> Meeting summary for 10 April 2024:</p>
    <ul
style="color: rgb(0, 0, 0); font-family: Verdana, Arial, &quot;Bitstream Vera Sans&quot;, Helvetica, sans-serif; font-size: 13px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">
      <li><strong>Updated: live route update feature</strong><br>
        <em>In short, the ability to update routes, DNS, ifconfig
          options, live, without having to do a full reconnect.</em><br>
        <em>One example where this solves an issue is when 1000 users
          are connected to a server, and you change a route that applies
          to all. You'd end up temporarily almost DDoS-ing yourself.</em><br>
        <em>As discussed last week, Lev has put together a proposal from
          which we can build a specification.</em><br>
        <em>The plan is to get approval for the specification first.
          Then<span> </span><a class="missing wiki"
href="https://community.openvpn.net/openvpn/wiki/CloudConnexa"
            rel="nofollow"
style="text-decoration: none; color: rgb(153, 153, 136); border-bottom: 1px dotted rgb(187, 187, 187);">CloudConnexa?</a>/openvpn3
          will get this implemented.</em><br>
        <em>In discussion with ordex it seems he and giaan can take on
          creating the OpenVPN2 server and client implementations.</em><br>
        <em>Proposal here:<span> </span><a class="ext-link"
href="https://cryptpad.fr/pad/#/2/pad/edit/w1SE-ttFQphTrgZALaG8o8YE/"
style="text-decoration: none; color: rgb(187, 0, 0); border-bottom: 1px dotted rgb(187, 187, 187);"><span
              class="icon"
style="background: url(&quot;../extlink.gif&quot;) left center no-repeat; padding-left: 15px;">​</span>https://cryptpad.fr/pad/#/2/pad/edit/w1SE-ttFQphTrgZALaG8o8YE/</a></em><br>
        <em>DYNAMIC_ROUTES message name is too limited to just routes,
          we instead prefer PUSH_UPDATE.</em><br>
        <em>Initially PUSH_UPDATE will support routes, DNS, and ifconfig
          options, to update network related settings on the client.
          This could be expanded in the future.</em></li>
    </ul>
    <ul
style="color: rgb(0, 0, 0); font-family: Verdana, Arial, &quot;Bitstream Vera Sans&quot;, Helvetica, sans-serif; font-size: 13px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">
      <li><strong>Updated: forums topics</strong><br>
        <em>ecrist still working on forums. DNS record for archive of
          old forums was finally correctly created.</em><br>
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
      <li><strong>Updated: OpenVPN community meetup 2024</strong><br>
        <em>Naming: We decided to rename from 'Hackathon' to 'OpenVPN
          community meetup'. This has a more open spirit to it.</em><br>
        <em>Where: Karlsruhe, Germany. Meeting room location to be
          determined.</em><br>
        <em>When: At the moment tentatively set to 20-22 September 2024.</em><br>
        <em>Who: We'll do an open invitation to openvpn-devel mailing
          list, but also CC: specifically past attendees and people of
          interest.</em><br>
        <em>Shirts: There is plenty of time still to prepare a shirt
          design.</em><br>
        <em>There's a wiki page up now where we can coordinate:<span> </span><a
            class="ext-link"
href="https://community.openvpn.net/openvpn/wiki/CommunityMeetup2024"
style="text-decoration: none; color: rgb(187, 0, 0); border-bottom: 1px dotted rgb(187, 187, 187);"><span
              class="icon"
style="background: url(&quot;../extlink.gif&quot;) left center no-repeat; padding-left: 15px;">​</span>https://community.openvpn.net/openvpn/wiki/CommunityMeetup2024</a></em></li>
    </ul>
    <p>As always you're welcome to join at #openvpn-meeting on Libera
      IRC network every Wednesday at 13:00 Central European Time.</p>
    <p>Kind regards,<br>
      Johan Draaisma<br>
    </p>
  </body>
</html>

--------------NgY8JXpLXuPKPThVunscDwVp--

