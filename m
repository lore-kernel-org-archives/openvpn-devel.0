From: chantra <chantra@...1258...>
Date: Thu, 3 Jun 2010 17:38:19 +0000 (UTC)
Message-ID: <loom.20100603T180754-260@...171...>
References: <mailman.487721.1275403360.5170.openvpn-devel@lists.sourceforge.net>
	<1275576515.23148.829.camel@...1259...>
	<20100603154619.GD26982@...1296...>
Mime-Version: 1.0
Subject: Re: [Openvpn-devel]
	=?utf-8?q?=5BPATCH=5D_Re=3A_Handling_of_subnets_g?=
	=?utf-8?q?rammar_in=09Packet_filter_file?=
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Gert Doering <gert <at> greenie.muc.de> writes:


> Both have merits, your fix is somewhat less code then adding an extra input
> validation check 
> 
>   if ((network.s_addr & netmask) != network.s_addr )  
>     { complain; }
> 
> - so: ACK from me.
> 
> (Since OpenVPN likes to print warnings, we *could* add code to print a 
> warning in this case - "warning: subnet address changed to match /%d,
> new value is %s/%d").
> 
> gert

Gert,

As discussed on IRC, it make sense to "warn" the admin, 
but it seems it is all that can be done as this is 
being going on at runtime.

I upated the patch and it will now display something like:
WARNING: PF: /dev/shm/openvpn_pf_ff18e7030fd03ce91bd0432563e4eb1a.tmp/5: 
incorrect subnet 192.168.100.8/28 changed to 192.168.100.0/28





