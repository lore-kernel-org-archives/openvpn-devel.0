Message-ID: <0e8144ec-8249-86fe-4d69-34ac315f39ef@...1227...>
Date: Mon, 9 Jan 2023 16:29:31 +0100
MIME-Version: 1.0
Content-Language: en-GB
References: <20221227223506.34136-1-gert@...1296...>
 <20230107162558.59659-1-gert@...1296...>
From: Arne Schwabe <arne@...1227...>
In-Reply-To: <20230107162558.59659-1-gert@...1296...>
Subject: Re: [Openvpn-devel] [PATCH v2] Undo FreeBSD 12.x workaround on IPv6
 ifconfig for 12.4 and up
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net

Am 07.01.23 um 17:25 schrieb Gert Doering:
> commit 5e19cc2c1bf22d introduced a workaround for a race condition
> that showed itself on IPv6 ifconfig on FreeBSD 12.x - sometimes breaking
> IPv6 connectivity on tun/tap interfaces.
> 
> This was fixed on the FreeBSD side in 12.4, 13.1 and up, and 13.0 is
> no longer supported.  So conditionalize the workaround on "12.0..12.3",
> to be fully removed later when 12.3 is also running out of support.
> 
> v2: fix version number comparison
> 

Thanks that looks now better.

Acked-By: Arne Schwabe <arne@...1227...>


