From: P Kern <pkern@...345...>
In-Reply-To: <05Jan28.134635est.1628422@...346...>
Message-Id: <05Jan28.161714est.1628422@...346...>
Subject: [Openvpn-devel] '#!/bin/sh' instead of '#!/bin/bash'  ... please?
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
Date: Fri Jan 28 13:34:12 2005
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net
Cc: pkern@...345...

Hello.
Minor nit.  Could the scripts in the source tree be made to use
'#!/bin/sh' instead of '#!/bin/bash'?  On FreeBSD (at least) bash is
an optional port.  And even if bash was installed it would normally be
found in /usr/local/bin.  If scripts don't use any bash-specific
features then they would be more portable if they used "#!/bin/sh".
Thanks in advance. pk.

