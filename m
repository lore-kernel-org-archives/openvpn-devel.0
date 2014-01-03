From: Lev Stipakov <lstipakov+openvpn.devel@...277...>
Date: Fri, 3 Jan 2014 11:58:25 +0000 (UTC)
Message-ID: <loom.20140103T122843-610@...171...>
References: <8c01c399-7f0c-477d-9bbe-dab589231ffc@...1848...>	<52B75C6B.9080100@...1847...>
	<52B76494.5010903@...1847...>	<20131223113229.GB161@...1296...>	<52B84C1F.8010500@...1847...>
	<CAHqXQkMpp9ayVdfgnyvvFjUy-HcmS0BYO--N_SDEbOUDUE9zbw@...278...>
	<52C1ADF7.2050702@...1227...>
Mime-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH v3] Floating: Add support for floating
	in TLS mode
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

Hi Arne,

I am researching how "session id" can be added to packet. Could you please 
clarify the statement "If we choose the session id to be 3 or 7 byte we 
would not need the "hack" for the packets with
session id." ?

I am currently at very beginning, so questions might look odd.

1) "3 or 7" - does it mean byte's ordinal number in packet or length of 
session id in bytes?

2) What you mean by "hack"? Do you mean new packet format or something else?

3) I am trying to comprehend protocol format reading 
http://openvpn.net/index.php/open-source/documentation/security-
overview.html and looking at wireshark capture results. Where exactly 
session id field should be placed?

-Lev


