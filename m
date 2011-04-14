From: =?utf-8?q?Samuli=20Sepp=C3=A4nen?= <samuli@...515...>
Date: Thu, 14 Apr 2011 17:40:33 +0300
Message-Id: <1302792033-9032-1-git-send-email-samuli@...515...>
Subject: [Openvpn-devel] [PATCH] Fix a bug in devcon source code handling
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

The win/config_ti.py build script assumes to find ../tapinstall/7600/sources.in
which does not exists in devcon.exe source code directory. This makes
config_ti.py look for ../tapinstall/7600/sources instead.
---
 win/config_ti.py |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/win/config_ti.py b/win/config_ti.py
index b495bb1..8742caa 100644
--- a/win/config_ti.py
+++ b/win/config_ti.py
@@ -7,7 +7,7 @@ def main(config):
     shutil.rmtree(dest, ignore_errors=True)
     shutil.copytree(src, dest)
     preprocess(config,
-               in_fn=os.path.join(dest, 'sources.in'),
+               in_fn=os.path.join(src, 'sources'),
                out_fn=os.path.join(dest, 'sources'),
                if_prefix='!',
                head_comment='# %s\n\n' % autogen)
-- 
1.6.3.3


