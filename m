From: Mathias Sundman <mathias@...209...>
In-Reply-To: <B531E2D213DD4946B97797232C7C16E18DC009@...248...>
Message-ID: <Pine.LNX.4.60.0407041155460.21697@...210...>
References: <B531E2D213DD4946B97797232C7C16E18DC009@...248...>
MIME-Version: 1.0
Subject: [Openvpn-devel] RE: [Openvpn-users] Release: OpenVPN-GUI for Windows v1.0-beta2
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
Date: Sun Jul  4 03:10:01 2004
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 8bit
To: Tyrone Omidi <tyrone.omidi@...247...>
Cc: Openvpn-users@lists.sourceforge.net, openvpn-devel@lists.sourceforge.net

On Sun, 4 Jul 2004, Tyrone Omidi wrote:

> How about options manage the service?

How would you like to see this implemented? Just another menu item that 
can start/stop the service?

What about multiple configs started by the service. Should the GUI be able 
to start/stop these individually? How do we do this?

When we have the "management protocol" ready we should be able to use this 
to hook into the processes started by the service.

To be able to stop a process started by the service and then start it 
again, we would need either:

1. A "SUSPEND" mode in openvpn, so we can tell it to "stop", but the 
process should still be running, but inactive, so we later can tell it to 
start again (still running as the same user as the service wrapper started 
it as.).

2. What Jan Kiszka suggested, an openvpn process running capable of 
forking of new processes with a specific config-file.

-- 
_____________________________________________________________
Mathias Sundman                  (^)   ASCII Ribbon Campaign
NILINGS AB                        X    NO HTML/RTF in e-mail
Tel: +46-(0)8-666 32 28          / \   NO Word docs in e-mail

