Date: Fri, 17 Jul 2020 10:02:49 +0200 (CEST)
Message-Id: <202007170802.06H82n5d006538@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20200716225338.611-3-davids@...515...>
References: <20200716225338.611-3-davids@...515...>
Subject: [Openvpn-devel] [PATCH applied] Re: doc/man: Replace old man page
 with generated man page
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
To: David Sommerseth <davids@...515...>
Cc: openvpn-devel@lists.sourceforge.net

Acked-by: Gert Doering <gert@...1296...>

I have not tested the actual docutils / openvpn.8 generation (Samuli will 
complain loudly if tarball making doesn't work anymore, so that *will* 
see testing).  Generally it looks sane.

This condition looks a bit fishy, though...

 +AM_CONDITIONAL([HAVE_PYDOCUTILS], [test "${RST2MAN}" -a "${RST2HTML}"])

not sure what that will do in a POSIX shell.

Maybe this shouldn't be conditional either

 +if HAVE_PYDOCUTILS
  dist_noinst_DATA += openvpn.8

because it will lead to "tarballs randomly contain openvpn.8 or not, 
depending on whether docutils are around" - "make dist" should behave
consistently, and if there are no docutils, I think it should fail, not
silently leave out files.


URL pointed to SF again due to patch size.

Your patch has been applied to the master branch.

commit 51f2e4b0a4e09382dbc1b10b6a8b08febc8d293f
Author: David Sommerseth
Date:   Fri Jul 17 00:53:32 2020 +0200

     doc/man: Replace old man page with generated man page

     Signed-off-by: David Sommerseth <davids@...515...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20200716225338.611-3-davids@...515...>
     URL: https://sourceforge.net/p/openvpn/mailman/message/37063373/
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


