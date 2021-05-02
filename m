References: <20210501130640.9330-1-a@...2181...>
 <20210501130640.9330-2-a@...2181...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <dcf52106-3084-f220-c081-278ac9ccd593@...1227...>
Date: Sun, 2 May 2021 14:14:09 +0200
MIME-Version: 1.0
In-Reply-To: <20210501130640.9330-2-a@...2181...>
Content-Language: en-GB
Subject: Re: [Openvpn-devel] [PATCH 1/3] windows: use appropriate and
 portable format specifier for 64bit pointer
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
To: Antonio Quartulli <a@...2181...>, openvpn-devel@lists.sourceforge.net
Cc: Antonio Quartulli <antonio@...515...>

Am 01.05.21 um 15:06 schrieb Antonio Quartulli:
> From: Antonio Quartulli <antonio@...515...>
> 
> To print a 64bit poiner, fprintf() must be provided with the appropriate
> format specifier.
> 
> The most portable in this case is PRIx64, which is redefined accordingly
> on each platform. It comes from inttypes.h and it's the recommended way
> to print a 64bit long hex value.

Yes. I checked at there seem to be no portable integer same size as
pointer, so the ifdef with a 64 bit int is okay here.

Acked-By: Arne Schwabe <arne@...1227...>

