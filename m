References: <56BB454C.3050006@...1227...>
	<1463393584-8318-1-git-send-email-gert@...1296...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <5739BE81.7000500@...1227...>
Date: Mon, 16 May 2016 14:35:13 +0200
MIME-Version: 1.0
In-Reply-To: <1463393584-8318-1-git-send-email-gert@...1296...>
Subject: Re: [Openvpn-devel] [PATCH v3] Implement push-remove option to
 selectively remove pushed options.
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
To: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net

Am 16.05.16 um 12:13 schrieb Gert Doering:
> With this option, the server can remove individual options from the
> set pushed to a client (call from --client-config-dir file, or from
> --client-connect script or plugin).  Options are removed at parse
> time, so it is possible to do stuff like:
> 
>   push-remove route-ipv6
>   push "route-ipv6 fd00::/8"
> 
> to first remove all IPv6 route options set so far, then add something
> specific (what "push-reset" does to all the options).
> 
> Arguments to push-remove are strncmp()'ed to option string, so partial
> matches like
> 
>   push-remove "route-ipv6 2001:"
> 
> are possible ("remove all IPv6 routes starting with 2001:").
> 
> Implementation of remove_iroutes_from_push_route_list() had to be changed
> slightly to stop it from re-enabling all disabled options again.
> 
> v2: documentation (Changes.rst, doc/openvpn.8)
>     remove surplus gc_arena
>     implement filtering of "ifconfig-ipv6"
> 
> v3: correct quoting in commit message
>     only handle a single argument per push-remove statement - if multiple
>     options are to be removed, just use multiple push-remove statements

Ack, thanks for v3.

Arne


