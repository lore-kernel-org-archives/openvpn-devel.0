From: David Sommerseth <openvpn.list@...1114...>
Date: Fri, 16 Apr 2010 22:21:50 +0200
Message-Id: <1271449313-26315-1-git-send-email-openvpn.list@...1114...>
Subject: [Openvpn-devel] [PATCHv2 0/3] Harden create_temp_filename()
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
To: Openvpn-devel@lists.sourceforge.net
Cc: James Yonan <james@...515...>, David Sommerseth <dazo@...384...>

From: David Sommerseth <dazo@...384...>

In a Debian bug report [1] there were worries that the --client-connect
script hook was prune to a "symlink" attack.  Even though this can
be recognised if --tmp-dir is set to a world writable directory, it is not
considered standard practice to do so.

This patch-set replaces the previous suggested patch, with an enhancement
suggested by Fabian Knittel.  In addition create_temp_filename() is renamed
to create_temp_file() to reflect the behvioural change in the function.


kind regards,

David Sommerseth

[1] <http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=534908>


*** BLURB HERE ***

Fabian Knittel and David Sommerseth (1):
  Harden create_temp_filename() (version 2)

David Sommerseth (2):
  Renamed all calls to create_temp_filename()
  Updated the man page to reflect the behavioural change of
    create_temp_file()

 init.c    |    2 +-
 misc.c    |   60 ++++++++++++++++++++++++++++++++++++++++++++++--------------
 misc.h    |    4 ++--
 multi.c   |   19 ++++++++++++++-----
 openvpn.8 |    2 +-
 pf.c      |   33 +++++++++++++++++----------------
 ssl.c     |   36 +++++++++++++++++++++---------------
 7 files changed, 102 insertions(+), 54 deletions(-)


