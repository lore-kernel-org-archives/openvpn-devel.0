MIME-Version: 1.0
References: <1600994969-7623-1-git-send-email-selva.nair@...277...>
 <1601085886-10351-1-git-send-email-selva.nair@...277...>
In-Reply-To: <1601085886-10351-1-git-send-email-selva.nair@...277...>
From: Lev Stipakov <lstipakov@...277...>
Date: Mon, 28 Sep 2020 11:57:36 +0300
Message-ID: <CAGyAFMU5GpQxkMOQohaGDaOVDRW8ER7GXG8T49k5i752xG=z=g@...278...>
Subject: Re: [Openvpn-devel] [PATCH v2] Set DNS Domain using iservice
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
To: Selva <selva.nair@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi,

> +    if (msg->domains[0]) {

Curly bracket could go to the next line, but @cron2 could fix that.

do_dns_domain_service() duplicates code from do_dns_service(), but
putting everything into one function will make it harder to read.

Compiled and tested on MSVC/Win10 - with that and ADAPTER_DOMAIN_SUFFIX patch
I connected to corporate VPN with Wintun and was able to browse intra websites
such as https://jenkins-dev. Also checked that "Connection-specific
DNS Suffix" is visible in "ipconfig /all".

I didn't run client on Windows 7, but checked that "wmic nicconf" works there.

Acked-by: Lev Stipakov <lstipakov@...277...>

