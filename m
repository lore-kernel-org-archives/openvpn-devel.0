References: <20211019183127.614175-1-arne@...1227...>
 <20211019183127.614175-10-arne@...1227...>
From: Max Fillinger <maximilian.fillinger@...2507...>
Message-ID: <d1800122-6aaa-3b92-afc7-120d7628fb24@...2507...>
Date: Mon, 25 Oct 2021 13:52:04 +0200
MIME-Version: 1.0
In-Reply-To: <20211019183127.614175-10-arne@...1227...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH v3 09/21] Refactor early initialisation
 and uninitialisation into methods
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

On 19/10/2021 20:31, Arne Schwabe wrote:
> This put the early initialisation and uninitialisation that needs to
> happen between option parsing and post processing into small methods.
> 
> Signed-off-by: Arne Schwabe <arne@...1227...>

Acked-by: Max Fillinger <maximilian.fillinger@...2507...>

It's easy to see that this does not change the behavior. Compiled and 
tested with OpenSSL 3 only because it doesn't actually touch any OpenSSL 
code.

