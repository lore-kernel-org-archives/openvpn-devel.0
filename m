Content-Type: multipart/alternative;
 boundary="------------OJbIzg4wK695X2RQ9ZLb3ynp"
Message-ID: <35b070f9-2daf-43f5-b174-09b13d41b6b9@...2751...>
Date: Wed, 6 Mar 2024 13:52:14 +0100
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
--------------OJbIzg4wK695X2RQ9ZLb3ynp
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Meeting summary for 6 March 2024:

  * *New: openvpn 2.6.10 release*
    /There are some Windows related issues to be resolved in this release./
    /Tentatively planned for end of next week./

  * *Updated: server-side testing status and next meeting*
      o mattock has created a PoC of --dev null "does a client connect"
        check
          + client config has "--dev null" and "ifconfig-noexec"
              # uses an "up" script to stop the parent (openvpn) process
                gracefully soon after connection initialization
              # the "up" script almost certainly includes some
                Linux-specifisms
              # example usage:
                  * openvpn --config client.conf |grep "Initialization
                    Sequence Completed"
              # integration with "make check", buildbot, etc. is still
                missing
              # next steps:
                  * integrate the PoC with "make check"
                  * make the script portable
                  * buildbot integration (if required separately)
        /We want to continue on this topic once a bit more progress has
        been made./

  * *Updated: forums topics*
    /A new forum is under construction. But already spammers have found it./
    /Suggestion is to give openvpn_inc user novaflash and Pippin_ full
    admin rights so they can help find a solution and help maintain the
    forums./
    /To be discussed with ecrist./
    /Layout and categories look ok?/
    /Access for Mod to delete users that put spam url in profile and
    never post a message, currently I cannot discover a way to delete
    those/(1)
    /Access for Mod to edit user profiles/(1)
    /Mod guide, hard or soft delete (chuck board?), what to do with
    GDPR, etc. (write it down and actually make it available to mods,
    maybe a hidden topic)/
    /Access for mods to logs so one can see what others did/
    /Considering some existing platform to do discussions next to forum?/
    /(1) May not be necessary if enough admin available/

  * *Updated: website release process*
    /Finally they have come up with a solution that they will run by
    novaflash this week./

  * *New: breaking DCO changes, how to approach?*
    /This topic appeared but we do not have details on what this entails
    exactly./
    /Perhaps ordex can provide details on what this is about, so we can
    have a meaningful discussion./

  * *Updated: Status of SBOM*
    /There was a discussion between MaxF and djpig and others./
    /For OpenVPN2 / OpenVPN-NL, there is not much overlap, as OpenVPN2
    doesn't ship much in terms of libraries, but OpenVPN-NL does./
    /The interesting use-case for an SBOM is really the OpenVPN Windows
    GUI client./

  * *Updated: Debian and Ubuntu snapshot packages and buildbot*
      o Cloudfront + S3 + aptly PoC is complete and seems to work fine
      o Cloudfront caches need to be invalidated when new packages are
        added or removed, or the apt repository will end up in an
        inconsistent state almost immediately
      o If we use swupdate.openvpn.net to publish the snapshots we will
        have to deal with cloudfront + cloudflare.
      o We can choose to just publish snapshots on build.openvpn.net.
        This seems the preferred option.
      o Alternatively a new S3 bucket + cloudfront can be done. Whatever
        people like best.
      o Buildbot integration is missing, but should be fairly
        straightforward
      o This will probably have to wait until "--dev null" is done

As always you're welcome to join at #openvpn-meeting on Libera IRC 
network every Wednesday at 13:00 Central European Time.

Kind regards,
Johan Draaisma

--------------OJbIzg4wK695X2RQ9ZLb3ynp
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p> Meeting summary for 6 March 2024:</p>
    <ul
style="color: rgb(0, 0, 0); font-family: Verdana, Arial, &quot;Bitstream Vera Sans&quot;, Helvetica, sans-serif; font-size: 13px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">
      <li><strong>New: openvpn 2.6.10 release</strong><br>
        <em>There are some Windows related issues to be resolved in this
          release.</em><br>
        <em>Tentatively planned for end of next week.</em><br>
      </li>
    </ul>
    <ul
