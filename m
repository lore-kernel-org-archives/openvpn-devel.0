MIME-Version: 1.0
In-Reply-To: <20161201123306.GK78624@...1296...>
References: <1480545687-19365-1-git-send-email-davids@...515...>
	<20161201080132.GC78624@...1296...>
	<9796b12f-21c2-d9ed-90e3-51de843b2eb8@...2080...>
	<20161201123306.GK78624@...1296...>
From: Steffan Karger <steffan@...1856...>
Date: Thu, 1 Dec 2016 13:35:49 +0100
Message-ID: <CAA1AbxLbWojTD_gzqHGEkpYnSG3GSKakV0QEVptq+YURLqK4Ww@...278...>
Subject: Re: [Openvpn-devel] [PATCH] push: Provide a warning if
 --ifconfig-push have argument mismatch with --topology
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: Gert Doering <gert@...1296...>
Cc: David Sommerseth <davids@...515...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

On 1 December 2016 at 13:33, Gert Doering <gert@...1296...> wrote:
>    ((uchar *)&c->c2.push_ifconfig_remote_netmask)[0]

Looks like dereferencing a type-punned pointer to me ;)

-Steffan

