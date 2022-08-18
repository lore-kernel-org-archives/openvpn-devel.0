Date: Thu, 18 Aug 2022 21:26:20 +0200 (CEST)
Message-Id: <202208181926.27IJQKeU072582@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20220813204224.22576-1-a@...2181...>
References: <20220813204224.22576-1-a@...2181...>
Subject: [Openvpn-devel] [PATCH applied] Re: dco-win: introduce low-level
 code for handling ovpn-dco-win in Windows
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
To: Antonio Quartulli <a@...2181...>
Cc: openvpn-devel@lists.sourceforge.net

I've stared at the code for a while...  I'm not really happy with the
jumping back and forth between dco.c and tun.c (who is supposed to
understand that code flow in 6 weeks from now?).  That said, the
"non windows" changes in this patch are harmless enough, and the
"windows bits" do look safe enough (wrt memory issues etc).

I notice a distinct lack of comments on "what do all these functions
do?" - neither dco_win.h nor dco_win.c have function descriptions
(what does it do, what goes in, what comes out).  Like, dco_connect_wait()
or dco_create_socket()... this really should be improved.

Some constructs nest too deeply...

+        DWORD err = GetLastError();
+        if (err != ERROR_IO_PENDING)
+        {
+            msg(M_ERR, "DeviceIoControl(OVPN_IOCTL_NEW_PEER) failed");
+        }
+        else
+        {
+            if (dco_connect_wait(tt.hand, &ov, timeout, signal_received) < 0)
+            {
+                close_tun_handle(&tt);
+            }
+        }

.. M_ERR does not return, so why have an else { } level here?

+    OVPN_CRYPTO_DATA crypto_data;
+    ZeroMemory(&crypto_data, sizeof(crypto_data));

.. we do have CLEAR(crypto_data) for this purpose.  Do not invent new
code for each platform to zeroize memory.

+    ASSERT(crypto_data.CipherAlg > 0);

this looks a bit out of place, 10+ lines after the CipherAlg assignment...


Since I currently can't build MinGW, I've pushed this to Github for
building, and the GHA-mingw/mingw64 builds succeed (and so does the
rest).

I've also subjected this to the linux DCO test rig "to be sure" - though
*these* changes really should not upset other platforms.  Seems they
do not :-)

My local git hook complains about formatting of ovpn_dco_win.h - we do
exclude that now in dev-tools/special-files.lst, but that is not effective
on the initial commit.  Not sure, though, why we want to maintain something
only maintained by us in a different coding style... I can see this for 
dco-linux (where "the Linux people" want a different style) - but here?

Anyway.

Your patch has been applied to the master branch.

commit 8b80cbc3846a56581e373a664db20d227a90120a
Author: Antonio Quartulli
Date:   Sat Aug 13 22:42:18 2022 +0200

     dco-win: introduce low-level code for handling ovpn-dco-win in Windows

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Signed-off-by: Lev Stipakov <lev@...515...>
     Signed-off-by: Antonio Quartulli <a@...2181...>
     Acked-by: Lev Stipakov <lstipakov@...277...>
     Message-Id: <20220813204224.22576-1-a@...2181...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg24919.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


