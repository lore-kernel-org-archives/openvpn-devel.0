Message-ID: <20101112175153.4861.qmail@...1287...>
Date: Fri, 12 Nov 2010 18:51:53 +0100
From: Peter Stuge <peter@...1287...>
References: <4CDD641F.30408@...515...> <20101112163620.27677.qmail@...1287...>
	<4CDD704B.7080505@...1114...>
	<20101112165541.29963.qmail@...1287...>
	<4CDD7309.3030808@...1114...> <4CDD7559.5000604@...515...>
	<4CDD77B9.8050606@...1114...> <4CDD7D32.2050401@...515...>
MIME-Version: 1.0
In-Reply-To: <4CDD7D32.2050401@...515...>
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
> Peter: settings.in is stored in git.

Ok.


> I agree that there should be no way one could make an unsigned build by
> mistake. I think dazo's suggestion about having a command-line switch
> ("force unsigned build") is a good one. The SIGNTOOL variable could then
> be used to just locate signtool.exe and nothing else. This would make it
> behave the same way as most other variables in "settings.in" and allow
> making signed and unsigned builds using the same configuration file.

Acked-by: Peter Stuge <peter@...1287...>

