MIME-Version: 1.0
References: <A975CEB0-C46B-4A03-A862-C1B321A26D07@...2293...>
 <20200924065519.1839-1-simon@...2293...>
In-Reply-To: <20200924065519.1839-1-simon@...2293...>
From: Lev Stipakov <lstipakov@...277...>
Date: Thu, 24 Sep 2020 12:31:03 +0300
Message-ID: <CAGyAFMUdGqGghmaKPaau+QZ=78i9goepGD2RBkbbVRBZTAh_0Q@...278...>
Subject: Re: [Openvpn-devel] [PATCH] openvpnmsica: Simplify find_adapters()
 to void return
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
To: Simon Rozman <simon@...2293...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi,

> to return result code. It still logs any error thou.

though

> -static UINT
> +static void

Indeed, the return value of find_adapters() has never been used.

Compiled with MSVC.

Acked-by: Lev Stipakov <lstipakov@...277...>

