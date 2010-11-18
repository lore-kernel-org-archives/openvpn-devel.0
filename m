Message-ID: <20101118164431.22193.qmail@...1287...>
Date: Thu, 18 Nov 2010 17:44:31 +0100
From: Peter Stuge <peter@...1287...>
References: <4CDD704B.7080505@...1114...>
	<20101112165541.29963.qmail@...1287...>
	<4CDD7309.3030808@...1114...> <4CDD7559.5000604@...515...>
	<4CDD77B9.8050606@...1114...> <4CDD7D32.2050401@...515...>
	<20101112175153.4861.qmail@...1287...> <4CE2A7F9.2020402@...515...>
	<20101116155849.23656.qmail@...1287...>
	<4CE54F2C.9040405@...515...>
MIME-Version: 1.0
In-Reply-To: <4CE54F2C.9040405@...515...>
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
> From 804aa21a12f74de4142305ed415b33a43e5fc276 Mon Sep 17 00:00:00 2001
> From: =?utf-8?q?Samuli=20Sepp=C3=A4nen?= <samuli@...515...>
> Date: Thu, 18 Nov 2010 18:00:54 +0200
> Subject: [PATCH] Added command-line option parser and an unsigned build option to build_all.py
> 
> Modified win/build_all.py so that it parses command-line options using getopt.
> Added option "-u / --unsigned" which allows forcing unsigned builds and a "-h /
> --help" option. By default a signed build is generated, provided that the Python
> SignTool module is installed. If not, the build is interrupted.
> ---
>  win/build_all.py |   45 +++++++++++++++++++++++++++++++++++++++++++--
>  1 files changed, 43 insertions(+), 2 deletions(-)

Acked-by: Peter Stuge <peter@...1287...>

