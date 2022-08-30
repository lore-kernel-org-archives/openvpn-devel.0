From: Kristof Provost <kprovost@...2661...>
Date: Tue, 30 Aug 2022 09:16:57 +0200
Message-ID: <51999814-F5D0-4D1C-BF91-7BEB3DAA2BDA@...2661...>
In-Reply-To: <20220829190124.2636045-1-gert@...1296...>
References: <20220829190124.2636045-1-gert@...1296...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH] Adjust Linux+FreeBSD DCO device name
 handling to 'non DCO linux style'
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

On 29 Aug 2022, at 21:01, Gert Doering wrote:
> On Linux, tun devices are created according to the following algorithm
>   --dev tun    -> try tun0, tun1, ... tun255, use first free
>   --dev anything -> create a TUN device named "anything"
> (as long as "anything" is not "null" or "tap[N]")
>
> DCO was following the "other platform convention", where everything
> not having a digit was iterated ("--dev tun-home" -> "tun-home0") -
> which does not work for classic tun/tap devices on the BSDs anyway,
> so is not the best model.
>
> Adjust open_tun_dco_generic() to document expected behaviour and
> do the thing.
>
> Signed-off-by: Gert Doering <gert@...1296...>
Acked-by: Kristof Provost <kprovost@...2661...>


Kristof

