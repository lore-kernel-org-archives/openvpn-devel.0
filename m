Content-Type: multipart/alternative;
 boundary="------------wo0hG20VMFotkyPI0b1AxMJi"
Message-ID: <aa06cd4f-f6d1-491d-9c93-e79cafda0562@...2722...>
Date: Wed, 27 Aug 2025 19:53:41 +0700
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
--------------wo0hG20VMFotkyPI0b1AxMJi
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Meeting summary for 27 August 2025:

  *

    *Updated: Release 2.7*
    DCO for Windows multipeer statistics driver part is done - userspace
    part is waiting review.
    The FreeBSD patch for float was merged, should show up in 14.4 probably.
    Planned release date for 2.7 beta1 updated to September 4th. These
    are some known remaining tasks:
    lev is working on broken "bytecount" functionality when using
    Windows DCO in server mode.
    Epoch data keys for Linux DCO and Windows DCO can be done in a minor
    release after 2.7.0.
    However ralf_lici is already looking into adding it into the Linux
    DCO right now.
    PUSH_UPDATE review and server-side support - cron2 wants to discuss
    changes.
    mi prefix handling, int/uint fixes, and the new 'real route' gateway
    handling.

  *

    *New: wolfSSL license changed from gplv2 to gplv3*
    The release notes of wolfSSL indicate the license changed to GPLv3.
    This basically makes wolfSSL incompatible in regards to licensing
    with OpenVPN.
    plaisthos will open an issue with them to either remove OpenVPN
    support or give a solution to remain licensing compatible.
    maxf has reached out to wolfSSL about this, and will wait a bit
    before adding a warning to README.wolfssl about this licensing
    incompatibility.

  *

    *Updated: t_server and t_client testing framework*
    mattock reports progress on building automated testing environment
    for really old OpenVPN versions.
    This covers tests for versions going back to 2.2.

As always you're welcome to join at #openvpn-meeting on Libera IRC 
network every Wednesday at 14:00 Central European Time.

Kind regards,
Johan Draaisma

--------------wo0hG20VMFotkyPI0b1AxMJi
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: 8bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p> Meeting summary for 27 August 2025:</p>
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
          Planned release date for 2.7 beta1 updated to September 4th.
          These are some known remaining tasks:<br
style="box-sizing: inherit; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);">
          lev is working on broken "bytecount" functionality when using
          Windows DCO in server mode.<br
style="box-sizing: inherit; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);">
          Epoch data keys for Linux DCO and Windows DCO can be done in a
          minor release after 2.7.0.<br
style="box-sizing: inherit; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);">
          However ralf_lici is already looking into adding it into the
          Linux DCO right now.<br
style="box-sizing: inherit; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);">
          PUSH_UPDATE review and server-side support - cron2 wants to
          discuss changes.<br
style="box-sizing: inherit; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);">
          mi prefix handling, int/uint fixes, and the new 'real route'
          gateway handling.</p>
      </li>
      <li
style="box-sizing: inherit; margin-bottom: 0.2rem; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255); margin-left: 1.5rem; list-style-type: disc;">
        <p
style="box-sizing: inherit; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);"><strong
style="box-sizing: inherit; font-weight: bolder; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);">New:
            wolfSSL license changed from gplv2 to gplv3</strong><br
style="box-sizing: inherit; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);">
          The release notes of wolfSSL indicate the license changed to
          GPLv3.<br
style="box-sizing: inherit; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);">
          This basically makes wolfSSL incompatible in regards to
          licensing with OpenVPN.<br
style="box-sizing: inherit; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);">
          plaisthos will open an issue with them to either remove
          OpenVPN support or give a solution to remain licensing
          compatible.<br
style="box-sizing: inherit; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);">
          maxf has reached out to wolfSSL about this, and will wait a
          bit before adding a warning to README.wolfssl about this
          licensing incompatibility.</p>
      </li>
      <li
style="box-sizing: inherit; margin-bottom: 0.2rem; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255); margin-left: 1.5rem; list-style-type: disc;">
        <p
style="box-sizing: inherit; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);"><strong
style="box-sizing: inherit; font-weight: bolder; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);">Updated:
            t_server and t_client testing framework</strong><span> </span><br>
          mattock reports progress on building automated testing
          environment for really old OpenVPN versions.<br
style="box-sizing: inherit; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);">
          This covers tests for versions going back to 2.2.</p>
      </li>
    </ul>
    <p>As always you're welcome to join at #openvpn-meeting on Libera
      IRC network every Wednesday at 14:00 Central European Time. </p>
    <p>Kind regards,<br>
      Johan Draaisma<br>
    </p>
  </body>
</html>

--------------wo0hG20VMFotkyPI0b1AxMJi--

