From: James Yonan <jim@...41...>
Subject: Re: [Openvpn-devel] One Time Password support
In-Reply-To: <2A6C5A0148EE5B4CBAD6C9BD6F590C48023C57@...330...>
Message-ID: <Pine.LNX.4.58.0412160301410.29069@...41...>
References: <2A6C5A0148EE5B4CBAD6C9BD6F590C48023C57@...330...>
MIME-Version: 1.0
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
Date: Thu Dec 16 02:11:02 2004
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 8bit
To: Farid Sarwari <fsarwari@...329...>
Cc: openvpn-devel@lists.sourceforge.net

On Wed, 15 Dec 2004, Farid Sarwari wrote:

> If one time passwords are used in the authentication is there a way to
> tell openvpn to renegotiate the SSL but not AUTH to prevent
> disconnection after every renegotiation?

No, that would create a security hole if TLS renegotiations could occur 
without the username/password, when --auth-user-pass-verify is specified.

> Or is the only way to use One Time Passwords to set --reneg-sec to
> something really high?

That would work.  You could also add --auth-nocache to prevent 
username/password caching.  Then OpenVPN would reprompt for u/p when the 
next TLS negotiation occurs.

> I use three factor authentication to connect: username, password, Key
> (from FOB device).  Key is appended to the username. Would it be
> possible to tell openvpn to prompt once again for a Key?
> 
> C:\> openvpn home.ovpn
> Enter Auth Username: jsmith
> Enter Auth Password: *******
> Enter Auth Key: 234-2343

There aren't any plans right now to add more fields beside 
username/password.  If extra info is needed, you can always postfix to 
username or password as you've done.

James

