Message-ID: <2d460de70709111447s22da553bm5bedf43ff92a3609@...278...>
Date: Tue, 11 Sep 2007 23:47:09 +0200
From: "Richard Hartmann" <richih.mailinglist@...277...>
In-Reply-To: <9e0cf0bf0709101323l568ec5e9ge28dcd0bec1ff437@...278...>
MIME-Version: 1.0
References: <2d460de70709100322m6cdd770bh566d825af7a33c7c@...278...>
	<9e0cf0bf0709101323l568ec5e9ge28dcd0bec1ff437@...278...>
Subject: Re: [Openvpn-devel] Revisit of a possible compile-time enabled
	pkcs11-pin option
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
To: Alon Bar-Lev <alon.barlev@...277...>
Cc: openvpn-devel@lists.sourceforge.net

On 10/09/2007, Alon Bar-Lev <alon.barlev@...277...> wrote:

> You can always provide your own management interface program that
> supply static PIN. No need to change anything in OpenVPN.

Yes, that is what I am doing at the moment. Still, I feel that it would be
more reliable, less error prone and, yes, more secure to do it via config
file.

The argument that you could use the management interface holds true
for the passphrase for normal certificates as well, still, after some
discussion, the OpenVPN team decided to offer the option with the
safety guard of it being a compile time option. I can, of course, not
force anyone's hand and make them code or agree to anything, nor
would I want to do so even if I could. Still, I would want to ask you
_why_ you think this is a bad idea, especially in light of exactly the
same thing being available for the established certificate storage
system.


Best regards,
Richard

