Content-Type: multipart/alternative;
 boundary="------------8oN0HYwPNppgB6nfcigAmuYx"
Message-ID: <0a346107-a603-46b4-a563-e74b055b0f89@...2722...>
Date: Wed, 12 Mar 2025 17:43:47 +0100
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
--------------8oN0HYwPNppgB6nfcigAmuYx
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit

Meeting summary for 12 March 2025:

  * *Updated: security mailing list*
    /Both community and company want to be in control of security
    mailing list. We need some resolution./
    /novaflash suggested to nominate ordex and cron2 as representatives
    of community to discuss directly with andrew from openvpn inc to
    come to some agreement./
    /This idea was accepted by community and novaflash will arrange a
    date/time for the call./

  * *Updated: DCO Linux upstreaming*
    /Upstreaming DCO to Linux is proceeding, it is in review stage at
    the moment./
    /A patchset v22 was sent in on Tuesday./

  * *Updated: new --dns option support
    */​https://gerrit.openvpn.net/q/topic:%22dns+option%22
    <https://gerrit.openvpn.net/q/topic:%22dns+option%22>//As agreed
    d12fk has been addressing things in the PR and handling comments there.
    //The new --dns directive allows more functionality and to resolve
    ambiguity in current dhcp-option dns handling, which is different
    per client and OS.
    //OpenVPN2 on unix-like systems does not have built-in DNS handling.
    On these you tend to have to add --up and --down script handling for
    DNS. Not ideal.
    //We want to deliver a DNS script that is enabled by default so
    OpenVPN2 on unix-like systems can 'just do DNS' out of the box.
    //But we also don't want to break situations where people have
    already implemented --up and --down script handling.
    //The proposed behavior is;
    //- by default dns-script is delivered with openvpn2 on Linux and
    enabled by default
    //- it is not used when --up script is set in openvpn config file -
    that will function as before
    //- it is not used when at runtime --dns-script disable is set
    //- it is not used when at compile time --disable-dns-script is set
    //The PRs for improving DNS implementation using NRPT on Windows and
    solving a WMIC related problem have already been merged./

As always you're welcome to join at #openvpn-meeting on Libera IRC 
network every Wednesday at 14:00 Central European Time.

Kind regards,
Johan Draaisma

--------------8oN0HYwPNppgB6nfcigAmuYx
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: 8bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p> Meeting summary for 12 March 2025:</p>
    <ul
style="color: rgb(0, 0, 0); font-family: Verdana, Arial, &quot;Bitstream Vera Sans&quot;, Helvetica, sans-serif; font-size: 13px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">
      <li><strong>Updated: security mailing list</strong><br>
        <em>Both community and company want to be in control of security
          mailing list. We need some resolution.</em><br>
        <em>novaflash suggested to nominate ordex and cron2 as
          representatives of community to discuss directly with andrew
          from openvpn inc to come to some agreement.</em><br>
        <em>This idea was accepted by community and novaflash will
          arrange a date/time for the call.</em></li>
    </ul>
    <ul
style="color: rgb(0, 0, 0); font-family: Verdana, Arial, &quot;Bitstream Vera Sans&quot;, Helvetica, sans-serif; font-size: 13px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">
      <li><strong>Updated: DCO Linux upstreaming</strong><br>
        <em>Upstreaming DCO to Linux is proceeding, it is in review
          stage at the moment.</em><br>
        <em>A patchset v22 was sent in on Tuesday.</em></li>
    </ul>
    <ul
style="color: rgb(0, 0, 0); font-family: Verdana, Arial, &quot;Bitstream Vera Sans&quot;, Helvetica, sans-serif; font-size: 13px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">
      <li><strong>Updated: new --dns option support<br>
        </strong><em><a class="ext-link"
            href="https://gerrit.openvpn.net/q/topic:%22dns+option%22"><span
              class="icon">​</span>https://gerrit.openvpn.net/q/topic:%22dns+option%22<br>
          </a></em><em>As agreed d12fk has been addressing things in the
          PR and handling comments there.<br>
        </em><em>The new --dns directive allows more functionality and
          to resolve ambiguity in current dhcp-option dns handling,
          which is different per client and OS.<br>
        </em><em>OpenVPN2 on unix-like systems does not have built-in
          DNS handling. On these you tend to have to add --up and --down
          script handling for DNS. Not ideal.<br>
        </em><em>We want to deliver a DNS script that is enabled by
          default so OpenVPN2 on unix-like systems can 'just do DNS' out
          of the box.<br>
        </em><em>But we also don't want to break situations where people
          have already implemented --up and --down script handling.<br>
        </em><em>The proposed behavior is;<br>
        </em><em>- by default dns-script is delivered with openvpn2 on
          Linux and enabled by default<br>
        </em><em>- it is not used when --up script is set in openvpn
          config file - that will function as before<br>
        </em><em>- it is not used when at runtime --dns-script disable
          is set<br>
        </em><em>- it is not used when at compile time
          --disable-dns-script is set<br>
        </em><em>The PRs for improving DNS implementation using NRPT on
          Windows and solving a WMIC related problem have already been
          merged.</em></li>
    </ul>
    <p>As always you're welcome to join at #openvpn-meeting on Libera
      IRC network every Wednesday at 14:00 Central European Time. </p>
    <p>Kind regards,<br>
      Johan Draaisma<br>
    </p>
  </body>
</html>

--------------8oN0HYwPNppgB6nfcigAmuYx--

