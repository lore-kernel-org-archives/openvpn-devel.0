From: Mathias Sundman <mathias@...209...>
Message-ID: <Pine.LNX.4.61.0411022157360.23349@...210...>
MIME-Version: 1.0
Subject: [Openvpn-devel] 2.0-beta15 on WinXP: CreateFile failed on TAP device
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
Date: Tue Nov  2 13:23:07 2004
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

James,

I think we made a little misstake with the "auto-find free TAP device" 
feature.

In OpenVPN GUI >= beta20 I close the connections and restart them after a 
suspend. If multiple connections were running this means that they 
will all be re-started at the exact same time after the suspend.

I suppose the same thing happends when you start the service wrapper.

Anyway, I had two connections running, and after a suspend, one of the 
connections started fine, but the other one failed with the following 
message:

CreateFile failed on TAP device: 
\\.\Global\{75E5A03B-F1A9-422E-8DBA-EFF4B55C1B07}.tap:
General failure (ERROR_GEN_FAILURE) (errno=31)

which is the same interface as the first connection used.

I havn't checked the code yet, but I suspect that you changed the code to 
search for a free adapter when openvpn is started, but not actually open 
it until later.

Both processes seemed to find the same interface free, but later one of 
them of cource failed to open it.

/Mathias

--
_____________________________________________________________
Mathias Sundman                  (^)   ASCII Ribbon Campaign
OpenVPN GUI for Windows           X    NO HTML/RTF in e-mail
http://www.nilings.se/openvpn    / \   NO Word docs in e-mail


