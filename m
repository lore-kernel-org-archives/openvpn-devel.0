Message-ID: <188809bc-0046-425b-8e84-86a7ced340ac@...1227...>
Date: Mon, 12 Feb 2024 14:47:21 +0100
MIME-Version: 1.0
References: <20240212132522.125903-1-juliusz@...2525...>
Content-Language: en-GB
From: Arne Schwabe <arne@...1227...>
In-Reply-To: <20240212132522.125903-1-juliusz@...2525...>
Subject: Re: [Openvpn-devel] [PATCH] Change include order for tests
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
To: Juliusz Sosinowicz <juliusz@...2525...>, openvpn-devel@lists.sourceforge.net

Am 12.02.24 um 14:25 schrieb Juliusz Sosinowicz:
> Including "ssl.h" conflicts with the wolfSSL ssl.h header file. The openvpn/src directory needs to be included before include/wolfssl. include/wolfssl needs to be included so that openvpn can pick up wolfSSL compatibility headers instead of OpenSSL headers without changing the paths.
> 
> src/openvpn/Makefile.am does not need to be modified because AM_CPPFLAGS is placed before AM_CFLAGS in the output Makefile.
> 


That looks reasonable and having test includes in a more similar order 
than our normal includes is also a good thing.

Acked-By: Arne Schwabe <arne@...1227...>


