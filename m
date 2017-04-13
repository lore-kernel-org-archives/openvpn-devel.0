References: <1482102097-29597-1-git-send-email-steffan@...1856...>
From: Steffan Karger <steffan.karger@...1435...>
Message-ID: <2b6a9a4a-2126-7c7d-25d3-23af23050a65@...1435...>
Date: Thu, 13 Apr 2017 11:38:39 +0200
MIME-Version: 1.0
In-Reply-To: <1482102097-29597-1-git-send-email-steffan@...1856...>
Subject: Re: [Openvpn-devel] [PATCH] cleanup: merge
 packet_id_alloc_outgoing() into packet_id_write()
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

On 19-12-16 00:01, Steffan Karger wrote:
> The functions packet_id_alloc_outgoing() and packet_id_write() were
> always called in tandem.  Instead of forcing the caller to allocate a
> packet_id_net to do so, merge the two functions.  This simplifies the API
> and reduces the chance on mistakes in the future.
> 
> This patch adds unit tests to verify the behaviour of packet_id_write().
> Verifying that we assert out correctly required the change to mock_msg.c.
> 
> Signed-off-by: Steffan Karger <steffan@...1856...>
> ---
> This patch is for the master branch only.
> 
>  src/openvpn/crypto.c                      |  19 ++--
>  src/openvpn/packet_id.c                   |  24 ++++-
>  src/openvpn/packet_id.h                   |  35 +++----
>  src/openvpn/tls_crypt.c                   |   4 +-
>  tests/unit_tests/openvpn/Makefile.am      |  16 ++-
>  tests/unit_tests/openvpn/mock_msg.c       |  15 ++-
>  tests/unit_tests/openvpn/test_packet_id.c | 168 ++++++++++++++++++++++++++++++
>  7 files changed, 229 insertions(+), 52 deletions(-)

Can I tempt anyone into reviewing this patch?  Don't get scared by the
size - it's mostly adding tests.  The function changes are very small.

-Steffan


