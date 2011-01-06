From: Matthias Andree <matthias.andree@...68...>
Date: Thu,  6 Jan 2011 18:08:33 +0100
Message-Id: <1294333715-28771-1-git-send-email-matthias.andree@...68...>
In-Reply-To: <4D1CFF2B.6030006@...68...>
References: <4D1CFF2B.6030006@...68...>
Subject: [Openvpn-devel] bugfix2.1: automake support for plugin build
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

Greetings,

following up the "[OpenVPN 2.1.4 BUG]: hard-coded values in Makefiles
for down-root and auth-pam plugins prevent cross compilation" bug, I am
providing patches for review and test in cross-compilation environments.

I have tested these on native compiles with Ubuntu Linux 10.10 32-bit,
openSUSE 11.3 32-bit, and FreeBSD 8.1 32-bit (all ix86), but the actual
plugins are lightly tested (they load and don't crash), and that's about
it.

This is the patch series for the bugfix2.1 branch.

I will send a separate patch pair for beta 2.2 soon.

Looking for feedback, review, and ACK or NAK :-)

Best regards
Matthias


