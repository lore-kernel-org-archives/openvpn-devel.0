From: Michael Renner <robe@...476...>
Message-ID: <loom.20051019T032752-672@...171...>
Mime-Version: 1.0
Subject: [Openvpn-devel] Problem with username-as-common-name when using concurrent sessions
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Tue Oct 18 19:13:19 2005
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Hi,

First - thanks for OpenVPN, this is by far one of the most hassle-free
opensource VPN solutions out there.

But there seems to be a problem (or undocumented behaviour?) when using
username-as-common-name in combination with concurrent sessions with identical
usernames. Currently if there's a second session connecting with the same
username as an already active session, the active sessions gets "overwritten"
with the new one, causing the former to timeout (and reconnect). Continue ad
nauseam. This behaviour goes away when you disable username-as-common-name.

Is this intended? (I don't know openvpns behaviour when using identical
certificates when doing certificate-based authentication).

Either way, this cost me quite a headache ;), and if it's not going to be
changed openvpn should at least throw a log message when active connections get
"reused".

best regards,
Michael Renner


