Message-ID: <20100401081508.14746.qmail@...1287...>
Date: Thu, 1 Apr 2010 10:15:08 +0200
From: Peter Stuge <peter@...1287...>
References: <cover.1270060247.git.fabian.knittel@...1338...>
	<70dd1e1441bb32df36f449920384f20a3683a2f0.1270060247.git.fabian.knittel@...1338...>
	<20100331230347.1687.qmail@...1287...> <4BB450FB.4010307@...1338...>
MIME-Version: 1.0
In-Reply-To: <4BB450FB.4010307@...1338...>
Subject: Re: [Openvpn-devel] [PATCH 3/9] vlan: Add per-client
	--vlan-tag	option
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: openvpn-devel@lists.sourceforge.net

Hi Fabian,

Fabian Knittel wrote:
> >> +#define OPENVPN_8021Q_MAX_VID 0xFFFE
> > 
> > The max VID in 802.1q is 4095 = 0xfff.
> 
> You are absolutely correct.  Thanks for catching that.  I intended
> it to say 0xFFE, because the standard talks about VID values being
> valid within the range 0 through 4094 [1].

Aha!


> But OPENVPN_8021Q_MASK_VID should definitely be defined as 0xFFF,
> as the bit field is 12 bits.

Right.


> VID == 0xFFF is "Reserved for implementation use." and "shall not
> be configured as PVID [...] or transmitted in a tag header." [2]
> But I'm not sure whether it's used in reality and if you'd like
> that value to be accepted, I have no objections.

I think it's good to play along with the standards, so I like MAX
0xffe too.


> Thanks again for reviewing!

You're welcome!


//Peter

