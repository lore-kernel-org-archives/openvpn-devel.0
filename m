From: Tony <kb2wjw@...277...>
Message-ID: <op.s9sekxenioehzu@...603...>
References: <op.s9rf5qftioehzu@...596...> <e4ij3s$rlq$1@...165...>
Mime-Version: 1.0
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
Date: Fri May 19 00:19:12 2006
Content-Type: text/plain; format=flowed; delsp=yes; charset=koi8-r
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

On Thu, 18 May 2006 23:49:16 +0400, Charles Duffy <cduffy@...294...>  
wrote:

> Why not just have separate config files for each possible configuration,  
> rather than stuffing several configurations in one file?
I did not know if it is possible on the client.

> The configurations could be set to exit on failure, and a wrapper script  
> (supervised by runit or a similar tool) could be responsible for  
> rotating between them.
The idea is based on what I see in the openssl configuration file  
regarding the certificate generation of different types ("client" vs  
"server"), for example.

Tony.


