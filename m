From: Steffan Karger <steffan@...1856...>
Date: Sat, 25 Oct 2014 22:35:18 +0200
Message-Id: <1414269324-14102-1-git-send-email-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH] Improve crypto/ssl logging
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

This patch set improves the logging from the crypto/ssl components. It adds some debug/logging wrappers to make it easy for developers to add proper logging, and makes the logging more verbose by reporting the underlying crypto library errors too.

When errors occur during the TLS handshake, users are quite often puzzled. We won't be able to fully prevent that, but let's at least be as verbose as possible about the underlying problems.

I prepared this set for the master branch, but on request I can backport it to 2.3 too, just let me know.

-Steffan


