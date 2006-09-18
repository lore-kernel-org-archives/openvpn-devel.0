From: Charles Duffy <cduffy@...294...>
Date: Mon, 18 Sep 2006 10:05:47 -0500
Message-ID: <eemckf$jfd$1@...165...>
References: <450C6060.6060605@...777...>
Mime-Version: 1.0
In-Reply-To: <450C6060.6060605@...777...>
Sender: news <news@...165...>
Subject: Re: [Openvpn-devel] request for input re: OpenVPN API
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

I'm not an OpenVPN developer per se -- other than a few trivial patches 
-- but I should be able to comment.

First -- the requirements for what you want a VPN to do in a grid 
environment are something which need to be specified. Since OpenVPN is 
limited to either a 2-endpoint peer-to-peer model or a hub-and-spoke 
model, it isn't necessarily well-suited to cases where a arbitrary 
communications will need to be encrypted within a cloud.

Second, OpenVPN already provides a number of methods to interact with it 
which are readily programmatically accessible. This includes the manual 
page; OS-level signals; command-line and configuration file parameters; 
etc. My experience is that these are more than adequate for controlling 
the behavior which is presently available -- and that in cases where 
these tools and in of themselves don't provide the desired level of 
functionality, that building additional layers on top of the preexisting 
interfaces (rather than building entirely new interfaces) is appropriate.

Could you document the exact functionality you wish to add, and the 
business case for exposing that functionality as a native API?


