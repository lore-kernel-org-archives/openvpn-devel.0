From: Gert Doering <gert@...1296...>
Date: Thu, 16 Aug 2012 20:31:21 +0200
Message-Id: <1345141883-9889-1-git-send-email-gert@...1296...>
Subject: [Openvpn-devel] housekeeping patches for 2.3
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

as discussed on IRC, the "--version" output for IPv6 is no longer
useful in its existing form -> shorten (but keep, to point out "yes,
this has IPv6" even if *we* all know).

Add another convenience patch to t_client.sh, to put the command line
used by a specific test run into the corresponding openvpn log file,
so you can always see what command was run (t_client.sh prints this,
but if you clear the screen in between, it's good to have a place to
go and look it up).

gert


