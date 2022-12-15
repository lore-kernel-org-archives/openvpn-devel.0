Message-ID: <74ca6b40-220d-f731-7c16-3e3e35bba8e9@...1227...>
Date: Thu, 15 Dec 2022 23:52:14 +0100
MIME-Version: 1.0
From: Arne Schwabe <arne@...1227...>
References: <20221215190143.2107896-1-arne@...1227...>
 <20221215190143.2107896-3-arne@...1227...>
In-Reply-To: <20221215190143.2107896-3-arne@...1227...>
Subject: Re: [Openvpn-devel] [PATCH 2/8] ssl_verify: Fix memleak if creating
 deferred auth control files fails
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
To: openvpn-devel@lists.sourceforge.net
Cc: David Sommerseth <davids@...515...>


Am 15.12.2022 um 20:01 schrieb Arne Schwabe:
> From: David Sommerseth <davids@...515...>
>
> If the key_state_gen_auth_control_files() call fails, the code would
> just return without freeing the argv container.  Instead the code should
> jump to an appropriate exit point where memory is being released.
>
> Also adjust the related comment, to indicate that these deferred auth
> control files are really pre-created.
>
> Signed-off-by: David Sommerseth <davids@...515...>
>
> Reported-by: Trial of Bits (TOB-OVPN-2)

Typo here: Should be Trail of Bits (my mistake)


