From: Kristof Provost <kprovost@...2661...>
Date: Wed, 27 Apr 2022 09:48:27 +0200
Message-Id: <20220427074828.6283-1-kprovost@...2661...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCHv2 DCO]: Handle (DCO) timeouts in client mode
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

Updated version of the timeout fix for client mode.
This time with trigger_ping_timeout_signal() as suggested by Arne.

Best regards,
Kristof



