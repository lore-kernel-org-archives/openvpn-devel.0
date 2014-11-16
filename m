Message-ID: <5468BEB7.5060300@...1856...>
Date: Sun, 16 Nov 2014 16:11:51 +0100
From: Steffan Karger <steffan@...1856...>
MIME-Version: 1.0
References: <1416148892-31540-1-git-send-email-arne@...1227...>
In-Reply-To: <1416148892-31540-1-git-send-email-arne@...1227...>
Subject: Re: [Openvpn-devel] [PATCH] Remove possibility of using --tls-auth
 with non OpenVPN Static key files
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Hi,

Feature-ACK for sure! Some minor comments though:

On 16-11-14 15:41, Arne Schwabe wrote:
> +Older version supported a freeform passphrase file. This is no longer
> +support in newer version.

version -> versions.

Also, I think it would be nice to state the actual versions here (i.e.
supported upto 2.3, dropped in 2.4+). This will help us later with
deciding when to remove this statement altogether.

> -	    msg (M_INFO,
> -		 "Control Channel Authentication: using '%s' as a free-form passphrase file",
> +	    msg (M_ERR,
> +		 "Control Channel Authentication: File '%s' does not have OpenVPN Static Key format. "
> +		 "Using free-form passphrase file is not supported anymore",

Fine, but could we also add a big fat 'This stuff is DEPRECATED' to the
message in the release/2.3 branch?

-Steffan

