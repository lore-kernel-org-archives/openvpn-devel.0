References: <20191020150039.21516-1-gert@...1296...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <905ae85d-8b06-0cb2-40f6-e6d6b523dfb2@...2181...>
Date: Thu, 24 Oct 2019 21:47:20 +0200
MIME-Version: 1.0
In-Reply-To: <20191020150039.21516-1-gert@...1296...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH] Force combinationation of --socks-proxy
 and --proto UDP to use IPv4.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

Hi,

On 20/10/2019 17:00, Gert Doering wrote:
> Our current socks.c code does not handle IPv6 + UDP mode (socket
> negotiated with server is IPv4-only, addresses passed in the
> packets are IPv4-only).  If this combination is specified, print
> an explanatory message and force IPv4-only.
> 
> While at it, extend socks.c code to print address+port of auxiliary
> UDP connection to SOCKS server (helps debugging).
> 
> Trac: #1221
> 
> Signed-off-by: Gert Doering <gert@...1296...>

I performed some basic test to ensure the rest is not being broken by
this change and it all looks good.

The patch does just what it says and it makes sense. I cannot test with
an actual socks server, but Gert said he did so and I trust his test rig.

I ensured that the "Force IPv4" was being performed when needed and it
did so.

Acked-by: Antonio Quartulli <antonio@...515...>


-- 
Antonio Quartulli

