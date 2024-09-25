Date: Wed, 25 Sep 2024 15:00:05 +0200
From: Frank Lichtenheld <frank@...2641...>
Message-ID: <ZvQJVdBjNsoyws2N@...2685...>
MIME-Version: 1.0
Subject: [Openvpn-devel] IRC community meeting summary (Sep 25th)
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

Meeting summary for 25 September 2024:

* *Done: OpenVPN community meetup 2024*
  Meetup was concluded. 13 persons in attendance.
  Much time was spent planning the 2.7 release. Planned for January 2025.
  (Not yet reflected on https://community.openvpn.net/openvpn/wiki/StatusOfOpenvpn27)
  Meeting notes: https://cryptpad.fr/pad/#/2/pad/edit/KPJKt7RSPrvC9grrvQ0KhbwE/

* *New: --dns patch review upcoming*
  DNS patches were discussed during Meetup. d12fk will provide them for review real soon.
  
* *Updated: DCO and Linux upstreaming, API change*
  Upstreaming DCO to Linux is proceeding, it is in review stage at the moment.
  ordex is collecting feedback on **patchset version 7**. Plan is to send v8 by end of month.
  During meetup it was discussed that if the patchset does not make it into the kernel
  before 2.7 we should update the out-of-tree module to match the new API anyway.
  So that 2.7 supports the new API and we need no or minimal further changes to work with
  the eventual in-tree version.

* *Updated: community.openvpn.net trac wiki*
  Seems mattock managed to get it into a reasonable shape ready for production.
  Some required changes to otterwiki have been submitted upstream.
  Next step is looking at migrating data from old to new.
  Also djpig needs to provide an EC2 instance in the community account for hosting
  production.

* *New: Community AWS account governance*
  Currently the Community AWS account is part of the OpenVPN, Inc. AWS organisation.
  With the OTF founding there would be opportunity to move to a separate AWS account
  that is not under the corporate umbrella.
  Requires further discussion whether that is something we want.

* *Updated: live route updates*
  PR to RFC was merged. (https://github.com/OpenVPN/openvpn-rfc/pull/4)
  Now we need to complete the actual implementations.
  Implementation for OpenVPN v2 will be looked at by ordex and his team.
  lev is working on (client-side) implementation in OpenVPN 3.

As always you're welcome to join at #openvpn-meeting on Libera IRC network
every Wednesday at 14:00 Central European Time.

Regards,
-- 
  Frank Lichtenheld

