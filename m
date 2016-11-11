References: <1478609729-25222-5-git-send-email-samuli@...515...>
	<1478613043-27033-1-git-send-email-samuli@...515...>
From: debbie10t <debbie10t@...277...>
Message-ID: <68076cb3-b018-28c7-0776-85f8a7212e38@...277...>
Date: Fri, 11 Nov 2016 00:25:49 +0000
MIME-Version: 1.0
In-Reply-To: <1478613043-27033-1-git-send-email-samuli@...515...>
Subject: Re: [Openvpn-devel] [PATCHv2 4/4] Allow passing extra arguments to
 fping/fping6 in t_client.rc
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net



On 08/11/16 13:50, samuli@...515... wrote:
> From: Samuli Seppänen <samuli@...515...>

> +	$cmd -b $bytes -C 20 -p 250 -q $FPING_EXTRA_ARGS $targetlist >>$LOGDIR/$SUF:fping.out 2>&1

This allows $FPING_EXTRA_ARGS to take precedence over previous arguments

eg: $FPING_EXTRA_ARGS = "-C 1000 -p 1000 -i 1000"


This does not:
$cmd $FPING_EXTRA_ARGS -b $bytes -C 20 -p 250 -q $targetlist 
$LOGDIR/$SUF:fping.out 2>&1


Sorry I have not diff'd this.

Regards

