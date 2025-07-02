Content-Type: multipart/alternative;
 boundary="------------a55ln8PbOtBRLpJm3jUbGqIp"
Message-ID: <7bfacfa6-1f47-4076-92d5-309c7175f4c9@...2722...>
Date: Wed, 2 Jul 2025 14:55:09 +0200
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
--------------a55ln8PbOtBRLpJm3jUbGqIp
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Meeting summary for 2 July 2025:

  *

    *New: cve.mitre.org deprecation notice*
    The MITRE CVE site we are linking to for all CVE record references
    has a deprecation notice.
    Instead cve.org is being advised as the site to use from now on.
    Suggestion from novaflash is to search/replace all links and update
    them accordingly to go to the new site.
    novaflash will make an internal company ticket to update links on
    the main site.
    and novaflash will search/replace things on community wiki to do the
    same.

  *

    *New: minor issue on community.openvpn.net site*
    While not causing critical issues, there are some cache related
    issues caused by cloudflare.
    This requires some finetuning of settings to solve issues like:
    Logging in requires to use query string parameter to defeat cache.
    Changes like enabling dark mode can linger in cache and affect other
    visitors.
    Sometimes pages added don't show in menu until cache is defeated in
    some way.
    The "are you human" screen is quite persistent and annoying, perhaps
    it can be fixed.
    novaflash is working with the company to look into finetuning the
    cloudflare settings to address these issues.

  *

    *New: format code using clang formatting*
    It seems prudent to do this before the real 2.7 release.
    It was discussed and there's some additional work to be paid either
    on reviewer or submitter side.
    Strategy will be; get all code into beta1, collect bugfixes,
    reformat everything, then beta2.
    Collect more bugfixes and then do release 2.7.0 and branch it off
    into its own release branch.

  *

    *Updated: Changes to community pages on main website*
    Company has published the updated community
    page:https://openvpn.net/community/
    This design was created in collaboration with community members lev,
    ordex, and novaflash.
    If any changes are requested please relay them to novaflash as per
    usual, and he will forward it internally.

  *

    *Updated: Release 2.7*
    For the DNS related changes, the macOS DNS script is merged but
    there's still some minor tweaks being made.
    For multisocket, a bug report came in, and we're working to fix that.
    For the DCO related changes, DCO+TCP is improving. Epoch data keys
    still needs to be done, float has a patch ready for review, mssfix
    not planned yet. For the live route updates changes, chances are
    improving that it may get in to 2.7 after all.

  *

    *Updated: push_update / live route updates*
    For client-side support, company did QA on it against the current
    only server implementation (cloudconnexa) and it works as expected.
    cron2 will put reviewing it on his to-do list.
    Server-side support patch is up and requires review and is a bit
    more involved, lev__ and company QA will work on it.

  *

    *Updated: OpenVPN community meetup 2025*
    https://community.openvpn.net/openvpn/wiki/CommunityMeetup2025
    When: weekend of 25 and 26 october.
    Where: Napoli, Italy.
    Meeting room: it looks like this may be
    it;https://www.hotelparadisonapoli.it/en/home-page.aspxwe will work
    to get budget cleared for this.
    Hotel: probably Paradiso Napoli. Beer: yes.
    T-shirts: yes.

As always you're welcome to join at #openvpn-meeting on Libera IRC 
network every Wednesday at 14:00 Central European Time.

Kind regards,
Johan Draaisma

--------------a55ln8PbOtBRLpJm3jUbGqIp
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: 8bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p> Meeting summary for 2 July 2025:</p>
    <ul
style="box-sizing: inherit; list-style: circle; padding-left: 1rem; margin-top: 0px; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255); color: rgba(0, 0, 0, 0.85); font-family: -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Roboto, Helvetica, Arial, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, &quot;Segoe UI Symbol&quot;; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; text-align: start; text-indent: 0px; text-transform: none; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">
      <li
style="box-sizing: inherit; margin-bottom: 0.2rem; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255); margin-left: 1.5rem; list-style-type: disc;">
        <p
style="box-sizing: inherit; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);"><strong
style="box-sizing: inherit; font-weight: bolder; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);">New:
            cve.mitre.org deprecation notice</strong><br
style="box-sizing: inherit; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);">
          The MITRE CVE site we are linking to for all CVE record
          references has a deprecation notice.<br
style="box-sizing: inherit; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);">
          Instead cve.org is being advised as the site to use from now
          on. Suggestion from novaflash is to search/replace all links
          and update them accordingly to go to the new site.<br
style="box-sizing: inherit; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);">
          novaflash will make an internal company ticket to update links
          on the main site.<br
style="box-sizing: inherit; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);">
          and novaflash will search/replace things on community wiki to
          do the same.</p>
      </li>
      <li
