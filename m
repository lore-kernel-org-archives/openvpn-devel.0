From: James Yonan <jim@...41...>
Subject: Re: [Openvpn-devel] Re: OpenVPN with OPIE (One Time Passwords in
 Everything) ??
In-Reply-To: <pan.2005.02.03.18.39.30.133381@...294...>
Message-ID: <Pine.LNX.4.58.0502031317270.23846@...41...>
References: <4202350D.4020708@...348...> <pan.2005.02.03.18.39.30.133381@...294...>
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
Date: Thu Feb  3 12:28:32 2005
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 8bit
To: Charles Duffy <cduffy@...294...>
Cc: openvpn-devel@lists.sourceforge.net


On Thu, 3 Feb 2005, Charles Duffy wrote:

> On Thu, 03 Feb 2005 15:28:29 +0100, Patrick Steiner wrote:
> 
> > Is it possible to use OpenVPN with OPIE (One Time Passwords in
> > Everything) What i want is to connect from a windows client to a linux
> > server. But for OPIE i need a interactive password authentication. this
> > means: the server send password string an the user at the client side
> > give his password based on the string from the server. Is this possible
> > to inplement?
> 
> It's already implemented. See auth-user-pass and auth-user-pass-verify.

Right, but I think he's asking for a challenge/response mechanism, which 
doesn't yet exist.

The server would need to generate a challenge string and send it to the
client BEFORE the client-user enters the password.  It could be done but 
would require a patch.

James


