From: Ian Pilcher <i.pilcher@...164...>
Message-ID: <bvu60k$bpq$1@...165...>
Mime-Version: 1.0
Subject: [Openvpn-devel] Daemon as non-root, high priority
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
Date: Thu Feb  5 17:23:15 2004
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

I would like to put together a patch that will allow the openvpn daemon
to run with elevated priority as a non-root user.  This currently
doesn't work, because the daemon changes its UID before it renices
itself.

Questions:

   * Are there any "philosophical" objections to this that would prevent
     such a patch from being accepted?

   * Any gotchas?  From my brief look at openvpn.c, it seems pretty
     simple.

Thanks!

-- 
========================================================================
Ian Pilcher                                        i.pilcher@...164...
========================================================================



