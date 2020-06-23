Message-ID: <1592953354.2103.3.camel@...2316...>
From: James Bottomley <James.Bottomley@...2316...>
Date: Tue, 23 Jun 2020 16:02:34 -0700
In-Reply-To: <CAFHpkQEz+eE76vN3s3bOiVWRCOdD6opNkdRMibfPMAh6GfeUUA@...278...>
References: <202006230628.05N6Sa3g001325@...2054...>
 <20200623072123.GA2034@...1296...>
 <1592917531.4768.4.camel@...2316...>
 <CAFHpkQF5tz91P_UJxMuNCRDUYodw8QPV8=h8mmkSTHOUH5AdfA@...278...>
 <CAFHpkQH-yGFBJ=-Eaz5XCSaUcD-=S00y=MvPs6Vmr5nE_PcTRg@...278...>
 <1592936237.4768.43.camel@...2316...>
 <CAFHpkQGQgQm2cEA1kw1JpRkf4Ldu4kT=y-YXF-6cLTXbEx_zDQ@...278...>
 <20200623184733.GK1431@...1296...>
 <20200623192627.GA11911@...1296...>
 <1592940762.4768.52.camel@...2316...>
 <20200623193702.GL1431@...1296...>
 <CAFHpkQEz+eE76vN3s3bOiVWRCOdD6opNkdRMibfPMAh6GfeUUA@...278...>
Mime-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH applied] Re: Add unit tests for engine
 keys
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
To: =?UTF-8?Q?=D0=98=D0=BB=D1=8C=D1=8F_=D0=A8=D0=B8=D0=BF=D0=B8=D1=86?= =?UTF-8?Q?=D0=B8=D0=BD?= <chipitsine@...277...>, Gert Doering <gert@...1296...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

On Wed, 2020-06-24 at 01:18 +0500, Илья Шипицин wrote:
[...]
> I've added output of log.txt, if you are going to modify "grep"
> magic, can you adopt something like that, please ?

OK, I folded this into the --enable-small correction

James

---8>8>8><8<8<8---
From: James Bottomley <James.Bottomley@...2316...>
Subject: [PATCH] engine-key tests: make check_engine_keys.sh work with
 --enable-small

--enable-small eliminates one of the openssl errors the test is
looking for, so alter the grep also to account for the message in this
version.  Additionally output log.txt on failure so any test platform
gives an easy clue about what went wrong.

Signed-off-by: James Bottomley <James.Bottomley@...2316...>
---
 tests/unit_tests/engine-key/check_engine_keys.sh | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/tests/unit_tests/engine-key/check_engine_keys.sh b/tests/unit_tests/engine-key/check_engine_keys.sh
index e0c9d7b0..7e9a0e80 100755
--- a/tests/unit_tests/engine-key/check_engine_keys.sh
+++ b/tests/unit_tests/engine-key/check_engine_keys.sh
@@ -12,6 +12,12 @@ pwdfile="${builddir}/passwd"
 sed 's/PRIVATE KEY/TEST ENGINE KEY/' < ${top_srcdir}/sample/sample-keys/client.key > ${key}
 echo "$password" > $pwdfile
 
+# our version of grep to output log.txt on failure in case it's an openssl
+# error mismatch and the grep expression needs updating
+loggrep() {
+    egrep -q "$1" log.txt || { echo '---- begin log.txt ----'; cat log.txt; echo '--- end log.txt ---'; return 1; }
+}
+
 # note here we've induced a mismatch in the client key and the server
 # cert which openvpn should report and die.  Check that it does.  Note
 # also that this mismatch depends on openssl not openvpn, so it is
@@ -21,10 +27,10 @@ ${top_builddir}/src/openvpn/openvpn --cd ${top_srcdir}/sample --config sample-co
 # first off check we died because of a key mismatch.  If this doesn't
 # pass, suspect openssl of returning different messages and update the
 # test accordingly
-grep -q 'X509_check_private_key:key values mismatch' log.txt || { echo "Key mismatch not detected"; exit 1; }
+loggrep '(X509_check_private_key:key values mismatch|func\(128\):reason\(116\))' log.txt || { echo "Key mismatch not detected"; exit 1; }
 
 # now look for the engine prints (these are under our control)
-grep -q 'ENGINE: engine_init called' log.txt || { echo "Engine initialization not detected"; exit 1; }
-grep -q 'ENGINE: engine_load_key called' log.txt || { echo "Key was not loaded from engine"; exit 1; }
-grep -q "ENGINE: engine_load_key got password ${password}" log.txt || { echo "Key password was not retrieved by the engine"; exit 1; }
+loggrep 'ENGINE: engine_init called' || { echo "Engine initialization not detected"; exit 1; }
+loggrep 'ENGINE: engine_load_key called' || { echo "Key was not loaded from engine"; exit 1; }
+loggrep "ENGINE: engine_load_key got password ${password}" || { echo "Key password was not retrieved by the engine"; exit 1; }
 exit 0
-- 
2.26.2


