Message-ID: <20110407143829.29319.qmail@...1287...>
Date: Thu, 7 Apr 2011 16:38:29 +0200
From: Peter Stuge <peter@...1287...>
References: <1302106222-10256-1-git-send-email-davids@...1347...>
	<BANLkTik3QGpmced2mqhxDv6cmNJDZcxFMw@...278...>
	<4D9DB2AE.2080907@...1347...>
	<BANLkTin837cp5Z1vUYTak_Wx3MDUbEHJrw@...278...>
MIME-Version: 1.0
In-Reply-To: <BANLkTin837cp5Z1vUYTak_Wx3MDUbEHJrw@...278...>
Subject: Re: [Openvpn-devel] [PATCH] Change the default --tmp-dir path to
	a	more suitable path
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

Alon Bar-Lev wrote:
> I really think you should remove this from compile time (autoconf). It
> is useless, users can override it anyway in configuration, so there is
> no need for this.

And users can also set the environment variable to point to where
they want. Agree, please remove from autoconf.


//Peter

