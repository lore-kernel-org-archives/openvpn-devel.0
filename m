Message-ID: <52C6E3FE.2080801@...1227...>
Date: Fri, 03 Jan 2014 17:23:26 +0100
From: Arne Schwabe <arne@...1227...>
MIME-Version: 1.0
References: <1388613479-22377-1-git-send-email-gert@...1296...>
	<1388613479-22377-2-git-send-email-gert@...1296...>
In-Reply-To: <1388613479-22377-2-git-send-email-gert@...1296...>
Subject: Re: [Openvpn-devel] [PATCH 2/2] Provide LZ4 sources in src/compat/
 and use if no system lz4 library found.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net

Am 01.01.14 22:57, schrieb Gert Doering:
> Bundle lz4.c and lz4.h from http://code.google.com/p/lz4/ (r109) as
> src/compat/compat-lz4.[ch], and use that (via #define NEED_COMPAT_LZ4)
> if autoconf cannot find lz4.h or -llz4 in the system.

ACK from me. Also:

<cron2> plaisthos: one of the problems with lz4 is that no distribution
is shipping a liblz4 yet, and that the original tarball also doesn't
even try to build a library, it just builds an executable - so
"installing a library" is more painful than for snappy or lzo



