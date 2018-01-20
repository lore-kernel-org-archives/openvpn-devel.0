MIME-Version: 1.0
In-Reply-To: <201801201336.w0KDajf8027638@...2054...>
References: <1516423647-21932-1-git-send-email-selva.nair@...277...>
 <201801201336.w0KDajf8027638@...2054...>
From: Selva Nair <selva.nair@...277...>
Date: Sat, 20 Jan 2018 09:05:50 -0500
Message-ID: <CAKuzo_hnkVLOLi1sxs_7kbcCKZ6=kbbV+a6njKh4=5LX=R5srA@...278...>
Subject: Re: [Openvpn-devel] [PATCH applied] Re: Add
 SSL_CTX_get_max_proto_version() not in openssl 1.0
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi,

If/when the TLS1.2+ support for cryptoapicert is ready for merge, is
it a candidate for 2.4? Technically its a new feature but considering
the "popular belief" that TLS1.1 needs to be shunned, and 2.5 is still
far away, its worth considering..

In that case this patch would need to be backported to 2.4, so good to
know what's the general consensus.

Thanks,

Selva

