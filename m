Date: Wed, 8 Jan 2025 14:57:26 +0100
From: Frank Lichtenheld <frank@...2641...>
Message-ID: <Z36ERnxqcn21Mxkb@...2685...>
MIME-Version: 1.0
Subject: [Openvpn-devel] RFC: tchar removal patch series
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
Cc: Heiko Hund <heiko@...2662...>, Selva Nair <selva.nair@...277...>, Lev Stipakov <lev@...515...>

Hi.

Today I submitted a patch series that removes all usages of
tchar.h from the OpenVPN 2 code base. You can see the full
series here: https://gerrit.openvpn.net/q/topic:%22tchar-removal%22

This series came about when I looked into the Windows code
for a potential clang-format reformat and for reviewing
Heiko's DNS series. I learned about TEXT() and about how it
is basically useless in our case (since we never build
non-unicode builds anymore). I came to the conclusion that
this is somewhat inconsistently used, useless clutter, and
potential source for confusion.

So I propose to remove the use of tchar.h and and associated
functions and just use wchar directly. The actual conversion
step is fully automated. See
https://gerrit.openvpn.net/c/openvpn/+/852 for the script.
So it can easily be rebased on any ongoing Windows work.

Let me know what you guys think about it. CCing our Windows
experts.

Regards,
-- 
  Frank Lichtenheld

