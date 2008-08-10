Message-ID: <489F3CF4.7040403@...41...>
Date: Sun, 10 Aug 2008 13:09:40 -0600
From: James Yonan <jim@...41...>
MIME-Version: 1.0
References: <4892B01F.10208@...41...>
	<20080808074543.GA8673@...33...>
In-Reply-To: <20080808074543.GA8673@...33...>
Subject: Re: [Openvpn-devel] OpenVPN 2.1_rc9 released -- note security fix
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: Matthias Andree <matthias.andree@...68...>
Cc: Openvpn-devel@lists.sourceforge.net

> 3 - one part of the self-test suite ("make check") needs to be adjusted
>     to cater for the tightened script security. Patch attached (against
>     SVN) - it also adds retrying if the addresses are in use. Note there
>     are two "svn propedit" or "svn propset" required for an additional
>     --down script - see attached patch

This has been merged in -r3217 
http://svn.openvpn.net/projects/openvpn/branches/BETA21

James

