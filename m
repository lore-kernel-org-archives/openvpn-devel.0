Message-ID: <54721676.90108@...1856...>
Date: Sun, 23 Nov 2014 18:16:38 +0100
From: Steffan Karger <steffan@...1856...>
MIME-Version: 1.0
References: <1416755831-21250-1-git-send-email-lstipakov@...277...>
In-Reply-To: <1416755831-21250-1-git-send-email-lstipakov@...277...>
Subject: Re: [Openvpn-devel] [PATCH] Peer-id patch v7
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

On 23-11-14 16:17, Lev Stipakov wrote:
> Added new packet format P_DATA_V2, which includes peer-id. If server
> supports, client sends all data packets in the new format. When data
> packet arrives, server identifies peer by peer-id. If peer's ip/port has
> changed, server assumes that client has floated, verifies HMAC and
> updates ip/port in internal structs.

ACK

During the hackathon, the group decided that this indeed is a nice way
to support floating clients. I did a code review, but no real testing
(just 'make check', including t_client). Lev, Gert and Arne have however
performed real-life tests with multiple iterations of this patch.

A remaining issue is that the memory usage of a client increases for
each 'float', because generate_prefix(mi) allocates memory on each call,
which will only be free'd when the client disconnects. However, we
agreed to fix that in a separate patch.

-Steffan

