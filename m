Date: Wed, 10 Feb 2016 00:12:07 +0100
From: Samuel Thibault <samuel.thibault@...1817...>
Message-ID: <20160209231207.GC2673@...2120...>
References: <20160208213929.GA20623@...2120...>
	<20160209092821.GH24952@...1296...>
MIME-Version: 1.0
In-Reply-To: <20160209092821.GH24952@...1296...>
Subject: Re: [Openvpn-devel] route / route-ipv6 can not be used in ccd
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

Hello,

Gert Doering, on Tue 09 Feb 2016 10:28:21 +0100, wrote:
> Alternatively, using
> --learn-address might actually be much easier than --client-connect, as
> it will already tell you which networks are "new for this client" - from
> the description, I'm fairly sure it handles iroute/iroute-ipv6 as well,
> but for whatever reason I've never actually used this combination...

That works indeed:

#!/bin/bash

add_del="$1"
route="$2"
cname="$3"

case "$route" in 
	*:*) six=-6 ;;
        *)   six="" ;;
esac

if [ -n "$dev" ]
then
  device="dev $dev"
else
  device=""
fi

ip $six route "$add_del" "$route" $device

Samuel

