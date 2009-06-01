From: "dave" <dev@...575...>
Date: Mon, 1 Jun 2009 07:45:13 -0500
Message-ID: <066077553B6D451A8727FFA24F09AC1C@...576...>
MIME-Version: 1.0
In-Reply-To: <20090601051543.GA15965@...1066...>
Subject: Re: [Openvpn-devel] Unable to use -OFB or -CFB ciphers in OpenVPN
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: 'Victor Wagner' <vitus@...1066...>, openvpn-devel@lists.sourceforge.net

> -----Original Message-----
> From: Victor Wagner [mailto:vitus@...1066...] 
...
> > 
> > The OFB and CFB cipher modes in OpenVPN have not been 
> well-tested and 
> > should be considered experimental at this point.
>   
> 
> > They are not compiled by default mostly to prevent someone from 
> > accidentally using them.
> 
> Okay, you see there is some demand for this cipher.
> 
> Can anybody explain why such strange design decision is taken.
> 
> As far as I know cryptography theory, there is absolutely no reason to
> prefer CBC to CFB or CNT.
...

I would suspect that the exclusion is due to:

A)  in CFB/OFB/CNT, the encrypted stream is byte-bounded, as opposed to
block-bounded.  There may be some assumptions in the code that assume
the cipher text is a multiple of block lengths.  As such, it is...

B)  not thoroughly tested, and the choice was made to not release it
without such testing.

I'm curious as to why you want this support specifically, since these
modes aren't really faster than CBC.  Are you concerned about the
padding?

-dave


