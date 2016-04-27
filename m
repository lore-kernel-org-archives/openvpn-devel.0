References: <53F1D97B.8010801@...1085...> <53F1DA95.7020701@...1085...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <57206F20.2060102@...1227...>
Date: Wed, 27 Apr 2016 10:49:52 +0300
MIME-Version: 1.0
In-Reply-To: <53F1DA95.7020701@...1085...>
Subject: Re: [Openvpn-devel] [PATCH] Push an IPv6 CIDR mask used by the
 server, not the pool's size
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
To: Josh Cepek <josh.cepek@...1085...>, openvpn-devel@lists.sourceforge.net

Am 18.08.14 um 13:51 schrieb Josh Cepek:
> Correctly handle CIDR masks when pushing clients addressing from an IPv6
> pool. This change ignores the incorrectly used `bits` argument to the
> --ifconfig-ipv6-pool option.
> 
> The code to save any provided CIDR mask after the pool IP is left in;
> this may someday become useful when we move to allow IPv6 pools without
> relying on an IPv4 pool assignment.
> 

ACK from me. The code change makes sense and the manpage change is good too.

Arne


