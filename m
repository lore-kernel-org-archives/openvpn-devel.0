From: Christian Gut <cycloon@...192...>
Message-ID: <20040625071229.GB17592@...192...>
Mime-Version: 1.0
Subject: [Openvpn-devel] [claudio@...243...: CVS: cvs.openbsd.org: src]
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
Date: Fri Jun 25 00:12:17 2004
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: openvpn-devel@lists.sourceforge.net

just FYI, OpenBSD now supports tap devices in -current.

----- Forwarded message from Claudio Jeker <claudio@...243...> -----

Date: Thu, 24 Jun 2004 22:09:03 -0600 (MDT)
From: Claudio Jeker <claudio@...243...>
Message-Id: <200406250409.i5P4936M017947@...243...>
To: source-changes@...243...
Subject: CVS: cvs.openbsd.org: src
CVSROOT:	/cvs

Module name:	src
Changes by:	claudio@...243...	2004/06/24 22:09:03

Modified files:
	share/man/man4 : tun.4 
	sys/net        : if_tun.c if_tun.h 

Log message:
Add tap aka layer 2 tunneling support to tun(4). It can be enabled by setting
the link0 flag via ifconfig(8). OK markus@, canacar@ also tested by ish@


----- End forwarded message -----

