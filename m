From: Lev Stipakov <lstipakov@...277...>
Date: Fri, 11 Dec 2015 22:29:33 +0200
Message-ID: <566B322D.1040300@...277...>
References: <1447079709-17806-1-git-send-email-lstipakov@...277...>
	<20151109145555.GE24952@...1296...> <5642F6B7.7090902@...277...>
	<20151111081604.GU24952@...1296...> <566B2704.8070500@...277...>
	<20151211200722.GU24952@...1296...>
Mime-Version: 1.0
In-Reply-To: <20151211200722.GU24952@...1296...>
Subject: Re: [Openvpn-devel] [PATCH v2] Use adapter index instead of name
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Thanks, I think (I think!) I got it now.

1) Since we have tt->adapter_index (which temporarily disappeared from 
my perception of reality), no need to add new member to tuntap or 
tuntap_options.

2) tt->adapter_index has nothing to do with rgi->adapter_index, first 
one is windows adapter index (which we pass to netsh), last one is for 
routing (which we pass to netsh too in special case).

3) In add/del_route* we (try to) use tt->adapter_index.

Regarding master's "special case" code. Should it be something like this:

   if ( r6->adapter_index )		/* vpn server special route */
     {
       struct buffer out = alloc_buf_gc (64, &gc);
       buf_printf (&out, "interface=%d", r6->adapter_index );
       device = buf_bptr(&out);
       gateway_needed = true;
     }
   else
     {
       /* device = interface=tt->adapter_index */
     }

-Lev


