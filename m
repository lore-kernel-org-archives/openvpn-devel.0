From: Florian Weimer <fw@...315...>
Subject: Re: [Openvpn-devel] Core dump ("unaligned access") on OpenBSD3.5 (DS10 - Alpha arch)
References: <200412161458.49238.csr@...331...>
	<Pine.LNX.4.58.0412160745480.9763@...41...>
In-Reply-To: <Pine.LNX.4.58.0412160745480.9763@...41...> (James Yonan's
	message of "Thu, 16 Dec 2004 07:56:38 -0700 (MST)")
Message-ID: <87wtvg1q71.fsf@...315...>
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
Date: Fri Dec 17 15:06:01 2004
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
To: James Yonan <jim@...41...>
Cc: Christian =?iso-8859-1?Q?R=F8snes?= <csr@...331...>, openvpn-devel@lists.sourceforge.net

* James Yonan:

>> >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
>> Program terminated with signal 10, Bus error.
>> #0  0x120023904 in mroute_extract_addr_from_packet 
>> (src=0x1ffffb220, dest=0x1ffffb208, buf=0x1, tunnel_type=-20292) at 
>> mroute.c:113
>> 113                           memcpy (src->addr, &ip->saddr, 4);
>> >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
>> 
>> I think my system choke on the 'ip->saddr' address in the memcpy statement.
>
> That's strange that it would hit an alignment fault on a memcpy.  memcpy
> is supposed to operate at byte granularity.

I suspect this statement is the problem:

  const struct openvpn_iphdr *ip = (const struct openvpn_iphdr *) BPTR (buf);

The cast results in undefined behavior if BPTR (buf) has the wrong
alignment.  Recent versions of GCC know this and therefore conclude
that BPTR must be properly aligned.  As a result, it is possible to
replace memcpy() with something that copies word-wise.

The char * casts in your other message won't fix this, they come too
late.  It's a common misconception that char pointers behave like
machine addresses.  They don't.

Just to be clear, this is not a bug in GCC.  Your code is not valid C.

