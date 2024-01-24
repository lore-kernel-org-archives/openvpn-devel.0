Content-Type: multipart/alternative;
 boundary="------------SrqY5TGxPdbsc0KLZaTmktUU"
Message-ID: <217aa283-1ee8-401c-bf73-c41135b971dd@...2751...>
Date: Wed, 24 Jan 2024 13:40:59 +0100
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
--------------SrqY5TGxPdbsc0KLZaTmktUU
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit

Meeting summary for 24 January 2024:

  * *Closed: License amendment for OpenVPN2 to solve openssl/mbedtls
    licensing issues*
    /All work on this is now completed./

  * *New: security mailing list procedure can stand improvement*
    /To be discussed in more detail later./

  * *Updated: tasks related to build processes (Mattock)*
      o Buildbot can now skip builds that don't touch irrelevant files
        (​https://github.com/OpenVPN/openvpn-buildbot/pull/31
        <https://github.com/OpenVPN/openvpn-buildbot/pull/31>)
          + Which file and/or directory changes should trigger the
            buildbot builds?
          + Do we want the skipped builds to show up on the build state
            page? Or to be (almost) completely invisible to buildbot?
          + We do not have answers right now to these questions but the
            fact that we can now skip irrelevant things is great.
      o Extending the above: Have different Builders and build steps for
        different types of files
          + We can have more than one Scheduler per project (e.g. openvpn)
          + Each Scheduler can have a different Change Filters for
            builds that are relevant for that type of build
          + Each Scheduler links to a set of Builders
          + Each Builder runs different commands on the Worker (e.g.
            "autoreconf -vi && ./configure ..." or "do-something-else")
          + Example Schedulers:
              # /openvpn-default/Scheduler (=what we have now) would:
                  * Trigger normal builds on all builders
                  * No build would be triggered on documentation changes
              # /openvpn-rst/Scheduler would:
                  * Trigger RST sanity check on one builder when .rst
                    file changes

  * *Updated: OpenVPN 2.6.9 release*
    /There is a small security issue reported in OpenVPN for Windows
    installer./
    /Once this is resolved we can make the 2.6.9 release./
    /lev, selva, and d12fk, are looking into this at the moment./
    /dazo will work with lev to arrange a CVE report./

  * *Updated: forums topics*
    /There has been a lot of spam. An antispam module had expired. We
    fixed that. But there's still the occasional bit of spam./
    /ecrist looked into setting up a new forum. Discovered that
    migrating data is not possible./
    /Suggested approach is to run both old and new side-by-side and let
    people finish discussions on old forums while new is up. Then after
    some time make the old forum read-only.
    /RegardingCloudFlare?
    <https://community.openvpn.net/openvpn/wiki/CloudFlare>, currently
    not enabled on forums, but we will enable it at some point on the
    new VM.

As always you're welcome to join at #openvpn-meeting on Libera IRC 
network every Wednesday at 13:00 Central European Time.

Kind regards,
Johan Draaisma

--------------SrqY5TGxPdbsc0KLZaTmktUU
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: 8bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p> Meeting summary for 24 January 2024:</p>
    <ul
style="color: rgb(0, 0, 0); font-family: Verdana, Arial, &quot;Bitstream Vera Sans&quot;, Helvetica, sans-serif; font-size: 13px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">
      <li><strong>Closed: License amendment for OpenVPN2 to solve
          openssl/mbedtls licensing issues</strong><br>
        <em>All work on this is now completed.</em><br>
      </li>
    </ul>
    <ul
style="color: rgb(0, 0, 0); font-family: Verdana, Arial, &quot;Bitstream Vera Sans&quot;, Helvetica, sans-serif; font-size: 13px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">
      <li><strong>New: security mailing list procedure can stand
          improvement</strong><br>
        <em>To be discussed in more detail later.</em><br>
      </li>
    </ul>
    <ul
style="color: rgb(0, 0, 0); font-family: Verdana, Arial, &quot;Bitstream Vera Sans&quot;, Helvetica, sans-serif; font-size: 13px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">
      <li><strong>Updated: tasks related to build processes (Mattock)</strong><br>
        <ul>
          <li>Buildbot can now skip builds that don't touch irrelevant
            files (<a class="ext-link"
              href="https://github.com/OpenVPN/openvpn-buildbot/pull/31"
style="text-decoration: none; color: rgb(187, 0, 0); border-bottom: 1px dotted rgb(187, 187, 187);"><span
                class="icon"
style="background: url(&quot;../extlink.gif&quot;) left center no-repeat; padding-left: 15px;">​</span>https://github.com/OpenVPN/openvpn-buildbot/pull/31</a>)
            <ul>
              <li>Which file and/or directory changes should trigger the
                buildbot builds?</li>
              <li>Do we want the skipped builds to show up on the build
                state page? Or to be (almost) completely invisible to
                buildbot?</li>
              <li>We do not have answers right now to these questions
                but the fact that we can now skip irrelevant things is
                great.</li>
            </ul>
          </li>
          <li>Extending the above: Have different Builders and build
            steps for different types of files
            <ul>
              <li>We can have more than one Scheduler per project (e.g.
                openvpn)</li>
              <li>Each Scheduler can have a different Change Filters for
                builds that are relevant for that type of build</li>
              <li>Each Scheduler links to a set of Builders</li>
              <li>Each Builder runs different commands on the Worker
                (e.g. "autoreconf -vi &amp;&amp; ./configure ..." or
                "do-something-else")</li>
              <li>Example Schedulers:
                <ul>
                  <li><em>openvpn-default</em><span> </span>Scheduler
                    (=what we have now) would:
                    <ul>
                      <li>Trigger normal builds on all builders</li>
                      <li>No build would be triggered on documentation
                        changes</li>
                    </ul>
                  </li>
                  <li><em>openvpn-rst</em><span> </span>Scheduler would:
                    <ul>
                      <li>Trigger RST sanity check on one builder when
                        .rst file changes</li>
                    </ul>
                  </li>
                </ul>
              </li>
            </ul>
          </li>
        </ul>
      </li>
    </ul>
    <p
style="color: rgb(0, 0, 0); font-family: Verdana, Arial, &quot;Bitstream Vera Sans&quot;, Helvetica, sans-serif; font-size: 13px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;"></p>
    <ul
style="color: rgb(0, 0, 0); font-family: Verdana, Arial, &quot;Bitstream Vera Sans&quot;, Helvetica, sans-serif; font-size: 13px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">
      <li><strong>Updated: OpenVPN 2.6.9 release</strong><br>
        <em>There is a small security issue reported in OpenVPN for
          Windows installer.</em><br>
        <em>Once this is resolved we can make the 2.6.9 release.</em><br>
        <em>lev, selva, and d12fk, are looking into this at the moment.</em><br>
        <em>dazo will work with lev to arrange a CVE report.</em><br>
      </li>
    </ul>
    <ul
style="color: rgb(0, 0, 0); font-family: Verdana, Arial, &quot;Bitstream Vera Sans&quot;, Helvetica, sans-serif; font-size: 13px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">
      <li><strong>Updated: forums topics</strong><br>
        <em>There has been a lot of spam. An antispam module had
          expired. We fixed that. But there's still the occasional bit
          of spam.</em><br>
        <em>ecrist looked into setting up a new forum. Discovered that
          migrating data is not possible.</em><br>
        <em>Suggested approach is to run both old and new side-by-side
          and let people finish discussions on old forums while new is
          up. Then after some time make the old forum read-only.<br>
        </em>Regarding<span> </span><a class="missing wiki"
          href="https://community.openvpn.net/openvpn/wiki/CloudFlare"
          rel="nofollow"
style="text-decoration: none; color: rgb(153, 153, 136); border-bottom: 1px dotted rgb(187, 187, 187);">CloudFlare?</a>,
        currently not enabled on forums, but we will enable it at some
        point on the new VM.</li>
    </ul>
    <p></p>
    <p>As always you're welcome to join at #openvpn-meeting on Libera
      IRC network every Wednesday at 13:00 Central European Time.</p>
    <p>Kind regards,<br>
      Johan Draaisma<br>
    </p>
  </body>
</html>

--------------SrqY5TGxPdbsc0KLZaTmktUU--

