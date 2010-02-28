From: Davide Brini <dave_br@...1278...>
Date: Sun, 28 Feb 2010 23:26:32 +0000
References: <1267391523-1123-1-git-send-email-openvpn.list@...1114...>
In-Reply-To: <1267391523-1123-1-git-send-email-openvpn.list@...1114...>
MIME-Version: 1.0
Message-Id: <201002282326.32573.dave_br@...1278...>
Subject: Re: [Openvpn-devel] [PATCH] bash->bourne script cleanup
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

On Sunday 28 February 2010, David Sommerseth wrote:
> From: Dan Nelson <dnelson@...384...>
> 
> Many of the scripts in the openvpn source have their shell set to
> /bin/bash, but only two use bash features. The attached patch (against
> openvpn-2.1_rc9) sets the shell on the rest of the scripts to /bin/sh for
> better portability. The only scripts that actually require bash are
> contrib/pull-resolv-conf/client.{up,down} ; they use the ${!var} variable
> indirection feature.

Not only that, they also use arrays, which are not part of standard sh.

For a POSIX-sh compliant solution thad does mostly the same thing (and handles 
multiple DOMAIN options as well, which client.{up,down} doesn't support), I 
suggest  you look into the Gentoo-provided {up,down}.sh scripts (though they 
contain some Gentoo-specific parts, but those are easily removed).

-- 
D.

