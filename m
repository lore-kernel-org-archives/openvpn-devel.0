Message-ID: <556CC8A1.5010807@...1227...>
Date: Mon, 01 Jun 2015 23:03:29 +0200
From: Arne Schwabe <arne@...1227...>
MIME-Version: 1.0
References: <1433080749-6892-1-git-send-email-gert@...1296...>
In-Reply-To: <1433080749-6892-1-git-send-email-gert@...1296...>
Subject: Re: [Openvpn-devel] [PATCH] Move res_init() call to inner
 openvpn_getaddrinfo() loop
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net

Am 31.05.15 um 15:59 schrieb Gert Doering:
> A non-working nameserver in /etc/resolv.conf could lead to endless
> loops inside openvpn_getaddrinfo(), because many systems will only
> pick up changes to resolv.conf if res_init() is called again.
>
> To reproduce, run openvpn with --resolv-retry infinite (2.3) or
> --resolv-retry "a high number" (master) on a BSD system.  Linux
> glibc seems to stat() resolv.conf on calls to getaddrinfo() and
> pick up changes automatically.
>
And Android makes even weirder stuff. But if we want to reread the
resolv.conf on every call this the right way, so ACK.

Arne


