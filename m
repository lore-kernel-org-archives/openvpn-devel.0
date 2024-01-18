Date: Thu, 18 Jan 2024 18:49:18 +0100 (CET)
Message-Id: <202401181749.40IHnI8x009756@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20240118151242.12169-1-gert@...1296...>
References: <20240118151242.12169-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: NTLM: when NTLMv1 is requested,
 try NTLMv2 instead
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
To: Frank Lichtenheld <frank@...2641...>
Cc: openvpn-devel@lists.sourceforge.net

This is "master only", as it is based on the NTLMv1 removal.

Haven't tested it beyond "GHA is happy" and "the code change looks
reasonable and matches what the commit message says".

Your patch has been applied to the master branch.

commit b541a86948d7e9866b33e876fcf070fad00b3dce
Author: Frank Lichtenheld
Date:   Thu Jan 18 16:12:42 2024 +0100

     NTLM: when NTLMv1 is requested, try NTLMv2 instead

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Arne Schwabe <arne-openvpn@...1227...>
     Message-Id: <20240118151242.12169-1-gert@...1296...>
     URL: https://www.mail-archive.com/search?l=mid&q=20240118151242.12169-1-gert@...1296...
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


