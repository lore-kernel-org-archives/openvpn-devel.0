Message-ID: <20101112163503.27538.qmail@...1287...>
Date: Fri, 12 Nov 2010 17:35:03 +0100
From: Peter Stuge <peter@...1287...>
References: <4CDD63D3.2000902@...515...>
MIME-Version: 1.0
In-Reply-To: <4CDD63D3.2000902@...515...>
Subject: Re: [Openvpn-devel] [PATCH] Added check for
	variable	CONFIGURE_DEFINES into options.c
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
> >From 327d6c66fff6962a96f86110dc91b1dad07ca224 Mon Sep 17 00:00:00 2001
> From: =?utf-8?q?Samuli=20Sepp=C3=A4nen?= <samuli@...515...>
> Date: Fri, 12 Nov 2010 17:30:07 +0200
> Subject: [PATCH] Added check for variable CONFIGURE_DEFINES into options.c
> 
> The file containing CONFIGURE_DEFINES variable, configure.h, is not present if
> openvpn is built using the Python + Visual C -based buildsystem. This causes the
> build to fail. This patch adds a check to see if variable exists before trying
> to use it.

Acked-by: Peter Stuge <peter@...1287...>

