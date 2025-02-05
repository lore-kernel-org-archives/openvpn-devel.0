Content-Type: multipart/alternative;
 boundary="------------gAA2VlIRZLOjfhUOVbTFi2Qz"
Message-ID: <1f99d4f7-c665-4acc-8779-f0b13ef695a9@...2722...>
Date: Wed, 5 Feb 2025 14:56:45 +0100
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
--------------gAA2VlIRZLOjfhUOVbTFi2Qz
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit

Meeting summary for 5 February 2025:

  * *New: OpenSSL update with vulnerability severity "HIGH" is dropping
    next week.*
    /This might not really affect us but we will likely have to do a
    2.6.13 I002 binary for Windows./

  * *New: Windows MSI snapshots not updating*
    /lev asks if this can be looked at. will look into it./

  * *Updated: Release 2.7*
    /We want to get our release done before the next major Debian release./
    /This means tentatively getting stuff for 2.7 done before March 1 or
    so, and release early April./
    /Looking into a weird failure to deliver properly working openssl
    binary on amd64 on master./

  * *Updated: DCO Linux upstreaming*
    /Upstreaming DCO to Linux is proceeding, it is in review stage at
    the moment./
    /Patchset v19 will be sent in after addressing some more comments,
    hopefully end of week./

  * *Updated: data format v3 / epoch data keys*
    /RFC is here: ​https://github.com/OpenVPN/openvpn-rfc/pull/5
    <https://github.com/OpenVPN/openvpn-rfc/pull/5>./
    /PR: ​https://gerrit.openvpn.net/c/openvpn/+/806
    <https://gerrit.openvpn.net/c/openvpn/+/806> /
    /Implementation in OpenVPN3 is done./
    /Implementation in OpenvPN2 is almost fully merged, has been tested,
    and has just one patch and ack to go. MaxF will review for final acks./

  * *Updated: multi-socket support*
    /​https://gerrit.openvpn.net/q/topic:%22multisocket%22
    <https://gerrit.openvpn.net/q/topic:%22multisocket%22>/
    /ordex and giaan continuing the work on this./ /Found a new
    problematic area that has to be dug into, this will take some time./
  * *Updated: DCO windows multi-peer*
    /lev is continuing his work on this, looks like it's nearing
    completion./

  * *Updated: new --dns option support*
    /​https://gerrit.openvpn.net/q/topic:%22dns+option%22
    <https://gerrit.openvpn.net/q/topic:%22dns+option%22>/
    /Certain issues were found during testing, these are being addressed./
    /There's also a small bugfix coming for a case reported by an
    OpenVPN Inc. customer related to search domains./
    /And after discussions between d12fk and plaisthos some adjustments
    will be made to how DNS config is applied./

  * *Updated: push_update / live route updates*
    /mrbff and ordex are implementing the openvpn2 server and client
    support for push_update./
    /PR has approves, waiting review from cron2./

  * *Updated: community.openvpn.net wiki*
    /Some content has been copied over, perhaps not ideally but there's
    something./
    /A couple of community folks have access now and we can start to
    work on this wiki replacement by adding content./
    /A 404 page was added that explains that we are moving to a new wiki
    so in case people hit something that was removed or not moved over
    yet, people at least will know why./
    /action item for novaflash; To continue migrating pages we want a
    list of hits over last 6 months or so./
    /action item for novaflash; To do outgoing SMTP we need an account
    for an SMTP servce./

  * //*Updated: t_server_null improvements
    */ovpnlwip seems to work fine on all linux platforms, based on
    buildbot tests.///
    /This is in cron2's backlog to review./

As always you're welcome to join at #openvpn-meeting on Libera IRC 
network every Wednesday at 14:00 Central European Time.

Kind regards,
Johan Draaisma

--------------gAA2VlIRZLOjfhUOVbTFi2Qz
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: 8bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p> Meeting summary for 5 February 2025:</p>
    <ul
style="color: rgb(0, 0, 0); font-family: Verdana, Arial, &quot;Bitstream Vera Sans&quot;, Helvetica, sans-serif; font-size: 13px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">
      <li><strong>New: OpenSSL update with vulnerability severity "HIGH"
          is dropping next week.</strong><br>
        <em>This might not really affect us but we will likely have to
          do a 2.6.13 I002 binary for Windows.</em></li>
    </ul>
    <ul
style="color: rgb(0, 0, 0); font-family: Verdana, Arial, &quot;Bitstream Vera Sans&quot;, Helvetica, sans-serif; font-size: 13px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">
      <li><strong>New: Windows MSI snapshots not updating</strong><br>
        <em>lev asks if this can be looked at. will look into it.</em></li>
    </ul>
    <ul
style="color: rgb(0, 0, 0); font-family: Verdana, Arial, &quot;Bitstream Vera Sans&quot;, Helvetica, sans-serif; font-size: 13px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">
      <li><strong>Updated: Release 2.7</strong><br>
        <em>We want to get our release done before the next major Debian
          release.</em><br>
        <em>This means tentatively getting stuff for 2.7 done before
          March 1 or so, and release early April.</em><br>
        <em>Looking into a weird failure to deliver properly working
          openssl binary on amd64 on master.</em></li>
    </ul>
    <ul
