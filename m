Date: Fri, 24 Jun 2022 10:14:09 +0200
From: Frank Lichtenheld <frank@...2641...>
Message-ID: <YrVyUXqzPSAdcCLr@...2678...>
References: <20220621161649.2872985-1-arne@...1227...>
 <20220621161649.2872985-4-arne@...1227...>
MIME-Version: 1.0
In-Reply-To: <20220621161649.2872985-4-arne@...1227...>
Subject: Re: [Openvpn-devel] [PATCH 4/6] Implement a function to calculate
 the default MTU
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net

NACK, doesn't build:

mtu.c: In function ‘frame_calculate_default_mtu’:
mtu.c:223:31: error: too few arguments to function ‘frame_calculate_payload_overhead’
  223 |     size_t payload_overhead = frame_calculate_payload_overhead(0, &options, &kt);
      |                               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
mtu.c:111:1: note: declared here
  111 | frame_calculate_payload_overhead(const struct frame *frame,
      | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
make[3]: *** [Makefile:754: mtu.o] Error 1

On Tue, Jun 21, 2022 at 06:16:47PM +0200, Arne Schwabe wrote:
> We could also just hardcode this value to 1420 but this approach does
> not add much (complicated) code and it is a bit better than to have
> a magic number to just be there.
> 
> Signed-off-by: Arne Schwabe <arne@...1227...>
> ---
>  src/openvpn/mtu.c                      | 22 ++++++++++++++++++++++
>  src/openvpn/mtu.h                      | 14 ++++++++++++++
>  tests/unit_tests/openvpn/test_crypto.c | 19 ++++++++++++++++++-
>  3 files changed, 54 insertions(+), 1 deletion(-)

