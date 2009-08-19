Message-ID: <4A8C20FF.5050202@...41...>
Date: Wed, 19 Aug 2009 08:57:51 -0700
From: James Yonan <jim@...41...>
MIME-Version: 1.0
References: <1250297260.23302.30.camel@...1257...>
In-Reply-To: <1250297260.23302.30.camel@...1257...>
Subject: Re: [Openvpn-devel] nclients patch for 2.1_rc19
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
To: Rob Lemley <rob@...1256...>
Cc: openvpn-devel@lists.sourceforge.net

Thanks for noticing that.  I've committed the patch.

James

Rob Lemley wrote:
> I noticed that building OpenVPN with --disable-server fails. Turns out
> to be a problem with the management server and the commands it allows.
> I've attached a simple patch which fixes it, not sure if it's "right" or
> not...
> 
> 
> 
> 
> ------------------------------------------------------------------------
> 
> ------------------------------------------------------------------------------
> Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
> trial. Simplify your report design, integration and deployment - and focus on 
> what you do best, core application coding. Discover what's new with 
> Crystal Reports now.  http://p.sf.net/sfu/bobj-july
> 
> 
> ------------------------------------------------------------------------
> 
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel

