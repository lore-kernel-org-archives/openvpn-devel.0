Message-ID: <3EB45928.6010307@...7...>
From: bishop <bishop@...7...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] Fwd: Re: comp-lzo and licensing issues
References: <20030428142748.GA826@...30...> <20030502160707.GB29245@...33...> <20030503093244.GA943@...30...> <20030503235033.GA5461@...33...>
In-Reply-To: <20030503235033.GA5461@...33...>
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Sat May  3 17:06:33 2003
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
To: Matthias Andree <ma+ovpnd@...31...>
Cc: OpenVPN devel <openvpn-devel@lists.sourceforge.net>

Matthias Andree wrote:
>>If OpenSSL is in the base system of FreeBSD, then there shouldn't be any
>>problem linking LZO with it.
>>You could also allow OpenVPN binaries without LZO support (as I
>>currently do in Debian).
> 
> This will break compatibility and is no longer needed in the light of
> the special permission Markus has given us.

This is actually a recurring problem with another, similar product.  The 
official word when it comes up over there is:  Use it if you want, 
because we can't stop you, but it's not recommended, definitely not 
supported, and problems aren't generally acceptable when logged against 
a derivative build with pieces missing.

Hmm.  I sense another Special Permission Request, though.

  - bish

-- 



