Message-ID: <20101112163620.27677.qmail@...1287...>
Date: Fri, 12 Nov 2010 17:36:20 +0100
From: Peter Stuge <peter@...1287...>
References: <4CDD641F.30408@...515...>
MIME-Version: 1.0
In-Reply-To: <4CDD641F.30408@...515...>
Subject: Re: [Openvpn-devel] [PATCH] Removed hardcoded signtool
	dependency	from win/build_all.py
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: openvpn-devel@lists.sourceforge.net

Samuli Seppänen wrote:
> From 57b983dc2a1f4a31d3b7c0e2f6de7f778d234b2e Mon Sep 17 00:00:00 2001
> From: =?utf-8?q?Samuli=20Sepp=C3=A4nen?= <samuli@...515...>
> Date: Fri, 12 Nov 2010 17:32:19 +0200
> Subject: [PATCH] Removed hardcoded signtool dependency from win/build_all.py
> 
> Modified win/build_all.py so that build does not fail even if the optional
> signtool python class is not available.

What is it needed for? Is it really *always* optional? Maybe some
setting or parameter to the script so that build can fail e.g. at
openvpn.net if building, where signing should always be done?


//Peter

