Message-ID: <462FEEFA.9060900@...41...>
Date: Wed, 25 Apr 2007 18:14:50 -0600
From: James Yonan <jim@...41...>
MIME-Version: 1.0
Subject: [Openvpn-devel] OpenVPN 2.1_rc4 released
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: openvpn-users@lists.sourceforge.net, Openvpn-devel@lists.sourceforge.net

The Vista x64 TAP driver signing issue has been resolved,
and I was able to successfully install and test OpenVPN
on Vista x64 with default driver signature verification
in effect.

Change Log:

2007.04.25 -- Version 2.1_rc4

* Worked out remaining issues with TAP driver signing
  on Vista x64.  OpenVPN will now run on Vista x64
  with driver signing enforcement enabled.

* Fixed 64-bit portability bug in time_string function
  (Thomas Habets).


James



