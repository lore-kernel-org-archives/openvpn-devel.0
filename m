Message-ID: <4F9986A2.10900@...1114...>
Date: Thu, 26 Apr 2012 19:32:18 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <1335441085-18186-1-git-send-email-davids@...1347...>
	<CAOazyz3-f2YkXE_vV2Oum+p4exQTUis=Q9RTOrvZ7WC0WEZymg@...278...>
	<20120426172410.GT1359@...1296...>
In-Reply-To: <20120426172410.GT1359@...1296...>
Subject: Re: [Openvpn-devel] [PATCH] Presume that Linux is always IPv6
 capable at build time
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Gert Doering <gert@...1296...>
Cc: Alon Bar-Lev <alon.barlev@...277...>, openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 26/04/12 19:24, Gert Doering wrote:
> Hi,
> 
> On Thu, Apr 26, 2012 at 07:03:40PM +0300, Alon Bar-Lev wrote:
>> I plan to add --enable-ipv6/--disable-ipv6 to explicit support 
>> ipv6.
> 
> NAK.
> 
> We considered this, and this will add a shitload of #ifdefs which 
> will make maintenance of the code a lot harder.
> 
> (We actually *removed* all the #ifdefs of JJO's IPv6 transport 
> code, because it really hurt)
> 
> We're in the year 2012, there are no operating systems without IPv6
> support anymore, and it does not make sense to have a VPN 
> implementation that has no IPv6 support.

Just for the record, I completely agree with Gert here.  Actually we
should focus on getting OpenVPN work better in IPv6-only environments
- - but that's probably something for the 2.4 cycle.


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk+ZhqIACgkQDC186MBRfrpv2QCgoc6BtPxufXasfiXS8e2VZFwJ
5bAAn2CrZ4I8HJ+vyc6LI3PMnF2LKJI0
=xyRg
-----END PGP SIGNATURE-----

