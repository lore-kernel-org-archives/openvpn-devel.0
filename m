Message-ID: <4F3D12B4.1060504@...1549...>
Date: Thu, 16 Feb 2012 15:29:08 +0100
From: Freek Dijkstra <public@...1549...>
MIME-Version: 1.0
References: <CB62AEE8.E86%brabander@...1435...>
In-Reply-To: <CB62AEE8.E86%brabander@...1435...>
Subject: Re: [Openvpn-devel] Cipher problem on Mac OS X
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Frank de Brabander wrote:

> Below I have included a patch that changes the bool return type to an int.
> This will result in 'make check' to pass.

I see that you already committed this.

% cd openvpn
% make distclean
% git pull
% git checkout 6449a149f850e9e1207233f3ca642d9342fbfbaf
% autoreconf -i -v
% ./configure --with-lzo-headers=/opt/local/include \
  --with-lzo-lib=/opt/local/lib
% make
% make check
(wait for it...)
====================
All 2 tests passed
(1 test was not run)
====================

Works like a charm!

Thanks, both of you!

Freek

