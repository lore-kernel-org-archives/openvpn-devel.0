References: <20160916190242.44897-1-gert@...1296...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <55dfbe2c-964d-c390-cea6-edb265ae2bd2@...1227...>
Date: Sat, 17 Sep 2016 13:21:19 +0300
MIME-Version: 1.0
In-Reply-To: <20160916190242.44897-1-gert@...1296...>
Subject: Re: [Openvpn-devel] [PATCH] Fix IP_PKTINFO related compilation
 failure on NetBSD 7.0
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
To: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net

Am 16.09.16 um 22:02 schrieb Gert Doering:
> NetBSD has introduced IP_PKTINFO and struct in_pktinfo, but does not
> have the "ipi_spec_dst" structure element, causing compilation errors.
> 
> Introduce a check for that (AC_CHECK_MEMBER) in configure.ac, and
> change all "#ifdef HAVE_IN_PKTINFO" to also check "HAVE_IPI_SPEC_DST".
> 
> Patch inspired by NetBSD pkgsrc patch set.
>
ACK frome me.

Arne


