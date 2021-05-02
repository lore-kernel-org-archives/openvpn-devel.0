References: <20210426152914.18314-1-a@...2181...>
 <20210427191314.21317-1-a@...2181...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <b34461ee-6c06-793e-6ae6-245348f212f2@...1227...>
Date: Sun, 2 May 2021 14:28:42 +0200
MIME-Version: 1.0
In-Reply-To: <20210427191314.21317-1-a@...2181...>
Content-Language: en-GB
Subject: Re: [Openvpn-devel] [PATCH v5] Add documentation on
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
Cc: Antonio Quartulli <antonio@...515...>

Am 27.04.21 um 21:13 schrieb Antonio Quartulli:
> From: Antonio Quartulli <antonio@...515...>
> 
> Changes from v4:
> - get rid of the overly complex EVENT_SHIFT() macro
> 
> Changes from v3:
> - re-introduce READ/WRITE_SHIFT because they are different from EVENT_READ/WRITE
> - define also EVENT_READ/WRITE using READ/WRITE_SHIFT
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

Acked-By: Arne Schwabe <arne@...1227...>

Arne

