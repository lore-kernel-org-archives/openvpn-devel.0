From: Lev Stipakov <lstipakov@...277...>
Date: Tue, 16 Feb 2016 11:53:01 +0200
Message-ID: <56C2F17D.5020903@...277...>
References: <56C2E0DD.3050707@...515...>
Mime-Version: 1.0
In-Reply-To: <56C2E0DD.3050707@...515...>
Subject: Re: [Openvpn-devel] --block-outside-dns speed
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Hi James,

> Has anyone seen issues with --block-outside-dns speed?  Because this
> approach drops certain DNS packets, I'm wondering if apps will
> experience lag time while waiting for dropped DNS requests to time out.

Yes, I have experienced issues with that patch.

On only machine I was able to reproduce DNS leak, this patch causes 
_all_ DNS requests to take 10 seconds to execute. According to 
Wireshark, Windows sends DNS requests to all adapters, got fast response 
from "right one", but nevertheless waits for about 10 seconds before 
giving up.


-Lev