style="box-sizing: inherit; margin-bottom: 0.2rem; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255); margin-left: 1.5rem; list-style-type: disc;">
        <p
style="box-sizing: inherit; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);"><strong
style="box-sizing: inherit; font-weight: bolder; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);">New:
            minor issue on community.openvpn.net site</strong><br
style="box-sizing: inherit; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);">
          While not causing critical issues, there are some cache
          related issues caused by cloudflare.<br
style="box-sizing: inherit; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);">
          This requires some finetuning of settings to solve issues
          like: Logging in requires to use query string parameter to
          defeat cache.<br
style="box-sizing: inherit; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);">
          Changes like enabling dark mode can linger in cache and affect
          other visitors.<br
style="box-sizing: inherit; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);">
          Sometimes pages added don't show in menu until cache is
          defeated in some way.<br
style="box-sizing: inherit; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);">
          The "are you human" screen is quite persistent and annoying,
          perhaps it can be fixed.<br
style="box-sizing: inherit; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);">
          novaflash is working with the company to look into finetuning
          the cloudflare settings to address these issues.</p>
      </li>
      <li
style="box-sizing: inherit; margin-bottom: 0.2rem; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255); margin-left: 1.5rem; list-style-type: disc;">
        <p
style="box-sizing: inherit; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);"><strong
style="box-sizing: inherit; font-weight: bolder; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);">New:
            format code using clang formatting</strong><br
style="box-sizing: inherit; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);">
          It seems prudent to do this before the real 2.7 release.<br
style="box-sizing: inherit; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);">
          It was discussed and there's some additional work to be paid
          either on reviewer or submitter side.<br
style="box-sizing: inherit; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);">
          Strategy will be; get all code into beta1, collect bugfixes,
          reformat everything, then beta2.<br
style="box-sizing: inherit; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);">
          Collect more bugfixes and then do release 2.7.0 and branch it
          off into its own release branch.</p>
      </li>
      <li
style="box-sizing: inherit; margin-bottom: 0.2rem; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255); margin-left: 1.5rem; list-style-type: disc;">
        <p
style="box-sizing: inherit; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);"><strong
style="box-sizing: inherit; font-weight: bolder; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);">Updated:
            Changes to community pages on main website</strong><br
style="box-sizing: inherit; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);">
          Company has published the updated community page:<span> </span><a
            href="https://openvpn.net/community/"
style="box-sizing: inherit; background-color: transparent; color: rgb(24, 144, 255); text-decoration: none; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);"
            class="moz-txt-link-freetext">https://openvpn.net/community/</a><br
style="box-sizing: inherit; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);">
          This design was created in collaboration with community
          members lev, ordex, and novaflash.<br
style="box-sizing: inherit; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);">
          If any changes are requested please relay them to novaflash as
          per usual, and he will forward it internally.</p>
      </li>
      <li
style="box-sizing: inherit; margin-bottom: 0.2rem; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255); margin-left: 1.5rem; list-style-type: disc;">
        <p
style="box-sizing: inherit; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);"><strong
style="box-sizing: inherit; font-weight: bolder; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);">Updated:
            Release 2.7</strong><br
style="box-sizing: inherit; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);">
          For the DNS related changes, the macOS DNS script is merged
          but there's still some minor tweaks being made.<br
style="box-sizing: inherit; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);">
          For multisocket, a bug report came in, and we're working to
          fix that.<br
style="box-sizing: inherit; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);">
          For the DCO related changes, DCO+TCP is improving. Epoch data
          keys still needs to be done, float has a patch ready for
          review, mssfix not planned yet. For the live route updates
          changes, chances are improving that it may get in to 2.7 after
          all.</p>
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
          cron2 will put reviewing it on his to-do list.<br
style="box-sizing: inherit; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);">
          Server-side support patch is up and requires review and is a
          bit more involved, lev__ and company QA will work on it.</p>
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
          When: weekend of 25 and 26 october.<br
style="box-sizing: inherit; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);">
          Where: Napoli, Italy.<br
style="box-sizing: inherit; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);">
          Meeting room: it looks like this may be it;<span> </span><a
            href="https://www.hotelparadisonapoli.it/en/home-page.aspx"
style="box-sizing: inherit; background-color: transparent; color: rgb(24, 144, 255); text-decoration: none; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);"
            class="moz-txt-link-freetext">https://www.hotelparadisonapoli.it/en/home-page.aspx</a><span> </span>we
          will work to get budget cleared for this.<br
style="box-sizing: inherit; scrollbar-width: thin; scrollbar-color: rgba(0, 0, 0, 0.25) rgb(255, 255, 255);">
          Hotel: probably Paradiso Napoli. Beer: yes.<br
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

--------------a55ln8PbOtBRLpJm3jUbGqIp--

