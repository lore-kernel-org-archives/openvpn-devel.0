Content-Type: multipart/alternative;
 boundary="------------8LFail0q0UbgmO6q18fjLBB5"
Message-ID: <a7372d92-5588-4206-90b1-501e9c194feb@...2722...>
Date: Wed, 14 May 2025 18:22:37 +0200
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
--------------8LFail0q0UbgmO6q18fjLBB5
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Meeting summary for 14 May 2025:

  *

    *Updated, closed: community.openvpn.net wiki*
    On May 12 around 14:30 CET the community wiki was switched to the
    new wiki.
    It is expected that there may be some dead links or some content
    missing, we will work to update links and add content as
    needed/reported.
    lev__ and d12fk were added as users to the wiki during the meeting.
    Since all seems to be working so far this topic can be closed.

  *

    *Updated, closed: OpenVPN GUI improvements*
    In OpenVPN GUI code wintun is now replaced with win-dco. Some code
    cleanup still remains to be done.
    OpenVPN GUI is also capable of adding new adapters (tap or win-dco)
    as needed if more than one connection needs to be active at the same
    time.
    These changes are available in technical previews currently and will
    go out as an official release with OpenVPN 2.7.

  *

    *Updated: testing framework improvements*
    mattock reports that win-dco iroute testing is progressing but not
    yet done.
    server log tail output in t_server_null.sh on failure is now working.

  *

    *Updated: Release 2.7*
    Current estimates are to have all major code items in by May 1st and
    then a release on July 1st.
    We may try for an alpha release next week if possible.
    Together with 2.7 a new DCO module based on upstreamed (linux
    kernel) codebase will be released, the code for this is done, bugs
    being fixed.
    Only module versioning is in the works for DCO and this is expected
    to be done soonish.
    For Windows things look really good - auto-creation of adapters,
    wintun removal. Some small items for DNS pending.
    DNS looks promising, some very minor fixes left to get unix support
    and some bugfixes.

  *

    *Updated: data format v3 / epoch data keys*
    Implementation in user space in OpenVPN2 and OpenVPN3 are both done now.
    Developing support for epoch data keys in DCO Linux was waiting for
    linux upstreaming. That is now done, so development can start.
    Developing support for epoch data keys in DCO Windows is unblocked -
    to be picked up by lev when he is able.

As always you're welcome to join at #openvpn-meeting on Libera IRC 
network every Wednesday at 14:00 Central European Time.

Kind regards,
Johan Draaisma

--------------8LFail0q0UbgmO6q18fjLBB5
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p> Meeting summary for 14 May 2025:</p>
    <ul
style="box-sizing: inherit; list-style: circle; padding-left: 1rem; margin-top: 0px; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255); color: rgba(0, 0, 0, 0.85); font-family: -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Roboto, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, &quot;Segoe UI Symbol&quot;; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; text-align: start; text-indent: 0px; text-transform: none; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">
      <li
style="box-sizing: inherit; margin-bottom: 0.2rem; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255); margin-left: 1.5rem; list-style-type: disc;">
        <p
style="box-sizing: inherit; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);"><strong
style="box-sizing: inherit; font-weight: bolder; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);">Updated,
            closed: community.openvpn.net wiki</strong><br
style="box-sizing: inherit; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);">
          On May 12 around 14:30 CET the community wiki was switched to
          the new wiki.<br
style="box-sizing: inherit; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);">
          It is expected that there may be some dead links or some
          content missing, we will work to update links and add content
          as needed/reported.<br
style="box-sizing: inherit; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);">
          lev__ and d12fk were added as users to the wiki during the
          meeting.<br
style="box-sizing: inherit; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);">
          Since all seems to be working so far this topic can be closed.</p>
      </li>
      <li
style="box-sizing: inherit; margin-bottom: 0.2rem; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255); margin-left: 1.5rem; list-style-type: disc;">
        <p
style="box-sizing: inherit; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);"><strong
style="box-sizing: inherit; font-weight: bolder; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);">Updated,
            closed: OpenVPN GUI improvements</strong><br
style="box-sizing: inherit; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);">
          In OpenVPN GUI code wintun is now replaced with win-dco. Some
          code cleanup still remains to be done.<br
style="box-sizing: inherit; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);">
          OpenVPN GUI is also capable of adding new adapters (tap or
          win-dco) as needed if more than one connection needs to be
          active at the same time.<br
style="box-sizing: inherit; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);">
          These changes are available in technical previews currently
          and will go out as an official release with OpenVPN 2.7.</p>
      </li>
      <li
style="box-sizing: inherit; margin-bottom: 0.2rem; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255); margin-left: 1.5rem; list-style-type: disc;">
        <p
style="box-sizing: inherit; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);"><strong
style="box-sizing: inherit; font-weight: bolder; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);">Updated:
            testing framework improvements</strong><br
style="box-sizing: inherit; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);">
          mattock reports that win-dco iroute testing is progressing but
          not yet done.<br
style="box-sizing: inherit; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);">
          server log tail output in t_server_null.sh on failure is now
          working.</p>
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
          We may try for an alpha release next week if possible.<br
style="box-sizing: inherit; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);">
          Together with 2.7 a new DCO module based on upstreamed (linux
          kernel) codebase will be released, the code for this is done,
          bugs being fixed.<br
style="box-sizing: inherit; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);">
          Only module versioning is in the works for DCO and this is
          expected to be done soonish.<br
style="box-sizing: inherit; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);">
          For Windows things look really good - auto-creation of
          adapters, wintun removal. Some small items for DNS pending.<br
style="box-sizing: inherit; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);">
          DNS looks promising, some very minor fixes left to get unix
          support and some bugfixes.</p>
      </li>
      <li
style="box-sizing: inherit; margin-bottom: 0.2rem; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255); margin-left: 1.5rem; list-style-type: disc;">
        <p
style="box-sizing: inherit; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);"><strong
style="box-sizing: inherit; font-weight: bolder; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);">Updated:
            data format v3 / epoch data keys</strong><br
style="box-sizing: inherit; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);">
          Implementation in user space in OpenVPN2 and OpenVPN3 are both
          done now.<br
style="box-sizing: inherit; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);">
          Developing support for epoch data keys in DCO Linux was
          waiting for linux upstreaming. That is now done, so
          development can start.<br
style="box-sizing: inherit; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);">
          Developing support for epoch data keys in DCO Windows is
          unblocked - to be picked up by lev when he is able.</p>
      </li>
    </ul>
    <p></p>
    <p>As always you're welcome to join at #openvpn-meeting on Libera
      IRC network every Wednesday at 14:00 Central European Time. </p>
    <p>Kind regards,<br>
      Johan Draaisma<br>
    </p>
  </body>
</html>

--------------8LFail0q0UbgmO6q18fjLBB5--

