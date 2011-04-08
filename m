From: David Sommerseth <davids@...1347...>
Date: Fri,  8 Apr 2011 13:40:03 +0200
Message-Id: <1302262805-23686-1-git-send-email-davids@...1347...>
In-Reply-To: <1302106222-10256-1-git-send-email-davids@...1347...>
References: <1302106222-10256-1-git-send-email-davids@...1347...>
Subject: [Openvpn-devel] [PATCH 0/2] Updates to --tmp-dir patch
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
Cc: David Sommerseth <davids@...1347...>

These patches goes on-top of the previous --tmp-dir patch [1].

In summary, these patches implement the consensus of the following
discussion.

* Remove compile time configuration option for default temp dir.
In non-Windows environments it is most likely that /tmp will exist
anyway.  For Windows environments it is now using %SystemRoot%\Temp
as the last fallback possibility.  If this fails, it is most likely that
there are more sever issues which is not related to OpenVPN at all.

* Check for $TMPDIR
In non-Windows environments, the $TMPDIR directory may be used to
set a specific temporary directory path.  If this is not found,
/tmp will be used as the default.  Nothing has changed in this
regard for Windows environments, where %TEMP% and %TMP% are checked
before the fallback.


Kind regards,

David Sommerseth



[1] <http://thread.gmane.org/gmane.network.openvpn.devel/4561>


David Sommerseth (2):
  Make use of $TMPDIR on non-Windows
  Use %SystemRoot% instead of hard-coded C:\WINDOWS for temp directory
    path

 configure.ac    |   11 -----------
 options.c       |    7 +++++--
 win/config.h.in |    3 ---
 win32.c         |   36 ++++++++++++++++++++++++++----------
 4 files changed, 31 insertions(+), 26 deletions(-)

-- 
1.7.4.2


