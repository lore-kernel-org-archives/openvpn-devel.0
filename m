References: <20170906235202.26551-1-davids@...515...>
From: fragmentux <fragmentux@...277...>
Message-ID: <45ee0784-77cf-bba1-85cf-f7c6265b25f5@...277...>
Date: Thu, 7 Sep 2017 16:08:15 +0100
MIME-Version: 1.0
In-Reply-To: <20170906235202.26551-1-davids@...515...>
Content-Language: en-GB
Subject: Re: [Openvpn-devel] [PATCH] systemd: Enable systemd's auto-restart
 feature for server profiles
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Hi,

On 07/09/17 00:52, David Sommerseth wrote:
> Systemd supervises services it has started and can act upon unexpected
> scenarios.  This change will restart OpenVPN after 5 seconds if the OpenVPN
> process exits unexpectedly.

Define "unexpectedly"
(my2c: something needs to be fixed)

> The on-failure mode is the recommended mode by upstream systemd.

IE:
This is the way "upstream systemd" recommend to use systemd
*if*  "some failed process"  is to be restarted.

(my2c: A decision better left to the sys-admin not openvpn developer)


> This change have been tested on a test server for some month, and it
> works indeed as intended when provoking the OpenVPN process to stop.

Define "provoking"
(my2c: not unexpectedly at all, nothing to fix here)


Either way,
it is only a few lines of a systemd unit.service file
to be deleted/customised by the relevant sys-admin.

Regards,

