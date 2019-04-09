From: Michal Soltys <soltys@...2503...>
Date: Tue,  9 Apr 2019 16:34:37 +0200
Message-Id: <20190409143438.25348-1-soltys@...2503...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 0/1] --capath/--crl-verify description update
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

A while ago I asked on the user list about correcting the description
of those two options:

https://www.mail-archive.com/openvpn-users@lists.sourceforge.net/msg04461.html

While it slipped my mind for a bit due to other work related stuff, here
is the patch against the master branch. Due to syntax corrections (among
those \- vs. -) in one of the earlier patches it doesn't apply cleanly
against stable branches - but it's a trivial resolution.

Michal Soltys (1):
  man: correct the description of --capath and --crl-verify regarding
    CRLs

 doc/openvpn.8 | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

-- 
2.21.0


