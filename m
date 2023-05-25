Message-ID: <f4adb251-da78-754a-5738-688fde356f81@...1227...>
Date: Thu, 25 May 2023 17:39:10 +0200
MIME-Version: 1.0
References: <20230509154657.2756-1-gianmarco@...2726...>
From: Arne Schwabe <arne@...1227...>
In-Reply-To: <20230509154657.2756-1-gianmarco@...2726...>
Subject: Re: [Openvpn-devel] [PATCH] Persist-key: enable persist-key option
 by default.
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
To: Gianmarco De Gregori <gianmarco@...2726...>, openvpn-devel@lists.sourceforge.net


Am 09.05.2023 um 17:46 schrieb Gianmarco De Gregori:
> -    bool persist_key;           /* Don't re-read key files on SIGUSR1 or PING_RESTART */

The downside of always enabling this option is that you can no longer 
replace the certificate and key without restarting the server completley.

Arne


