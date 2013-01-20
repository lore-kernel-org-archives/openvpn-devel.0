Message-ID: <50FBEC82.2050503@...68...>
Date: Sun, 20 Jan 2013 14:09:22 +0100
From: Matthias Andree <matthias.andree@...68...>
MIME-Version: 1.0
References: <1358411009-2350-1-git-send-email-steffan.karger@...1435...>
	<1358411009-2350-4-git-send-email-steffan.karger@...1435...>
In-Reply-To: <1358411009-2350-4-git-send-email-steffan.karger@...1435...>
Subject: Re: [Openvpn-devel] [PATCH 3/3] PolarSSL-1.2 support
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Is there any important system where requiring PolarSSL >= 1.2.3 is not
an option, besides "admin is too lazy or can't convince his manager that
he needs to upgrade"?

This #ifdef stuff makes the whole story a bit inconcise.  It might be
suitable for 2.3.X, but not to base 2.4 or newer releases on.

Barring that, I'd suggest to add stuff to fail the build with older
PolarSSL versions and kill the PolarSSL < 1.2.3 code.  It would seem
from the changelogs that PolarSSL 1.2.N (with N highest available) does
away with certain design issues in earlier versions, so there is a
compelling reason to upgrade.

(I was irritated anyways that the newest released OpenVPN version would
not work with the newest stable PolarSSL version, and am foregoing the
PolarSSL option on the FreeBSD port - we do have an up-to-date PolarSSL,
so it wouldn't build.)

