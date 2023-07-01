Message-ID: <e0aa8be2-1068-7abb-f960-f0964affb00c@...1227...>
Date: Sat, 1 Jul 2023 14:30:00 +0300
MIME-Version: 1.0
References: <20230630123908.82588-1-frank@...2641...>
Content-Language: en-GB
From: Arne Schwabe <arne@...1227...>
In-Reply-To: <20230630123908.82588-1-frank@...2641...>
Subject: Re: [Openvpn-devel] [PATCH] test_tls_crypt: Improve mock() usage to
 be more portable
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
To: Frank Lichtenheld <frank@...2641...>, openvpn-devel@lists.sourceforge.net

Am 30.06.23 um 15:39 schrieb Frank Lichtenheld:
> Use the casting variants of mock(). Using the mock_ptr_type
> fixes an existing bug where test_tls_crypt.c couldn't
> build in MinGW 32bit:

Acked-By: Arne Schwabe <arne@...1227...>


