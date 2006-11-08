From: Roy Marples <uberlord@...594...>
Date: Wed, 8 Nov 2006 13:43:07 +0000
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_r7dUFzpM7gDh3hM"
Message-Id: <200611081343.07350.uberlord@...594...>
Subject: [Openvpn-devel] [PATCH] txqueuelen for persistent interfaces
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--Boundary-00=_r7dUFzpM7gDh3hM
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi.

openvpn does not apply the --txqueuelen option to persistent interfaces made 
with --mktun [1]

Attached are patches to 2.0.7 and 2.1_rc1 that fix the issue.

Thanks!

[1] http://bugs.gentoo.org/show_bug.cgi?id=150791

-- 
Roy Marples <uberlord@...594...>
Gentoo Developer (baselayout, networking)

--Boundary-00=_r7dUFzpM7gDh3hM--

