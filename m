MIME-Version: 1.0
Date: Thu, 25 Oct 2012 18:24:20 +0200
Message-ID: <CA+=Fv5QP9FY3AZoxfV62kG7rP0mU3Ad2UVtzt_LGTYONUJW9PA@...278...>
From: Magnus Lindholm <linmag7@...277...>
Subject: [Openvpn-devel] openvpn on solaris
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

Hi all,

with openvpn-2.2.2 I get "unable to redirect default gateway -- Cannot
read current default gateway from system" on my solaris sparc box.
Maybe I missed something but I solved this by putting together some
code into a patch to route.c that lets openvpn read the default
gateway correctly on solaris boxes (.SunOS 5.11 snv_151a sun4u) Let me
know if anyone is interested in incorporating this functionality into
openvpn

Regards

Magnus

