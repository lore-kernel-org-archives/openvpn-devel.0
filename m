From: James Yonan <james@...515...>
Message-ID: <56C2E0DD.3050707@...515...>
Date: Tue, 16 Feb 2016 01:42:05 -0700
MIME-Version: 1.0
Subject: [Openvpn-devel] --block-outside-dns speed
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Has anyone seen issues with --block-outside-dns speed?  Because this 
approach drops certain DNS packets, I'm wondering if apps will 
experience lag time while waiting for dropped DNS requests to time out.

James

