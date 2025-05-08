Message-ID: <eb1fff71-bcfb-4360-af40-31f9856a1019@...2181...>
Date: Thu, 8 May 2025 13:28:45 +0200
MIME-Version: 1.0
References: <20250430123250.8627-1-a@...2181...>
 <20250505225549.19492-1-a@...2181...> <aBtEWDpucmll4HJJ@...1296...>
Content-Language: en-US
From: Antonio Quartulli <a@...2181...>
In-Reply-To: <aBtEWDpucmll4HJJ@...1296...>
Subject: Re: [Openvpn-devel] [PATCH ovpn-net-next v2] ovpn: ensure sk is
 still valid during cleanup
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
To: Sabrina Dubroca <sd@...2891...>
Cc: openvpn-devel@lists.sourceforge.net

Hi Sabrina,

On 07/05/2025 13:30, Gert Doering wrote:
> Tested-By: Gert Doering <gert@...1296...>
> 

Gert has stress tested this change quite a bit and he couldn't reproduce 
any side issue.

To me it looks like this is a reasonable solution to avoid clashes due 
to racing cleanups (ovpn_socket_release vs destroy/close).

Please let me know if you have any comment, otherwise I'd like to send 
this to netdev for inclusion, since it fixes a frequent kernel panic.

Regards,



-- 
Antonio Quartulli


