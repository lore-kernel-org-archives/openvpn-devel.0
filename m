From: James Yonan <jim@...41...>
In-Reply-To: <Pine.LNX.4.61.0410240047440.12811@...210...>
Message-ID: <Pine.LNX.4.58.0410231759230.23144@...269...>
References: <Pine.LNX.4.61.0410240047440.12811@...210...>
MIME-Version: 1.0
Subject: [Openvpn-devel] Re: exit_event not check between key password auth username
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
Date: Sat Oct 23 17:01:02 2004
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 8bit
To: Mathias Sundman <mathias@...209...>
Cc: openvpn-devel@lists.sourceforge.net


On Sun, 24 Oct 2004, Mathias Sundman wrote:

> I've added support for the new username/password auth method to OpenVPN 
> GUI.
> 
> If you have a setup with double auth (both key/cert and username/password 
> auth), the GUI first prompt for username/password, and after that for 
> the private key passphrase. If --askpass is specified in the config 
> they come in the reverse order of cource. Works perfect...
> 
> But, if the user hits Cancel on the first prompt, I signal the exist 
> event, but OpenVPN does not seem to check this between these two prompts, 
> so the user is still given the second auth dialog, which is a little 
> annoying.
> 
> Do you think this should be fixed in OpenVPN, or should I handle it in the 
> GUI, by simply sending an extra CR for the next prompt?

Yeah, right now the exit event is not checked between username/password 
inputs.  I can probably add that.

James


