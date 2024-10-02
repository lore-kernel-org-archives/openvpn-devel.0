Date: Wed, 2 Oct 2024 18:19:17 +0200
From: Frank Lichtenheld <frank@...2641...>
Message-ID: <Zv1yhdo021+XDWFY@...2685...>
MIME-Version: 1.0
Subject: [Openvpn-devel] IRC community meeting summary (Oct 2nd)
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

Meeting summary for 2 October 2024:

* *Release 2.7*
  https://community.openvpn.net/openvpn/wiki/StatusOfOpenvpn27 was updated with the results
  from Karlsruhe meetup. Compare also
  https://community.openvpn.net/openvpn/wiki/CommunityMeetup2024
  Note: automatic enabling of --compression migrate was dropped from feature list since
  the meeting since djpig discovered it is too complicated to get right.

* *Updated: multi-socket patch series*
  New version of the patch series is posted. Reviews welcome :)

* *Updated: DATA_V3 patch*
  plaisthos has written a new draft for new key handling for the data channel based on
  discussions in Karlsruhe. See https://github.com/OpenVPN/openvpn-rfc/pull/5.
  Feedback welcome :)

* *Updated: buildbot improvements*
  mattock has a patch to split the mails for different project to different mail addresses.
  The idea is to split openvpn3 and openvpn3-linux out so it doesn't go to
  openvpn-builds@ ML anymore. Instead we could create a openvpn3-builds@ ML. djpig will
  look into that.

* *Updated: t_server_null improvements*
  mattock plans to work on improving stability of the test first. At the moment, if the
  test fails to clean up it can easily leave the worker in a state where all future
  tests fail.
  Next feature plans are to add more cross-version tests. E.g. have a test for
  release/2.6 <-> master in buildbot.

* *New: 2.7 security audit*
  ordex mentioned that OTF offers the possibility to get a 3rd-party security audit for
  supported projects. So we will apply for that around or after the 2.7 release to review
  the latest code.

Regards,
-- 
  Frank Lichtenheld

