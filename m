Date: Fri, 19 Sep 2025 15:05:43 +0200 (CEST)
Message-Id: <202509191305.58JD5hVR026109@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20250918135908.14364-1-gert@...1296...>
References: <20250918135908.14364-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: GHA: collect more artifacts for
 mingw builds
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
To: Lev Stipakov <lev@...515...>
Cc: openvpn-devel@lists.sourceforge.net

This is all black magic to me... but it gets the job done, says the downloaded
.zip file from GHA, now with openvpnservmsg.dll :-)

$ unzip -v openvpn-mingw-x86.zip       
Archive:  openvpn-mingw-x86.zip
 Length   Method    Size  Cmpr    Date    Time   CRC-32   Name
--------  ------  ------- ---- ---------- ----- --------  ----
21282176  Defl:N  7645357  64% 09-19-2025 12:41 70c7e105  Debug/openvpn.exe
  345852  Defl:N   138651  60% 09-19-2025 12:41 a2b88add  src/openvpnmsica/Debug/libopenvpnmsica.dll
    4862  Defl:N      896  82% 09-19-2025 12:41 89971b1a  src/openvpnserv/Debug/libopenvpnservmsg.dll
  436001  Defl:N   174058  60% 09-19-2025 12:41 13aba5d8  src/openvpnserv/Debug/openvpnserv.exe
  352604  Defl:N   140351  60% 09-19-2025 12:41 37908229  src/tapctl/Debug/tapctl.exe


Your patch has been applied to the master and release/2.6 branch.

commit 8465972b00bef5230d3ec36baedf56952448443f (master)
commit 8891307a8154b44dc9f41dbbe9292591e79672ef (release/2.6)
Author: Lev Stipakov
Date:   Thu Sep 18 15:59:03 2025 +0200

     GHA: collect more artifacts for mingw builds

     Signed-off-by: Lev Stipakov <lev@...515...>
     Acked-by: Frank Lichtenheld <frank@...2641...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1200
     Message-Id: <20250918135908.14364-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg33058.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


