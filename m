From: Steffan Karger <steffan@...1856...>
Date: Fri, 16 Oct 2015 00:43:13 +0200
Message-Id: <1444948995-18720-1-git-send-email-steffan@...1856...>
In-Reply-To: <1444383559-15788-1-git-send-email-janjust@...1147...>
References: <1444383559-15788-1-git-send-email-janjust@...1147...>
Subject: [Openvpn-devel] [PATCH] Add --verify-client-cert optional support
	for polarssl builds
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
To: openvpn-devel@lists.sourceforge.net

Hi,

ACK to the --verify-client-cert patch from JJK.

Also, as promised earlier, patches to add --verify-client-cert optional
support for Polarssl build.  While adding this, I discovered that at some
point (probably with the upgrade to polar 1.3), --client-cert-not-required
was broken for PolarSSL builds.  So two patches: one to fix the regression,
and one to add --verify-client-support optional.

-Steffan


