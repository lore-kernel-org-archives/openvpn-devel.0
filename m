Date: Sat, 20 Jan 2018 12:26:56 +0100 (CET)
Message-Id: <201801201126.w0KBQurZ025062@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20180120094228.13285-1-steffan@...1856...>
References: <20180120094228.13285-1-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH applied] Re: Fix --tls-version-min and
 --tls-version-max for OpenSSL 1.1+
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

ACK (compared the patches, only difference is the SSL_OP_NO_COMPRESSION
#ifdef).  So I take the ACK from Selva, on the base patch, and add my
ACK for "the 2.4 modifications make sense".  Haven't tested on an 0.9.8 
system yet.

for patchwork:

Acked-by: Gert Doering <gert@...1296...>

Your patch has been applied to the release/2.4 branch.

commit a25a278c1ccdbfd9ca06f60f2cc4cf2436269854
Author: Steffan Karger
Date:   Sat Jan 20 10:42:28 2018 +0100

     Fix --tls-version-min and --tls-version-max for OpenSSL 1.1+

     Signed-off-by: Steffan Karger <steffan@...1856...>
     Acked-by: Selva Nair <selva.nair@...277...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20180120094228.13285-1-steffan@...1856...>
     URL: https://www.mail-archive.com/search?l=mid&q=20180120094228.13285-1-steffan@...1856...
     Signed-off-by: Gert Doering <gert@...1296...>
     (cherry picked with 2.4 amendments from commit 0e8a30c0b05c1e2b59a1dea0a6eab5daa1d9d9a1)

--
kind regards,

Gert Doering


