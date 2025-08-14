Content-Type: multipart/alternative;
 boundary="------------tnd207ir0uvdIWPprwTvGfZc"
Message-ID: <48838d54-516a-4341-bf91-88f1872b4f17@...2722...>
Date: Thu, 14 Aug 2025 20:26:32 +0700
MIME-Version: 1.0
From: Johan Draaisma <johan@...2722...>
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
--------------tnd207ir0uvdIWPprwTvGfZc
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Meeting summary for 13 August 2025:

  *

    *Updated: Release 2.7*
    DCO for Windows multipeer statistics driver part is done - userspace
    part is waiting review.
    The FreeBSD patch for float was merged, should show up in 14.4 probably.
    The tentative plan for release is now:
    August 20: beta1
    September 3: release candidate 1
    September 17: stable release
    These are some known remaining tasks:
    Epoch data keys for Linux DCO and Windows DCO - can be done in a
    minor release after 2.7.0.
    Small fix to check message id/acked ids too when doing sessionid
    cookie checks - should go into 2.7.0.
    PUSH_UPDATE review and server-side support - cron2 wants to discuss
    changes.
    mi prefix handling, int/uint fixes, and the new 'real route' gateway
    handling

  *

    *Updated: OpenVPN community meetup 2025*
    https://community.openvpn.net/openvpn/wiki/CommunityMeetup2025
    When: 25 and 26 october (saturday and sunday), with travel days on
    the friday before and monday after.
    Where: Napoli, Italy.
    Meeting
    room:https://www.hotelparadisonapoli.it/en/home-page.aspxsponsored
    by company.
    Hotel: Paradiso Napoli Hotel.
    Beer: yes.
    T-shirts: yes.
    Should send out invites. To include people like jan just, reynir,
    kristof, syzzer, max, rein, selva, perhaps leon from netgate who
    contributed multipeer to dco-win.
    novaflash will make a draft, let cron2 review it, then send it out
    to some peeps. If we forgot anyone we can forward a copy after.

  *

    *Updated: Github repo for open sourced MCP project*
    MCP is a protocol that AI agents can speak, like a universal API, so
    that if other programs also speak MCP, then AI can work with it.
    Company is going to do some MCP project to work with CloudConnexa,
    maybe in the future Access Server.
    They want to open source this and ask for a repo to publish it in.
    This is a bit similar to this
    project;https://github.com/OpenVPN/terraform-provider-cloudconnexawhich
    was started elsewhere but got published to open source.
    Seems like community has no objections to this, so will relay that
    approval back to company.

As always you're welcome to join at #openvpn-meeting on Libera IRC 
network every Wednesday at 14:00 Central European Time.

Kind regards,
Johan Draaisma

--------------tnd207ir0uvdIWPprwTvGfZc
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: 8bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p> Meeting summary for 13 August 2025:</p>
    <ul
style="box-sizing: inherit; list-style: circle; padding-left: 1rem; margin-top: 0px; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255); color: rgba(0, 0, 0, 0.85); font-family: -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Roboto, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, &quot;Segoe UI Symbol&quot;; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; text-align: start; text-indent: 0px; text-transform: none; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">
      <li
style="box-sizing: inherit; margin-bottom: 0.2rem; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255); margin-left: 1.5rem; list-style-type: disc;">
        <p
style="box-sizing: inherit; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);"><strong
style="box-sizing: inherit; font-weight: bolder; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);">Updated:
            Release 2.7</strong><br
style="box-sizing: inherit; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);">
          DCO for Windows multipeer statistics driver part is done -
          userspace part is waiting review.<br
style="box-sizing: inherit; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);">
          The FreeBSD patch for float was merged, should show up in 14.4
          probably.<br
style="box-sizing: inherit; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);">
          The tentative plan for release is now:<br
style="box-sizing: inherit; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);">
          August 20: beta1<br
style="box-sizing: inherit; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);">
          September 3: release candidate 1<br
style="box-sizing: inherit; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);">
          September 17: stable release<br
style="box-sizing: inherit; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);">
          These are some known remaining tasks:<br
