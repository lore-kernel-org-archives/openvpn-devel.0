From: Kristof Provost <kprovost@...2661...>
Date: Tue, 26 Apr 2022 18:29:33 +0200
Message-Id: <20220426162934.12938-1-kprovost@...2661...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH DCO]: Handle (DCO) timeouts in client mode
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

During testing of FreeBSD DCO support we discovered that a DCO enabled
client does not detect that the server has gone away, even if
'keepalive' is set.

This turns out to be because we only handle DCO notification messages in
the multi-instance (i.e. server) code path.
I'm not 100% sure this patch does the correct thing, but we do need to
do something at the point it changes.

Br,
Kristof



