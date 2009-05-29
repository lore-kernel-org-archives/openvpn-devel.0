Date: Fri, 29 May 2009 13:09:57 +0200
From: "Markus Bickel" <ZeroCool.2001@...68...>
Message-ID: <20090529110957.111780@...95...>
MIME-Version: 1.0
Subject: [Openvpn-devel] Reporting issue with v2.1 rc16 and --cryptoapicert
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net


Dear developers,

I'm currently installing and testing OpenVPN 2.1 on windows environment and have seen that there's a newer version rc16.

Since this version I cannot use the parameter:

--cryptoapicert "Thumb:xx xx xx xx xx"

Error message:

cannot load certificate "Thumb:xx xx xx xx .... " from Microsoft Certificate Store:
error:C506C064:microsoft cryptoapi:GetProcAddress:The specified procedure could not be found.


This behaviour is the same on server or client sides.
With rc15 this worked well.

Maybe this is a small bug.  
So I want to report this issue to you.

Would it be fixed in rc17?

Thanks in Adanvce,

Markus

-- 
Nur bis 31.05.: GMX FreeDSL Komplettanschluss mit DSL 6.000 Flatrate und
Telefonanschluss nur 17,95 Euro/mtl.!* http://portal.gmx.net/de/go/dsl02

