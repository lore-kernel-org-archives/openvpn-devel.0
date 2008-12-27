Message-ID: <9e0cf0bf0812271220h508b1d0h535420d8dec1dee9@...278...>
Date: Sat, 27 Dec 2008 22:20:47 +0200
From: "Alon Bar-Lev" <alon.barlev@...277...>
In-Reply-To: <49568CE0.7050104@...1148...>
MIME-Version: 1.0
References: <48F11865.5080903@...1135...>
	<495628C0.7060405@...1135...>
	<9e0cf0bf0812270738s2a248adcx6967116ee58e1edd@...278...>
	<4956551D.7030700@...1148...>
	<9e0cf0bf0812271015q1bfcf453j8dd94f216945ad2e@...278...>
	<49567616.8020406@...1148...>
	<9e0cf0bf0812271111y7e02691au99114ef2cc0cd139@...278...>
	<4956821E.6010402@...1148...>
	<9e0cf0bf0812271143n2b4b88f9p5c7c4f7ab97a10cd@...278...>
	<49568CE0.7050104@...1148...>
Subject: Re: [Openvpn-devel] Alternative GUI for OpenVPN
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
To: Morten Christensen <mc-openvpn@...1148...>
Cc: openvpn-devel@lists.sourceforge.net

On 12/27/08, Morten Christensen <mc-openvpn@...1148...> wrote:
>  > I just never had username configuration before... I actually don't
>  > understand why you need it anyway.... :)
>  >
>
> We are combining a certificate without password with authentification
>  with the username and password of the servers.
>  I find that it has 2 advantages:
>  The user cannot change the password to something too short.
>  When the user forgets the password, it is easy to enter a new one
>  without the need far a new certificate.

OK... but the true protection is the cryptography... So the level of
authentication is username/password.

Have you tried the dummy scenario.

Alon.

