From: Mathias Sundman <mathias@...209...>
In-Reply-To: <40E744F9.5000700@...83...>
Message-ID: <Pine.LNX.4.60.0407052042310.29911@...210...>
References: <40E18559.8020407@...244...> <200406301725.43961.jim@...41...>
 <1088881994.40e7054a0e5e6@...238...> <200407031601.24438.jim@...41...>
 <40E744F9.5000700@...83...>
MIME-Version: 1.0
Subject: [Openvpn-devel] Re: Interface with GUI agent
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
Date: Mon Jul  5 11:52:07 2004
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 8bit
To: Jan Kiszka <jan.kiszka@...83...>
Cc: James Yonan <jim@...41...>, openvpn-devel@lists.sourceforge.net

On Sun, 4 Jul 2004, Jan Kiszka wrote:

> I would like to have some mechanism to fork an openvpn instance and let the 
> new process use a specific configuration file. This would allow to start only 
> certain VPN tunnels depending on what the user selects in the GUI.

I've been giving this some more thought... and I agree we definitly need 
something like this.

Is it possible in windows to install a program as SUID in unix, so the 
application is ran as administrator even though it is started by an 
ordinary user? If yes, that would be eliminate the need to fork new 
processes (as I can think of right now atleast).

If no, Is it only on windows we can't do this, or do we have this problem 
on other platforms too?

If it's a windows specific problem, then maybe this functionally should be 
in the service wrapper. If we add a simple interface to the service 
wrapper our gui client could tell the service wrapper to start new openvpn 
processes when we want.

If it's not a windows specific problem, then I suppost it's best to add 
the functionallity in the openvpn binary so we get the portability.

-- 
_____________________________________________________________
Mathias Sundman                  (^)   ASCII Ribbon Campaign
NILINGS AB                        X    NO HTML/RTF in e-mail
Tel: +46-(0)8-666 32 28          / \   NO Word docs in e-mail

