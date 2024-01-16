Date: Tue, 16 Jan 2024 23:06:37 +0100 (CET)
Message-Id: <202401162206.40GM6bG1059857@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20240116214152.27316-1-gert@...1296...>
References: <20240116214152.27316-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: Add test_ssl unit test and test
 export of PEM to file
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
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net

After some long haggling with cmake and autoconf and mingw... finally it
builds & tests everywhere.  Verified on a local mingw+autoconf build and
with GHA.

Your patch has been applied to the master branch.

It can not go to release/2.6 "as is", as it would need the "win_get_tmpdir"
patch to build (and possibly others, it fails almost all builds) - and
that is "refactoring" so only master (so far).  For new test code I think
"master only" is not a huge problem, though.

commit cedbac710c4f6a3c5ecca5487c491f009e2b7775 (master)
Author: Arne Schwabe
Date:   Tue Jan 16 22:41:52 2024 +0100

     Add test_ssl unit test and test export of PEM to file

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20240116214152.27316-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg28028.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


