Message-ID: <20101112172105.617.qmail@...1287...>
Date: Fri, 12 Nov 2010 18:21:05 +0100
From: Peter Stuge <peter@...1287...>
References: <4CDD641F.30408@...515...> <20101112163620.27677.qmail@...1287...>
	<4CDD704B.7080505@...1114...>
	<20101112165541.29963.qmail@...1287...>
	<4CDD7309.3030808@...1114...> <4CDD7559.5000604@...515...>
MIME-Version: 1.0
In-Reply-To: <4CDD7559.5000604@...515...>
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
> What if build_all.py did this:
> 
> - Check if SIGNTOOL is enabled in settings.in:
>   - Yes: fail if can't import "sign" module
>   - No: don't fail if can't import "sign" module

This also sounds good. (Who typically creates settings.in? Is one in git?)


//Peter

