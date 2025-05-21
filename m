Content-Type: multipart/alternative;
 boundary="------------J44KRCwhqGYKHh4QJpL0Hh7A"
Message-ID: <5731b6b7-cfb6-47c9-b8ed-65bd5416877e@...2722...>
Date: Wed, 21 May 2025 17:06:08 +0200
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
--------------J44KRCwhqGYKHh4QJpL0Hh7A
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Meeting summary for 21 May 2025:

  *

    *New: Changes to community pages on main website*
    Company reached out to novaflash about proposed changes.
    novaflash involved ordex and lev__ for feedback/ideas.
    It's about cleaning up and revamping the community section, remove
    old releases, focus on latest release, and so on.
    Feedback from last time was incorporated: 'community' item was moved
    out of main menu. Community gave feedback; it was moved back to main
    menu.
    Renaming of Community to open source can be done partially - got
    pushback from openvpn inc CEO to rename community to open source in
    the main menu. Rest of places we can update it though to mention
    open source. Basic idea is to revamp the community page on main
    website so it shows just the main download artifacts and release
    notes of latest version, plus where community resources can be
    found, plus where developers can be reached. A list of resources and
    contact methods has been collected and while not set in stone will
    be passed for an initial design to be reviewed later.

  *

    *Updated: Release 2.7*
    Current estimates are to have all major code items in by May 1st and
    then a release on July 1st.
    Together with 2.7 a new Linux DCO module based on upstreamed (linux
    kernel) codebase will be released, the code for this is done, bugs
    being fixed.
    Together with 2.7 a new Windows DCO module with server support will
    be released. The code for this is done but needs more testing.
    DNS changes are mostly in but some issues are still found on Windows
    and need to be addressed.
    Currently we feel that it looks reasonable to do a 2.7 alpha release
    next week.
    For the actual release we should still do a reformatting to
    clang-format so master and 2.7 have the same formatting. Otherwise
    backporting bugfixes will be a pain.

  *

    *Updated: DCO tasks*
    Implementation of epoch data keys in user space in OpenVPN2 and
    OpenVPN3 are both done now. For Windows, Linux, and FreeBSD DCO this
    implementation still needs to happen.
    lev__ has started work on epoch data keys in Windows DCO. Windows
    DCO has also support for server mode now so has some significant
    changes coming with 2.7. Red Hat 9.6 introduced a change that breaks
    the current production DCO kernel module code. A fix for this is
    available now.
    Programs that rely on this like Access Server and OpenVPN3 Linux
    will push out an updated DCO kernel module with this fix soonish.
    There are still some bugfixes for the backport copy of linux kernel
    upstreamed version of DCO for 2.7 to be resolved.

  *

    *Updated: OpenVPN community meetup 2025*
    https://community.openvpn.net/openvpn/wiki/CommunityMeetup2025
    When: based on an availabilty poll and by agreement the weekend of
    25 and 26 october as meeting days, with days before and after as
    travel days, seems best.
    Where: Napoli, Italy.
    Meeting room: giaan will take a look into this.
    Hotel: giaan will take a look into this.
    Beer: yes.
    T-shirts: yes.

As always you're welcome to join at #openvpn-meeting on Libera IRC 
network every Wednesday at 14:00 Central European Time.

Kind regards,
Johan Draaisma

--------------J44KRCwhqGYKHh4QJpL0Hh7A
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p> Meeting summary for 21 May 2025:</p>
    <ul
style="box-sizing: inherit; list-style: circle; padding-left: 1rem; margin-top: 0px; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255); color: rgba(0, 0, 0, 0.85); font-family: -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Roboto, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, &quot;Segoe UI Symbol&quot;; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; text-align: start; text-indent: 0px; text-transform: none; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">
      <li
style="box-sizing: inherit; margin-bottom: 0.2rem; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255); margin-left: 1.5rem; list-style-type: disc;">
        <p
style="box-sizing: inherit; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);"><strong
style="box-sizing: inherit; font-weight: bolder; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);">New:
            Changes to community pages on main website</strong><br
style="box-sizing: inherit; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);">
          Company reached out to novaflash about proposed changes.<br
