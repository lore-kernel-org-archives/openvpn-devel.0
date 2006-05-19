Message-ID: <446DDBE4.5030002@...642...>
From: Barry Michels <bmichels@...642...>
MIME-Version: 1.0
Subject: [Openvpn-devel] auth-retry question
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
Date: Fri May 19 07:56:01 2006
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

I set my auth-retry to nointeract so the service wouldn't stop when the 
client-connect script refused a connection.  However, it seems to be 
hard-coded to a 10 second retry.  Is there an undocumented option 
somewhere that will allow that to be changed?  I'd like to set it to 5 
minutes.

Or, is there a service watcher program that I could install alongside 
OpenVPN that would restart the service when it senses a change in the 
network? (different IP, different wireless SSID, disconnect/reconnect, etc)

Thanks,
Barry

