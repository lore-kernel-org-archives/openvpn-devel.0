From: Charles Duffy <cduffy@...294...>
Message-ID: <pan.2005.02.03.18.39.30.133381@...294...>
References: <4202350D.4020708@...348...>
Mime-Version: 1.0
Subject: [Openvpn-devel] Re: OpenVPN with OPIE (One Time Passwords in Everything) ??
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
Date: Thu Feb  3 10:47:53 2005
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

On Thu, 03 Feb 2005 15:28:29 +0100, Patrick Steiner wrote:

> Is it possible to use OpenVPN with OPIE (One Time Passwords in
> Everything) What i want is to connect from a windows client to a linux
> server. But for OPIE i need a interactive password authentication. this
> means: the server send password string an the user at the client side
> give his password based on the string from the server. Is this possible
> to inplement?

It's already implemented. See auth-user-pass and auth-user-pass-verify.


