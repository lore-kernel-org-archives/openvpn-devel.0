From: Mathias Sundman <mathias@...209...>
Message-ID: <Pine.LNX.4.61.0502131551270.5891@...210...>
MIME-Version: 1.0
Subject: [Openvpn-devel] Windows install pkg leaves a ; in path
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
Date: Sun Feb 13 07:14:13 2005
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net
Cc: James Yonan <jim@...41...>, markku@...124...

When uninstalling OpenVPN, the installation package leaves a semicolon at 
the end of the path.

When OpenVPN is then re-installed, another semicolon is added to the path 
before the openvpn path, and you therefore end up with two semicolons 
before the OpenVPN path.

Every time you install a new version of OpenVPN an extra semicolon is 
added!

I have solved this in the OpenVPN GUI installation package simply by 
changing

   ; remove previously set path (if any)
   Push "$INSTDIR\bin"
   Call RemoveFromPath

to

   ; remove previously set path (if any)
   Push ";$INSTDIR\bin"
   Call RemoveFromPath

in the two places RemoveFromPath is called from the NSIS script.

I guess a more "correct" solution would be to fix the setpath.nsi 
RemoveFromPath function so it removes the preceding semicolon if a such 
exists.

Thanks to Markku Leinio for reporting this problem.

--
_____________________________________________________________
Mathias Sundman                  (^)   ASCII Ribbon Campaign
OpenVPN GUI for Windows           X    NO HTML/RTF in e-mail
http://openvpn.se                / \   NO Word docs in e-mail


