Date: Fri, 18 Mar 2011 17:37:03 +0100
From: Thomas Glanzmann <thomas@...1029...>
Message-ID: <20110318163703.GB29966@...1029...>
References: <20110317054155.GA9684@...1029...>
	<201103181442.48308.hhund@...194...>
	<20110318144325.GF26254@...1029...>
	<201103181726.51810.hhund@...194...>
MIME-Version: 1.0
In-Reply-To: <201103181726.51810.hhund@...194...>
Subject: Re: [Openvpn-devel] OpenVPN GUI and ntlm Proxy password
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
To: Heiko Hund <hhund@...194...>
Cc: openvpn-devel@lists.sourceforge.net, info@...454...

Hello Heiko,

> The incomplete filename is caused by a too small buffer in the GUI.
> You must be using a hostname for the proxy and it's somewhere close to
> 30 characters long, right? I'll add a bug to the tracker for this
> then. In the meantime, could you please try if it works for you using
> the proxy IP address.

that's correct. The hostname has 29 chars.

Cheers,
        Thomas

