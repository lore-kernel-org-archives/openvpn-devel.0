References: <20210425232831.2611-1-a@...2181...>
 <20210426132603.31629-1-a@...2181...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <6262a011-ca62-2c5d-aa3b-a03917c0ad31@...1227...>
Date: Mon, 26 Apr 2021 15:42:39 +0200
MIME-Version: 1.0
In-Reply-To: <20210426132603.31629-1-a@...2181...>
Content-Language: en-GB
Subject: Re: [Openvpn-devel] [PATCH v3] Add documentation on
 EVENT_READ/EVENT_WRITE constants
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: Antonio Quartulli <a@...2181...>, openvpn-devel@lists.sourceforge.net

Am 26.04.21 um 15:26 schrieb Antonio Quartulli:
> From: Arne Schwabe <arne@...1227...>
> 
> Changes from v2:
> - moved event definitions to event.h
> - removed READ/WRITE_SHIFT and use EVENT_READ/WRITE
> - removed ifdefs around *_SHIFTS definitions in event.h
> 
> Changes from v1:
> - fixed typ0s
> - extended comment
> - moved *_SHIFT definition to openvpn.h
> - made READ/WRITE events dependant on _SHIFT definition with a macro
> 
> Signed-off-by: Arne Schwabe <arne@...1227...>
> Signed-off-by: Antonio Quartulli <a@...2181...>

Thanks for picking it up and getting it in shape. It probably should now
say From: Antonio Quartulli <a@...2181...> as that is now most of the
code. That also looks better on the commit log as it doesn't look like I
acked my own patch.

Acked-By: Arne Schwabe <arne@...1227...>

