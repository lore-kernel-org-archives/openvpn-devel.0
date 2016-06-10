From: debbie10t <debbie10t@...277...>
Message-ID: <575AA2BD.60908@...277...>
Date: Fri, 10 Jun 2016 12:21:33 +0100
MIME-Version: 1.0
Subject: [Openvpn-devel]  pull-filter reject = server hammering !
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
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Hi,

today I successfully built git-master for windows x86_64
and started testing the new features.

You will be pleased to know that everything works well
(as far as my limited knowledge and testing goes)

However, why does pull-filter reject throw SIGUSER1 ?

If the server pushes an item the client rejects then
the client will just reconnect endlessly, completing a
full reconnect to the server then restarting !
Thispractically constitutes a DDOS ..

I suggest this is changed from SIGUSR1 to SIGTERM.

Regards.


