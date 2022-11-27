From: Kristof Provost <kprovost@...2661...>
Date: Sun, 27 Nov 2022 12:18:44 +0100
Message-Id: <20221127111845.11310-1-kprovost@...2661...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [DRAFT]: packet counting for DCO
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
To: openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi,

Here's an initial draft for how I'd approach getting traffic statistics
in DCO mode.
Userspace doesn't see all of the traffic, so we need to ask the kernel
too.

I've added new variables for the kernel numbers so that we can keep the
userspace numbers, for the control packets which go through the socket
directly (so not through the DCO driver).

This isn't intended to be a finished patch, rather it's intended to
serve as a basis for discussion.

Best regards,
Kristof



