MIME-Version: 1.0
Sender: fabian@...1547...
In-Reply-To: <CAOazyz0Tv0_9Fqr_b8smQ0z00qk5fQ2AUaHz_75K-gQoEANDOg@...278...>
References: <1335441085-18186-1-git-send-email-davids@...1347...>
	<CAOazyz3-f2YkXE_vV2Oum+p4exQTUis=Q9RTOrvZ7WC0WEZymg@...278...>
	<20120426172410.GT1359@...1296...>
	<4F9986A2.10900@...1114...>
	<CAOazyz0Tv0_9Fqr_b8smQ0z00qk5fQ2AUaHz_75K-gQoEANDOg@...278...>
From: Fabian Knittel <fabian.knittel@...1547...>
Date: Thu, 26 Apr 2012 19:56:31 +0200
Message-ID: <CAP+U6t+=xTjrD3SC+aE=M6SAGY59rU33UXgL+XHhwhUGnNPyYA@...278...>
Subject: Re: [Openvpn-devel] [PATCH] Presume that Linux is always IPv6
 capable at build time
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: Alon Bar-Lev <alon.barlev@...277...>
Cc: openvpn-devel@lists.sourceforge.net

Hi Alon,

2012/4/26 Alon Bar-Lev <alon.barlev@...277...>:
> At embedded system and several distros like Gentoo, the ipv6 should be
> made enable/disabled, just like any other project.
> It is the same #ifdef as we already have these in code.
> Even in 2012 kernels can be compiled without ipv6.

If embedded systems really need to save space, maybe we should make
IPv4 optional instead? :)

Cheers
Fabian