style="color: rgb(0, 0, 0); font-family: Verdana, Arial, &quot;Bitstream Vera Sans&quot;, Helvetica, sans-serif; font-size: 13px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">
      <li><strong>Updated: DCO Linux upstreaming</strong><br>
        <em>Upstreaming DCO to Linux is proceeding, it is in review
          stage at the moment.</em><br>
        <em>Patchset v19 will be sent in after addressing some more
          comments, hopefully end of week.</em></li>
    </ul>
    <ul
style="color: rgb(0, 0, 0); font-family: Verdana, Arial, &quot;Bitstream Vera Sans&quot;, Helvetica, sans-serif; font-size: 13px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">
      <li><strong>Updated: data format v3 / epoch data keys</strong><br>
        <em>RFC is here: <a class="ext-link"
            href="https://github.com/OpenVPN/openvpn-rfc/pull/5"><span
              class="icon">​</span>https://github.com/OpenVPN/openvpn-rfc/pull/5</a>.</em><br>
        <em>PR: <a class="ext-link"
            href="https://gerrit.openvpn.net/c/openvpn/+/806"><span
              class="icon">​</span>https://gerrit.openvpn.net/c/openvpn/+/806</a>
        </em><br>
        <em>Implementation in OpenVPN3 is done.</em><br>
        <em>Implementation in OpenvPN2 is almost fully merged, has been
          tested, and has just one patch and ack to go. MaxF will review
          for final acks.</em></li>
    </ul>
    <ul
style="color: rgb(0, 0, 0); font-family: Verdana, Arial, &quot;Bitstream Vera Sans&quot;, Helvetica, sans-serif; font-size: 13px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">
      <li><strong>Updated: multi-socket support</strong><br>
        <em><a class="ext-link"
            href="https://gerrit.openvpn.net/q/topic:%22multisocket%22"><span
              class="icon">​</span>https://gerrit.openvpn.net/q/topic:%22multisocket%22</a></em>
        <br>
        <em>ordex and giaan continuing the work on this.</em>
        <em>Found a new problematic area that has to be dug into, this
          will take some time.</em><br>
      </li>
      <li><strong>Updated: DCO windows multi-peer</strong><br>
        <em>lev is continuing his work on this, looks like it's nearing
          completion.</em></li>
    </ul>
    <ul
style="color: rgb(0, 0, 0); font-family: Verdana, Arial, &quot;Bitstream Vera Sans&quot;, Helvetica, sans-serif; font-size: 13px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">
      <li><strong>Updated: new --dns option support</strong><br>
        <em><a class="ext-link"
            href="https://gerrit.openvpn.net/q/topic:%22dns+option%22"><span
              class="icon">​</span>https://gerrit.openvpn.net/q/topic:%22dns+option%22</a></em><br>
        <em>Certain issues were found during testing, these are being
          addressed.</em><br>
        <em>There's also a small bugfix coming for a case reported by an
          OpenVPN Inc. customer related to search domains.</em><br>
        <em>And after discussions between d12fk and plaisthos some
          adjustments will be made to how DNS config is applied.</em></li>
    </ul>
    <ul
style="color: rgb(0, 0, 0); font-family: Verdana, Arial, &quot;Bitstream Vera Sans&quot;, Helvetica, sans-serif; font-size: 13px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">
      <li><strong>Updated: push_update / live route updates</strong><br>
        <em>mrbff and ordex are implementing the openvpn2 server and
          client support for push_update.</em><br>
        <em>PR has approves, waiting review from cron2.</em></li>
    </ul>
    <ul
style="color: rgb(0, 0, 0); font-family: Verdana, Arial, &quot;Bitstream Vera Sans&quot;, Helvetica, sans-serif; font-size: 13px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">
      <li><strong>Updated: community.openvpn.net wiki</strong><br>
        <em>Some content has been copied over, perhaps not ideally but
          there's something.</em><br>
        <em>A couple of community folks have access now and we can start
          to work on this wiki replacement by adding content.</em><br>
        <em>A 404 page was added that explains that we are moving to a
          new wiki so in case people hit something that was removed or
          not moved over yet, people at least will know why.</em><br>
        <em>action item for novaflash; To continue migrating pages we
          want a list of hits over last 6 months or so.</em><br>
        <em>action item for novaflash; To do outgoing SMTP we need an
          account for an SMTP servce.</em></li>
    </ul>
    <ul
style="color: rgb(0, 0, 0); font-family: Verdana, Arial, &quot;Bitstream Vera Sans&quot;, Helvetica, sans-serif; font-size: 13px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">
      <li><em></em><strong>Updated: t_server_null improvements<br>
        </strong><em>ovpnlwip seems to work fine on all linux platforms,
          based on buildbot tests.</em><em></em><br>
        <em>This is in cron2's backlog to review.</em></li>
    </ul>
    <p>As always you're welcome to join at #openvpn-meeting on Libera
      IRC network every Wednesday at 14:00 Central European Time. </p>
    <p>Kind regards,<br>
      Johan Draaisma<br>
    </p>
  </body>
</html>

--------------gAA2VlIRZLOjfhUOVbTFi2Qz--

