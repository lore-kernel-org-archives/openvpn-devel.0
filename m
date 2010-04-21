Message-Id: <CA8D46C6-BAA6-4BEA-901B-34E1B5B20D97@...1348...>
From: Toby Thain <toby@...1348...>
In-Reply-To: <4BCF0259.8070902@...1347...>
Mime-Version: 1.0 (Apple Message framework v936)
Date: Thu, 22 Apr 2010 00:13:35 +1000
References: <4BCF0259.8070902@...1347...>
Subject: Re: [Openvpn-devel] Slight modification to the contrib client.up
	script: DNS in server order
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
To: Richard Monk <rmonk@...1347...>
Cc: openvpn-devel@lists.sourceforge.net


On 21-Apr-10, at 11:49 PM, Richard Monk wrote:

> I had an issue come up where the clients were getting DNS entries in  
> the
> reverse order the server sends them when using the client.up contrib
> script.  Since the DNS servers on our system are in order from
> closest->farthest network wise from the VPN server, having them
> backwards caused some performance issues.

Have you considered a local caching DNS with forwarding?

--Toby

>
> I've attached a patch that puts the DNS entries in the correct order
> that the server sends them.  Can this be updated in the next release?
>
> -- 
> Richard Monk (rmonk@...1347...) - Security Analyst
> Red Hat - Centennial Office: Raleigh, NC USA
> +1 (919) 890 8501
> GPG Key ID: 0x1EBEF129
> <dns-order- 
> client 
> .up 
> .patch 
> > 
> ------------------------------------------------------------------------------
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel


