Message-ID: <41A437EA.1030209@...321...>
From: Maarten Koopmans <maarten.koopmans@...321...>
MIME-Version: 1.0
Subject: [Openvpn-devel] Configuring TAP-win32
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
Date: Tue Nov 23 23:43:16 2004
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Hi,

Being a newbie to openvpn, so I hope the answer my question isn't to 
obvious...

 From what I have understood openvpn has a TAP-Win32 driver that it uses 
to tunnel a network device over a TCP or UDP connection. Is it possible 
to configure the driver in such a way that it simply sends the received 
data to a well-known host:port (and back)?

I have a process with a TCP or UDP interface that I'd like to "see" as a 
network device, hence the question.

Or is is a better option to use openvpn as a plain tunnel to a 
well-known host:port ? Or...?

Thanks!

--Maarten


