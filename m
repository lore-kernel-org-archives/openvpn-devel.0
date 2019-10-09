Message-Id: <201910091211.x99CBNYR022592@...2300...>
From: Casper.Dik@...2528...
In-Reply-To: <20191009120043.22692-1-gert@...1296...> 
References: <20191009120043.22692-1-gert@...1296...> 
Mime-Version: 1.0
Date: Wed, 09 Oct 2019 14:11:23 +0200
Subject: Re: [Openvpn-devel] [PATCH] OpenSolaris/OpenIllumos: use /bin/bash
 if available for test scripts.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net


>t_client.sh relies on "echo -e" and "echo -n" to produce nicely
>looking output, which fails on Solaris /bin/sh - force SHELL=/bin/bash
>on recent-enough Solaris variants that have it.


Where recent is "Solaris 8 or later"

I.e., just under 20 years old. :-)

Can't tell how which version of bash it was shipped with, though...

Casper


