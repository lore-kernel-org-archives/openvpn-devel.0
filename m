Date: Thu, 6 Mar 2025 13:17:31 +0100 (CET)
Message-Id: <202503061217.526CHV0o086588@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20250306101339.12985-1-gert@...1296...>
References: <20250306101339.12985-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: Rename occurences of 'struct
 link_socket' from 'ls' to 'sock'
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
To: Gianmarco De Gregori <gianmarco@...2726...>
Cc: openvpn-devel@lists.sourceforge.net

This is really just straightforward renaming of the "remaining pieces" -
some of these "link_socket" things have been touched by the multisocket
patchset, and others not yet.  I asked for the rest to be sent in a 
separate patch to untangle "straightforward renaming in unrelated code
paths" from "actual multisocket related changes" - and, here we go.

Usually I link to the mail archives on mail-archive.com, but it's refusing
cooperation today - so this is now linking to the sf.net archive for a
change (+our gerrit).  Hopefully the other site will recover...

Your patch has been applied to the master branch.

commit 7e5535289908af23bed244e7f0417358f2f316bc
Author: Gianmarco De Gregori
Date:   Thu Mar 6 11:13:39 2025 +0100

     Rename occurences of 'struct link_socket' from 'ls' to 'sock'

     Signed-off-by: Gianmarco De Gregori <gianmarco@...2726...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20250306101339.12985-1-gert@...1296...>
     URL: https://sourceforge.net/p/openvpn/mailman/message/59156800/
     URL: https://gerrit.openvpn.net/c/openvpn/+/874
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


