Date: Wed, 14 Jan 2026 19:35:17 +0100 (CET)
Message-Id: <202601141835.60EIZHDN035433@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20260114160238.31321-1-gert@...1296...>
References: <20260114160238.31321-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: Add check for bind-dev in DCO
 options
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
To: Brandon Currell <brandon+git@...2989...>
Cc: openvpn-devel@lists.sourceforge.net

As discussed in the GH issue, we do not expect to see support for
--bind-dev in 2.6.x with the old linux "out of kernel" support - so turn off
DCO if --bind-dev is requested.

This patch is only appled to release/2.6, as we *do* expect to have working
--bind-dev support with the "new linux in-kernel DCO" in 2.7.0 and up, so
turning it off there would be the wrong thing (even if the support has not
actually merged to a release kernel yet).

I have not tested this (beyond a quick compile test), but it's straight-
forward enough, and Antonio as primary DCO developer has ACKed it.

I have added your signed-off-by: line to the commit, as per our coding
conventions.

Your patch has been applied to the release/2.6 branch.

commit 30041d6c40c9c0b6aa5581d4570110cde61cad0e (release/2.6)
Author: Brandon Currell
Date:   Wed Jan 14 17:02:32 2026 +0100

     Add check for bind-dev in DCO options

     Signed-off-by: Gert Doering <gert@...1296...>
     Acked-by: Antonio Quartulli <antonio@...2726...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1447
     Message-Id: <20260114160238.31321-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg35260.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