style="color: rgb(0, 0, 0); font-family: Verdana, Arial, &quot;Bitstream Vera Sans&quot;, Helvetica, sans-serif; font-size: 13px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">
      <li><strong>Updated: server-side testing status and next meeting</strong><br>
        <ul>
          <li>mattock has created a PoC of --dev null "does a client
            connect" check
            <ul>
              <li>client config has "--dev null" and "ifconfig-noexec"
                <ul>
                  <li>uses an "up" script to stop the parent (openvpn)
                    process gracefully soon after connection
                    initialization</li>
                  <li>the "up" script almost certainly includes some
                    Linux-specifisms</li>
                  <li>example usage:
                    <ul>
                      <li>openvpn --config client.conf |grep
                        "Initialization Sequence Completed"</li>
                    </ul>
                  </li>
                  <li>integration with "make check", buildbot, etc. is
                    still missing</li>
                  <li>next steps:
                    <ul>
                      <li>integrate the PoC with "make check"</li>
                      <li>make the script portable</li>
                      <li>buildbot integration (if required separately)</li>
                    </ul>
                  </li>
                </ul>
              </li>
            </ul>
            <em>We want to continue on this topic once a bit more
              progress has been made.</em><br>
          </li>
        </ul>
      </li>
    </ul>
    <ul
style="color: rgb(0, 0, 0); font-family: Verdana, Arial, &quot;Bitstream Vera Sans&quot;, Helvetica, sans-serif; font-size: 13px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">
      <li><strong>Updated: forums topics</strong><br>
        <em>A new forum is under construction. But already spammers have
          found it.</em><br>
        <em>Suggestion is to give openvpn_inc user novaflash and Pippin_
          full admin rights so they can help find a solution and help
          maintain the forums.</em><br>
        <em>To be discussed with ecrist.</em><br>
        <em>Layout and categories look ok?</em><br>
        <em>Access for Mod to delete users that put spam url in profile
          and never post a message, currently I cannot discover a way to
          delete those</em>(1)<br>
        <em>Access for Mod to edit user profiles</em>(1)<br>
        <em>Mod guide, hard or soft delete (chuck board?), what to do
          with GDPR, etc. (write it down and actually make it available
          to mods, maybe a hidden topic)</em><br>
        <em>Access for mods to logs so one can see what others did</em><br>
        <em>Considering some existing platform to do discussions next to
          forum?</em><br>
        <em>(1) May not be necessary if enough admin available</em><br>
      </li>
    </ul>
    <ul
style="color: rgb(0, 0, 0); font-family: Verdana, Arial, &quot;Bitstream Vera Sans&quot;, Helvetica, sans-serif; font-size: 13px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">
      <li><strong>Updated: website release process</strong><br>
        <em>Finally they have come up with a solution that they will run
          by novaflash this week.</em><br>
      </li>
    </ul>
    <ul
style="color: rgb(0, 0, 0); font-family: Verdana, Arial, &quot;Bitstream Vera Sans&quot;, Helvetica, sans-serif; font-size: 13px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">
      <li><strong>New: breaking DCO changes, how to approach?</strong><br>
        <em>This topic appeared but we do not have details on what this
          entails exactly.</em><br>
        <em>Perhaps ordex can provide details on what this is about, so
          we can have a meaningful discussion.</em><br>
      </li>
    </ul>
    <ul
style="color: rgb(0, 0, 0); font-family: Verdana, Arial, &quot;Bitstream Vera Sans&quot;, Helvetica, sans-serif; font-size: 13px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">
      <li><strong>Updated: Status of SBOM</strong><br>
        <em>There was a discussion between MaxF and djpig and others.</em><br>
        <em>For OpenVPN2 / OpenVPN-NL, there is not much overlap, as
          OpenVPN2 doesn't ship much in terms of libraries, but
          OpenVPN-NL does.</em><br>
        <em>The interesting use-case for an SBOM is really the OpenVPN
          Windows GUI client.</em><br>
      </li>
    </ul>
    <ul
style="color: rgb(0, 0, 0); font-family: Verdana, Arial, &quot;Bitstream Vera Sans&quot;, Helvetica, sans-serif; font-size: 13px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">
      <li><strong>Updated: Debian and Ubuntu snapshot packages and
          buildbot</strong><br>
        <ul>
          <li>Cloudfront + S3 + aptly PoC is complete and seems to work
            fine</li>
          <li>Cloudfront caches need to be invalidated when new packages
            are added or removed, or the apt repository will end up in
            an inconsistent state almost immediately</li>
          <li>If we use swupdate.openvpn.net to publish the snapshots we
            will have to deal with cloudfront + cloudflare.</li>
          <li>We can choose to just publish snapshots on
            build.openvpn.net. This seems the preferred option.</li>
          <li>Alternatively a new S3 bucket + cloudfront can be done.
            Whatever people like best.</li>
          <li>Buildbot integration is missing, but should be fairly
            straightforward</li>
          <li>This will probably have to wait until "--dev null" is done</li>
        </ul>
      </li>
    </ul>
    <p>As always you're welcome to join at #openvpn-meeting on Libera
      IRC network every Wednesday at 13:00 Central European Time.</p>
    <p>Kind regards,<br>
      Johan Draaisma<br>
    </p>
  </body>
</html>

--------------OJbIzg4wK695X2RQ9ZLb3ynp--

