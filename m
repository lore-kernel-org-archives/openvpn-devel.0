Message-ID: <52C6E39C.7020809@...1227...>
Date: Fri, 03 Jan 2014 17:21:48 +0100
From: Arne Schwabe <arne@...1227...>
MIME-Version: 1.0
References: <1388613479-22377-1-git-send-email-gert@...1296...>
In-Reply-To: <1388613479-22377-1-git-send-email-gert@...1296...>
Subject: Re: [Openvpn-devel] [PATCH 1/2] Implement LZ4 compression.
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
> Implement LZ4 compression, similar to the existing snappy / push-peer-info
> model: a LZ4 capable client will send IV_LZ4=3D1 to the server, and the
> algorithm is selected by pushing "compress lz4" back.
>
> LZ4 does not compress as well as LZO or Snappy, but needs far less CPU
> and is much faster, thus better suited for mobile devices.  See
> https://code.google.com/p/lz4/ for more details.
>
> LZ4 include and library path can be specified by specifying LZ4_LIBS=3D...
> and LZ4_CFLAGS=3D... on the configure command line.
ACK. To the patch. I have only lightly tested it but it work in my test
setup. Before commiting you should fix the LX4 typo.

Arne




