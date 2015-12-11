From: Lev Stipakov <lstipakov@...277...>
Date: Fri, 11 Dec 2015 09:47:57 +0200
Message-ID: <566A7FAD.6040203@...277...>
References: <5661686A.4090305@...2070...>
	<1449656275-24934-1-git-send-email-iam@...2070...>
	<56694C04.6020904@...277...> <20151210162651.GI24952@...1296...>
	<5669AD21.4000301@...2070...>
Mime-Version: 1.0
In-Reply-To: <5669AD21.4000301@...2070...>
Subject: Re: [Openvpn-devel] [PATCH v8-master] Add Windows DNS Leak fix
 using WFP ('block-outside-dns')
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

On 10.12.2015 18:49, ValdikSS wrote:

> I'd better go with just
> closing the engine without deleting everything. I don't see any
> drawbacks, that should be perfectly OK for a dynamic session.
>
> Is this correct, Lev? If yes, I'll push v9 today or tomorrow morning.

Removing non-working FwpmSubLayerDeleteByKey0 call is indeed step into 
right direction, rest is up to you :) I already mentioned above what I 
would do.

Just for the record - this patch does not work on my only win10 box with 
DNS leak - it blocks leaks but each DNS request takes 10 seconds, so I 
cannot give an ACK. On the other hand, it works for others in this 
discussion and is optional in any case (should not break things). So I 
won't say NACK either.

-Lev




