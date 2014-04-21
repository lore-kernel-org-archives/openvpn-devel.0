Message-ID: <5354FBFF.2050205@...1227...>
Date: Mon, 21 Apr 2014 13:07:43 +0200
From: Arne Schwabe <arne@...1227...>
MIME-Version: 1.0
References: <1398019261-30180-1-git-send-email-gert@...1296...>
In-Reply-To: <1398019261-30180-1-git-send-email-gert@...1296...>
Subject: Re: [Openvpn-devel] [PATCH] Minor t_client.sh cleanups
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net

On 20.04.2014 20:41, Gert Doering wrote:
> - remove built tests/t_client.sh script on "make clean"
> - ignore Linux iproute2 "ssthresh <n>" output that sometimes shows up
>    in "ip -6 route show" and breaks before/after comparison
>
ACK.

Arne

