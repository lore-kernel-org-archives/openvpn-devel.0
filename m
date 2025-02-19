Content-Type: multipart/alternative;
 boundary="------------0dgYoEcXF0vVs3gieNR1av9s"
Message-ID: <35d9fd6d-5a46-40dc-b8c5-c6bed9d5d6c2@...2722...>
Date: Wed, 19 Feb 2025 16:33:39 +0100
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
--------------0dgYoEcXF0vVs3gieNR1av9s
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit

Meeting summary for 19 February 2025:

  * *New: community downloads hard to find on main website*
    /Three suggestions that will be passed on to company:/
    /1. rename community to open source, there is a consensus in the
    meeting that community could be anything and open source is specific
    to openvpn open source software./
    /2. open source community would prefer to see open source downloads
    back on the 'second line' main menu./
    /3. it was suggested to add a call to action like "looking for open
    source downloads?" at the bottom of the page./

  * *Updated: OpenSSL update severity high*
    /We discussed internally and looks like it doesn't affect us. But
    since a copy of OpenSSL is shipped with the Windows installer, we'll
    just update that copy just to be sure./
    /This will be shipped as a 2.6.13-I002 update/revision to the MSI
    installer only, not a full OpenVPN release./

  * *Updated: Release 2.7*
    /We want to get our release done before the next major Debian release./
    /This means tentatively getting stuff for 2.7 done before March 1 or
    so, and release early April./
    /Looking into a weird failure to deliver properly working openssl
    binary on amd64 on master. Looks like with old MSVC the OpenSSL
    ARM64 bug we observed doesn't occur./
    /We need to decide on switching to newer API for DCO and making a
    newer out-of-tree DCO. We're already working towards an updated
    out-of-tree DCO copy./
    /There is a party interested in doing a security audit of OpenVPN
    2.7, there are some questions to be clarified about it being a code
    audit and/or testing./

  * *Updated: data format v3 / epoch data keys*
    /Implementation in user space in OpenVPN2 and OpenVPN3 are both done
    now./
    /Since Linux DCO is in the process of upstreaming to Linux kernel,
    we're not changing the implementation to include this now, but will
    do it after./
    /Windows DCO multipeer support is currently in review process - once
    that part is done we can look at adding the necessary changes for
    epoch data keys./

  * *Udated: DCO Linux upstreaming*
    /Upstreaming DCO to Linux is proceeding, it is in review stage at
    the moment./
    /Patchset v19 lead to some further discussions which are believed to
    now be resolved, v20 should land by end of this week./

  * *Updated: multi-socket support*
    /​https://gerrit.openvpn.net/q/topic:%22multisocket%22
    <https://gerrit.openvpn.net/q/topic:%22multisocket%22>/
    /Currently there's 3 patches left. A trivial one, then one that may
    need more discussion, and then the big one that makes it all work./
    /It generally works but cron2 was able to trigger crashes after
    stress testing it - so that needs to be addressed./

  * *Updated: DCO windows multi-peer*
    /This is in review now - it compiles and works./
    /cron2 is looking into stress testing it to see what breaks./

  * *Updated: new --dns option support
    */​https://gerrit.openvpn.net/q/topic:%22dns+option%22
    <https://gerrit.openvpn.net/q/topic:%22dns+option%22>//It's going to
    be updated based on feedback received and discussions had on how to
    handle the situation of being unable to handle certain DNS options.
    //Expect it to be ready for review again by end of the week./

As always you're welcome to join at #openvpn-meeting on Libera IRC 
network every Wednesday at 14:00 Central European Time.

Kind regards,
Johan Draaisma

--------------0dgYoEcXF0vVs3gieNR1av9s
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: 8bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p> Meeting summary for 19 February 2025:</p>
    <ul
style="color: rgb(0, 0, 0); font-family: Verdana, Arial, &quot;Bitstream Vera Sans&quot;, Helvetica, sans-serif; font-size: 13px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">
      <li><strong>New: community downloads hard to find on main website</strong><br>
        <em>Three suggestions that will be passed on to company:</em><br>
        <em>1. rename community to open source, there is a consensus in
          the meeting that community could be anything and open source
          is specific to openvpn open source software.</em><br>
        <em>2. open source community would prefer to see open source
          downloads back on the 'second line' main menu.</em><br>
        <em>3. it was suggested to add a call to action like "looking
          for open source downloads?" at the bottom of the page.</em></li>
    </ul>
    <ul
