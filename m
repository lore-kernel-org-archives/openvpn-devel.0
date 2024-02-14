Date: Wed, 14 Feb 2024 16:22:03 +0100
From: Frank Lichtenheld <frank@...2641...>
Message-ID: <Zczam85nBDgD74kE@...2685...>
MIME-Version: 1.0
Subject: [Openvpn-devel] IRC community meeting summary (Feb 14th)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: openvpn-devel@lists.sourceforge.net

Meeting summary for 14 February 2024:

* *Updated: Pending Buildbot PRs*
  https://github.com/OpenVPN/openvpn-buildbot/pull/33 (Add license file)
  https://github.com/OpenVPN/openvpn-buildbot/pull/31 (changeFilter)
  https://github.com/OpenVPN/openvpn-buildbot/pull/32 (smoketest)
  /#33 has been merged. #32 has been merged, it was required to reset the buildbot
   database to get it working. #31 still pending/

* *New: Debian snapshot packages*
  Buildbot builds Debian packages, but they are not stored or even published
  anywhere.
  /mattock will work on this and produce a PoC. Looking into aptly. The current
   freight setup used for official releases on build.openvpn.net is old and
   limited/

* *Updated: Wiki migration*
  /Consensus seems to be that we should continue with Wiki.js. mattock will
   continue work on the PoCs and let djpig/uddr know when he is ready to
   move into the actual community infrastructure./

* *Updated: Server Side Testing*
  /No updates. Still not agreed on meeting./

* *New: Easy-rsa in Windows installers*
  easy-rsa has included pre-built Windows binaries for a long time. But with
  Windows 11 they do not seem to work correctly anymore in some cases. There
  is a plan to switch to a current version of busybox.exe instead.
  But the required changes to the Windows installer raise the question whether
  it is actually worth the effort? Does anyone use the included easy-rsa on
  Windows.
  /Decided to ask on openvpn-users ml and forums if people really care about
   easy-rsa in the Windows installers. Depending on the feedback we might
   drop it from the installer./

* *Closed: 2.6.9*
  /Release was done on Monday/

Regards,
-- 
  Frank Lichtenheld

