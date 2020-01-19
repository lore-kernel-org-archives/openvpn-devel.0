Date: Sun, 19 Jan 2020 18:21:27 +0100 (CET)
Message-Id: <202001191721.00JHLRv3090211@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20191110231018.30621-1-steffan@...1856...>
References: <20191110231018.30621-1-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH applied] Re: mbedtls: add RFC 5705 keying
 material exporter support
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Steffan Karger <steffan@...1856...>
Cc: openvpn-devel@lists.sourceforge.net

Your patch has been applied to the master branch.

I ran test builds on FreeBSD/mbedtls 2.16.3 (t_client test) and 
Gentoo/mbedtls 2.12.0 (t_server test), which pass.  No tests were 
done with the crypto material exporter - have no test rig for it
(but I wouldn't mind some easy to set up scripts to *do* test it...)

Of course my mbedtls versions are all too old to provide the needed
functionality in the first place, so I suspect "#if HAVE_EKM" takes
care of me not seeing any effects... but see my other mail on what
happens if I upgrade the Gentoo to 2.19.1... *bang* :-)


commit ab27c9f77b7cd10d530b3c6380465322969a9d21
Author: Steffan Karger
Date:   Mon Nov 11 00:10:18 2019 +0100

     mbedtls: add RFC 5705 keying material exporter support

     Signed-off-by: Steffan Karger <steffan@...1856...>
     Acked-by: Arne Schwabe <arne@...1227...>
     Message-Id: <20191110231018.30621-1-steffan@...1856...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg19111.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