style="box-sizing: inherit; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);">
          novaflash involved ordex and lev__ for feedback/ideas.<br
style="box-sizing: inherit; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);">
          It's about cleaning up and revamping the community section,
          remove old releases, focus on latest release, and so on.<br
style="box-sizing: inherit; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);">
          Feedback from last time was incorporated: 'community' item was
          moved out of main menu. Community gave feedback; it was moved
          back to main menu.<br
style="box-sizing: inherit; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);">
          Renaming of Community to open source can be done partially -
          got pushback from openvpn inc CEO to rename community to open
          source in the main menu. Rest of places we can update it
          though to mention open source. Basic idea is to revamp the
          community page on main website so it shows just the main
          download artifacts and release notes of latest version, plus
          where community resources can be found, plus where developers
          can be reached. A list of resources and contact methods has
          been collected and while not set in stone will be passed for
          an initial design to be reviewed later.</p>
      </li>
      <li
style="box-sizing: inherit; margin-bottom: 0.2rem; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255); margin-left: 1.5rem; list-style-type: disc;">
        <p
style="box-sizing: inherit; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);"><strong
style="box-sizing: inherit; font-weight: bolder; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);">Updated:
            Release 2.7</strong><br
style="box-sizing: inherit; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);">
          Current estimates are to have all major code items in by May
          1st and then a release on July 1st.<br
style="box-sizing: inherit; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);">
          Together with 2.7 a new Linux DCO module based on upstreamed
          (linux kernel) codebase will be released, the code for this is
          done, bugs being fixed.<br
style="box-sizing: inherit; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);">
          Together with 2.7 a new Windows DCO module with server support
          will be released. The code for this is done but needs more
          testing.<br
style="box-sizing: inherit; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);">
          DNS changes are mostly in but some issues are still found on
          Windows and need to be addressed.<br
style="box-sizing: inherit; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);">
          Currently we feel that it looks reasonable to do a 2.7 alpha
          release next week.<br
style="box-sizing: inherit; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);">
          For the actual release we should still do a reformatting to
          clang-format so master and 2.7 have the same formatting.
          Otherwise backporting bugfixes will be a pain.</p>
      </li>
      <li
style="box-sizing: inherit; margin-bottom: 0.2rem; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255); margin-left: 1.5rem; list-style-type: disc;">
        <p
style="box-sizing: inherit; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);"><strong
style="box-sizing: inherit; font-weight: bolder; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);">Updated:
            DCO tasks</strong><br
style="box-sizing: inherit; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);">
          Implementation of epoch data keys in user space in OpenVPN2
          and OpenVPN3 are both done now. For Windows, Linux, and
          FreeBSD DCO this implementation still needs to happen.<br
style="box-sizing: inherit; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);">
          lev__ has started work on epoch data keys in Windows DCO.
          Windows DCO has also support for server mode now so has some
          significant changes coming with 2.7. Red Hat 9.6 introduced a
          change that breaks the current production DCO kernel module
          code. A fix for this is available now.<br
style="box-sizing: inherit; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);">
          Programs that rely on this like Access Server and OpenVPN3
          Linux will push out an updated DCO kernel module with this fix
          soonish.<br
style="box-sizing: inherit; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);">
          There are still some bugfixes for the backport copy of linux
          kernel upstreamed version of DCO for 2.7 to be resolved.</p>
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
          When: based on an availabilty poll and by agreement the
          weekend of 25 and 26 october as meeting days, with days before
          and after as travel days, seems best.<br
style="box-sizing: inherit; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);">
          Where: Napoli, Italy.<br
style="box-sizing: inherit; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);">
          Meeting room: giaan will take a look into this.<br
style="box-sizing: inherit; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);">
          Hotel: giaan will take a look into this.<br
style="box-sizing: inherit; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);">
          Beer: yes.<br
style="box-sizing: inherit; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);">
          T-shirts: yes.</p>
      </li>
    </ul>
    <p>As always you're welcome to join at #openvpn-meeting on Libera
      IRC network every Wednesday at 14:00 Central European Time. </p>
    <p>Kind regards,<br>
      Johan Draaisma<br>
    </p>
  </body>
</html>

--------------J44KRCwhqGYKHh4QJpL0Hh7A--

