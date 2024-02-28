Date: Wed, 28 Feb 2024 15:43:19 +0100
From: Frank Lichtenheld <frank@...2641...>
Message-ID: <Zd9Gh2sdfOnrqmnS@...2685...>
MIME-Version: 1.0
Subject: [Openvpn-devel] IRC community meeting summary (Feb 28th)
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

Meeting summary for 28 February 2024:

* *Updated: Server-side testing*
  /Meeting happened yesterday, some highlights:
   * cron2 will try to clean up his server-side testing infrastructure
     code and make it available publicly, probably at 
     https://github.com/OpenVPN/openvpn-tests
   * mattock will look into setting up some --dev null test suite which
     can run inside make check on UNIXy platforms
   * plaisthos will look into enhancing --dev null with some lightweight IP
     stack so that it can simulate more things for testing
   Will review progress in next week's community meeting and decide whether
   another dedicated meeting is required/

* *Updated: Publishing debian package snapshots*
  /mattock says he made good progress on aptly PoC, will move ahead with that/

* *Updated: Wiki replacement*
  /We decided to go with Wiki.js, but mattock has not had time to work on it yet/

Regards,
-- 
  Frank Lichtenheld

