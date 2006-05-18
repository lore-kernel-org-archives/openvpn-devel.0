From: Charles Duffy <cduffy@...294...>
Message-ID: <e4ij3s$rlq$1@...165...>
References: <op.s9rf5qftioehzu@...596...>
Mime-Version: 1.0
In-Reply-To: <op.s9rf5qftioehzu@...596...>
Subject: [Openvpn-devel] Re: Configuration flexibility enhancement suggestion.
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
Date: Thu May 18 12:50:11 2006
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Why not just have separate config files for each possible configuration, 
rather than stuffing several configurations in one file?

The configurations could be set to exit on failure, and a wrapper script 
(supervised by runit or a similar tool) could be responsible for 
rotating between them.


