Content-Type: multipart/alternative;
 boundary="------------8lAppJqRAUf9CL4k2mNa9s1O"
Message-ID: <5454d4e8-d45d-40f9-8234-7a85b13d1580@...2722...>
Date: Wed, 23 Jul 2025 23:14:34 +0700
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
--------------8lAppJqRAUf9CL4k2mNa9s1O
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Meeting summary for 23 July 2025:

  *

    *Updated: Release 2.7*
    We planned for an alpha3 this week but decided to postpone because
    for DCO and push_update we have some fixes coming in.
    Float with DCO on Linux and Windows is now in and working. FreeBSD
    patch is in review.
    For multisocket the reported bug when peer IDs collide is now in.
    For the DCO related changes, DCO+TCP is improving. Epoch data keys
    still needs to be done, mssfix not planned yet.
    For DCO Windows driver there's some small bugfixes that can go out
    with alpha3. Let's see how reviewing and merging the pending items
    goes and then see if by next week an alpha3 can be made.

  *

    *Updated: push_update / live route updates*
    For client-side support, company did QA on it against the current
    only server implementation (cloudconnexa) and it works as expected.
    For server-side support, company did QA on it with openvpn2 but
    found some missing features that are being added now.
    At least client-side support will probably make it into alpha3.

As always you're welcome to join at #openvpn-meeting on Libera IRC 
network every Wednesday at 14:00 Central European Time.

Kind regards,
Johan Draaisma

--------------8lAppJqRAUf9CL4k2mNa9s1O
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p> Meeting summary for 23 July 2025:</p>
    <ul
style="box-sizing: inherit; list-style: circle; padding-left: 1rem; margin-top: 0px; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255); color: rgba(0, 0, 0, 0.85); font-family: -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Roboto, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, &quot;Segoe UI Symbol&quot;; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; text-align: start; text-indent: 0px; text-transform: none; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">
      <li
style="box-sizing: inherit; margin-bottom: 0.2rem; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255); margin-left: 1.5rem; list-style-type: disc;">
        <p
style="box-sizing: inherit; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);"><strong
style="box-sizing: inherit; font-weight: bolder; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);">Updated:
            Release 2.7</strong><br
style="box-sizing: inherit; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);">
          We planned for an alpha3 this week but decided to postpone
          because for DCO and push_update we have some fixes coming in.<br
style="box-sizing: inherit; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);">
          Float with DCO on Linux and Windows is now in and working.
          FreeBSD patch is in review.<br
style="box-sizing: inherit; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);">
          For multisocket the reported bug when peer IDs collide is now
          in.<br
style="box-sizing: inherit; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);">
          For the DCO related changes, DCO+TCP is improving. Epoch data
          keys still needs to be done, mssfix not planned yet.<br
style="box-sizing: inherit; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);">
          For DCO Windows driver there's some small bugfixes that can go
          out with alpha3. Let's see how reviewing and merging the
          pending items goes and then see if by next week an alpha3 can
          be made.</p>
      </li>
      <li
style="box-sizing: inherit; margin-bottom: 0.2rem; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255); margin-left: 1.5rem; list-style-type: disc;">
        <p
style="box-sizing: inherit; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);"><strong
style="box-sizing: inherit; font-weight: bolder; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);">Updated:
            push_update / live route updates</strong><br
style="box-sizing: inherit; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);">
          For client-side support, company did QA on it against the
          current only server implementation (cloudconnexa) and it works
          as expected.<br
style="box-sizing: inherit; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);">
          For server-side support, company did QA on it with openvpn2
          but found some missing features that are being added now.<br
style="box-sizing: inherit; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);">
          At least client-side support will probably make it into
          alpha3.</p>
      </li>
    </ul>
    <p>As always you're welcome to join at #openvpn-meeting on Libera
      IRC network every Wednesday at 14:00 Central European Time. </p>
    <p>Kind regards,<br>
      Johan Draaisma<br>
    </p>
  </body>
</html>

--------------8lAppJqRAUf9CL4k2mNa9s1O--

