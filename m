Date: Wed, 11 May 2022 12:17:33 +0200 (CEST)
From: Frank Lichtenheld <frank@...2641...>
Message-ID: <1957647252.642516.1652264253337@...2642...>
In-Reply-To: <20220422142953.3805364-18-arne@...1227...>
References: <20220422134038.3801239-1-arne@...1227...>
 <20220422142953.3805364-1-arne@...1227...>
 <20220422142953.3805364-18-arne@...1227...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH 27/28] Add unit test for
 reliable_get_num_output_sequenced_available
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: Arne Schwabe <arne@...1227...>, openvpn-devel@lists.sourceforge.net

Acked-By: Frank Lichtenheld <frank@...2641...>

Not sure whether it should be concerning that reliable_get_num_output_sequenced_available
is happy to give results given the complete garbage we put into the test
buffer. But anyway, an UT is better than no UT and the test code looks
correct to me.

Obviously depends on previous patches.

Regards,
  Frank

> Arne Schwabe <arne@...1227...> hat am 22.04.2022 16:29 geschrieben:
> 
>  
> ---
>  tests/unit_tests/openvpn/Makefile.am       |  5 +-
>  tests/unit_tests/openvpn/mock_get_random.c | 10 ++++
>  tests/unit_tests/openvpn/test_packet_id.c  | 55 ++++++++++++++++++++++
>  3 files changed, 69 insertions(+), 1 deletion(-)
> 

--
Frank Lichtenheld