style="color: rgb(0, 0, 0); font-family: Verdana, Arial, &quot;Bitstream Vera Sans&quot;, Helvetica, sans-serif; font-size: 13px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">
      <li><strong>Updated: OpenSSL update severity high</strong><br>
        <em>We discussed internally and looks like it doesn't affect us.
          But since a copy of OpenSSL is shipped with the Windows
          installer, we'll just update that copy just to be sure.</em><br>
        <em>This will be shipped as a 2.6.13-I002 update/revision to the
          MSI installer only, not a full OpenVPN release.</em></li>
    </ul>
    <ul
style="color: rgb(0, 0, 0); font-family: Verdana, Arial, &quot;Bitstream Vera Sans&quot;, Helvetica, sans-serif; font-size: 13px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">
      <li><strong>Updated: Release 2.7</strong><br>
        <em>We want to get our release done before the next major Debian
          release.</em><br>
        <em>This means tentatively getting stuff for 2.7 done before
          March 1 or so, and release early April.</em><br>
        <em>Looking into a weird failure to deliver properly working
          openssl binary on amd64 on master. Looks like with old MSVC
          the OpenSSL ARM64 bug we observed doesn't occur.</em><br>
        <em>We need to decide on switching to newer API for DCO and
          making a newer out-of-tree DCO. We're already working towards
          an updated out-of-tree DCO copy.</em><br>
        <em>There is a party interested in doing a security audit of
          OpenVPN 2.7, there are some questions to be clarified about it
          being a code audit and/or testing.</em></li>
    </ul>
    <ul
style="color: rgb(0, 0, 0); font-family: Verdana, Arial, &quot;Bitstream Vera Sans&quot;, Helvetica, sans-serif; font-size: 13px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">
      <li><strong>Updated: data format v3 / epoch data keys</strong><br>
        <em>Implementation in user space in OpenVPN2 and OpenVPN3 are
          both done now.</em><br>
        <em>Since Linux DCO is in the process of upstreaming to Linux
          kernel, we're not changing the implementation to include this
          now, but will do it after.</em><br>
        <em>Windows DCO multipeer support is currently in review process
          - once that part is done we can look at adding the necessary
          changes for epoch data keys.</em></li>
    </ul>
    <ul
style="color: rgb(0, 0, 0); font-family: Verdana, Arial, &quot;Bitstream Vera Sans&quot;, Helvetica, sans-serif; font-size: 13px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">
      <li><strong>Udated: DCO Linux upstreaming</strong><br>
        <em>Upstreaming DCO to Linux is proceeding, it is in review
          stage at the moment.</em><br>
        <em>Patchset v19 lead to some further discussions which are
          believed to now be resolved, v20 should land by end of this
          week.</em></li>
    </ul>
    <ul
style="color: rgb(0, 0, 0); font-family: Verdana, Arial, &quot;Bitstream Vera Sans&quot;, Helvetica, sans-serif; font-size: 13px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">
      <li><strong>Updated: multi-socket support</strong><br>
        <em><a class="ext-link"
            href="https://gerrit.openvpn.net/q/topic:%22multisocket%22"><span
              class="icon">​</span>https://gerrit.openvpn.net/q/topic:%22multisocket%22</a></em>
        <br>
        <em>Currently there's 3 patches left. A trivial one, then one
          that may need more discussion, and then the big one that makes
          it all work.</em><br>
        <em>It generally works but cron2 was able to trigger crashes
          after stress testing it - so that needs to be addressed.</em></li>
    </ul>
    <ul
style="color: rgb(0, 0, 0); font-family: Verdana, Arial, &quot;Bitstream Vera Sans&quot;, Helvetica, sans-serif; font-size: 13px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">
      <li><strong>Updated: DCO windows multi-peer</strong><br>
        <em>This is in review now - it compiles and works.</em><br>
        <em>cron2 is looking into stress testing it to see what breaks.</em></li>
    </ul>
    <ul
style="color: rgb(0, 0, 0); font-family: Verdana, Arial, &quot;Bitstream Vera Sans&quot;, Helvetica, sans-serif; font-size: 13px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">
      <li><strong>Updated: new --dns option support<br>
        </strong><em><a class="ext-link"
            href="https://gerrit.openvpn.net/q/topic:%22dns+option%22"><span
              class="icon">​</span>https://gerrit.openvpn.net/q/topic:%22dns+option%22<br>
          </a></em><em>It's going to be updated based on feedback
          received and discussions had on how to handle the situation of
          being unable to handle certain DNS options.<br>
        </em><em>Expect it to be ready for review again by end of the
          week.</em></li>
    </ul>
    <p>As always you're welcome to join at #openvpn-meeting on Libera
      IRC network every Wednesday at 14:00 Central European Time. </p>
    <p>Kind regards,<br>
      Johan Draaisma<br>
    </p>
  </body>
</html>

--------------0dgYoEcXF0vVs3gieNR1av9s--

