MIME-Version: 1.0
Date: Mon, 27 Sep 2010 20:04:19 -0400
Message-ID: <AANLkTinJNNoewiqB2BzM6F_iwK=xctA72B2bUJpvnvUp@...278...>
From: Praetorian <praetoriancode@...277...>
Subject: [Openvpn-devel] Multihomed Openvpn server setup question.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
To: Openvpn-devel@lists.sourceforge.net

I am settting up some servers to test the beta debian packages and
wanted to try a multihomed server.  I have two isp's coming into the
building and wish to make one the primarly connection side and then
one be the backup (ie because it is the slower of the two).  I looked
through the man page for 2.3 and did not see any settings in the
<connection> area to do like preferences to a group of  connections
(other than going in the order they are located in the file).  Also
once connected to the backup is there a way for it to probe when the
other route/connection comes back online to change back over from the
fall back to the prefered connection?

Wayne

