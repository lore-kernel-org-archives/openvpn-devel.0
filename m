Message-ID: <02c901c97d0d$cb519ca0$06c8a8c0@...1189...>
From: "Stuart Nicholson" <stuart@...1188...>
Date: Thu, 22 Jan 2009 22:50:48 -0500
MIME-Version: 1.0
Subject: [Openvpn-devel] Why TUN_MTU_MIN of 100 bytes?
Reply-To: Stuart Nicholson <stuart@...1188...>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; format=flowed; charset="utf-8"; reply-type=response
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

I am using openvpn to test IP fragmentation with small MTU values.  I would 
like to set the tun/tap interface to have an MTU of 68 bytes, the minimum 
allowed by RFC 791.  But openvpn defines a constant TUN_MTU_MIN with a value 
of 100.  Can someone explain why the MTU must be this large?


