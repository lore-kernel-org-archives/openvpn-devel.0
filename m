Message-Id: <200809071232.m87CWZc5005898@...1119...>
Date: Sun, 07 Sep 2008 14:32:35 +0200
From: Jos Vos <jos@...1120...>
Subject: [Openvpn-devel] Confusing "mtu-dynamic" warnings
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

Hi,

When makins some inconsistency mistake with "--fragment" settings, I get
an error message like:

WARNING: 'mtu-dynamic' is present in local config but missing in remote config, local='mtu-dynamic'

I guess this message has to be updates, as "--fragment" is meant to
replace "--mtu-dynamic" AFAICS.

This is with 2.1_rc9.

--
--    Jos Vos <jos@...1120...>
--    X/OS Experts in Open Systems BV   |   Phone: +31 20 6938364
--    Amsterdam, The Netherlands        |     Fax: +31 20 6948204

