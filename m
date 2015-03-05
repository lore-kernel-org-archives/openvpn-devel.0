MIME-Version: 1.0
Date: Thu, 5 Mar 2015 01:28:56 -0700
Message-ID: <CAAA5faF6nqup+1otgeD4EctaobacAngcrkNUikcMgjBhQDAKtw@...278...>
From: Reinoud Koornstra <reinoudkoornstra@...277...>
Subject: [Openvpn-devel] reading from the status file from another pid
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

Hi Everyone,

I've configured openvpn to write the status every 5 seconds to a status file.
Looking at the code that when openvpn starts you call open()

Then every 5 seconds, the status file is truncated in status_flush.

Only when you close openvpn, the file descriptor will be closed again.
Hence, the file remains open all the time, but is truncated every 5 seconds.

Now I would the read from the status file periodically as well in
another process that is running.
I can open the file just fine, the only issue that makes me incertain
is the truncating of the file every 5 seconds. Currently I am looking
for a safe way to read from the status file, while it is opened and
truncated every 5 seconds.
Any suggestions?
Thanks,

Reinoud.