style="box-sizing: inherit; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);">
          Epoch data keys for Linux DCO and Windows DCO - can be done in
          a minor release after 2.7.0.<br
style="box-sizing: inherit; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);">
          Small fix to check message id/acked ids too when doing
          sessionid cookie checks - should go into 2.7.0.<br
style="box-sizing: inherit; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);">
          PUSH_UPDATE review and server-side support - cron2 wants to
          discuss changes.<br
style="box-sizing: inherit; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);">
          mi prefix handling, int/uint fixes, and the new 'real route'
          gateway handling</p>
      </li>
      <li
style="box-sizing: inherit; margin-bottom: 0.2rem; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255); margin-left: 1.5rem; list-style-type: disc;">
        <p
style="box-sizing: inherit; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);"><strong
style="box-sizing: inherit; font-weight: bolder; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);">Updated:
            OpenVPN community meetup 2025</strong><br
style="box-sizing: inherit; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);">
          <a
href="https://community.openvpn.net/openvpn/wiki/CommunityMeetup2025"
style="box-sizing: inherit; background-color: transparent; color: rgb(24, 144, 255); text-decoration: none; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);"
            class="moz-txt-link-freetext">https://community.openvpn.net/openvpn/wiki/CommunityMeetup2025</a><br
style="box-sizing: inherit; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);">
          When: 25 and 26 october (saturday and sunday), with travel
          days on the friday before and monday after.<br
style="box-sizing: inherit; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);">
          Where: Napoli, Italy.<br
style="box-sizing: inherit; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);">
          Meeting room:<span> </span><a
            href="https://www.hotelparadisonapoli.it/en/home-page.aspx"
style="box-sizing: inherit; background-color: transparent; color: rgb(24, 144, 255); text-decoration: none; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);"
            class="moz-txt-link-freetext">https://www.hotelparadisonapoli.it/en/home-page.aspx</a><span> </span>sponsored
          by company.<br
style="box-sizing: inherit; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);">
          Hotel: Paradiso Napoli Hotel.<br
style="box-sizing: inherit; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);">
          Beer: yes.<br
style="box-sizing: inherit; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);">
          T-shirts: yes.<br
style="box-sizing: inherit; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);">
          Should send out invites. To include people like jan just,
          reynir, kristof, syzzer, max, rein, selva, perhaps leon from
          netgate who contributed multipeer to dco-win.<br
style="box-sizing: inherit; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);">
          novaflash will make a draft, let cron2 review it, then send it
          out to some peeps. If we forgot anyone we can forward a copy
          after.</p>
      </li>
      <li
style="box-sizing: inherit; margin-bottom: 0.2rem; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255); margin-left: 1.5rem; list-style-type: disc;">
        <p
style="box-sizing: inherit; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);"><strong
style="box-sizing: inherit; font-weight: bolder; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);">Updated:
            Github repo for open sourced MCP project</strong><br
style="box-sizing: inherit; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);">
          MCP is a protocol that AI agents can speak, like a universal
          API, so that if other programs also speak MCP, then AI can
          work with it.<br
style="box-sizing: inherit; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);">
          Company is going to do some MCP project to work with
          CloudConnexa, maybe in the future Access Server.<br
style="box-sizing: inherit; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);">
          They want to open source this and ask for a repo to publish it
          in.<br
style="box-sizing: inherit; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);">
          This is a bit similar to this project;<span> </span><a
href="https://github.com/OpenVPN/terraform-provider-cloudconnexa"
style="box-sizing: inherit; background-color: transparent; color: rgb(24, 144, 255); text-decoration: none; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);"
            class="moz-txt-link-freetext">https://github.com/OpenVPN/terraform-provider-cloudconnexa</a><span> </span>which
          was started elsewhere but got published to open source.<br
style="box-sizing: inherit; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);">
          Seems like community has no objections to this, so will relay
          that approval back to company.</p>
      </li>
    </ul>
    <p>As always you're welcome to join at #openvpn-meeting on Libera
      IRC network every Wednesday at 14:00 Central European Time. </p>
    <p>Kind regards,<br>
      Johan Draaisma<br>
    </p>
  </body>
</html>

--------------tnd207ir0uvdIWPprwTvGfZc--

