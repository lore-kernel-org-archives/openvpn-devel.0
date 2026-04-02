From: Alexey Slokva <Alesha72003@...1780...>
Date: Fri,  3 Apr 2026 01:09:48 +0300
Message-ID: <20260402221251.16811-1-Alesha72003@...1780...>
MIME-Version: 1.0
Subject: [Openvpn-devel] (no subject)
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
To: openvpn-devel@lists.sourceforge.net


Hello,

this patch fixes a build failure in the DCO netcfg path caused by
ignoring the return value of ParseFromString() when parsing key_config.

Recent protobuf versions mark ParseFromString() as [[nodiscard]], and
with stricter warning settings this now breaks the build on Arch Linux.

The patch checks the return value explicitly and throws NetCfgException
if parsing fails.

Regards,
Alexey Slokva

